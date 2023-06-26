Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9773DD0F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBW-0002w7-0l; Mon, 26 Jun 2023 07:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBO-0002up-8Z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBM-0000Y0-LP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kq1X8mGUPqT12w5Uk0eOYlWmUkW0klSacfknT377XKk=;
 b=h0FPXRKmHNvRfPU/6/+vekpu9tsdpJ+W2mWiD58rQ7n6j3Po8GKAzMF3L1rHwuIwvJNeVI
 1S0Zqm0BCgmrNibpYkf0ZNJvIRe9mo8wP046TAT1XPhYrfdv8u8TdiP/9UPZhTIEBhWGv1
 Ldmow4Y/qGkTlYItYU1fMb5zrMb4bfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-_NYcpfN6MSq6C6elHCAdMQ-1; Mon, 26 Jun 2023 07:14:54 -0400
X-MC-Unique: _NYcpfN6MSq6C6elHCAdMQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313f59eba37so189789f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778093; x=1690370093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kq1X8mGUPqT12w5Uk0eOYlWmUkW0klSacfknT377XKk=;
 b=Kdi8dYQ9+8/dU55JpB/c0mwD/1l+XxMYrcIeDkmjkUvsgiJxbM1lHPWertuZSktKhl
 LHIogfHVy3pk9crTnOjSyCobccZg1HeNS7yQDvP7JY4wBLiK4MvoGihcxEB68o+P10mg
 mTWLijF20Yu3vIGOhjUCpppTw091KGokdKBaVCnl9/JmZZAkA2S+XbFZWvgaDKRobKZo
 dAlxzmqi7gAej0k2GP79ChyqpkjCqxr1Rz7jJf6zbRUSaf9CjNRAXBch3/CQadAemwCz
 ljVqrs87egE0GtJKYwZkrKizwBIRmhb2Pgc/MPcRZ/IxFkvDhmhAVS1KWhav6fMk/nGa
 HCFg==
X-Gm-Message-State: AC+VfDzPzVoWS1WmuP4cMBhMy6dqM72iGk24R2rlyL+WA9IKl+T0P7q1
 XpdSlMXEQ+/0GZLzTIaWA277q3JdYxd26mpp3kr+5f3/Nn7+h0xuwtr1m0sRVqRD+qV16EDV9dK
 fJOiq3P+vMz0qToyvE5GlkPpKwELbv3A/1S5P/lnmISxmxBSxF24ummRa5WBN1cG0Pzw9CODapQ
 w=
X-Received: by 2002:a5d:5410:0:b0:313:ef24:6fe6 with SMTP id
 g16-20020a5d5410000000b00313ef246fe6mr2162918wrv.1.1687778093101; 
 Mon, 26 Jun 2023 04:14:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5I9UX8rIepdNCEYUcD6IP+MeKwDmG44MEwLRqTuzZS5hc5pyEIwzPeHYIEg+mShPs3i2W9GQ==
X-Received: by 2002:a5d:5410:0:b0:313:ef24:6fe6 with SMTP id
 g16-20020a5d5410000000b00313ef246fe6mr2162904wrv.1.1687778092757; 
 Mon, 26 Jun 2023 04:14:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a5d4442000000b003113ccbf388sm7033668wrr.13.2023.06.26.04.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 04/18] hw/arm: Validate cluster and NUMA node boundary
Date: Mon, 26 Jun 2023 13:14:31 +0200
Message-ID: <20230626111445.163573-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

There are two ARM machines where NUMA is aware: 'virt' and 'sbsa-ref'.
Both of them are required to follow cluster-NUMA-node boundary. To
enable the validation to warn about the irregular configuration where
multiple CPUs in one cluster have been associated with different NUMA
nodes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230509002739.18388-3-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/sbsa-ref.c | 2 ++
 hw/arm/virt.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 0639f97dd5f..b774d802918 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -910,6 +910,8 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
+    /* platform instead of architectural choice */
+    mc->cpu_cluster_has_numa_boundary = true;
 }
 
 static const TypeInfo sbsa_ref_info = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9b9f7d9c687..3937e304774 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3033,6 +3033,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.clusters_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
+    /* platform instead of architectural choice */
+    mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "mach-virt.ram";
     mc->default_nic = "virtio-net-pci";
 
-- 
2.41.0


