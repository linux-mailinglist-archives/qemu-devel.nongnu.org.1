Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9263473DD1C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBb-0002xd-SZ; Mon, 26 Jun 2023 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBP-0002vE-NF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBO-0000YI-3w
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0854vsu3mSnDVm0bautGjrbU7bk2cLvYsDwU8lwzi1I=;
 b=WiAKnv/wiGpZHmIW6oDTNhuFdtBG4jYOcIR3mxkEQpPkpmnSvkSrTIBUgg/SIsYbEqsOYX
 kZSFF6YVlQjmp4Mz8LBWl68/AwCFvEhxXMXucFfRIDyHpk+0jbH/KqXeaI4QCGToZDd8fu
 VE1lZ58DxVPE/48e1/AD106DvCIBNYM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-SkstPZgQOSyCtlebB-c4fw-1; Mon, 26 Jun 2023 07:14:56 -0400
X-MC-Unique: SkstPZgQOSyCtlebB-c4fw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so26862415e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778094; x=1690370094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0854vsu3mSnDVm0bautGjrbU7bk2cLvYsDwU8lwzi1I=;
 b=jy3vbBzwGKHA+v7KYyW0cRixNa+aVyr6fsW2iz2inghDjO2gaqk/deem11cGAxRV1Y
 nuzRoG+4klGAPM8s4W8lOA/Ou/K6qUwIk4kE0o+BxrDfYhgE7SvjctHUko5crbBsy07f
 z+5bZ36oLsclYlxCLEJL1MMOkorzO+FPILmCMaHpxg8BgqFRkOUvxfACGRPKSYC8sw+T
 XIl+uAppyQ/lOs1srWsDMyspO6bS2ua/+wGbNttAUGkUPjfaxjAx9mGwtTVwyqE963fu
 gzsn5LZgl3Tgo0oEliBTQMuiLaxFwio5goFjQO+YttYEdorkxpO08w4y+YXqSLw8eCsd
 H+nQ==
X-Gm-Message-State: AC+VfDxnAj4V6zZSGcwxRypRFL5LKdpbjyYh1uvoKYFn7AqOo/FQQuo/
 oMhVlbd+pPUrsU9Dv7EyfRUreU7XZWYDRyysC+o0S18SAQmwRHazOZOfEi6sRG7AytkB4lZpM/a
 QyiU9z5tcQUlYR2VhY3P/UUbYBYQsTzqy82Z2G+3tTTXkJ5DezUWoSHcW8kGwWopZ4xnfZt2Ywb
 A=
X-Received: by 2002:a7b:c5d8:0:b0:3f1:789d:ad32 with SMTP id
 n24-20020a7bc5d8000000b003f1789dad32mr32214224wmk.11.1687778094542; 
 Mon, 26 Jun 2023 04:14:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PCdx0hPwheCmRf0RCSk4hejAX0fFIuzxL08y7wtOWsz7OOEyUlsbNa1cZIFhq74A1fnAn+w==
X-Received: by 2002:a7b:c5d8:0:b0:3f1:789d:ad32 with SMTP id
 n24-20020a7bc5d8000000b003f1789dad32mr32214210wmk.11.1687778094313; 
 Mon, 26 Jun 2023 04:14:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fa95c466a1sm2937456wmi.5.2023.06.26.04.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/18] hw/riscv: Validate cluster and NUMA node boundary
Date: Mon, 26 Jun 2023 13:14:32 +0200
Message-ID: <20230626111445.163573-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Gavin Shan <gshan@redhat.com>

There are two RISCV machines where NUMA is aware: 'virt' and 'spike'.
Both of them are required to follow cluster-NUMA-node boundary. To
enable the validation to warn about the irregular configuration where
multiple CPUs in one cluster has been associated with multiple NUMA
nodes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230509002739.18388-4-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/riscv/spike.c | 2 ++
 hw/riscv/virt.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2c5546560aa..81f7e53aedd 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -354,6 +354,8 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
     mc->numa_mem_supported = true;
+    /* platform instead of architectural choice */
+    mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 95708d890e0..ed4c27487e4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1669,6 +1669,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
     mc->numa_mem_supported = true;
+    /* platform instead of architectural choice */
+    mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv_virt_board.ram";
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
-- 
2.41.0


