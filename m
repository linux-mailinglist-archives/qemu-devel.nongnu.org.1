Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C87341A8
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 16:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAWvX-0003Tw-Rp; Sat, 17 Jun 2023 10:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1qAWvV-0003TN-3F
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 10:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1qAWvT-0006jp-E4
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 10:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687012151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZErPQfnaOi1iRbKc+DoIEKgN1o6hNfwdJXjQGK4F1gU=;
 b=ceQePvLkUiDS5jILK7ef3XHk4zyOFTC9vTCj6gkojW0bhAIxbdQ3mdb60jj9IzBSNb1rfr
 25s5w4zwm9SjzShbCT6DNujShWdjE/nlPoenJRb+axA+m8WeqOD0u56jS0jdvNg4kyHt2G
 1Jn840G6WKu8C5UJOOps9/vJ9zYlS6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-ktOcF-SHMxmN9QyT6NXqRg-1; Sat, 17 Jun 2023 10:29:07 -0400
X-MC-Unique: ktOcF-SHMxmN9QyT6NXqRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C31F85A58C;
 Sat, 17 Jun 2023 14:29:07 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B4C940C95E3;
 Sat, 17 Jun 2023 14:29:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id AABD0403E9C61; Fri, 16 Jun 2023 14:44:29 -0300 (-03)
Date: Fri, 16 Jun 2023 14:44:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>
Subject: [PATCH v2] kvm: reuse per-vcpu stats fd to avoid vcpu interruption
Message-ID: <ZIyffW2qasdS4PVN@tpad>
References: <ZIiz8R3F76VqTmKO@tpad>
 <87h6rab8gv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6rab8gv.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


A regression has been detected in latency testing of KVM guests.  
More specifically, it was observed that the cyclictest  
numbers inside of an isolated vcpu (running on isolated pcpu) are:  
                                            
# Max Latencies: 00090 00096 00141  
  
Where a maximum of 50us is acceptable.   
                   
The implementation of KVM_GET_STATS_FD uses run_on_cpu to query  
per vcpu statistics, which interrupts the vcpu (and is unnecessary).  
                
To fix this, open the per vcpu stats fd on vcpu initialization,  
and read from that fd from QEMU's main thread.  
             
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>  

---

v2: use convention for Error parameter order (Markus Armbruster)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7679f397ae..9aa898db14 100644
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
index 383456d1b3..4f0fa70755 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -402,6 +402,7 @@ struct CPUState {
     struct kvm_dirty_gfn *kvm_dirty_gfns;
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
+    int kvm_vcpu_stats_fd;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;


