Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FE830766
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:56:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6Oo-0007wg-07; Wed, 17 Jan 2024 08:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Oj-0007w1-2a
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Oh-00089N-El
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705499762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E68qz9eWIh4EeL0cYgweHNBbIG4H/spw71K8b2pFW0o=;
 b=X8POKYqqAPG0m6Psug1cQTGPUP21VeUVUxOX0YUR0IOcjYREuaaPeY1l8WxZxMHHlKAQhz
 L/j/G39z5akQIZyCvQpeVrZJVNaBKOL1eLna8CUiQ8KYkimCzUL/BMTbwl+m37rWovsljP
 5VfWIfRv+KkRjQat562EyMfvaptIMf8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-KHK8v1H8NjaHiP9s8Vxm9w-1; Wed,
 17 Jan 2024 08:55:59 -0500
X-MC-Unique: KHK8v1H8NjaHiP9s8Vxm9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36B4F38212DA;
 Wed, 17 Jan 2024 13:55:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A447E3C25;
 Wed, 17 Jan 2024 13:55:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mario Casquero <mcasquer@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v1 1/2] hv-balloon: use get_min_alignment() to express 32 GiB
 alignment
Date: Wed, 17 Jan 2024 14:55:53 +0100
Message-ID: <20240117135554.787344-2-david@redhat.com>
In-Reply-To: <20240117135554.787344-1-david@redhat.com>
References: <20240117135554.787344-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's implement the get_min_alignment() callback for memory devices, and
copy for the device memory region the alignment of the host memory
region. This mimics what virtio-mem does, and allows for re-introducing
proper alignment checks for the memory region size (where we don't care
about additional device requirements) in memory device core.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/hyperv/hv-balloon.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 66f297c1d7..0829c495b0 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1476,22 +1476,7 @@ static void hv_balloon_ensure_mr(HvBalloon *balloon)
     balloon->mr = g_new0(MemoryRegion, 1);
     memory_region_init(balloon->mr, OBJECT(balloon), TYPE_HV_BALLOON,
                        memory_region_size(hostmem_mr));
-
-    /*
-     * The VM can indicate an alignment up to 32 GiB. Memory device core can
-     * usually only handle/guarantee 1 GiB alignment. The user will have to
-     * specify a larger maxmem eventually.
-     *
-     * The memory device core will warn the user in case maxmem might have to be
-     * increased and will fail plugging the device if there is not sufficient
-     * space after alignment.
-     *
-     * TODO: we could do the alignment ourselves in a slightly bigger region.
-     * But this feels better, although the warning might be annoying. Maybe
-     * we can optimize that in the future (e.g., with such a device on the
-     * cmdline place/size the device memory region differently.
-     */
-    balloon->mr->align = MAX(32 * GiB, memory_region_get_alignment(hostmem_mr));
+    balloon->mr->align = memory_region_get_alignment(hostmem_mr);
 }
 
 static void hv_balloon_free_mr(HvBalloon *balloon)
@@ -1653,6 +1638,25 @@ static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
     return balloon->mr;
 }
 
+static uint64_t hv_balloon_md_get_min_alignment(const MemoryDeviceState *md)
+{
+    /*
+     * The VM can indicate an alignment up to 32 GiB. Memory device core can
+     * usually only handle/guarantee 1 GiB alignment. The user will have to
+     * specify a larger maxmem eventually.
+     *
+     * The memory device core will warn the user in case maxmem might have to be
+     * increased and will fail plugging the device if there is not sufficient
+     * space after alignment.
+     *
+     * TODO: we could do the alignment ourselves in a slightly bigger region.
+     * But this feels better, although the warning might be annoying. Maybe
+     * we can optimize that in the future (e.g., with such a device on the
+     * cmdline place/size the device memory region differently.
+     */
+    return 32 * GiB;
+}
+
 static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
                                            MemoryDeviceInfo *info)
 {
@@ -1765,5 +1769,6 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
     mdc->get_memory_region = hv_balloon_md_get_memory_region;
     mdc->decide_memslots = hv_balloon_decide_memslots;
     mdc->get_memslots = hv_balloon_get_memslots;
+    mdc->get_min_alignment = hv_balloon_md_get_min_alignment;
     mdc->fill_device_info = hv_balloon_md_fill_device_info;
 }
-- 
2.43.0


