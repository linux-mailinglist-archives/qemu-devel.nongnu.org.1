Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDEFBB944C
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 08:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5IfF-0004uJ-Kx; Sun, 05 Oct 2025 02:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5If8-0004oP-Gu; Sun, 05 Oct 2025 02:56:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5If6-0007xg-Ib; Sun, 05 Oct 2025 02:56:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1045F15A8EB;
 Sun, 05 Oct 2025 09:55:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D0FC299480;
 Sun,  5 Oct 2025 09:55:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: nanliu <nanliu@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/8] docs/devel: Correct uefi-vars-x64 device name
Date: Sun,  5 Oct 2025 09:55:34 +0300
Message-ID: <20251005065538.436862-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251005065538.436862-1-mjt@tls.msk.ru>
References: <20251005065538.436862-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: nanliu <nanliu@redhat.com>

The documentation for UEFI variable storage in uefi-vars.rst
incorrectly listed the device name as `uefi-vars-x86`.

The correct device name as implemented in the source code is
`uefi-vars-x64`.

This commit updates the documentation to use the correct name,
aligning it with the implementation.

Signed-off-by: Nana Liu <nanliu@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/uefi-vars.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/uefi-vars.rst b/docs/devel/uefi-vars.rst
index 0151a26a0a..b4013b5d12 100644
--- a/docs/devel/uefi-vars.rst
+++ b/docs/devel/uefi-vars.rst
@@ -34,7 +34,7 @@ configures the shared buffer location and size, and traps to the host
 to process the requests.
 
 The ``uefi-vars`` device implements the UEFI virtual device.  It comes
-in ``uefi-vars-x86`` and ``uefi-vars-sysbus`` flavours.  The device
+in ``uefi-vars-x64`` and ``uefi-vars-sysbus`` flavours.  The device
 reimplements the handlers needed, specifically
 ``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
 also consumes events (``EfiEndOfDxeEventGroup``,
@@ -57,7 +57,7 @@ usage on x86_64
 .. code::
 
    qemu-system-x86_64 \
-      -device uefi-vars-x86,jsonfile=/path/to/vars.json
+      -device uefi-vars-x64,jsonfile=/path/to/vars.json
 
 usage on aarch64
 ----------------
-- 
2.47.3


