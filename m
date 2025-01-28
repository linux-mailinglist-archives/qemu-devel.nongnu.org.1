Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2DA2056D
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:01:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgUf-0000iY-Rz; Tue, 28 Jan 2025 02:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgUX-0008Jd-IU; Tue, 28 Jan 2025 02:58:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgUV-0000vr-Vu; Tue, 28 Jan 2025 02:58:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC65AE1AFA;
 Tue, 28 Jan 2025 10:54:25 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3773B1A62E1;
 Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id ECAAD52059; Tue, 28 Jan 2025 10:54:50 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 25/45] fuzz: specify audiodev for usb-audio
Date: Mon, 27 Jan 2025 23:26:06 +0300
Message-Id: <20250127202630.3724367-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes test-failure on Fedora 40 CI.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240527040711.311865-1-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e7fca81e170530104c36bd8f3e1d7e7c11011481)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index 4d7c8ca4ec..ef0ad95712 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -150,7 +150,8 @@ const generic_fuzz_config predefined_configs[] = {
         "-chardev null,id=cd0 -chardev null,id=cd1 "
         "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
         "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
-        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
+        "-device usb-tablet -device usb-wacom-tablet "
+        "-device usb-audio,audiodev=snd0 -audiodev none,id=snd0",
         .objects = "*usb* *uhci* *xhci*",
     },{
         .name = "pc-i440fx",
-- 
2.39.5


