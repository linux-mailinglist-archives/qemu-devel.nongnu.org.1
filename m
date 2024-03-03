Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490ED86F430
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Mar 2024 10:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgiDl-0001SS-5q; Sun, 03 Mar 2024 04:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDd-0001S5-DU; Sun, 03 Mar 2024 04:33:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDZ-0006Vu-Hj; Sun, 03 Mar 2024 04:33:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1AE9E527CE;
 Sun,  3 Mar 2024 12:33:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 93DDB8E8CA;
 Sun,  3 Mar 2024 12:33:04 +0300 (MSK)
Received: (nullmailer pid 1357010 invoked by uid 1000);
 Sun, 03 Mar 2024 09:33:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Benjamin David Lunt <benlunt@fysnet.net>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 80/82] hw/usb/bus.c: PCAP adding 0xA in Windows version
Date: Sun,  3 Mar 2024 12:32:58 +0300
Message-Id: <20240303093304.1356981-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Benjamin David Lunt <benlunt@fysnet.net>

Since Windows text files use CRLFs for all \n, the Windows version of QEMU
inserts a CR in the PCAP stream when a LF is encountered when using USB PCAP
files. This is due to the fact that the PCAP file is opened as TEXT instead
of BINARY.

To show an example, when using a very common protocol to USB disks, the BBB
protocol uses a 10-byte command packet. For example, the READ_CAPACITY(10)
command will have a command block length of 10 (0xA). When this 10-byte
command (part of the 31-byte CBW) is placed into the PCAP file, the Windows
file manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
32-byte CBW.

Actual CBW:
  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25 USBC...........%
  0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ...............

PCAP CBW
  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a USBC............
  0050 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 %..............

I believe simply opening the PCAP file as BINARY instead of TEXT will fix
this issue.

Resolves: https://bugs.launchpad.net/qemu/+bug/2054889
Signed-off-by: Benjamin David Lunt <benlunt@fysnet.net>
Message-ID: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
[thuth: Break long line to avoid checkpatch.pl error]
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 5e02a4fdebc442e34c5bb05e4540f85cc6e802f0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 92d6ed5626..4d4c671913 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -273,13 +273,14 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     if (dev->pcap_filename) {
-        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+        int fd = qemu_open_old(dev->pcap_filename,
+                               O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
         if (fd < 0) {
             error_setg(errp, "open %s failed", dev->pcap_filename);
             usb_qdev_unrealize(qdev);
             return;
         }
-        dev->pcap = fdopen(fd, "w");
+        dev->pcap = fdopen(fd, "wb");
         usb_pcap_init(dev->pcap);
     }
 }
-- 
2.39.2


