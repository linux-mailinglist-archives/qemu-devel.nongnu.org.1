Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58A86A26D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 23:26:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sH-0006vM-0K; Tue, 27 Feb 2024 17:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GmHeZQcKCosz3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com>)
 id 1rf5sE-0006tv-Dg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:30 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GmHeZQcKCosz3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com>)
 id 1rf5sC-0008Il-Q3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:30 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-608e4171382so37672347b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072666; x=1709677466; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3K58JDMdIZ5vfPmp+GaHPT46hd+lszOuP6OSMvo8Vsk=;
 b=4Zwq3uu2tLLt3TAYIDi5BbFDG9GIFuchXaQwZbrzJqoOpZ7Wkr/uwUp5xNsRkfp994
 j0iar772xINVtBLlqZ46wZ6zb0OUV8WljEIMnYpa63cTol110Mf1u7Qccf3uzxLtm48u
 Jff9G/HGcZnmrePiHLMcWI7jfgxUVcL9rtu2xleyZVqMgnb3SRVQ970Q3HBFVuvUC6eo
 XwXJ+HqblXn1COsqkJkUJMRH37wBfmrAp7LrXS7ipLV3h2qsIC9R8ZaLPI0uCQKn7gDV
 pg325/+f5KjkoRkNNJ9xyp0p81qNeLDqUJxuuw0SjFsIxZ4mTuA9rYYY3XwFF2p1gno+
 ZP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072666; x=1709677466;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3K58JDMdIZ5vfPmp+GaHPT46hd+lszOuP6OSMvo8Vsk=;
 b=MzJ8oIflHrmmuB+UlIeYI7EP608pOY8FTEtG5dD26aTOLgKeGQtp5A/DG/pdySurP9
 xyVv3IVnQNbGYy0MCEF9lLlqpXJukyvAFuplRKN3NwLIfrPla7H5wbUlfQ9YqEKkhCc8
 glENsVt01OouSkH6t/u5CYFmbblKXDc9s9FiFT5kMxWUpSeDg2kSPvOeyowqLUTM2vIz
 AHAhz6SrNXMgb8x4ZbIjv6jYsYDgVhWxPAJ1T5t1a9hLJbb1FgQY4VEbQ48X467umwgq
 BTK5OR+oBIQQqsZo8PFq8v9Zo9c4ROHfpB39y58I2UCW+I/VWTd1ypcfBKLaat29fNqn
 ltuQ==
X-Gm-Message-State: AOJu0Yzv+h++MxBmRxjyfyhWg7QfxkNpEN9HvyEOLVcn4uU9USWr1+yx
 IGfFf2QrT8MB1LIBb0ko0D6RtmfVaiJe0SIGJ5LxNsTPB0GKJ+yzZVS3KEfofeHYe2gXnCi1lYK
 6O/Ch1eQtsR+EV9kTGhb+nhCD7dgvTYXUMhATM/qRwBrlfvBCj5Me6OqXvkLXV/zJ2LmonjUTn5
 Q5ii3FTnx7cqweOBiD0mEJo1Tgm+yG1UpilAJL
X-Google-Smtp-Source: AGHT+IFNdzREnNQMu+UI/6N9TfbYHTjzbA2Vjf80uTnz63+iXNsR16qOg+vYWjDtj+EgdkUhTR3CRc9o4LT3
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6902:2106:b0:dc6:d1d7:d03e with SMTP
 id dk6-20020a056902210600b00dc6d1d7d03emr60797ybb.8.1709072666145; Tue, 27
 Feb 2024 14:24:26 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:16 +0000
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-5-komlodi@google.com>
Subject: [RFC PATCH 4/5] target/arm: Add user-defined memattrs
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3GmHeZQcKCosz3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

During transactions, these get added to memory attributes at the same
time other attributes are added.

Similar to the requester ID, these are added on PTWs, GPCs, and
descriptor grabbing as well.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 target/arm/cpu.c | 2 ++
 target/arm/cpu.h | 2 ++
 target/arm/ptw.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9cfbba10c2..dcd2c16c2e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2404,6 +2404,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* For MemTxAttrs. */
     env->requester_id = cpu->requester_id;
+    env->memattr_user_defined = cpu->memattr_user_defined;
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
@@ -2443,6 +2444,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     DEFINE_PROP_UINT16("requester-id", ARMCPU, requester_id, 0),
+    DEFINE_PROP_UINT8("memattr-user-defined", ARMCPU, memattr_user_defined, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5fc572e077..499a5b25c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -777,6 +777,7 @@ typedef struct CPUArchState {
 
     /* For MemTxAttrs. */
     uint16_t requester_id;
+    uint8_t memattr_user_defined;
 } CPUARMState;
 
 static inline void set_feature(CPUARMState *env, int feature)
@@ -1097,6 +1098,7 @@ struct ArchCPU {
 
     /* Requester ID, used in MemTxAttrs. */
     uint16_t requester_id;
+    uint8_t memattr_user_defined;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 148af3a000..b2af3d9052 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -288,6 +288,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         .secure = true,
         .space = ARMSS_Root,
         .requester_id = env->requester_id,
+        .user_defined = env->memattr_user_defined,
     };
     ARMCPU *cpu = env_archcpu(env);
     uint64_t gpccr = env->cp15.gpccr_el3;
@@ -640,6 +641,7 @@ static uint32_t arm_ldl_ptw(CPUARMState *env, S1Translate *ptw,
             .space = ptw->out_space,
             .secure = arm_space_is_secure(ptw->out_space),
             .requester_id = env->requester_id,
+            .user_defined = env->memattr_user_defined,
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -687,6 +689,7 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
             .space = ptw->out_space,
             .secure = arm_space_is_secure(ptw->out_space),
             .requester_id = env->requester_id,
+            .user_defined = env->memattr_user_defined,
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -3310,6 +3313,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
     result->f.attrs.requester_id = env->requester_id;
+    result->f.attrs.user_defined = env->memattr_user_defined;
 
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
-- 
2.44.0.rc0.258.g7320e95886-goog


