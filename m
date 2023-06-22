Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5D73A0B5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJFd-0004VY-OE; Thu, 22 Jun 2023 08:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJF5-0004Dg-4C
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:54 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJF2-0004xw-8n
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436192; x=1688040992; i=lukasstraub2@web.de;
 bh=OXl53ydPaLHEO9W6L9zf0yph3Okbtg2KEAYvqSFOuWc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=pS0WGnPPhz9BT8pM+Jop69Cku8NcEzMaSSaG+Lxj+n447MYgBr/rOZPAalo2CR6bW8/aeX2
 H77y/9A5pmXRiIcOrb7A8V17aulhmF6KraneacpvDWaBB7xd39OZ3wrLIFe5sH6xq5U/iKWa4
 rZ2k8Alu/ub/4fCfDja9t6dEhgKEHmjhy5rX/VVOQ+HVzN/FmAUFf0FDQZe9+6y7RsOP5Ad5X
 lFk3z9OOEv3o5ehOcVFUMYYvVMpANyhQ4sLC/fYy4Zv5oUJpDgtnc7Cc/aDPqBEBiNJQJgLhM
 bz4l7KVNMxvWiymKWBzSNzWH9ZGLkIeuIoqBVpnAc+wxVVpu23PQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1qJykV4A8i-00A4PA; Thu, 22
 Jun 2023 14:16:32 +0200
Date: Thu, 22 Jun 2023 14:16:28 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 7/8] colo: Reject colo with block migration capability enabled
Message-ID: <dcf358d5dbd3e5c82b8c2c085146088da60b4b4e.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yjmeoGEA/pij_WahwauE.mq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:s/YoV9zE25RIi3G82I/rJwAND2jDra5jR5vkSsIJUB9vOo6Dt95
 dbf1L3WSHlUcJohkIWxX8+DcXiIRlyPdIPJZlm0Kt4Be0Oicsos79zZvadI1rTvc75hXTrA
 Iqz9R+J+zEN4o4I4guIR+IhCIQRgAqCtDBHjMh6zJDDXEYhrRUhCtdK6mxlBdlJdKKuEsfZ
 dA50JJeiibu0WjdyCnxHg==
UI-OutboundReport: notjunk:1;M01:P0:CPhDQX7JfzE=;6GdoBkR2G7yc6WK2L2D5JeTbVA7
 PKP0Ya4sn6W6vLbk315AFovGBt9ypbXU8I1A3amNeGaby5gD8/GIclHU95YfvcVf/Xi3y72SS
 vriurfG9hQcXgLtx5VAWwyPe5mqCO42NDK+OjQ2pYFwm5ohMI6JDqj6uxHTnK2d4B/4A/sWmq
 Km2H6KPqFq1NMsOTrt4eD34bRq3ZYF21ri3+T0ePYI8jAvOxUJ0cGFlgwbLpUxYI0PcqjK+SW
 xGTpIALSbE4j13TBzcloZ3z14Vy7suin5Da0SrceN6SUeaTp7D8JI01YrFZQPyHZ0wpWF5Y07
 tjH+HpwJ5jDxcvfhK1gfe+uS4+Yl/r46KI79GTRJsQwiAcNMsAqDXm/4mut31Gmjy1Vis6Rzm
 Qvx2iFlFFM8YeABdaR7MzO4qXJeiQuVELLz0TTuTP4ZyI7N6EENqd4jIzFKZdkMJYDPMkUYfY
 9GdVW88UCrtgOLtCFMv06X9LpoAfYqAW0kKPxI3GAiegwcdl96mv7k35UY3d0z9HZi1cYAI6U
 zfO7x2VPdqBOK42bN2IJGRrWX6TuCdF0rQvpIj3uEErLFPOWzeDkpxxHVz7sbopIZMG7Ul+WH
 PlwTUiRbAOXyZJuB7IdsFsKIuEVdEKXV6i8VjEsF7k6J+2AGTUpU/wT+D8w7n3DZ32ZAYUH91
 SroElE5f26l/qMEjzt2eIcGMDoLx/QbgPigBiQZHswSm2HIw9tr552Xs3oxGiZh6xemZQhL2H
 7IAIBop02fRxA51UiZuD7cZUlxCeFc3lL/Jf3xwUNoCcAVKfK+CYeJUapTiklbxgCL4cTJ+sC
 6ihmdiAOFx0N26kKR1Bj2B7wiaQQ2PxsvnAFJJD2fxwHDdsNgGeJ/ys7SmLjCYDlGQWUN9BTJ
 S9u3C3mZHte8M8zjOJtJaNaGRY71b9lClVCXueGcd59SrL3dZ1O8g+yLVX+xZ2EEwIYZwpe47
 EhENgOfUN7BWk6eGp0ywpJYM/cI=
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--Sig_/yjmeoGEA/pij_WahwauE.mq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c | 4 ----
 migration/options.c   | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9860f960f2..270130579f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1571,10 +1571,6 @@ static bool migrate_prepare(MigrationState *s, bool =
blk, bool blk_inc,
     }
=20
     if (blk || blk_inc) {
-        if (migrate_colo()) {
-            error_setg(errp, "No disk migration is required in COLO mode");
-            return false;
-        }
         if (migrate_block() || migrate_block_incremental()) {
             error_setg(errp, "Command options are incompatible with "
                        "current migration capabilities");
diff --git a/migration/options.c b/migration/options.c
index d3d4525d40..1e9659fcb3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -451,6 +451,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps=
, Error **errp)
             error_setg(errp, "COLO is not compatible with postcopy");
             return false;
         }
+
+        if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
+            error_setg(errp, "COLO is not compatible with block migration"=
);
+            return false;
+        }
     }
 #endif
=20
--=20
2.39.2


--Sig_/yjmeoGEA/pij_WahwauE.mq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO50ACgkQNasLKJxd
slgXTA//Xauv+h8bAYAcRdWVZYumMjZqzN4uMEMx6/tkmnIt9DwZca/7d/zt94/m
IjifQP6cimR1BjcXuAU9G4vpP1d8blBzaBkiGg6vEL6z8a6XWD+380NqnpduQnIJ
uYO0fdsX+P1xWZuE/4KRl0I3ZlDPpNV36VeYObEL8rRvW2l9RhUn+NQEe/zpqS8n
ehQ3pwZOkTLPqJ2Q9BXQUZCokyFinmwHe9g3h4SaU9YamhkGeHasqMRJzJRtNzIa
rZc5pjRrbIlYBFDIiFc/CRbgdHVI/AsrOjntZxnvAcbykk+hEZMG8l/udQsqYm8t
55LbKgq3XwUxb1DcQ2fp+P1ey1d+h7qEXyXojJl8RqSwOJVHaIsYajlv+b8vfak7
sAyLsJa55bPVp9P6jbu3QJhfOexU6TUNbazU97eak/ylciVrWjPt8mHn9D0l2BgM
EMdRilBxQ8VV/drW6WHVGf3hkBYDJAQTxu1iHx1j1RPoJrMOdOmQ4jMV7EWxXaHr
5TVtB1SR0gc+rbVOrZjxtyqhlrxzC43V9Xj9o3MOXq9ieDcqQ93HmIoIqHXr28nP
bx0QoDRXRQ4lYQFuRYTU82t/wbFy3G8iuFOp5YT6FXhQjwkAbDMcgOwUCtMAIuQv
hlx0si6vjzcCxwW0seEFHo0LBFj0fZ/N6+MmvfF8kJALhqzqlKs=
=sX8C
-----END PGP SIGNATURE-----

--Sig_/yjmeoGEA/pij_WahwauE.mq--

