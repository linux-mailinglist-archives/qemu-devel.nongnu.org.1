Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F2780F64
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1Ys-00065g-FX; Fri, 18 Aug 2023 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1Yq-00062Z-W6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:38:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1Ym-0006si-NA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:38:52 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso7979475ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692373127; x=1692977927;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dt2pxDLYCvtYnbd9Kcz0RsICXDPY1ubZxGRvI292KMk=;
 b=LjsPbs/BM8I25LDW2ce7pCoLWYRMGlmF5cMYynWWCDwlKcEt73zBoqTgkQxsvvcu7y
 L9dD1Uf92SyqDsFEHz0AdmDMf5J8okQwxy5g1aV0RgcVKhEm8qzhuf5XNLrWv/a6KWs8
 RIvKmJPd8xORBjXnleyfJCepJShFQHo3cyoHSnXrOrc/8RTd8mazVpqhQryAvXdZHWdf
 6HHz3dJ4npTp4eZPgLqMDreRMF0Lvr6uc/Ub72jqoeip7vDCCy0CqsEpjT7BAl1GrkSC
 jn0Q7OGTJ8WfD/13wfzI3D4HiEX0stHYSi6/KnkyuHP4pQKLfmn4OHhc86lxnVfVeePu
 p6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692373127; x=1692977927;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt2pxDLYCvtYnbd9Kcz0RsICXDPY1ubZxGRvI292KMk=;
 b=TBvVqgQcJvq0X0XOoyocnCN+vLblDe7HOwcDogYVa9Ngpyv/FHnrIob7ocWijz5c1s
 /EDGK69jvPVk5mKc09JnQldYam7eyY9nkDNVNTRjYHzBoneWfTMRDbwrduf6k0d3lWSN
 JscJChVTkfHZr5Rinsr0l4fEyXg14T6bzre0umsIu0pd2YTUKIJhoOu07df7Y7RPNSDS
 wyJxZUO++HyqEZSo4e5PQVtyhfXWTldtt6HwUeCgYuNh94UfeGqZ+eS7ItxpoIC+Pg/d
 ahV4slwWZK5xf3kEVLdOXisbdgolLuSxpJtmgiHWhm/PnuvIfxBzToRCoWFj8eiyIuq+
 qrmQ==
X-Gm-Message-State: AOJu0YxxDCp6ewVilEw4KXpHUdA3kJdTvwgN+axqOh9PLdfqkH0nGXYS
 kxhmNaZSP2AFwv8yWIM6rhEqq9NUtZ5+u9qPTC0=
X-Google-Smtp-Source: AGHT+IEI3H0EPQqLxVwSHH7hC60iwEoyGcJ01iiBxhmmvoAmB67YecV+A+RyLVkE3aicuCXVB4m9NA==
X-Received: by 2002:a17:902:e80a:b0:1bc:8fca:9d59 with SMTP id
 u10-20020a170902e80a00b001bc8fca9d59mr3026468plg.29.1692373126835; 
 Fri, 18 Aug 2023 08:38:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902748900b001ac7f583f72sm1897221pll.209.2023.08.18.08.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:38:46 -0700 (PDT)
Message-ID: <ece8e004-1d3a-e3a0-670e-53489609c90e@linaro.org>
Date: Fri, 18 Aug 2023 08:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/18] linux-user: Load vdso image if available
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230816180338.572576-1-richard.henderson@linaro.org>
 <20230816180338.572576-8-richard.henderson@linaro.org>
 <41dee294-d74c-1e58-b7c0-6325e4aea83a@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <41dee294-d74c-1e58-b7c0-6325e4aea83a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 00:28, gaosong wrote:
> Hi, Richard
> 
> 在 2023/8/17 上午2:03, Richard Henderson 写道:
>> @@ -3629,10 +3694,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info 
>> *info)
>>       }
>>       /*
>> -     * TODO: load a vdso, which would also contain the signal trampolines.
>> -     * Otherwise, allocate a private page to hold them.
>> +     * Load a vdso if available, which will amongst other things contain the
>> +     * signal trampolines.  Otherwise, allocate a separate page for them.
>>        */
>> -    if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
>> +    const VdsoImageInfo *vdso = vdso_image_info();
>> +    if (vdso) {
>> +        load_elf_vdso(&vdso_info, vdso);
>> +    } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
> I see some targets already support vdso.
> 
> ./linux-user/aarch64/vdso-be.so
> ./linux-user/aarch64/vdso-le.so
> ./linux-user/arm/vdso-arm-be.so
> ./linux-user/arm/vdso-arm-le.so
> ./linux-user/arm/vdso-thm-be.so
> ./linux-user/arm/vdso-thm-le.so
> ./linux-user/hppa/vdso.so
> ./linux-user/i386/vdso.so
> ./linux-user/loongarch64/vdso.so
> ./linux-user/ppc/vdso-32.so
> ./linux-user/ppc/vdso-64.so
> ./linux-user/ppc/vdso-64le.so
> ./linux-user/riscv/vdso-32.so
> ./linux-user/riscv/vdso-64.so
> ./linux-user/s390x/vdso.so
> ./linux-user/x86_64/vdso.so
> 
> This branch will never reach.
> 
> what about remove TARGET_ARCH_HAS_SIGTRAMP_PAGE and setup_sigtramp() for these targets?

I can do that as a follow-up, yes.

r~


