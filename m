Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DFD9D1FF0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 07:06:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHMS-0002DI-5v; Tue, 19 Nov 2024 01:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHMO-00020b-BZ; Tue, 19 Nov 2024 01:05:12 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHMM-0004gs-8x; Tue, 19 Nov 2024 01:05:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3F84DA626C;
 Tue, 19 Nov 2024 09:04:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6671D1738E1;
 Tue, 19 Nov 2024 09:04:19 +0300 (MSK)
Received: (nullmailer pid 2368960 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 69/72] hw/misc/mos6522: Fix bad class definition of the
 MOS6522 device
Date: Tue, 19 Nov 2024 09:04:10 +0300
Message-Id: <20241119060418.2368866-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-cfi, the "q800" m68k machine
currently crashes very early, when the q800_machine_init() function
tries to wire the interrupts of the "via1" device.
This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
in its class definition where it is only derived from DeviceClass,
and not from SysBusDeviceClass, so we end up in funny memory access
issues here. Using the right class hierarchy for the MOS6522 device
fixes the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
Signed-off-by: Thomas Huth <thuth@redhat.com>
Fixes: 51f233ec92 ("misc: introduce new mos6522 VIA device")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241114104653.963812-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit c3d7c18b0d616cf7fb3c1f325503e1462307209d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index fba45668ab..920871a598 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -154,7 +154,7 @@ struct MOS6522State {
 OBJECT_DECLARE_TYPE(MOS6522State, MOS6522DeviceClass, MOS6522)
 
 struct MOS6522DeviceClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
 
     ResettablePhases parent_phases;
     void (*portB_write)(MOS6522State *dev);
-- 
2.39.5


