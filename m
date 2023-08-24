Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DD786AE0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6BV-0001cf-L4; Thu, 24 Aug 2023 04:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6BF-0001Bt-3R
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6BC-00045M-Dt
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tKonvgasUB+hKKDkSYEjkN5CNR2JzmcxLIKxvnV7XI=;
 b=A1LAIQo2ejBKo7mfLjCaDQPXBnCzaYoKnCnUE3d/I9AbYIqkU4akGu/Lw6VwtT++3rmjB6
 ZJKAYHN/VCrjOAVEQus4CUBlnzGh/uk116k/wwtOD+Qi8FRqrbus1y6Un86aax0k7pvgec
 H/W7UcyX+KnnIU/M9WfKIurXLLNdzOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-GfWia7PbPfe3v8KFe1NdCA-1; Thu, 24 Aug 2023 04:58:02 -0400
X-MC-Unique: GfWia7PbPfe3v8KFe1NdCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DE6485CCE0;
 Thu, 24 Aug 2023 08:58:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F24702026D35;
 Thu, 24 Aug 2023 08:58:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C528118009BC; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 6/6] check for e820 conflict
Date: Thu, 24 Aug 2023 10:57:56 +0200
Message-ID: <20230824085756.66732-7-kraxel@redhat.com>
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add support to check for overlaps with e820 entries.
In case the 64bit pci io window has conflicts move it down.

The only known case where this happens is AMD processors
with 1TB address space which has some space just below
1TB reserved for HT.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/e820map.h    |  1 +
 src/e820map.c    | 15 +++++++++++++++
 src/fw/pciinit.c |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/src/e820map.h b/src/e820map.h
index de8b523003c5..07ce16ec213f 100644
--- a/src/e820map.h
+++ b/src/e820map.h
@@ -18,6 +18,7 @@ struct e820entry {
 void e820_add(u64 start, u64 size, u32 type);
 void e820_remove(u64 start, u64 size);
 void e820_prepboot(void);
+int e820_is_used(u64 start, u64 size);
 
 // e820 map storage
 extern struct e820entry e820_list[];
diff --git a/src/e820map.c b/src/e820map.c
index 39445cf6399d..c761e5e98a75 100644
--- a/src/e820map.c
+++ b/src/e820map.c
@@ -150,3 +150,18 @@ e820_prepboot(void)
 {
     dump_map();
 }
+
+int
+e820_is_used(u64 start, u64 size)
+{
+    int i;
+    for (i=0; i<e820_count; i++) {
+        struct e820entry *e = &e820_list[i];
+        if (start + size <= e->start)
+            continue;
+        if (start >= e->start + e->size)
+            continue;
+        return 1;
+    }
+    return 0;
+}
diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index b52bd1d5054b..c7084f5e397e 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -1140,6 +1140,8 @@ static void pci_bios_map_devices(struct pci_bus *busses)
             if (r64_mem.base < top - size) {
                 r64_mem.base = top - size;
             }
+            if (e820_is_used(r64_mem.base, size))
+                r64_mem.base -= size;
         }
         r64_mem.base = ALIGN(r64_mem.base, align_mem);
         r64_mem.base = ALIGN(r64_mem.base, (1LL<<30));    // 1G hugepage
-- 
2.41.0


