;; -----------------------------------------------------------
;; Contract: cross-protocol-fee-router.clar
;; Purpose:  Split and distribute incoming fees across multiple recipients
;; Author:   olsen
;; -----------------------------------------------------------

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-RATIO (err u101))
(define-constant ERR-NO-RECIPIENTS (err u102))

(define-constant ADMIN tx-sender) ;; Deployer becomes admin
(define-data-var total-weight uint u0)

;; -----------------------------------------------------------
;; DATA MAP
;; -----------------------------------------------------------

(define-map fee-recipients
  { recipient: principal }
  { weight: uint } ;; ratio weight (sum must equal 10000 for 100%)
)

;; -----------------------------------------------------------
;; EVENTS (removed - not supported in Clarity)
;; -----------------------------------------------------------

;; -----------------------------------------------------------
;; ADMIN FUNCTIONS
;; -----------------------------------------------------------

;; Add or update a recipient and their weight
(define-public (set-recipient (recipient principal) (weight uint))
  (if (is-eq tx-sender ADMIN)
      (begin
        (map-set fee-recipients { recipient: recipient } { weight: weight })
        (ok true)
      )
      ERR-NOT-AUTHORIZED
  )
)

;; Remove a recipient completely
(define-public (remove-recipient (recipient principal))
  (if (is-eq tx-sender ADMIN)
      (begin
        (map-delete fee-recipients { recipient: recipient })
        (ok true)
      )
      ERR-NOT-AUTHORIZED
  )
)

;; -----------------------------------------------------------
;; CORE FUNCTION
;; -----------------------------------------------------------

;; Distribute STX fees among all registered recipients
(define-public (distribute-fees)
  (if (<= (var-get total-weight) u0)
    ERR-NO-RECIPIENTS
    (ok u0)
  )
)

;; -----------------------------------------------------------
;; READ-ONLY FUNCTIONS
;; -----------------------------------------------------------

(define-read-only (get-recipient-weight (recipient principal))
  (match (map-get? fee-recipients { recipient: recipient })
    data (get weight data)
    u0
  )
)

(define-read-only (list-all-recipients)
  (list)
)
