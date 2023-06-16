Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDC732B7C
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5jk-0004yo-Dc; Fri, 16 Jun 2023 05:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5ji-0004yD-1T
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jg-0000HL-FH
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYAGcIiBozkpSp3T5+K2LJNfVGImLOKVErgdOfZyLGs=;
 b=ikJRqfYCh8T2sVTPfaTri7sFmW9xQaSs0HI67YX+IeG1OBi+1P/RNUt/+0HV8FepHMRpWw
 4hzVr7QrrMwhHDY3KhnMegequGI/gZkF3IKQBfLVdRU3mqEQQMjYEzGAifkd8McJxYHCks
 UU9c3toXkgv2OZGvLxIlfCoPa6IDsC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-603ggW9-NtO0DCIu0SPyKQ-1; Fri, 16 Jun 2023 05:27:12 -0400
X-MC-Unique: 603ggW9-NtO0DCIu0SPyKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5187A810BBA;
 Fri, 16 Jun 2023 09:27:12 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5447C1121314;
 Fri, 16 Jun 2023 09:27:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 01/15] memory-device: Track the required memslots in
 DeviceMemoryState
Date: Fri, 16 Jun 2023 11:26:40 +0200
Message-Id: <20230616092654.175518-2-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's track how many memslots are currently required by plugged memory
devices. We'll use this number to perform sanity checks next (soft limit
to warn the user).

Right now, each memory device consumes exactly one memslot, and the
number of required memslots matches the number of used memslots.

Once we support memory devices that consume multiple memslots
dynamically, the requested number of memslots will no longer correspond to
the number of memory devices, and there will be a difference between
required and actually used memslots.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 2 ++
 include/hw/boards.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 667d56bd29..28ad419dc0 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -275,6 +275,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     ms->device_memory->used_region_size += memory_region_size(mr);
+    ms->device_memory->required_memslots++;
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
     trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
@@ -294,6 +295,7 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
     ms->device_memory->used_region_size -= memory_region_size(mr);
+    ms->device_memory->required_memslots--;
     trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
                                mdc->get_addr(md));
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fcaf40b9da..a346b4ec4a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -297,12 +297,14 @@ struct MachineClass {
  * @mr: address space container for memory devices
  * @dimm_size: the sum of plugged DIMMs' sizes
  * @used_region_size: the part of @mr already used by memory devices
+ * @required_memslots: the number of memslots required by memory devices
  */
 typedef struct DeviceMemoryState {
     hwaddr base;
     MemoryRegion mr;
     uint64_t dimm_size;
     uint64_t used_region_size;
+    unsigned int required_memslots;
 } DeviceMemoryState;
 
 /**
-- 
2.40.1


