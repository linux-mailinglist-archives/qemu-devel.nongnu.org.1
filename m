Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1C7C8607
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHZQ-0008L7-Co; Fri, 13 Oct 2023 08:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrHZO-0008Kt-0u
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:47:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrHZL-00007t-RQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:47:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c8a1541232so17966595ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201224; x=1697806024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p55oQCbJJPqWVKiSKNWArRdZy9RC9E6EJKodJHa2yTk=;
 b=B3NTBREKqlEGrSwW1o0zTvkawLZRZDcxE68SjodtyHXK1QJNoO3LtKPH7Yzsuf4aSw
 xkkxMrHA3cj5oBv7X5/EYqgqhzV4xh1LcNPTmqRgwZdXYAulgLTAC9TMn9zXa6lk3Wl5
 TYSS4A08GeFOevFrvL3xjSo/pLXtTDx+kAun+h/fei9XQA5KKNxfkmqVcfMdpLzmp4US
 Ryzw6aWXtR++So8KL0BlxYIYixTY51od46nE1bai3okmQeYVODJXZ3SgoJ46IiGS09yj
 V3g6HpciPwUPKm44mAR0cch2rxfeSAKnarThgAtXGrPDm+/IcqN7sbDmei74NuLfFePZ
 QIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201224; x=1697806024;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p55oQCbJJPqWVKiSKNWArRdZy9RC9E6EJKodJHa2yTk=;
 b=Skzx7J99KDsT8U22bjur7XubAPkDfJFe/EYfIO1bMiZZI/UR8KQvBQOuXV58hQmKvs
 r77SdwnyE9Ri0TzCWoDHBbwmCJNfqlA4FP24+Q2JQWRjsM1dON/nm7hFrO/WqFhfHlMP
 hNMOrp2FbtBTH7haflTsuRz0RvmjmrS4UmwwzPcHzm0H+m+s49cyMSYWw12tW6Co3Zye
 Ls0XN19wuwjXnjdZcufRLdaO5jpHhztLkbtsxisFZyo/OAOMpgOerFiWZLZQQI+njD7I
 rkHbTF08XLuJOSKDDmrS/GkVzaNx7kPbV9US9/ynU6uBrHjgCVFl5KTQQPMBBS4MSj9G
 xNig==
X-Gm-Message-State: AOJu0Yxd/ZsIsSGIRatXIanHzoV2ZYBXbIoI5MUB3Kt4gR7ZsvqwCpt0
 CD6HY7eSdGbi+jHWFTV9aIJGpg==
X-Google-Smtp-Source: AGHT+IF0CTd7F+EqjfNE9TvgbIXKjczP1xrmWlu4kKGRrwVqmBdQGbwbgD60mRQ6vLT8om8N7jntGQ==
X-Received: by 2002:a17:902:e811:b0:1b8:8af0:416f with SMTP id
 u17-20020a170902e81100b001b88af0416fmr34855543plg.1.1697201224368; 
 Fri, 13 Oct 2023 05:47:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170902ee1500b001c8836a3795sm3775824plb.271.2023.10.13.05.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 05:47:03 -0700 (PDT)
Message-ID: <06f15a55-9d19-40d8-b71f-90de8984b01a@linaro.org>
Date: Fri, 13 Oct 2023 05:47:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-16-philmd@linaro.org>
 <c580297d-c3cc-4476-a941-6dbc5e11dc43@linaro.org>
Content-Language: en-US
In-Reply-To: <c580297d-c3cc-4476-a941-6dbc5e11dc43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/12/23 21:27, Richard Henderson wrote:
> On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
>> Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
>> type, when declaring multiple CPUs of the same ArchCPU type we get
>> an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
>> use within OBJECT_DECLARE_TYPE():
>>
>>    target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
>>    OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>>    ^
>>    include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
>>        OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
>>        ^
>>    include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
>>        G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
>>        ^
>>    /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 
>> 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>>      _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
>>      ^
>>    /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro 
>> '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
>>      static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName 
>> *_ptr)                     \
>>                                       ^
>>    /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro 
>> '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
>>    #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
>>                                                    ^
>>    <scratch space>:54:1: note: expanded from here
>>    glib_autoptr_clear_ArchCPU
>>    ^
>>    target/mips/cpu-qom.h:30:1: note: previous definition is here
>>    OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
>>    ^
>>
>> Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
>> within OBJECT_DECLARE_CPU_TYPE().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Unfortunate, but I suppose this isn't so bad.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

What about adding an OBJECT_DECLARE_CPU_SUBTYPE that omits half the stuff instead?
We don't need another object typedef at all, for instance.


r~


