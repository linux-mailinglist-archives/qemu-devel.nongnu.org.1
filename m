Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A88831376
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:57:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGE-0005bC-7G; Thu, 18 Jan 2024 02:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFz-0004wx-Uw; Thu, 18 Jan 2024 02:56:12 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFy-0007sp-2x; Thu, 18 Jan 2024 02:56:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71D3045043;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9AFC6661AC;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381704 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 25/38] tests/qtest/virtio-ccw: Fix device presence
 checking
Date: Thu, 18 Jan 2024 10:52:52 +0300
Message-Id: <20240118075404.2381519-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Samuel Tardieu <sam@rfc1149.net>

An apparent copy-paste error tests for the presence of the
virtio-rng-ccw device in order to perform tests on the virtio-scsi-ccw
device.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Message-ID: <20240106130121.1244993-1-sam@rfc1149.net>
Fixes: 65331bf5d1 ("tests/qtest: Check for virtio-ccw devices before  using them")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit c98873ee4a0c2694aac976ab9affcf55da8b7e61)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
index f4f5858b84..7a5357c212 100644
--- a/tests/qtest/virtio-ccw-test.c
+++ b/tests/qtest/virtio-ccw-test.c
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
     if (qtest_has_device("virtio-rng-ccw")) {
         qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
     }
-    if (qtest_has_device("virtio-rng-ccw")) {
+    if (qtest_has_device("virtio-scsi-ccw")) {
         qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
         qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
     }
-- 
2.39.2


