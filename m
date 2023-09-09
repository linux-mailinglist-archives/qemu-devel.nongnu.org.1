Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C83799880
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:17:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexhe-0008T9-BX; Sat, 09 Sep 2023 09:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhS-0008Ca-KR; Sat, 09 Sep 2023 09:08:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhQ-0003xD-0M; Sat, 09 Sep 2023 09:08:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F8D9205EF;
 Sat,  9 Sep 2023 16:06:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9150B26E42;
 Sat,  9 Sep 2023 16:05:19 +0300 (MSK)
Received: (nullmailer pid 354363 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 34/37] qemu-options.hx: Rephrase the descriptions of
 the -hd* and -cdrom options
Date: Sat,  9 Sep 2023 16:05:04 +0300
Message-Id: <20230909130511.354171-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The current description says that these options will create a device
on the IDE bus, which is only true on x86. So rephrase these sentences
a little bit to speak of "default bus" instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit bcd8e243083c878884e52d609deddbe6be17c730)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index e52289479b..379692da86 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1171,10 +1171,10 @@ SRST
 ERST
 
 DEF("hda", HAS_ARG, QEMU_OPTION_hda,
-    "-hda/-hdb file  use 'file' as IDE hard disk 0/1 image\n", QEMU_ARCH_ALL)
+    "-hda/-hdb file  use 'file' as hard disk 0/1 image\n", QEMU_ARCH_ALL)
 DEF("hdb", HAS_ARG, QEMU_OPTION_hdb, "", QEMU_ARCH_ALL)
 DEF("hdc", HAS_ARG, QEMU_OPTION_hdc,
-    "-hdc/-hdd file  use 'file' as IDE hard disk 2/3 image\n", QEMU_ARCH_ALL)
+    "-hdc/-hdd file  use 'file' as hard disk 2/3 image\n", QEMU_ARCH_ALL)
 DEF("hdd", HAS_ARG, QEMU_OPTION_hdd, "", QEMU_ARCH_ALL)
 SRST
 ``-hda file``
@@ -1184,18 +1184,22 @@ SRST
 ``-hdc file``
   \ 
 ``-hdd file``
-    Use file as hard disk 0, 1, 2 or 3 image (see the :ref:`disk images`
-    chapter in the System Emulation Users Guide).
+    Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
+    emulated machine (this is for example the IDE bus on most x86 machines,
+    but it can also be SCSI, virtio or something else on other target
+    architectures). See also the :ref:`disk images` chapter in the System
+    Emulation Users Guide.
 ERST
 
 DEF("cdrom", HAS_ARG, QEMU_OPTION_cdrom,
-    "-cdrom file     use 'file' as IDE cdrom image (cdrom is ide1 master)\n",
+    "-cdrom file     use 'file' as CD-ROM image\n",
     QEMU_ARCH_ALL)
 SRST
 ``-cdrom file``
-    Use file as CD-ROM image (you cannot use ``-hdc`` and ``-cdrom`` at
-    the same time). You can use the host CD-ROM by using ``/dev/cdrom``
-    as filename.
+    Use file as CD-ROM image on the default bus of the emulated machine
+    (which is IDE1 master on x86, so you cannot use ``-hdc`` and ``-cdrom``
+    at the same time there). On systems that support it, you can use the
+    host CD-ROM by using ``/dev/cdrom`` as filename.
 ERST
 
 DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
-- 
2.39.2


