Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD68201BC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLD-0006vy-DC; Fri, 29 Dec 2023 16:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL5-0006ue-5S
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:20 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL2-0006PK-9Q
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:18 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204301f2934so5196657fac.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885053; x=1704489853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFO7RAJUqXH71mzo/s8NnyQP9pZH+bYMV+IP41+DcOk=;
 b=M4ezPhHgPtlAbAfuFXoPaKHVzVOVlqdimRrKH65y2o5Lrdmic/EL8PhuE+Ped2Hdl/
 0uHOiwGX+TS5sEqtGLBozq/uakAvyjfnOxljB8gdgbgBY3x4U2+RULq3FapFxx209UQj
 wJo5atA6n5QAjjU/GnhXILz6hs68aas+57tC0RwC4dfu2jgZZLNoY1pmoqiDNPF3eNLH
 4CulStzktgTjWfEjz9QB9zO1go8B0Exd49cOfT0rCYO36eQ4Ax4Ph8soBv5kY1W0u6nr
 lLyrS6v7vcLaifdLVtsJnOo5dfTNxmMcM/MfB5/hznAjWl4WI+hcaq619dx6praqAfXG
 hJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885053; x=1704489853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFO7RAJUqXH71mzo/s8NnyQP9pZH+bYMV+IP41+DcOk=;
 b=AWr2GHu7AwToDW6DMEpuftOu+d7lambsXaYtPSqcW1amL2FgJj3ml+yPcwvvZEPTF8
 Hp5WoG6fj6eAtvZtEsGqT2BxpUnQSQWUtuMdSFu4yNAAJTTxx9pERfEwAIs9JXJkrwEJ
 kWA56MRi4ye8nm1vUdx+CThIPZmeTk73ebkbk7yHneG5PUKw3lG6U06qtLG4Mq4ZaBFP
 m22Hzz0p23rkrfMXtETepEHZreg3XV1cYhcVaG2nSKsQ5YqT8fKwQrmHF7A006yFBfkc
 CVvja0oOe+2McTlQoxrNjPzmS0VBtNPbVLPhrO+6jkLqKGZWE1lRAjsNBZZr7JTQ0AJ8
 mbGg==
X-Gm-Message-State: AOJu0YzSVBUlfn8shl3MbYotai3N39tp3HH1qPIAuAvfEftq2uBWVCsG
 B190yhczn/xZ00JyHyy7tfECPl0b58Hq0oGXlW1iVhgD9/+OKw==
X-Google-Smtp-Source: AGHT+IGy/nREhhBtVrUdQ6dEiR42PgnIhXfYAq5IOijheT77QNAFpbBhV8+1RAusteNDQwWbMdLntA==
X-Received: by 2002:a05:6870:178e:b0:204:6d0a:577b with SMTP id
 r14-20020a056870178e00b002046d0a577bmr11903266oae.21.1703885053562; 
 Fri, 29 Dec 2023 13:24:13 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/71] target/i386: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:43 +1100
Message-Id: <20231229212346.147149-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231221031652.119827-9-richard.henderson@linaro.org>
---
 target/i386/machine.c | 128 +++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index a1041ef828..c3ae320814 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -18,7 +18,7 @@ static const VMStateDescription vmstate_segment = {
     .name = "segment",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(selector, SegmentCache),
         VMSTATE_UINTTL(base, SegmentCache),
         VMSTATE_UINT32(limit, SegmentCache),
@@ -43,7 +43,7 @@ static const VMStateDescription vmstate_xmm_reg = {
     .name = "xmm_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ZMM_Q(0), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(1), ZMMReg),
         VMSTATE_END_OF_LIST()
@@ -59,7 +59,7 @@ static const VMStateDescription vmstate_ymmh_reg = {
     .name = "ymmh_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ZMM_Q(2), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(3), ZMMReg),
         VMSTATE_END_OF_LIST()
@@ -74,7 +74,7 @@ static const VMStateDescription vmstate_zmmh_reg = {
     .name = "zmmh_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ZMM_Q(4), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(5), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(6), ZMMReg),
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_hi16_zmm_reg = {
     .name = "hi16_zmm_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ZMM_Q(0), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(1), ZMMReg),
         VMSTATE_UINT64(ZMM_Q(2), ZMMReg),
@@ -114,7 +114,7 @@ static const VMStateDescription vmstate_bnd_regs = {
     .name = "bnd_regs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(lb, BNDReg),
         VMSTATE_UINT64(ub, BNDReg),
         VMSTATE_END_OF_LIST()
@@ -128,7 +128,7 @@ static const VMStateDescription vmstate_mtrr_var = {
     .name = "mtrr_var",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, MTRRVar),
         VMSTATE_UINT64(mask, MTRRVar),
         VMSTATE_END_OF_LIST()
@@ -142,7 +142,7 @@ static const VMStateDescription vmstate_lbr_records_var = {
     .name = "lbr_records_var",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(from, LBREntry),
         VMSTATE_UINT64(to, LBREntry),
         VMSTATE_UINT64(info, LBREntry),
@@ -201,7 +201,7 @@ static const VMStateDescription vmstate_fpreg_tmp = {
     .name = "fpreg_tmp",
     .post_load = fpreg_post_load,
     .pre_save  = fpreg_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tmp_mant, x86_FPReg_tmp),
         VMSTATE_UINT16(tmp_exp, x86_FPReg_tmp),
         VMSTATE_END_OF_LIST()
@@ -210,7 +210,7 @@ static const VMStateDescription vmstate_fpreg_tmp = {
 
 static const VMStateDescription vmstate_fpreg = {
     .name = "fpreg",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(FPReg, x86_FPReg_tmp, vmstate_fpreg_tmp),
         VMSTATE_END_OF_LIST()
     }
@@ -453,7 +453,7 @@ static const VMStateDescription vmstate_exception_info = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = exception_info_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(env.exception_pending, X86CPU),
         VMSTATE_UINT8(env.exception_injected, X86CPU),
         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
@@ -475,7 +475,7 @@ static const VMStateDescription vmstate_steal_time_msr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = steal_time_msr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.steal_time_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -486,7 +486,7 @@ static const VMStateDescription vmstate_async_pf_msr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = async_pf_msr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.async_pf_en_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -497,7 +497,7 @@ static const VMStateDescription vmstate_async_pf_int_msr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = async_pf_int_msr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.async_pf_int_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -508,7 +508,7 @@ static const VMStateDescription vmstate_pv_eoi_msr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pv_eoi_msr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.pv_eoi_en_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -519,7 +519,7 @@ static const VMStateDescription vmstate_poll_control_msr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = poll_control_msr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.poll_control_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -538,7 +538,7 @@ static const VMStateDescription vmstate_fpop_ip_dp = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpop_ip_dp_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(env.fpop, X86CPU),
         VMSTATE_UINT64(env.fpip, X86CPU),
         VMSTATE_UINT64(env.fpdp, X86CPU),
@@ -559,7 +559,7 @@ static const VMStateDescription vmstate_msr_tsc_adjust = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tsc_adjust_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.tsc_adjust, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -578,7 +578,7 @@ static const VMStateDescription vmstate_msr_smi_count = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = msr_smi_count_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_smi_count, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -597,7 +597,7 @@ static const VMStateDescription vmstate_msr_tscdeadline = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tscdeadline_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.tsc_deadline, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -624,7 +624,7 @@ static const VMStateDescription vmstate_msr_ia32_misc_enable = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = misc_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_ia32_misc_enable, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -635,7 +635,7 @@ static const VMStateDescription vmstate_msr_ia32_feature_control = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = feature_control_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_ia32_feature_control, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -670,7 +670,7 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmu_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_status, X86CPU),
@@ -706,7 +706,7 @@ static const VMStateDescription vmstate_mpx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = mpx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BND_REGS(env.bnd_regs, X86CPU, 4),
         VMSTATE_UINT64(env.bndcs_regs.cfgu, X86CPU),
         VMSTATE_UINT64(env.bndcs_regs.sts, X86CPU),
@@ -728,7 +728,7 @@ static const VMStateDescription vmstate_msr_hyperv_hypercall = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_hypercall_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_guest_os_id, X86CPU),
         VMSTATE_UINT64(env.msr_hv_hypercall, X86CPU),
         VMSTATE_END_OF_LIST()
@@ -748,7 +748,7 @@ static const VMStateDescription vmstate_msr_hyperv_vapic = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_vapic_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_vapic, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -767,7 +767,7 @@ static const VMStateDescription vmstate_msr_hyperv_time = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_time_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_tsc, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -792,7 +792,7 @@ static const VMStateDescription vmstate_msr_hyperv_crash = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_crash_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.msr_hv_crash_params, X86CPU, HV_CRASH_PARAMS),
         VMSTATE_END_OF_LIST()
     }
@@ -815,7 +815,7 @@ static const VMStateDescription vmstate_msr_hyperv_runtime = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_runtime_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_runtime, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -855,7 +855,7 @@ static const VMStateDescription vmstate_msr_hyperv_synic = {
     .minimum_version_id = 1,
     .needed = hyperv_synic_enable_needed,
     .post_load = hyperv_synic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_msg_page, X86CPU),
@@ -883,7 +883,7 @@ static const VMStateDescription vmstate_msr_hyperv_stimer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_stimer_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_config, X86CPU,
                              HV_STIMER_COUNT),
         VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_count, X86CPU, HV_STIMER_COUNT),
@@ -926,7 +926,7 @@ static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
     .minimum_version_id = 1,
     .needed = hyperv_reenlightenment_enable_needed,
     .post_load = hyperv_reenlightenment_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_reenlightenment_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_tsc_emulation_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_tsc_emulation_status, X86CPU),
@@ -970,7 +970,7 @@ static const VMStateDescription vmstate_avx512 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = avx512_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.opmask_regs, X86CPU, NB_OPMASK_REGS),
         VMSTATE_ZMMH_REGS_VARS(env.xmm_regs, X86CPU, 0),
 #ifdef TARGET_X86_64
@@ -993,7 +993,7 @@ static const VMStateDescription vmstate_xss = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = xss_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.xss, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1012,7 +1012,7 @@ static const VMStateDescription vmstate_umwait = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = umwait_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.umwait, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1031,7 +1031,7 @@ static const VMStateDescription vmstate_pkru = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pkru_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32(env.pkru, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1050,7 +1050,7 @@ static const VMStateDescription vmstate_pkrs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pkrs_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32(env.pkrs, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1070,7 +1070,7 @@ static const VMStateDescription vmstate_tsc_khz = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tsc_khz_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(env.tsc_khz, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1090,7 +1090,7 @@ static const VMStateDescription vmstate_vmx_vmcs12 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmx_vmcs12_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(data.vmx[0].vmcs12,
                             struct kvm_nested_state,
                             KVM_STATE_NESTED_VMX_VMCS_SIZE),
@@ -1110,7 +1110,7 @@ static const VMStateDescription vmstate_vmx_shadow_vmcs12 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmx_shadow_vmcs12_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(data.vmx[0].shadow_vmcs12,
                             struct kvm_nested_state,
                             KVM_STATE_NESTED_VMX_VMCS_SIZE),
@@ -1131,13 +1131,13 @@ static const VMStateDescription vmstate_vmx_nested_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmx_nested_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_U64(hdr.vmx.vmxon_pa, struct kvm_nested_state),
         VMSTATE_U64(hdr.vmx.vmcs12_pa, struct kvm_nested_state),
         VMSTATE_U16(hdr.vmx.smm.flags, struct kvm_nested_state),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_vmx_vmcs12,
         &vmstate_vmx_shadow_vmcs12,
         NULL,
@@ -1162,7 +1162,7 @@ static const VMStateDescription vmstate_svm_nested_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = svm_nested_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_U64(hdr.svm.vmcb_pa, struct kvm_nested_state),
         VMSTATE_UINT8_ARRAY(data.svm[0].vmcb12,
                             struct kvm_nested_state,
@@ -1232,13 +1232,13 @@ static const VMStateDescription vmstate_kvm_nested_state = {
     .name = "cpu/kvm_nested_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_U16(flags, struct kvm_nested_state),
         VMSTATE_U16(format, struct kvm_nested_state),
         VMSTATE_U32(size, struct kvm_nested_state),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_vmx_nested_state,
         &vmstate_svm_nested_state,
         NULL
@@ -1251,7 +1251,7 @@ static const VMStateDescription vmstate_nested_state = {
     .minimum_version_id = 1,
     .needed = nested_state_needed,
     .post_load = nested_state_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER(env.nested_state, X86CPU,
                 vmstate_kvm_nested_state,
                 struct kvm_nested_state),
@@ -1269,7 +1269,7 @@ static const VMStateDescription vmstate_xen_vcpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = xen_vcpu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.xen_vcpu_info_gpa, X86CPU),
         VMSTATE_UINT64(env.xen_vcpu_info_default_gpa, X86CPU),
         VMSTATE_UINT64(env.xen_vcpu_time_info_gpa, X86CPU),
@@ -1295,7 +1295,7 @@ static const VMStateDescription vmstate_mcg_ext_ctl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = mcg_ext_ctl_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.mcg_ext_ctl, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1314,7 +1314,7 @@ static const VMStateDescription vmstate_spec_ctrl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spec_ctrl_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT64(env.spec_ctrl, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1334,7 +1334,7 @@ static const VMStateDescription amd_tsc_scale_msr_ctrl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = amd_tsc_scale_msr_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT64(env.amd_tsc_scale_msr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1367,7 +1367,7 @@ static const VMStateDescription vmstate_msr_intel_pt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = intel_pt_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_rtit_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_rtit_status, X86CPU),
         VMSTATE_UINT64(env.msr_rtit_output_base, X86CPU),
@@ -1391,7 +1391,7 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virt_ssbd_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT64(env.virt_ssbd, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1410,7 +1410,7 @@ static const VMStateDescription vmstate_svm_npt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = svm_npt_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT64(env.nested_cr3, X86CPU),
         VMSTATE_UINT32(env.nested_pg_mode, X86CPU),
         VMSTATE_END_OF_LIST()
@@ -1430,7 +1430,7 @@ static const VMStateDescription vmstate_svm_guest = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = svm_guest_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32(env.int_ctl, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1450,7 +1450,7 @@ static const VMStateDescription vmstate_efer32 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = intel_efer32_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.efer, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1470,7 +1470,7 @@ static const VMStateDescription vmstate_msr_tsx_ctrl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = msr_tsx_ctrl_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.tsx_ctrl, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1489,7 +1489,7 @@ static const VMStateDescription vmstate_msr_intel_sgx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = intel_sgx_msrs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.msr_ia32_sgxlepubkeyhash, X86CPU, 4),
                 VMSTATE_END_OF_LIST()
             }
@@ -1517,7 +1517,7 @@ static const VMStateDescription vmstate_pdptrs = {
     .minimum_version_id = 1,
     .needed = pdptrs_needed,
     .post_load = pdptrs_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.pdptrs, X86CPU, 4),
         VMSTATE_END_OF_LIST()
     }
@@ -1536,7 +1536,7 @@ static const VMStateDescription vmstate_msr_xfd = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = xfd_msrs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_xfd, X86CPU),
         VMSTATE_UINT64(env.msr_xfd_err, X86CPU),
         VMSTATE_END_OF_LIST()
@@ -1557,7 +1557,7 @@ static const VMStateDescription vmstate_amx_xtile = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = amx_xtile_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(env.xtilecfg, X86CPU, 64),
         VMSTATE_UINT8_ARRAY(env.xtiledata, X86CPU, 8192),
         VMSTATE_END_OF_LIST()
@@ -1578,7 +1578,7 @@ static const VMStateDescription vmstate_arch_lbr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = arch_lbr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_lbr_ctl, X86CPU),
         VMSTATE_UINT64(env.msr_lbr_depth, X86CPU),
         VMSTATE_LBR_VARS(env.lbr_records, X86CPU, ARCH_LBR_NR_ENTRIES, 1),
@@ -1599,7 +1599,7 @@ static const VMStateDescription vmstate_triple_fault = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = triple_fault_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(env.triple_fault_pending, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1611,7 +1611,7 @@ const VMStateDescription vmstate_x86_cpu = {
     .minimum_version_id = 11,
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.regs, X86CPU, CPU_NB_REGS),
         VMSTATE_UINTTL(env.eip, X86CPU),
         VMSTATE_UINTTL(env.eflags, X86CPU),
@@ -1699,7 +1699,7 @@ const VMStateDescription vmstate_x86_cpu = {
         VMSTATE_END_OF_LIST()
         /* The above list is not sorted /wrt version numbers, watch out! */
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_exception_info,
         &vmstate_async_pf_msr,
         &vmstate_async_pf_int_msr,
-- 
2.34.1


