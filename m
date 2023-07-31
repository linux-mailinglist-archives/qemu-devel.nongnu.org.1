Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6D7696F9
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSVj-0007lI-UZ; Mon, 31 Jul 2023 09:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQSVG-0007kW-UU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQSVE-0007xv-Dq
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690808399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qcpWBDDJOi4yLuCS/GSO1Pdlb8fB/uP6AVuMBECFsQQ=;
 b=F9ExWnBKV4QsNDDLwe6ufPRQyo4EGJlPuAAgXaYsrFfZFVsDST/NaJ8KuHMj5y9DUHerh0
 M6WHipor31INXGmarOMinbxeeKTDzruOvPqO0sV3W814P85D83myH52FLeH2yTrUiCsx3d
 6ylXuhHWxiTpZ/H/9uzC0svCQov45GE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-pi-kRdmQOhy25-t3RpKKrg-1; Mon, 31 Jul 2023 08:59:56 -0400
X-MC-Unique: pi-kRdmQOhy25-t3RpKKrg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9FD18022EF;
 Mon, 31 Jul 2023 12:59:55 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254FF492B03;
 Mon, 31 Jul 2023 12:59:52 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, david@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2] kvm: Fix crash due to access uninitialized kvm_state
Date: Mon, 31 Jul 2023 22:59:46 +1000
Message-ID: <20230731125946.2038742-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Runs into core dump on arm64 and the backtrace extracted from the
core dump is shown as below. It's caused by accessing uninitialized
@kvm_state in kvm_flush_coalesced_mmio_buffer() due to commit 176d073029
("hw/arm/virt: Use machine_memory_devices_init()"), where the machine's
memory region is added earlier than before.

    main
    qemu_init
    configure_accelerators
    qemu_opts_foreach
    do_configure_accelerator
    accel_init_machine
    kvm_init
    virt_kvm_type
    virt_set_memmap
    machine_memory_devices_init
    memory_region_add_subregion
    memory_region_add_subregion_common
    memory_region_update_container_subregions
    memory_region_transaction_begin
    qemu_flush_coalesced_mmio_buffer
    kvm_flush_coalesced_mmio_buffer

Fix it by bailing early in kvm_flush_coalesced_mmio_buffer() on the
uninitialized @kvm_state. With this applied, no crash is observed on
arm64.

Fixes: 176d073029 ("hw/arm/virt: Use machine_memory_devices_init()")
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Bail early in kvm_flush_coalesced_mmio_buffer() on the uninitialized
    @kvm_state and improved changelog        (David/Peter)
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..7b3da8dc3a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2812,7 +2812,7 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
     KVMState *s = kvm_state;
 
-    if (s->coalesced_flush_in_progress) {
+    if (!s || s->coalesced_flush_in_progress) {
         return;
     }
 
-- 
2.41.0


