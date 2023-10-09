Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5A7BD30D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjSU-0005Wa-7f; Mon, 09 Oct 2023 02:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjSQ-0005WL-Fb
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:09:34 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjSO-0008JM-Uf
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:09:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so466294666b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696831771; x=1697436571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zm3vhcWfiG1SXdvRbaygXn3NXZYIuE9nYz3CmZSpjQg=;
 b=w87U8jzCCz/4uezWSD0x5M7ToNn3iKoe4F4bmlKgPue9vFUoOBCojcYMxOGSa5Ygf6
 tdQznKShhKC8UBNsG9LKxmhPWdHIRYnPMN4ng1zh1XojOtS8lxvGdIjwdKRgf2sZWPQk
 DyLBTCbu9NrDiaeg8/Lc4uQc3BDRxkTRROsS2oSRtY0IChZiIDRZ5oJp7GRM3WPmlYea
 3mqFC3cSlAocDu1EMAlomDfSWBd+SVbp/v6TZk7c3gNcagDT2bWtzGk/dgcMg2V9z3Hc
 SNyMrMhu2/AsjP0CJCgI+EcmQhT4ffPUK9rB4roSnpeOhODbSSFBT2f5/mw7MYk8E8WP
 B+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696831771; x=1697436571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zm3vhcWfiG1SXdvRbaygXn3NXZYIuE9nYz3CmZSpjQg=;
 b=aVBPX/f91/nJ7BdIYvB1wOJvGTkE5knCNQ+vD96UwvCccGmQpersjmMKs31iHFk/4i
 2rk6blXIOSIzcq40K8L3d0KqQbTi8VRYWbH1Arod4r7ZKqtLAuYiwjdYKUxK924dLdDZ
 45Xj8lV/+nK9G4FiS2eSFFwC8/B3vntQySGIP+QfA0J9ZZ0r+CLT31kIYw8ztUIDMDUR
 /Wpm+4X1Hi6sLxh48/F8MpIks3VzqW82PWuU8gTBhOMJtK5S0DpgbcdcGgoGB1gDuv0f
 sCIXnQ4Nch2MkUypk7/O7FMSdS/ayUlwqEqpYxZZ6+nlu320Kvhf+K3NrK+thVkg2PKz
 GvRw==
X-Gm-Message-State: AOJu0YzF0XQ3zWEKwzLE43br46Xom7fmCfpKJ+edqkjn3AM/AWVYYojV
 uirpG1iriE2ylW7ugnJ9tZlPuA==
X-Google-Smtp-Source: AGHT+IG/zynIL8hsNZKXZ7/0sdyIgyVAMsE/K2T/pHU32UYXfqbwqq8HiIYuKghDYYzt6UW1YGyeJQ==
X-Received: by 2002:a17:907:7804:b0:9ae:52fb:2202 with SMTP id
 la4-20020a170907780400b009ae52fb2202mr13111534ejc.40.1696831771225; 
 Sun, 08 Oct 2023 23:09:31 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a17090616c800b009a1be9c29d7sm6422005ejd.179.2023.10.08.23.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:09:30 -0700 (PDT)
Message-ID: <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
Date: Mon, 9 Oct 2023 08:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 Thomas Huth <thuth@redhat.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005222206.2784853-4-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

Hi Brian,

On 6/10/23 00:22, Brian Cain wrote:
> The typedef `vaddr` is shadowed by `vaddr` identifiers, so we rename the
> identifiers to avoid shadowing the type name.

This one surprises me, since we have other occurences:

include/exec/memory.h:751:bool memory_get_xlat_addr(IOMMUTLBEntry 
*iotlb, void **vaddr,
	include/qemu/plugin.h:199:void qemu_plugin_vcpu_mem_cb(CPUState *cpu, 
uint64_t vaddr,
target/arm/internals.h:643:G_NORETURN void 
arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
target/i386/tcg/helper-tcg.h:70:G_NORETURN void 
handle_unaligned_access(CPUX86State *env, vaddr vaddr,
...

$ git grep -w vaddr, | wc -l
      207

What is the error/warning like?

> The global `cpu_env` is shadowed by local `cpu_env` arguments, so we
> rename the function arguments to avoid shadowing the global.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/genptr.c                 | 56 ++++++++++++-------------
>   target/hexagon/genptr.h                 | 18 ++++----
>   target/hexagon/mmvec/system_ext_mmvec.c |  4 +-
>   target/hexagon/mmvec/system_ext_mmvec.h |  2 +-
>   target/hexagon/op_helper.c              |  4 +-
>   5 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 217bc7bb5a..11377ac92b 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -334,28 +334,28 @@ void gen_set_byte_i64(int N, TCGv_i64 result, TCGv src)
>       tcg_gen_deposit_i64(result, result, src64, N * 8, 8);
>   }
>   
> -static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int mem_index)
> +static inline void gen_load_locked4u(TCGv dest, TCGv v_addr, int mem_index)
>   {
> -    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_TEUL);
> -    tcg_gen_mov_tl(hex_llsc_addr, vaddr);
> +    tcg_gen_qemu_ld_tl(dest, v_addr, mem_index, MO_TEUL);
> +    tcg_gen_mov_tl(hex_llsc_addr, v_addr);
>       tcg_gen_mov_tl(hex_llsc_val, dest);
>   }


