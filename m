Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E07970C124
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16Ym-000690-Vk; Mon, 22 May 2023 10:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q16Yf-00068F-RB
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:30:47 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q16Yd-0004sn-GK
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:30:45 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6af6df840ffso1255658a34.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684765841; x=1687357841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qzqChIr7BUoc+pjS1WfYzYrHL7ybVeo7KcQ/VSzJSW0=;
 b=Exm+pAqvjKrpYHUJVSWsrjH70g688+L6S+mw8tDRCxpUWefDaUY1RTy8qdnLg7DHPP
 Bzy4HzRlcSIkVraHNR06b57KRlhzjXY6zht2iKwFk3wKg3xjlAll3PSduaZqYB6Iy4w4
 CtRrM5dDZN95dpYU7OuJlZEQ4wwtEirFCK7T/DYammEzxPXcHI+jXvnrh1hCC/Oo4iFM
 WTv6F0qYJG5VkKceHD2AuhJ+XAXQhcjR7hZ8ypOY1s4CjfhrUK6V58qcpEbmnupr9lVy
 wW/so1ERM0UP7rYgXR/8ON9lRAWdYu+sg32GQ9R+T9rmGVe4Qm01O/3ftJhxPVLSbb5w
 FFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684765841; x=1687357841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzqChIr7BUoc+pjS1WfYzYrHL7ybVeo7KcQ/VSzJSW0=;
 b=IO2ASbIwEdmLo9nCKAiEh2fhKc1+MkWEX13wO95wJd5soXyylm2+bgFoXZ3Kw2NRCj
 vmS8gRiG1HtQnMjovvjLyQMKCYm4HLKvOTbon5VNQ763llsDXEV0Xl8hrY/nSlLQNHXq
 AmRL+QYyds8zlHf2kBRWA8gNQQ8s1wmoN1spfhrCOLtdEKdfh+wh2GhZTt8vNIw6X+uE
 PwY0GK982+/1eUZjXNQkkAfZz09lLHi103LKWc7GKuYmzlAxQAqKgzJBC+VPKoplMOp6
 9ryIiGJIe7kb8igsjAHBp4YI/lJMTQxhG4smWj3vnmhORoi+l7bi2tC1zTyJzldMmM5R
 EcSw==
X-Gm-Message-State: AC+VfDylxWbgY2FX6psCcIjoTwbGTVak3R5eZI4fAZxN6FS2/EhPwbA8
 vfBaraa3C2oM9KYDkYbYnM2QCA==
X-Google-Smtp-Source: ACHHUZ5//pvGERtI/02xBg6dNE8iTrJVBCQEbGUPM5YfZBl0zJbtWm/T96R30EA+epGUhamEzWZcbQ==
X-Received: by 2002:a05:6830:1402:b0:6ab:1fc:43b4 with SMTP id
 v2-20020a056830140200b006ab01fc43b4mr5345432otp.9.1684765841016; 
 Mon, 22 May 2023 07:30:41 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a9d62cd000000b006aafb3a4ca0sm2340674otk.70.2023.05.22.07.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 07:30:40 -0700 (PDT)
Message-ID: <61c83ef0-52f9-156b-ecab-11f8c5928118@ventanamicro.com>
Date: Mon, 22 May 2023 11:30:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] disas/riscv.c: Support disas for Zcm* extensions
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230519021926.15362-1-liweiwei@iscas.ac.cn>
 <20230519021926.15362-4-liweiwei@iscas.ac.cn>
 <0ca6bb76-ba1c-4185-6faf-e70f979849da@ventanamicro.com>
 <5d70173d-75d0-a072-2e36-777d91496df5@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5d70173d-75d0-a072-2e36-777d91496df5@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 5/22/23 11:27, Weiwei Li wrote:
> 
> On 2023/5/22 21:10, Daniel Henrique Barboza wrote:
>> In fact, apparently checkpatch.pl is not too happy about this patch:
>>
>> On 5/18/23 23:19, Weiwei Li wrote:
>>> Support disas for Zcmt* instructions only when related extensions
>>> are supported.
>>>
>>> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
>>> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
>>> ---
>>>   disas/riscv.c | 20 ++++++++++++--------
>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/disas/riscv.c b/disas/riscv.c
>>> index 729ab684da..9e01810eef 100644
>>> --- a/disas/riscv.c
>>> +++ b/disas/riscv.c
>>> @@ -2501,7 +2501,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                   op = rv_op_c_sqsp;
>>>               } else {
>>>                   op = rv_op_c_fsdsp;
>>> -                if (((inst >> 12) & 0b01)) {
>>> +                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
>>>                       switch ((inst >> 8) & 0b01111) {
>>>                       case 8:
>>>                           if (((inst >> 4) & 0b01111) >= 4) {
>>> @@ -2527,16 +2527,20 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>>                   } else {
>>>                       switch ((inst >> 10) & 0b011) {
>>>                       case 0:
>>> -                        if (((inst >> 2) & 0xFF) >= 32) {
>>> -                            op = rv_op_cm_jalt;
>>> -                        } else {
>>> -                            op = rv_op_cm_jt;
>>> +                        if (dec->cfg->ext_zcmt) {
>>> +                            if (((inst >> 2) & 0xFF) >= 32) {
>>> +                                op = rv_op_cm_jalt;
>>> +                            } else {
>>> +                                op = rv_op_cm_jt;
>>> +                            }
>>>                           }
>>>                           break;
>>>                       case 3:
>>> -                        switch ((inst >> 5) & 0b011) {
>>> -                        case 1: op = rv_op_cm_mvsa01; break;
>>> -                        case 3: op = rv_op_cm_mva01s; break;
>>> +                        if (dec->cfg->ext_zcmp) {
>>> +                            switch ((inst >> 5) & 0b011) {
>>> +                            case 1: op = rv_op_cm_mvsa01; break;
>>> +                            case 3: op = rv_op_cm_mva01s; break;
>>> +                            }
>>
>> At this point:
>>
>> ================
>> 3/7 Checking commit 989059d476f9 (disas/riscv.c: Support disas for Zcm* extensions)
>> ERROR: trailing statements should be on next line
>> #51: FILE: disas/riscv.c:2541:
>> +                            case 1: op = rv_op_cm_mvsa01; break;
>>
>> ERROR: trailing statements should be on next line
>> #52: FILE: disas/riscv.c:2542:
>> +                            case 3: op = rv_op_cm_mva01s; break;
>>
>> total: 2 errors, 0 warnings, 35 lines checked
>>
>> Patch 3/7 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> ================
>>
> Yeah. I also found this errors when I ran the checkpatch.pl.
> 
> However, this is the usual code style in this file. So I didn't fix it.

As long as the maintainer is ok with it (since it'll make noise in Gitlab when
running the test runners and so on) we can leave it as is.



Daniel

> 
> Regards,
> 
> Weiwei Li
> 
>>
>> The issue predates your patch. It would be very nice of you if you can fix it
>> though :D
>>
>>
>>
>> Daniel
>>
>>
>>>                           }
>>>                           break;
>>>                       }
> 

