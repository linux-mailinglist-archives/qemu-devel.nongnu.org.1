Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE570555E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyyla-0000oK-3K; Tue, 16 May 2023 13:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1pyw2T-0007HQ-4S; Tue, 16 May 2023 10:52:43 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1pyw2L-0007gI-Mt; Tue, 16 May 2023 10:52:31 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 73EEA11EF66;
 Tue, 16 May 2023 14:52:23 +0000 (UTC)
From: ~akihirosuda <akihirosuda@git.sr.ht>
Date: Tue, 16 May 2023 23:32:27 +0900
Subject: [PATCH qemu] docs/interop/qcow2.txt: fix description about "zlib"
 clusters
Message-ID: <168424874322.11954.1340942046351859521-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 May 2023 13:47:12 -0400
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
Reply-To: ~akihirosuda <suda.kyoto@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

"zlib" clusters are actually raw deflate (RFC1951) clusters without
zlib headers.

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 docs/interop/qcow2.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index f7dc304ff6..e7f036c286 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -214,14 +214,18 @@ version 2.
                     type.
=20
                     If the incompatible bit "Compression type" is set: the f=
ield
-                    must be present and non-zero (which means non-zlib
+                    must be present and non-zero (which means non-deflate
                     compression type). Otherwise, this field must not be pre=
sent
-                    or must be zero (which means zlib).
+                    or must be zero (which means deflate).
=20
                     Available compression type values:
-                        0: zlib <https://www.zlib.net/>
+                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
                         1: zstd <http://github.com/facebook/zstd>
=20
+                    The deflate compression type is called "zlib"
+                    <https://www.zlib.net/> in QEMU. However, clusters with =
the
+                    deflate compression type do not have zlib headers.
+
=20
 =3D=3D=3D Header padding =3D=3D=3D
=20
--=20
2.38.4

