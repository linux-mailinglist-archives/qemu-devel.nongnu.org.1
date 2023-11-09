Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A47E6C0B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:06:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15fO-0003y7-Kx; Thu, 09 Nov 2023 09:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15cN-0004IA-HS; Thu, 09 Nov 2023 09:02:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15cL-0006rj-Dn; Thu, 09 Nov 2023 09:02:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA11B31BD9;
 Thu,  9 Nov 2023 16:59:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D452E34512;
 Thu,  9 Nov 2023 16:59:48 +0300 (MSK)
Received: (nullmailer pid 1462884 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 35/62] migration: Fix analyze-migration read operation
 signedness
Date: Thu,  9 Nov 2023 16:59:03 +0300
Message-Id: <20231109135933.1462615-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

The migration code uses unsigned values for 16, 32 and 64-bit
operations. Fix the script to do the same.

This was causing an issue when parsing the migration stream generated
on the ppc64 target because one of instance_ids was larger than the
32bit signed maximum:

Traceback (most recent call last):
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 658, in <module>
    dump.read(dump_memory = args.memory)
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 592, in read
    classdesc = self.section_classes[section_key]
KeyError: ('spapr_iommu', -2147483648)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-6-farosas@suse.de>
(cherry picked from commit caea03279e11dfcb0e5a567b81fe7f02ee80af02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index b82a1b0c58..44d306aedc 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -38,13 +38,13 @@ def __init__(self, filename):
         self.file = open(self.filename, "rb")
 
     def read64(self):
-        return int.from_bytes(self.file.read(8), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(8), byteorder='big', signed=False)
 
     def read32(self):
-        return int.from_bytes(self.file.read(4), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(4), byteorder='big', signed=False)
 
     def read16(self):
-        return int.from_bytes(self.file.read(2), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(2), byteorder='big', signed=False)
 
     def read8(self):
         return int.from_bytes(self.file.read(1), byteorder='big', signed=True)
-- 
2.39.2


