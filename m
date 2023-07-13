Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F27752C17
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3qI-0005Sh-Gr; Thu, 13 Jul 2023 17:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qK3qD-0005N4-Jc
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:27:13 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qK3qA-00069t-Vb
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:27:13 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b0419f758eso1530459fac.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689283629; x=1691875629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wrEdkceJ0td0Nrg1CGVb9YxaEYI00IHdoC+2pTcgdQ8=;
 b=D/nwT/IBln8JPgZq3Ly6Zvwbilo6kCvVkGW8l/yttPN0A6GA5tf6YFxoLX3u0e4SQG
 xJi5ABP85tgMXaJGVtDljcSTpugJyzU8yAKKhN9SICY7ekTnkUSwV+RoVHTQ1x/tvonU
 185f4S4fFpVKbnG9WcND9OASns/9B55hZcTK5H/FRwkpvQEQZ14XUpxjdItJsd8nohx/
 Lr15eLRMBrsYYFvJW2sgcG5Km6s1JPRC5aDqCSK+9fIjLdNqi8QFuLyt9a13h7Sqrrcb
 YzvVC4xcjLWXy05LSpJ+VgsaeSBLOpUooxUqOlf6S5l80oWuGjA0erqn7L1KSAl3kpOC
 +h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689283629; x=1691875629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wrEdkceJ0td0Nrg1CGVb9YxaEYI00IHdoC+2pTcgdQ8=;
 b=ch2AyIEZ8ZbirKUn3BYbTViHvt8FdYX/agL88Tzq7l3vfkVa4jNxMf/DgijAUU+A0c
 WH+UkkuxO9MhLfIxpZ1DFw0RnYhliV0gQJpmjm3G4syYxscT72X1ou4i9czteAVcNG8m
 HDsivu1w9aqRIeFuIokv+m2IF8Jl47sZXN8tTZTT7HeYZbrNj7nQWfeOaOj6ULmv9Mhm
 lQVu/K43mGbox3i4XhRswP1yS4Da/mXWs+w2TFfibLtPCCgUTUeSQrixfe9VoVL7UyXx
 LHGpEAY5GTX2z8Xeh0V4oVVknaon9F9Kd3yqmztM6W+Y+NErQZNPZJewiMGud9icX5Z7
 5nJA==
X-Gm-Message-State: ABy/qLZePojgGCFoOjBE0b6wiuVpLmtLR1/t4BSW0jvCcBlTZ7X0ne/O
 /LLVFFqGkw81zz7QuW/pKoG3pA==
X-Google-Smtp-Source: APBJJlG/3XJyIauEYWnYYDWCJ2rxohrvKq+dxtsxVHCAGQMOCm37VKRzxr+LGESIrpwXQX0rfP0kwQ==
X-Received: by 2002:a05:6870:15c2:b0:1b7:4523:2af0 with SMTP id
 k2-20020a05687015c200b001b745232af0mr725495oad.2.1689283629285; 
 Thu, 13 Jul 2023 14:27:09 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 dw18-20020a056870771200b001b05c4b3b3dsm3449051oab.31.2023.07.13.14.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 14:27:09 -0700 (PDT)
Message-ID: <f26e3e23-6c15-9d8d-5750-37d43275a87a@ventanamicro.com>
Date: Thu, 13 Jul 2023 18:27:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.2 v2 5/7] target/riscv/cpu.c: add a
 ADD_CPU_PROPERTIES_ARRAY() macro
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230712205748.446931-1-dbarboza@ventanamicro.com>
 <20230712205748.446931-6-dbarboza@ventanamicro.com>
 <9626ed95-9d50-344b-696a-95998e98e3f4@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <9626ed95-9d50-344b-696a-95998e98e3f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/13/23 17:40, Richard Henderson wrote:
> On 7/12/23 21:57, Daniel Henrique Barboza wrote:
>> +#define ADD_CPU_PROPERTIES_ARRAY(_dev, _array) \
>> +    for (prop = _array; prop && prop->name; prop++) { \
>> +        qdev_property_add_static(_dev, prop); \
>> +    } \
> 
> do { } while(0)
> 
> Watch the \ on the last line of the macro.
> Declare the iterator within the macro, rather than use one defined in the outer scope.

Like this?

#define ADD_CPU_PROPERTIES_ARRAY(_dev, _array) \
     do { \
         Property *prop; \
         for (prop = _array; prop && prop->name; prop++) { \
             qdev_property_add_static(_dev, prop); \
         } \
     } while(0)

> Why not use ARRAY_SIZE?

Hm, the arrays are finishing with DEFINE_PROP_END_OF_LIST() (I copied the existing
array structure), which adds an empty element, so ARRAY_SIZE will get empty stuff
in the end.

Since these are new arrays I can get rid of the end_of_list blank element and use
ARRAY_SIZE().


Daniel
> 
> 
> r~

