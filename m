Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973779A888
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhkH-0000Dp-LD; Mon, 11 Sep 2023 10:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfhkF-0000D4-45
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:18:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfhk8-0001P8-K3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:18:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3666410f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694441903; x=1695046703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xsp8ZoNeByD/97KEiAZ64LniCEo/AMtd8DnzqKgBwPI=;
 b=M0uteZJ0RmDfB5HcqFHfTmvnuSYUabvcKYCj5K0PtWdDzpNCO0EzR6JeP0gYT9Fdk9
 FQFJPk3Ahu34IhScQA8hO8Z/M6nYQWEuy8Aie6i5HEy0Zl8+1OffCX60y3gGIz4t1d3Q
 7zpmFSlUxIxxy4WsHFUF7wewnXb41IYPM81yvnIAQqG2spQLXPQOFmp54MQrMwJgZ5hc
 3eBQdI13lzNFtDkAcCtYnNfgd+s8OY5e2KCb4EEkkKMWcrod8hnYo9/Jcr6CcHmjVLNZ
 sN07LAaiJlbbWw3Ho1Dtk1B99et2dODprUyPVO+QH8UqLfvpzA+tzYqyD8hOYFpKsccD
 dsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694441903; x=1695046703;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsp8ZoNeByD/97KEiAZ64LniCEo/AMtd8DnzqKgBwPI=;
 b=ZTyySvGly6W+1FR39enHTZumP4zalXLa4sXexF0TCWiXUucT20LIHuwOdf3oZet0th
 KTlTxSFZKBobVo6Q4DAbieupNbGNxFySy3nAGtwY/4//X/gUrcpBJchJiIytto8hcBMo
 dAvWp8hjAC6uuw4dvB8R8Li4qBN08qalpgz2b/zUtVBepe73B5CRxuEkSD55GyfVBWhB
 KYJNV76XwccEhbM8u7UsSk/NjoSB/biTD87puqsPdShrfT3cz7p8XMYDmfnHFg2EXc00
 7tcgDDETi8EjDzBtWWZOeO2jn9Oug7k/WmIyDDPLlp16rm4QtiH9RMtnleKUNNxuo3O2
 jKwA==
X-Gm-Message-State: AOJu0YxnqYKotEWUqtodcqxyy9ikzZt4ISCprNkcRlh+hyTNvLQLOMGN
 F38uEWlMrTm2KuDsK1i437ryxw==
X-Google-Smtp-Source: AGHT+IEvQl2LaVfL4lJhdIRYlmuslm812UpivCIBPCwOnSlBoTpT1LVZVubqe6ajVcZCGqMuHHJ96w==
X-Received: by 2002:adf:fc12:0:b0:31c:e933:9593 with SMTP id
 i18-20020adffc12000000b0031ce9339593mr8300776wrr.6.1694441903071; 
 Mon, 11 Sep 2023 07:18:23 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 b11-20020a5d4d8b000000b0031416362e23sm10273378wru.3.2023.09.11.07.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 07:18:22 -0700 (PDT)
Message-ID: <730af37f-fd3a-a5ce-7090-f8cbd6e6fc9d@linaro.org>
Date: Mon, 11 Sep 2023 16:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com> <ZPtZvXcQhIWA3Iu0@redhat.com>
 <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
 <ec32b24d-9ca1-3436-0c7b-5e3ce1ee27da@linaro.org>
In-Reply-To: <ec32b24d-9ca1-3436-0c7b-5e3ce1ee27da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/9/23 12:11, Philippe Mathieu-Daudé wrote:
> On 8/9/23 21:21, Paolo Bonzini wrote:
>> On Fri, Sep 8, 2023 at 7:28 PM Kevin Wolf <kwolf@redhat.com> wrote:
>>> Maybe the calls aren't eliminated because --enable-debug implies -O0?
>>
>> My experience is that it will still fold simple dead code like "0 &&
>> foo()" or even "if (0) { ... }", but maybe it's a GCC vs. clang
>> difference. Philippe, I take it that you are looking at it?

FTR preprocessed code is indeed:

# 5682 "../../target/i386/cpu.c"
uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                             _Bool migratable_only)
{
     FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;

     if ((0)) {
         switch (wi->type) {
         case CPUID_FEATURE_WORD:
             r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
                                                         wi->cpuid.ecx,
                                                         wi->cpuid.reg);
             break;
         case MSR_FEATURE_WORD:
             r = kvm_arch_get_supported_msr_feature(kvm_state,
                         wi->msr.index);
             break;
         }
     } else if (0) {
         if (wi->type != CPUID_FEATURE_WORD) {
             return 0;
         }
         r = 0;


     } else if ((tcg_allowed)) {
         r = wi->tcg_features;
     } else {
         return ~0;
     }
# 5725 "../../target/i386/cpu.c"
     if (migratable_only) {
         r &= x86_cpu_get_migratable_flags(w);
     }
     return r;
}

static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
                                         uint32_t *eax, uint32_t *ebx,
                                         uint32_t *ecx, uint32_t *edx)
{
     if ((0)) {
         *eax = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EAX);
         *ebx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EBX);
         *ecx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_ECX);
         *edx = kvm_arch_get_supported_cpuid(kvm_state, func, index, R_EDX);
     } else if (0) {
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
     } else {
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
     }
}

Which made me wonder about this sysemu code use from useremu,
in particular because the link failure comes from
libqemu-x86_64-linux-user.fa.p. This pair of #ifdef'ry to
restrict system-specific code seems sufficient to link:

-- >8 --
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..83914d5d1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6163,6 +6163,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
index, uint32_t count,
              }
              *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */

+#ifndef CONFIG_USER_ONLY
              /*
               * SGX cannot be emulated in software.  If hardware does not
               * support enabling SGX and/or SGX flexible launch control,
@@ -6181,6 +6182,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
index, uint32_t count,
                      CPUID_7_0_ECX_SGX_LC))) {
                  *ecx &= ~CPUID_7_0_ECX_SGX_LC;
              }
+#endif
          } else if (count == 1) {
              *eax = env->features[FEAT_7_1_EAX];
              *edx = env->features[FEAT_7_1_EDX];
@@ -7152,6 +7154,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, 
bool verbose)
          mark_unavailable_features(cpu, w, unavailable_features, prefix);
      }

+#ifndef CONFIG_USER_ONLY
      if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
          kvm_enabled()) {
          KVMState *s = CPU(cpu)->kvm_state;
@@ -7179,6 +7182,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, 
bool verbose)
              mark_unavailable_features(cpu, FEAT_7_0_EBX, 
CPUID_7_0_EBX_INTEL_PT, prefix);
          }
      }
+#endif
  }
---

So I'll send a v3.


