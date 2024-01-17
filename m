Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AA830767
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:57:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6On-0007wd-Qk; Wed, 17 Jan 2024 08:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Ol-0007wH-AB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Oj-00089k-E5
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705499764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ru72SgkOsur1oJ2gAj77F1d80+kd0B/sK3M/DGy0vQ=;
 b=hkmBvl5QazlTH7aA1s7HEgM8yDtWKsmuzyFlUJedgBbOVug3NYEhBli6NC6AQUwX2+Hu4t
 KgqHoG+UhULpWME2xIkbxQlCMJxsznthP+VMnnYZqmptJezyKOEDw2sS76Xnn9kvi1gfc4
 6oEQvDaCtdOfOKVNbNEBKe/X85p6GlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KfZ-BN1cMJmHKkGBz6H4Lw-1; Wed, 17 Jan 2024 08:56:01 -0500
X-MC-Unique: KfZ-BN1cMJmHKkGBz6H4Lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B1E98371C0;
 Wed, 17 Jan 2024 13:56:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 977B43C25;
 Wed, 17 Jan 2024 13:55:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mario Casquero <mcasquer@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v1 2/2] memory-device: reintroduce memory region size check
Date: Wed, 17 Jan 2024 14:55:54 +0100
Message-ID: <20240117135554.787344-3-david@redhat.com>
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

We used to check that the memory region size is multiples of the overall
requested address alignment for the device memory address.

We removed that check, because there are cases (i.e., hv-balloon) where
devices unconditionally request an address alignment that has a very large
alignment (i.e., 32 GiB), but the actual memory device size might not be
multiples of that alignment.

However, this change:

(a) allows for some practically impossible DIMM sizes, like "1GB+1 byte".
(b) allows for DIMMs that partially cover hugetlb pages, previously
    reported in [1].

Both scenarios don't make any sense: we might even waste memory.

So let's reintroduce that check, but only check that the
memory region size is multiples of the memory region alignment (i.e.,
page size, huge page size), but not any additional memory device
requirements communicated using md->get_min_alignment().

The following examples now fail again as expected:

(a) 1M with 2M THP
 qemu-system-x86_64 -m 4g,maxmem=16g,slots=1 -S -nodefaults -nographic \
                     -object memory-backend-ram,id=mem1,size=1M \
                     -device pc-dimm,id=dimm1,memdev=mem1
 -> backend memory size must be multiple of 0x200000

(b) 1G+1byte

 qemu-system-x86_64 -m 4g,maxmem=16g,slots=1 -S -nodefaults -nographic \
                   -object memory-backend-ram,id=mem1,size=1073741825B \
                   -device pc-dimm,id=dimm1,memdev=mem1
 -> backend memory size must be multiple of 0x200000

(c) Unliagned hugetlb size (2M)

 qemu-system-x86_64 -m 4g,maxmem=16g,slots=1 -S -nodefaults -nographic \
                   -object memory-backend-file,id=mem1,mem-path=/dev/hugepages/tmp,size=511M \
                   -device pc-dimm,id=dimm1,memdev=mem1
 backend memory size must be multiple of 0x200000

(d) Unliagned hugetlb size (1G)

 qemu-system-x86_64 -m 4g,maxmem=16g,slots=1 -S -nodefaults -nographic \
                    -object memory-backend-file,id=mem1,mem-path=/dev/hugepages1G/tmp,size=2047M \
                    -device pc-dimm,id=dimm1,memdev=mem1
 -> backend memory size must be multiple of 0x40000000

Note that this fix depends on a hv-balloon change to communicate its
additional alignment requirements using get_min_alignment() instead of
through the memory region.

[1] https://lkml.kernel.org/r/f77d641d500324525ac036fe1827b3070de75fc1.1701088320.git.mprivozn@redhat.com

Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Reported-by: Michal Privoznik <mprivozn@redhat.com>
Fixes: eb1b7c4bd413 ("memory-device: Drop size alignment check")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a1b1af26bc..e098585cda 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -374,6 +374,20 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
 
+    /*
+     * We always want the memory region size to be multiples of the memory
+     * region alignment: for example, DIMMs with 1G+1byte size don't make
+     * any sense. Note that we don't check that the size is multiples
+     * of any additional alignment requirements the memory device might
+     * have when it comes to the address in physical address space.
+     */
+    if (!QEMU_IS_ALIGNED(memory_region_size(mr),
+                         memory_region_get_alignment(mr))) {
+        error_setg(errp, "backend memory size must be multiple of 0x%"
+                   PRIx64, memory_region_get_alignment(mr));
+        return;
+    }
+
     if (legacy_align) {
         align = *legacy_align;
     } else {
-- 
2.43.0


