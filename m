Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450237A094E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoJ9-0005f8-NF; Thu, 14 Sep 2023 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgoJ7-0005bL-0V
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:31:05 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgoJ3-0003BH-Fn
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:31:04 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-502e6d632b6so1491696e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694705459; x=1695310259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/bpaD3WjXp/oNm1DnwX/X7M6HzSLrNm3+sUbvz1VpaY=;
 b=ffNlEyu4YFsbEIYpzOtI9eXxbOGST1KwOr9RW5yTU1ui1UTwwgix3L2VZdihE1sIuA
 T3fDYjP0Du+xpYHR7HoDSoQU7tgQuzoSD9B2XxSB8qngMNL5AKOVRaBIRhO3Eo/UhIy7
 ue+MPP/n+H32d5ff7CnsDPxCgKHwGZBoH4u03HOXwsobY2ladcGBklgT/PrGsefsVmZb
 ii9QMDnQ85IDAOFSaqAqWUjVbmo4nEkajaaaqiS6HBttlrHjTKSpYNxuS+SbQPDmIlbj
 kTh14B9txp/LZd+2JguDu1qjkuAwFlkI1rfEq0ls8i+mMgmzGggfKiza07lO4RAQi8RT
 MEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694705459; x=1695310259;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bpaD3WjXp/oNm1DnwX/X7M6HzSLrNm3+sUbvz1VpaY=;
 b=fzdDREcqgRhLuTzLDLDHdWPQvlujZiCclXp15w/AwlFUrKJPdDFrhTrMkWfiIylx+O
 vMik2X8BczBtl5Zexww2cV4zplFk4kBETofznUk1zDis6Zq8nSrxrYBzrT4PxzKSSuZc
 zg4ZDT+4+xG3b2Cv8GTIjnPfzimTue8Y9DYMv1YQ3hlXf1Mc/lVLyloi1fQOW76jSGKr
 H9UaNZ0Bill+RQOWm82wSfG4X/94i/bEqK/r7GAaPlJxIeo6NdYCHXh55Dz7yrZGtXsN
 l7AlFYZnlRrISPlfHHcNQGCL88aOJ/R40VbIBUX1Ix3F1alzVOEF3lhgrqfg/kaFv2T0
 uBuA==
X-Gm-Message-State: AOJu0YxsF1vFaU6w+Sc6G/ECI+CFE16y+NB4WZErkSv/ua8ZXZB2kR+R
 lNTM3DwTZwQ2tJ1x7yalVUaeKuDsSBApS6sEOCk=
X-Google-Smtp-Source: AGHT+IGzHxyVxpUvvzCcAPMRLkEMgCo/YnVecRDvtOKKvVMIdWQK0WJY5ScUQKkW/11+PCceEgKxfA==
X-Received: by 2002:a05:6512:3050:b0:501:bae0:36 with SMTP id
 b16-20020a056512305000b00501bae00036mr6206799lfb.16.1694705459476; 
 Thu, 14 Sep 2023 08:30:59 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 kt26-20020a170906aada00b0098f99048053sm1180443ejb.148.2023.09.14.08.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 08:30:58 -0700 (PDT)
Message-ID: <63024472-2a8b-3c3a-3e5f-a6c6bebdd727@linaro.org>
Date: Thu, 14 Sep 2023 17:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 12/24] tcg: Rename cpu_env to tcg_env
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-13-richard.henderson@linaro.org>
 <2bc511e7-9932-dd75-fb13-c3bb0196111a@linaro.org>
In-Reply-To: <2bc511e7-9932-dd75-fb13-c3bb0196111a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/9/23 08:10, Philippe Mathieu-Daudé wrote:
> On 14/9/23 04:44, Richard Henderson wrote:
>> Allow the name 'cpu_env' to be used for something else.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg.h                             |    2 +-
>>   target/arm/tcg/translate-a32.h                |    2 +-
>>   target/arm/tcg/translate-a64.h                |    4 +-
>>   target/arm/tcg/translate.h                    |   16 +-
>>   target/hexagon/gen_tcg.h                      |  120 +-
>>   target/hexagon/gen_tcg_hvx.h                  |   20 +-
>>   target/hexagon/macros.h                       |    8 +-
>>   target/mips/tcg/translate.h                   |    6 +-
>>   accel/tcg/translator.c                        |    8 +-
>>   target/alpha/translate.c                      |  142 +-
>>   target/arm/tcg/translate-a64.c                |  374 ++---
>>   target/arm/tcg/translate-m-nocp.c             |   24 +-
>>   target/arm/tcg/translate-mve.c                |   52 +-
>>   target/arm/tcg/translate-neon.c               |   78 +-
>>   target/arm/tcg/translate-sme.c                |    8 +-
>>   target/arm/tcg/translate-sve.c                |  172 +--
>>   target/arm/tcg/translate-vfp.c                |   56 +-
>>   target/arm/tcg/translate.c                    |  228 +--
>>   target/avr/translate.c                        |   64 +-
>>   target/cris/translate.c                       |   68 +-
>>   target/hexagon/genptr.c                       |   36 +-
>>   target/hexagon/idef-parser/parser-helpers.c   |    2 +-
>>   target/hexagon/translate.c                    |   48 +-
>>   target/hppa/translate.c                       |  144 +-
>>   target/i386/tcg/translate.c                   |  580 ++++----
>>   target/loongarch/translate.c                  |   18 +-
>>   target/m68k/translate.c                       |  302 ++--
>>   target/microblaze/translate.c                 |   50 +-
>>   target/mips/tcg/lcsr_translate.c              |    6 +-
>>   target/mips/tcg/msa_translate.c               |   34 +-
>>   target/mips/tcg/mxu_translate.c               |    4 +-
>>   target/mips/tcg/translate.c                   | 1284 ++++++++---------
>>   target/mips/tcg/vr54xx_translate.c            |    2 +-
>>   target/nios2/translate.c                      |   48 +-
>>   target/openrisc/translate.c                   |   84 +-
>>   target/ppc/translate.c                        |  362 ++---
>>   target/riscv/translate.c                      |   50 +-
>>   target/rx/translate.c                         |   56 +-
>>   target/s390x/tcg/translate.c                  |  424 +++---
>>   target/sh4/translate.c                        |  124 +-
>>   target/sparc/translate.c                      |  328 ++---
>>   target/tricore/translate.c                    |  220 +--
>>   target/xtensa/translate.c                     |  188 +--
>>   tcg/tcg-op-gvec.c                             |  288 ++--
>>   tcg/tcg-op-ldst.c                             |   22 +-
>>   tcg/tcg-op.c                                  |    2 +-
>>   tcg/tcg.c                                     |    4 +-
>>   target/cris/translate_v10.c.inc               |   28 +-
>>   target/i386/tcg/decode-new.c.inc              |    2 +-
>>   target/i386/tcg/emit.c.inc                    |  262 ++--
>>   .../loongarch/insn_trans/trans_atomic.c.inc   |    4 +-
>>   .../loongarch/insn_trans/trans_branch.c.inc   |    2 +-
>>   target/loongarch/insn_trans/trans_extra.c.inc |   10 +-
>>   .../loongarch/insn_trans/trans_farith.c.inc   |    6 +-
>>   target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +-
>>   .../loongarch/insn_trans/trans_fmemory.c.inc  |    8 +-
>>   target/loongarch/insn_trans/trans_fmov.c.inc  |   20 +-
>>   target/loongarch/insn_trans/trans_lsx.c.inc   |   44 +-
>>   .../loongarch/insn_trans/trans_memory.c.inc   |    8 +-
>>   .../insn_trans/trans_privileged.c.inc         |   52 +-
>>   target/mips/tcg/micromips_translate.c.inc     |   12 +-
>>   target/mips/tcg/nanomips_translate.c.inc      |  200 +--
>>   target/ppc/power8-pmu-regs.c.inc              |    8 +-
>>   target/ppc/translate/branch-impl.c.inc        |    2 +-
>>   target/ppc/translate/dfp-impl.c.inc           |   22 +-
>>   target/ppc/translate/fixedpoint-impl.c.inc    |    2 +-
>>   target/ppc/translate/fp-impl.c.inc            |   50 +-
>>   .../ppc/translate/processor-ctrl-impl.c.inc   |    8 +-
>>   target/ppc/translate/spe-impl.c.inc           |   30 +-
>>   target/ppc/translate/storage-ctrl-impl.c.inc  |   26 +-
>>   target/ppc/translate/vmx-impl.c.inc           |   34 +-
>>   target/ppc/translate/vsx-impl.c.inc           |   54 +-
>>   .../riscv/insn_trans/trans_privileged.c.inc   |    8 +-
>>   target/riscv/insn_trans/trans_rvbf16.c.inc    |   10 +-
>>   target/riscv/insn_trans/trans_rvd.c.inc       |   48 +-
>>   target/riscv/insn_trans/trans_rvf.c.inc       |   46 +-
>>   target/riscv/insn_trans/trans_rvh.c.inc       |    8 +-
>>   target/riscv/insn_trans/trans_rvi.c.inc       |   16 +-
>>   target/riscv/insn_trans/trans_rvm.c.inc       |   16 +-
>>   target/riscv/insn_trans/trans_rvv.c.inc       |  130 +-
>>   target/riscv/insn_trans/trans_rvvk.c.inc      |   30 +-
>>   target/riscv/insn_trans/trans_rvzce.c.inc     |    2 +-
>>   target/riscv/insn_trans/trans_rvzfa.c.inc     |   38 +-
>>   target/riscv/insn_trans/trans_rvzfh.c.inc     |   54 +-
>>   target/riscv/insn_trans/trans_rvzicbo.c.inc   |    8 +-
>>   target/riscv/insn_trans/trans_svinval.c.inc   |    6 +-
>>   target/riscv/insn_trans/trans_xthead.c.inc    |    2 +-
>>   target/s390x/tcg/translate_vx.c.inc           |  104 +-
>>   target/hexagon/README                         |   10 +-
>>   target/hexagon/gen_tcg_funcs.py               |   16 +-
>>   90 files changed, 3808 insertions(+), 3808 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Missing:

-- >8 --
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5c13615112..985c980c92 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -104,7 +104,7 @@ static void gen_empty_udata_cb(void)
      TCGv_ptr udata = tcg_temp_ebb_new_ptr();

      tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, cpu_env,
+    tcg_gen_ld_i32(cpu_index, tcg_env,
                     -offsetof(ArchCPU, env) + offsetof(CPUState, 
cpu_index));
      gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);

@@ -138,7 +138,7 @@ static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t 
info)

      tcg_gen_movi_i32(meminfo, info);
      tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, cpu_env,
+    tcg_gen_ld_i32(cpu_index, tcg_env,
                     -offsetof(ArchCPU, env) + offsetof(CPUState, 
cpu_index));

      gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr, udata);
@@ -157,7 +157,7 @@ static void gen_empty_mem_helper(void)
      TCGv_ptr ptr = tcg_temp_ebb_new_ptr();

      tcg_gen_movi_ptr(ptr, 0);
-    tcg_gen_st_ptr(ptr, cpu_env, offsetof(CPUState, plugin_mem_cbs) -
+    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
                                   offsetof(ArchCPU, env));
      tcg_temp_free_ptr(ptr);
  }
@@ -581,7 +581,7 @@ void plugin_gen_disable_mem_helpers(void)
      if (!tcg_ctx->plugin_tb->mem_helper) {
          return;
      }
-    tcg_gen_st_ptr(tcg_constant_ptr(NULL), cpu_env,
+    tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
                     offsetof(CPUState, plugin_mem_cbs) - 
offsetof(ArchCPU, env));
  }

---


