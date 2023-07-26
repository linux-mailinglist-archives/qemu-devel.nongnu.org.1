Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99340763B92
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfzw-00070P-Fv; Wed, 26 Jul 2023 11:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qOfzI-0006VN-IT
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:59:41 -0400
Received: from m12.mail.163.com ([220.181.12.217])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qOfzE-0003RU-Cn
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dYdqc
 E4/UlRL/8jH464mNjfvncT7PDOJd3UbhFuphVo=; b=p3pkuwhMTHzO9iFANtg3p
 zInoFwOOORzZ28QvF/dp6LO21wtF8ONmDVOifFa2CUxeYDEAPnpVLDBM6wKP8Hpd
 7hn83zSjLe4t1tDmuuNLdxP/YUzsQAwKAVEbXGEIk4PIiSRKoeguvy3XLQmxqoP4
 BnGWxgz9YWISpgf7dODd7k=
Received: from localhost.localdomain (unknown [183.242.254.172])
 by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3DOrNNMFkB6OIBQ--.32996S2;
 Wed, 26 Jul 2023 22:59:26 +0800 (CST)
From: Thiner Logoer <logoerthiner1@163.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com,
 Thiner Logoer <logoerthiner1@163.com>
Subject: [PATCH v2] softmmu/physmem: try opening file readonly before failure
 in file_ram_open
Date: Wed, 26 Jul 2023 14:59:12 +0000
Message-Id: <20230726145912.88545-1-logoerthiner1@163.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3DOrNNMFkB6OIBQ--.32996S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrZF4fWw45tr13KrWxJFb_yoW8ZrWfp3
 yrGrn8tr4vyr43ArsI9F9a9Fy5tr97JFn0grWrA348Gr98W3WxuFW0gr1YgFy3ZryxGFW7
 Zw4UWF97u39xGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zij2M8UUUUU=
X-Originating-IP: [183.242.254.172]
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/1tbiKRC4nlXl6l8+1wAAsz
Received-SPF: pass client-ip=220.181.12.217;
 envelope-from=logoerthiner1@163.com; helo=m12.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L4=0.001,
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

Users may give "-mem-path" a read only file and expect the file
to be mapped read-write privately. Allow this but give a warning
since other users may surprise when the ram file is readonly and
qemu suddenly aborts elsewhere.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
---

See the previous version at:
https://lore.kernel.org/qemu-devel/96a462ec-6f9d-fd83-f697-73e132432ca4@redhat.com/T/

verified, this patch works for my setup, both functionality and the warning
are expected behavior.

Also another problem when I look at the file_ram_open

When readonly is true and the path is a directory, the open will succeed but
any later operations will fail since it is a directory fd. This may require
additional commits which is out of my scope. Merely record the question here.

 softmmu/physmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..e8279d69d4 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1296,6 +1296,7 @@ static int file_ram_open(const char *path,
     char *sanitized_name;
     char *c;
     int fd = -1;
+    bool first_trial = true;
 
     *created = false;
     for (;;) {
@@ -1332,6 +1333,18 @@ static int file_ram_open(const char *path,
                 break;
             }
             g_free(filename);
+        } else if (first_trial && !readonly && errno == EACCES) {
+            /* @path may be a read only file */
+            fd = open(path, O_RDONLY);
+            if (fd >= 0) {
+                /*
+                 * Sometimes this behavior is not desired. Fire a warning but
+                 * continue.
+                 */
+                warn_report("backing store %s is opened readonly because the"
+                            "file is not writable", path);
+                break;
+            }
         }
         if (errno != EEXIST && errno != EINTR) {
             error_setg_errno(errp, errno,
@@ -1343,6 +1356,7 @@ static int file_ram_open(const char *path,
          * Try again on EINTR and EEXIST.  The latter happens when
          * something else creates the file between our two open().
          */
+        first_trial = false;
     }
 
     return fd;
-- 
2.40.1


