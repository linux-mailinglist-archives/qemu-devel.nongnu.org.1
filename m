Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061DA712B3B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahl-00030s-Gz; Fri, 26 May 2023 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahf-0002yD-Qy
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahc-0002Gf-QJ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so7038535e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120047; x=1687712047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XebfzUZQBA1ilEy0+7OzzMavlGn27zqK0j5kHcKVcZ8=;
 b=G1ZstibEcg18v8h9VhpbGDwtrbPFarVRqdB5MPlj1XmM9+q4IrOyYGbA+f32+wSpd7
 gz9C4AZPLYdB4N9AnGzDbXpi5BR4BrNCTgk0nSKwx8OdqEqGmg6rH/ylGCEKo/d6C6WH
 41ECxith+RrVoMhOLGiOBQa4PBa4EEBdeaYCGz91HCo9p5UvAJD9dzfyOF0VdV9LwRZ2
 Jvm4CLYqUst6903yvEZnAZFjHAinhkc4ZqE9zvLvlmSnf2UN56w5GJYMu9x9ppXzPUXL
 QDwE5laBWQkSsR1rmzo+6YwZyLYgBeasL47MvaHf24r/pjNwyorssXxEK1P5bRzxsXlJ
 uEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120047; x=1687712047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XebfzUZQBA1ilEy0+7OzzMavlGn27zqK0j5kHcKVcZ8=;
 b=FDwfOZV4FIKYl7guNaWhK7HmzaJIjQY3npYFdotgcFILAuzRTxvSUs8Uon6cHp8TIC
 +dbomM7pmpRlvhU9/hQTfNMz9mcQIFqAKHhZ5n42mhlsk/e20ai3hv2WJWWKPdSUTusw
 XULXFwedb5d1wEx8nB/334tweWSAmFHdGv7pDCLhC+ncZRfRpifdkVZnb+uWBgunVUOy
 dTP1njYN3g9QgSLAZ6euw7vf3116tjfbdog3BRFiUHiZjUGBnq9H1ngG9j2TuHHCBjQB
 UItPC02YGcZrkOmeVo/EiksFDodhwuvq+bT3o6+lIvXkQ1tjwn/0O9211Romg8GZFyaY
 shPA==
X-Gm-Message-State: AC+VfDwCjiFjGzq/IjqiSuIGPzB5fIv+UZoCpqIT5XwzG5h4Sv2YbtAV
 C32DjSmXOpNSaNaxWjCzF1Cr1A==
X-Google-Smtp-Source: ACHHUZ4dVnsEpa3W+oN98k5t+oUFQt3Y/SCBdl7Ct9Fku5kPbuiAucm2olAsD8ryzcU3dlPDeoESRw==
X-Received: by 2002:a1c:f40a:0:b0:3f4:e853:6a1 with SMTP id
 z10-20020a1cf40a000000b003f4e85306a1mr2206300wma.38.1685120047514; 
 Fri, 26 May 2023 09:54:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a05600c0ac700b003f4fb5532a1sm5682160wmr.43.2023.05.26.09.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11F201FFBC;
 Fri, 26 May 2023 17:54:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 09/11] tcg: remove the final vestiges of dstate
Date: Fri, 26 May 2023 17:53:59 +0100
Message-Id: <20230526165401.574474-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now we no longer have dynamic state affecting things we can remove the
additional fields in cpu.h and simplify the TB hash calculation.

For the benchmark:

    hyperfine -w 2 -m 20 \
      "./arm-softmmu/qemu-system-arm -cpu cortex-a15 \
        -machine type=virt,highmem=off \
        -display none -m 2048 \
        -serial mon:stdio \
        -netdev user,id=unet,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=unet \
        -device virtio-scsi-pci \
        -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf \
        -device scsi-hd,drive=hd -smp 4 \
        -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage \
        -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' \
        -snapshot"

It has a marginal effect on runtime, before:

  Time (mean ± σ):     26.279 s ±  2.438 s    [User: 41.113 s, System: 1.843 s]
  Range (min … max):   24.420 s … 32.565 s    20 runs

after:

  Time (mean ± σ):     24.440 s ±  2.885 s    [User: 34.474 s, System: 2.028 s]
  Range (min … max):   21.663 s … 29.937 s    20 runs

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1358
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230524133952.3971948-9-alex.bennee@linaro.org>
---
 accel/tcg/tb-hash.h       | 6 +++---
 include/exec/exec-all.h   | 3 ---
 include/hw/core/cpu.h     | 5 -----
 accel/tcg/cpu-exec.c      | 7 +------
 accel/tcg/tb-maint.c      | 5 ++---
 accel/tcg/translate-all.c | 6 ------
 6 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 83dc610e4c..1d19c69caa 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -61,10 +61,10 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #endif /* CONFIG_SOFTMMU */
 
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
-                      uint32_t cf_mask, uint32_t trace_vcpu_dstate)
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+                      uint32_t flags, uint32_t cf_mask)
 {
-    return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
+    return qemu_xxhash6(phys_pc, pc, flags, cf_mask);
 }
 
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4d2b151986..3b1b57f6ad 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -545,9 +545,6 @@ struct TranslationBlock {
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
-    /* Per-vCPU dynamic tracing state used to generate this TB */
-    uint32_t trace_vcpu_dstate;
-
     /*
      * Above fields used for comparing
      */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 39150cf8f8..383456d1b3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -266,7 +266,6 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on_cpu_data data);
 struct qemu_work_item;
 
 #define CPU_UNSET_NUMA_NODE_ID -1
-#define CPU_TRACE_DSTATE_MAX_EVENTS 32
 
 /**
  * CPUState:
@@ -407,10 +406,6 @@ struct CPUState {
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
 
-    /* Used for events with 'vcpu' and *without* the 'disabled' properties */
-    DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
-    DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
-
     DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
 
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0e741960da..4a1dce98ff 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -175,7 +175,6 @@ struct tb_desc {
     tb_page_addr_t page_addr0;
     uint32_t flags;
     uint32_t cflags;
-    uint32_t trace_vcpu_dstate;
 };
 
 static bool tb_lookup_cmp(const void *p, const void *d)
@@ -187,7 +186,6 @@ static bool tb_lookup_cmp(const void *p, const void *d)
         tb_page_addr0(tb) == desc->page_addr0 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
-        tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
         tb_cflags(tb) == desc->cflags) {
         /* check next page if needed */
         tb_page_addr_t tb_phys_page1 = tb_page_addr1(tb);
@@ -228,7 +226,6 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.cs_base = cs_base;
     desc.flags = flags;
     desc.cflags = cflags;
-    desc.trace_vcpu_dstate = *cpu->trace_dstate;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     if (phys_pc == -1) {
@@ -236,7 +233,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     }
     desc.page_addr0 = phys_pc;
     h = tb_hash_func(phys_pc, (cflags & CF_PCREL ? 0 : pc),
-                     flags, cflags, *cpu->trace_dstate);
+                     flags, cflags);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
@@ -263,7 +260,6 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
                    jc->array[hash].pc == pc &&
                    tb->cs_base == cs_base &&
                    tb->flags == flags &&
-                   tb->trace_vcpu_dstate == *cpu->trace_dstate &&
                    tb_cflags(tb) == cflags)) {
             return tb;
         }
@@ -282,7 +278,6 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
                    tb->pc == pc &&
                    tb->cs_base == cs_base &&
                    tb->flags == flags &&
-                   tb->trace_vcpu_dstate == *cpu->trace_dstate &&
                    tb_cflags(tb) == cflags)) {
             return tb;
         }
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 991746f80f..bc1961ea55 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -50,7 +50,6 @@ static bool tb_cmp(const void *ap, const void *bp)
             a->cs_base == b->cs_base &&
             a->flags == b->flags &&
             (tb_cflags(a) & ~CF_INVALID) == (tb_cflags(b) & ~CF_INVALID) &&
-            a->trace_vcpu_dstate == b->trace_vcpu_dstate &&
             tb_page_addr0(a) == tb_page_addr0(b) &&
             tb_page_addr1(a) == tb_page_addr1(b));
 }
@@ -888,7 +887,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     /* remove the TB from the hash list */
     phys_pc = tb_page_addr0(tb);
     h = tb_hash_func(phys_pc, (orig_cflags & CF_PCREL ? 0 : tb->pc),
-                     tb->flags, orig_cflags, tb->trace_vcpu_dstate);
+                     tb->flags, orig_cflags);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
     }
@@ -969,7 +968,7 @@ TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 
     /* add in the hash table */
     h = tb_hash_func(phys_pc, (tb->cflags & CF_PCREL ? 0 : tb->pc),
-                     tb->flags, tb->cflags, tb->trace_vcpu_dstate);
+                     tb->flags, tb->cflags);
     qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
     /* remove TB from the page(s) if we couldn't insert it */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c87648b99e..bf814b9e81 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,11 +65,6 @@
 #include "internal.h"
 #include "perf.h"
 
-/* Make sure all possible CPU event bits fit in tb->trace_vcpu_dstate */
-QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
-                  sizeof_field(TranslationBlock, trace_vcpu_dstate)
-                  * BITS_PER_BYTE);
-
 TBContext tb_ctx;
 
 /*
@@ -352,7 +347,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
-    tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tb_set_page_addr0(tb, phys_pc);
     tb_set_page_addr1(tb, -1);
     tcg_ctx->gen_tb = tb;
-- 
2.39.2


