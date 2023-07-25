Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5557619AC
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHvm-0002Pf-CW; Tue, 25 Jul 2023 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qOFfE-0003ez-41
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:53:12 -0400
Received: from m12.mail.163.com ([220.181.12.196])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qOFfB-00051O-Go
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Vz5FK
 ixIE6aCmdk5wAjaQcgYA4OVhMfXpHBQt53Sfg0=; b=MiMf8Ig7W9nIOhXY1ETPX
 LePhqNlOp/RPUatKyOZqXwhsWuoj80JdEPi/8YW4RLnszlydH4SSrY5SMq2uMVz6
 OKT4oD0E9mq7wcPFEcpZHTKEVvPPLdeV9gu/NsIHiJBuOXroM/M/S4ry471AWkST
 gC1dHPf91T9cWhh4oILBkQ=
Received: from localhost.localdomain (unknown [183.242.254.172])
 by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wBXSwWEqb9k3ec2BQ--.34558S2;
 Tue, 25 Jul 2023 18:52:53 +0800 (CST)
From: Thiner Logoer <logoerthiner1@163.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com,
 Thiner Logoer <logoerthiner1@163.com>
Subject: [PATCH] Open file as read only on private mapping in
 qemu_ram_alloc_from_file
Date: Tue, 25 Jul 2023 10:52:39 +0000
Message-Id: <20230725105239.2022-1-logoerthiner1@163.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXSwWEqb9k3ec2BQ--.34558S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JryUuryrGry8KF4xZr17Awb_yoW8Jry8pr
 Z3Grn0krnY9a92va1kt3WYqFyrGa48GFy8XFZ3uryDXFsxWw1v9F40k34FgFnFqFyxJrsx
 Za17Ka4DWF47C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE_OzQUUUUU=
X-Originating-IP: [183.242.254.172]
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBZgS3nlaEEW9aMAAAsN
Received-SPF: pass client-ip=220.181.12.196;
 envelope-from=logoerthiner1@163.com; helo=m12.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jul 2023 09:18:23 -0400
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

An read only file can be mapped with read write as long as the
mapping is private, which is very common case. Make
qemu_ram_alloc_from_file open file as read only when the
mapping is private, otherwise open will fail when file
does not allow write.

If this file does not exist or is a directory, the flag is not used,
so it should be OK.

from https://gitlab.com/qemu-project/qemu/-/issues/1689

Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
---
 softmmu/physmem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..e8036ee335 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1945,8 +1945,15 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     int fd;
     bool created;
     RAMBlock *block;
+    
+    /*
+     * If map is private, the fd does not need to be writable.
+     * This only get effective when the file is existent.
+     */
+    bool open_as_readonly = readonly || !(ram_flags & RAM_SHARED);
 
-    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
+    fd = file_ram_open(mem_path, memory_region_name(mr),
+                       open_as_readonly, &created,
                        errp);
     if (fd < 0) {
         return NULL;
-- 
2.40.1


