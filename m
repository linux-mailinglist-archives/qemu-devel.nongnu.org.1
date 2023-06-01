Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE971A210
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jwN-0006ny-2d; Thu, 01 Jun 2023 11:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jwE-0006kg-Ty
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:10:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jwC-0008NE-Kr
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:10:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b02497f4cfso4819935ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685632203; x=1688224203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPFpkhNmSIasfljHxhsXshxzjRrAeoBmXk9WWKOeVNw=;
 b=V7jkL7UcV/qqKGQ4qGAi3eR47UAnTJnii7+f/7BHaIPALPJRXT74REAO1aRk/42BOE
 sJb6baWgRCVplLNdtbnJ8U+/Q9IbCS6Po50tGzz/UUOs0PLS+krH9UtcHseYqw1U70gR
 jJwP/h7CL1xO0oGYq2XIkJWjGTrCJnXPN13bMb0qQQyNDRw62cuPemJdxHD2uAp2XPGn
 +HFr06pb+Wrv0feblZCpH4qqnsL20n0si+wbFuZjL1DNz/Nn+lgJxBg2/lQpGo4QJHRD
 XaxnpBrReRY75+ijl82NrMWVHGHomc/bDNf9z7c36cAgzt1fYutggRPx3ZbtocG0Ubgv
 JtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685632203; x=1688224203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPFpkhNmSIasfljHxhsXshxzjRrAeoBmXk9WWKOeVNw=;
 b=dRAd6QHQ9i3kkS2jZQWAcGp+iQQVv07WtzkS5LvcdTqcyvYkM0INgevkEM9gClFc//
 kPa3/+XH8R134jygdcaNdHq3YRwhS5zj9mXu/RgkiJgc3VcVwGOskPftv6MTEoucHoXC
 1Jen2bVpzhrzasBV3n5n7QnA8p+VFpr/SQ6CvhlgT0Yrfn0U/XrjSYil7Zdl1zMmpNnn
 02H8BOQizKvCFIRQB9HhYNZCV1IEfcla0BdQEhd4hUeVkX1Dmh9lYn/5GAiEYQH1dZEM
 4SFif3PrT3SxuaEbJQ3m4wteaXTLPr4+iv9AUoNP3smtwPZxCN7nfxr7yBRWIOrgdanl
 5VBQ==
X-Gm-Message-State: AC+VfDy8Xsw2VDtSqIUNWi9ryOYQNgr/XkVKp6CuAf09bLtW7AF90JC7
 s2tXDeCuN+B3yjKefMBpZe5p7g==
X-Google-Smtp-Source: ACHHUZ7Vie2AGUAc+rl7CQHCNOUQtg0e9KTY+Js7KVG1R8hhIjtVX2WzcflHwWahSqM3OQbhhZSHEg==
X-Received: by 2002:a17:902:ce82:b0:1af:f751:1be9 with SMTP id
 f2-20020a170902ce8200b001aff7511be9mr7613456plg.32.1685632203174; 
 Thu, 01 Jun 2023 08:10:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902f54a00b001b03a7a40e7sm2405659plf.19.2023.06.01.08.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 08:10:02 -0700 (PDT)
Message-ID: <5cee6cfd-0e96-aadb-4e0f-6603b3e29e0c@linaro.org>
Date: Thu, 1 Jun 2023 08:10:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com>
 <3cc014aa-96ef-9a5a-f567-2e55ce37b469@linaro.org>
 <7345653a-6237-afc3-3e9f-63e31e0539b1@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7345653a-6237-afc3-3e9f-63e31e0539b1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 5/31/23 23:48, Wu, Fei wrote:
> On 6/1/2023 9:08 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> +    qatomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
>>
>> You can't qatomic_add a 64-bit value on a 32-bit host.
> 
> Right, I only changed the counters to size_t, didn't fix time part. Is
> it possible to support it with some kind of locks on 32-bit as a generic
> fallback solution? After all, 32-bit host seems not popular, it might be
> sacrifice performance a little bit.

We have

int64_t  qatomic_read_i64(const int64_t *ptr);
uint64_t qatomic_read_u64(const uint64_t *ptr);
void qatomic_set_i64(int64_t *ptr, int64_t val);
void qatomic_set_u64(uint64_t *ptr, uint64_t val);

to support 32-bit hosts. You must also use

typedef int64_t aligned_int64_t __attribute__((aligned(8)));
typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));


r~

