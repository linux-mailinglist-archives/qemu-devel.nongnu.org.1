Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D244774479
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRIx-0000fY-Sy; Tue, 08 Aug 2023 14:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRIv-0000f5-OK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:19:37 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRIu-00063y-7O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:19:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso1485313b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691518774; x=1692123574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7f874Hic4Fdanw7+UZLAxy8yxbZqClRJZFFORyrjRw=;
 b=ot/mjaTFpMzc8q5WaxgGXyqpSc/b6+O9uyPZefNMFNwS/YayQ3OSs54SgHVrzzMjJk
 msgf79RxnfQtF2IUCJckxdi2QKtHX9PLPTAaAo2hannBje0xQw0b3myyG5ktDO0kLfxu
 3eo3pXjGAE8RQVHsduLMVFih7a0rqZJypju0Syi3aL58TuuPr80qFXVxZ616OkUFelEA
 w0GM+asDq0VIQLDom1CUCvIUpBWS4td/I8bBCiqlpB0PRWB1HCEi3NvRS+dk2S6mnVPP
 mHmTggQpBOKqw1jv7Eiu/Qzf5cPg45uqk4oIvw63arXAsdYILlEpKN4q315CFfEPtW80
 Y8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691518774; x=1692123574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7f874Hic4Fdanw7+UZLAxy8yxbZqClRJZFFORyrjRw=;
 b=aHZyCAOj/PxbM/iGMRXCmoFtXBI7O2KfQZ/K8F03OXkqgWE2+2j1RUC6PRkmQLzmLx
 RDW8+ADf8lmU1yL5YQ4tcywNSeCKdCCKBWOa3QlQFghDBxCFHvr6rgAHY/AARnDDl4nF
 x72EsKBv5Uu3pal1xo1wezKdyTkxEZbJxqSUKol1KvlZlKxg4kxP/mvf9/0dTmmEKmQE
 nUwlykPcgARjjVEz1lzTjnvINKFlDe5TYFHHy3sx92JQFW5pThGA6PpnFV5w4UzWhkbl
 CsfS98F+x4rRt6dA1HW7FZlSnfsWvGOCkZVwcXluVAuOoxOm9bX9XdXPzFJWbiIt7m2F
 J7mw==
X-Gm-Message-State: AOJu0YywPNFVgma3WjNsGp+lCo7l8nSBIALAiNgxfKA9+E/51gjwLCIj
 4vSZGi40PttLCD0Klj1HJWAw+Q==
X-Google-Smtp-Source: AGHT+IEnA0FY3MPRPCV3plsxsjBRzRu18MroKF7Xlia5l7yCwBkoZ+fZHzP4ma0zZkXm2LvuAn9hbA==
X-Received: by 2002:a05:6a00:39a2:b0:66a:48db:8f6a with SMTP id
 fi34-20020a056a0039a200b0066a48db8f6amr320212pfb.12.1691518774484; 
 Tue, 08 Aug 2023 11:19:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a056a00270f00b0068718aadda7sm8393639pfv.108.2023.08.08.11.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:19:34 -0700 (PDT)
Message-ID: <aec747e6-e780-d9b4-5bbd-74d830dd714e@linaro.org>
Date: Tue, 8 Aug 2023 11:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/11] target/loongarch: Add new object class for
 loongarch32 cpus
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-3-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-3-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> Add object class for future loongarch32 cpus. It is derived from the
> loongarch64 object class.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.c | 24 ++++++++++++++++++++++++
>   target/loongarch/cpu.h | 11 +++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ad93ecac92..3bd293d00a 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -732,6 +732,10 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>   #endif
>   }
>   
> +static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
> +{
> +}
> +
>   #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
>       { \
>           .parent = TYPE_LOONGARCH_CPU, \
> @@ -754,3 +758,23 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>   };
>   
>   DEFINE_TYPES(loongarch_cpu_type_infos)
> +
> +#define DEFINE_LOONGARCH32_CPU_TYPE(model, initfn) \
> +    { \
> +        .parent = TYPE_LOONGARCH32_CPU, \
> +        .instance_init = initfn, \
> +        .name = LOONGARCH_CPU_TYPE_NAME(model), \
> +    }
> +
> +static const TypeInfo loongarch32_cpu_type_infos[] = {
> +    {
> +        .name = TYPE_LOONGARCH32_CPU,
> +        .parent = TYPE_LOONGARCH_CPU,
> +        .instance_size = sizeof(LoongArchCPU),
> +
> +        .abstract = true,
> +        .class_size = sizeof(LoongArchCPUClass),
> +        .class_init = loongarch32_cpu_class_init,
> +    },
> +};

You don't need to create a new array, you can put these into the existing 
loongarch_cpu_type_infos[] like so:


static const TypeInfo loongarch_cpu_type_infos[] = {
     {
         .name = TYPE_LOONGARCH_CPU,
         ...
     },
     {
         .name = TYPE_LOONGARCH32_CPU,
         ...
     },
     DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
};


> +#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
> +typedef struct LoongArch32CPUClass LoongArch32CPUClass;
> +DECLARE_CLASS_CHECKERS(LoongArch32CPUClass, LOONGARCH32_CPU,
> +                       TYPE_LOONGARCH32_CPU)
> +
> +struct LoongArch32CPUClass {
> +    /*< private >*/
> +    LoongArchCPUClass parent_class;
> +    /*< public >*/
> +};

You don't need to declare another struct if it's just a wrapper.
If you do declare another struct, then you must actually use it in the .class_size 
initializer.


Also, I've noticed two existing bugs:

(1) Missing alignment on fprs, which is required by tcg_gen_gvec_*:

   typedef struct CPUArchState {
       uint64_t gpr[32];
       uint64_t pc;

-     fpr_t fpr[32];
+     fpr_t fpr[32] QEMU_ALIGNED(16);


(2) Missing instance_align on the class:

     .instance_align = __alignof(LoongArchCPU),


r~



