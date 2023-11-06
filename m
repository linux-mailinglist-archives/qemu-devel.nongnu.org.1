Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3017E314F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 00:23:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r08v9-0002RT-SB; Mon, 06 Nov 2023 18:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r08v1-0002RF-GB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 18:22:07 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r08uy-0003x8-Is
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 18:22:07 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b8c39a2dceso2912173a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 15:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699312923; x=1699917723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kYuq7mOGRUlCLpkfv/ILSsMW81QcHxMSuxTX0z/2Ahw=;
 b=iapME5M5o0hNJR1iWNjBHY3Cbq0MUpEkNKTDS91Yd1LNxJHoNr96JEiRKMY9H6zvy7
 /TxpjQPTDP/27PHpW0ZA9/MrbtQdHtRD+4qbsQy6+IlWuad1sklXPgAU0W0cQQxvAS4R
 T+7RhIZFAeQoqLdYWZuiFqwiSaIYQybpsW/lS2ZjXq69Pk2IW8NchEvbWoWaaqWyP4Ik
 OeZ/N42I+2JHLDSBiF7RmgFMkDatiKQbjEbD9K2qxh8a7u1R9Fbd8RMiCGMPN98NbSaj
 jgBzstaaNXNOHOKEMSQGkMm50e4TaTyTRlw92n5biZZuuNS0Y90y2RRrytf4Lf8RZSOB
 VMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699312923; x=1699917723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYuq7mOGRUlCLpkfv/ILSsMW81QcHxMSuxTX0z/2Ahw=;
 b=admULlGTyoj9hPvYEO3/GIZTduQfDSQ3cX5CygmGaRVf78JNRfy9rK6HAXPrloIqNG
 A/LxEf5PqZKQWd12hXmd/VbHzh3wLBkf+aOeH2cgKUvhEPTPrkVriUYODiGEbJYLDAp1
 KvcKQui9lyDLBm5Xgx3hZvlymUnmN7Rbp6jwVTKK5VPVPzJhp5K6KW2yAVodShrTTI3e
 8ZN64yoJfISyvSFM+XXsAPJM+oDA2O6TH4px4qO4kQcK3PZm3lGzu+qnjYQfYKGx8thM
 mAaRwHQh7IIdZqwwoAMmXQv3SrI81fdT8inf6cfRuv+0prDJhmivz24wL4iGByVGKqvf
 J5Kg==
X-Gm-Message-State: AOJu0Ywn6rGggS7TW4M6K6emjCxlc+Q6vQqM7vAXhV4jgmeUgrkZwILZ
 LwAy2VCZzuuucNleINzelQMl7Q==
X-Google-Smtp-Source: AGHT+IEJYhvyRCDzf/PFYaE2wHF3dnnJ0fWVaeU10eI0jNCDFKQkfzH+NRuH5j1mibRUwpD96LMf5A==
X-Received: by 2002:a05:6a20:2694:b0:161:2df0:eadf with SMTP id
 h20-20020a056a20269400b001612df0eadfmr19891306pze.24.1699312922839; 
 Mon, 06 Nov 2023 15:22:02 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a056a0014c200b0069ee4242f89sm6285638pfu.13.2023.11.06.15.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 15:22:02 -0800 (PST)
Message-ID: <dbaa98dc-b95b-42f5-89bf-49548dd66bb1@linaro.org>
Date: Mon, 6 Nov 2023 15:22:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] default-configs: Add TARGET_XML_FILES definition
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-2-alex.bennee@linaro.org>
 <936a0e12-f022-4d16-a21c-89e4b77f547f@linaro.org>
 <87zfzqc2ex.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87zfzqc2ex.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 11/6/23 07:44, Alex Bennée wrote:
>>> +TARGET_XML_FILES=gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
>>
>>
>> The qemu-loongarch64 binary emulates loongarch64 only, not
>> loongarch32.  The inclusion of loongarch-base32.xml here is not
>> relevant.
> 
> Does the system binary emulate both?

Yes.

Technically, the user-only binary will emulate the 32-bit cpu just fine.  But much like 
aarch64, there is no ilp32 kernel abi for loongarch.


>> That said, we don't exclude TYPE_LOONGARCH32_CPU or -cpu la132 from
>> CONFIG_USER_ONLY, which is a separate mistake.
> 
> Where should that be done?

Probably target/loongarch/cpu.c, by omitting TYPE_LOONGARCH32_CPU and "la132".


r~


