Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9773DD22
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBY-0002x4-Nq; Mon, 26 Jun 2023 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBW-0002wm-Jv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBP-0000YX-FW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZQj7BH0bNHPLOV6nQDyI8ds3wFsn9tVHsOJxglkA1Q=;
 b=h1AQW4DEP7FyzQyZewmJhZErUml4sxZcQdfgx67azaU/Uv+Y9qKvo/Din4Q01nx1QoJNxN
 dd4MdSKrX3qzCmy2HyPCnc4ffKvy8EJKU+Zj5q+CVAp6YotLnZab7c+UCB12J6/fhC2SAB
 KPZx6PeI+CYGdnQgKKGxiRBuycqpQNY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-YFvzpiKMOGS7fuo4f0WQGQ-1; Mon, 26 Jun 2023 07:14:57 -0400
X-MC-Unique: YFvzpiKMOGS7fuo4f0WQGQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa714fa27aso18687175e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778096; x=1690370096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZQj7BH0bNHPLOV6nQDyI8ds3wFsn9tVHsOJxglkA1Q=;
 b=OxyBODuCLIKMO+5XknouC8A7zaMSeNYFTuhn4a0XKvWa4PUinHr0OmPligGPIUk2LG
 l167CBjZ5jCFmbux0ZJF/tblgLYTp0ZImJmmTOugMKMR1KIRAY5Ty5xRTtBFz6h99+Pn
 0Tg1pld+aPIs0iH9mu+9LnB/MhYfar/0iNuY4Z2aI1C/pBLjpoyYFi46EOi26ihnuamM
 HYGQuol1YuPKPAA1TBPYV+EHpSvARgCfNgXQdJ94UH9ZofVzVgPoDgJ3gb6hQitrj5tc
 /v2ldqvrE+c+/haoQVqFkOb5wLKUVD0UUuyR5gJ6gYarT3B9gv+RcWwCb4bypQU1P5Ve
 XNKg==
X-Gm-Message-State: AC+VfDyX4EmcPMWygGgroXAxcvko6L9P6TmqXLtqBs+YBaURo3SiPbe9
 5zzelmu9ELVm5kZ2h+SS7rLu+6cMLtlHgMFlvYKJ2FSI5Qo+bda37t0d/wb9eXKVLpitfW0sPkG
 njm+jd9rix+t+NszsMGu3q2Cm/+Ul7NM30mZqO8ssdSwaw/KOxOm/3MAjeuCr/XYoCC2Ve4WNnc
 M=
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id
 s18-20020a7bc392000000b003fa8fb150femr2593390wmj.15.1687778096036; 
 Mon, 26 Jun 2023 04:14:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TidpIRvn310vMeZRKWvmGJ0MhuEQ2ARFZe5rT1NoWGq1vw0tlcgyejNgi6ZpWHm1o+VVAhQ==
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id
 s18-20020a7bc392000000b003fa8fb150femr2593382wmj.15.1687778095812; 
 Mon, 26 Jun 2023 04:14:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4d03000000b0030aec5e020fsm7032393wrt.86.2023.06.26.04.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PULL 06/18] kvm: reuse per-vcpu stats fd to avoid vcpu interruption
Date: Mon, 26 Jun 2023 13:14:33 +0200
Message-ID: <20230626111445.163573-7-pbonzini@redhat.com>
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

From: Marcelo Tosatti <mtosatti@redhat.com>

A regression has been detected in latency testing of KVM guests.
More specifically, it was observed that the cyclictest
numbers inside of an isolated vcpu (running on isolated pcpu) are:

Where a maximum of 50us is acceptable.

The implementation of KVM_GET_STATS_FD uses run_on_cpu to query
per vcpu statistics, which interrupts the vcpu (and is unnecessary).

To fix this, open the per vcpu stats fd on vcpu initialization,
and read from that fd from QEMU's main thread.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   | 30 +++++++++++++++---------------
 include/hw/core/cpu.h |  1 +
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7679f397aec..9aa898db142 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -450,6 +450,8 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
                          "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
     }
+    cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+
 err:
     return ret;
 }
@@ -4007,7 +4009,7 @@ static StatsDescriptors *find_stats_descriptors(StatsTarget target, int stats_fd
 
     /* Read stats header */
     kvm_stats_header = &descriptors->kvm_stats_header;
-    ret = read(stats_fd, kvm_stats_header, sizeof(*kvm_stats_header));
+    ret = pread(stats_fd, kvm_stats_header, sizeof(*kvm_stats_header), 0);
     if (ret != sizeof(*kvm_stats_header)) {
         error_setg(errp, "KVM stats: failed to read stats header: "
                    "expected %zu actual %zu",
@@ -4038,7 +4040,8 @@ static StatsDescriptors *find_stats_descriptors(StatsTarget target, int stats_fd
 }
 
 static void query_stats(StatsResultList **result, StatsTarget target,
-                        strList *names, int stats_fd, Error **errp)
+                        strList *names, int stats_fd, CPUState *cpu,
+                        Error **errp)
 {
     struct kvm_stats_desc *kvm_stats_desc;
     struct kvm_stats_header *kvm_stats_header;
@@ -4096,7 +4099,7 @@ static void query_stats(StatsResultList **result, StatsTarget target,
         break;
     case STATS_TARGET_VCPU:
         add_stats_entry(result, STATS_PROVIDER_KVM,
-                        current_cpu->parent_obj.canonical_path,
+                        cpu->parent_obj.canonical_path,
                         stats_list);
         break;
     default:
@@ -4133,10 +4136,9 @@ static void query_stats_schema(StatsSchemaList **result, StatsTarget target,
     add_stats_schema(result, STATS_PROVIDER_KVM, target, stats_list);
 }
 
-static void query_stats_vcpu(CPUState *cpu, run_on_cpu_data data)
+static void query_stats_vcpu(CPUState *cpu, StatsArgs *kvm_stats_args)
 {
-    StatsArgs *kvm_stats_args = (StatsArgs *) data.host_ptr;
-    int stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+    int stats_fd = cpu->kvm_vcpu_stats_fd;
     Error *local_err = NULL;
 
     if (stats_fd == -1) {
@@ -4145,14 +4147,13 @@ static void query_stats_vcpu(CPUState *cpu, run_on_cpu_data data)
         return;
     }
     query_stats(kvm_stats_args->result.stats, STATS_TARGET_VCPU,
-                kvm_stats_args->names, stats_fd, kvm_stats_args->errp);
-    close(stats_fd);
+                kvm_stats_args->names, stats_fd, cpu,
+                kvm_stats_args->errp);
 }
 
-static void query_stats_schema_vcpu(CPUState *cpu, run_on_cpu_data data)
+static void query_stats_schema_vcpu(CPUState *cpu, StatsArgs *kvm_stats_args)
 {
-    StatsArgs *kvm_stats_args = (StatsArgs *) data.host_ptr;
-    int stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+    int stats_fd = cpu->kvm_vcpu_stats_fd;
     Error *local_err = NULL;
 
     if (stats_fd == -1) {
@@ -4162,7 +4163,6 @@ static void query_stats_schema_vcpu(CPUState *cpu, run_on_cpu_data data)
     }
     query_stats_schema(kvm_stats_args->result.schema, STATS_TARGET_VCPU, stats_fd,
                        kvm_stats_args->errp);
-    close(stats_fd);
 }
 
 static void query_stats_cb(StatsResultList **result, StatsTarget target,
@@ -4180,7 +4180,7 @@ static void query_stats_cb(StatsResultList **result, StatsTarget target,
             error_setg_errno(errp, errno, "KVM stats: ioctl failed");
             return;
         }
-        query_stats(result, target, names, stats_fd, errp);
+        query_stats(result, target, names, stats_fd, NULL, errp);
         close(stats_fd);
         break;
     }
@@ -4194,7 +4194,7 @@ static void query_stats_cb(StatsResultList **result, StatsTarget target,
             if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {
                 continue;
             }
-            run_on_cpu(cpu, query_stats_vcpu, RUN_ON_CPU_HOST_PTR(&stats_args));
+            query_stats_vcpu(cpu, &stats_args);
         }
         break;
     }
@@ -4220,6 +4220,6 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
     if (first_cpu) {
         stats_args.result.schema = result;
         stats_args.errp = errp;
-        run_on_cpu(first_cpu, query_stats_schema_vcpu, RUN_ON_CPU_HOST_PTR(&stats_args));
+        query_stats_schema_vcpu(first_cpu, &stats_args);
     }
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4871ad85f07..3b765beb9b1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -402,6 +402,7 @@ struct CPUState {
     struct kvm_dirty_gfn *kvm_dirty_gfns;
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
+    int kvm_vcpu_stats_fd;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
-- 
2.41.0


