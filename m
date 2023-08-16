Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EFC77E671
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJQx-00062C-4Z; Wed, 16 Aug 2023 12:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWJQW-00061y-QE
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:31:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWJQU-0006U7-BK
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:31:20 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2680eee423aso3741096a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692203477; x=1692808277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L5JBoVZdscOawP6Ok5uZvfaO4WVs50sKe/MJkTbxM/A=;
 b=wTHCNcjIelzoa6PqQf8o5bF7ktBAi9uUo7JroFHxfiUqS2KcJy5vhsS34k5OCH6If1
 9bUiyKd0VgAAswAQwggE+8swnnAOtYf43yialVaelrr6IEu9Nud0d6rL6ZD+kYIFvMNj
 wB51h2XpwBiXdMcRBF321y0HmGlZaaxpfcpbnKKO0OyhsgSxkG8BT+WJhbzRLLTcweop
 z2mx0xftyrLuX8J2C/ayjxvb0IMzFAXFEqDLK9kdIx68RwoiGDC4qnEEgaq2v184cnLR
 h/Ha9DDrfYobzWOC24phooIIPVVjK//wIHUNjdkhccmyT36m9qnsvdnRzTkMYZLxFsws
 yTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692203477; x=1692808277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5JBoVZdscOawP6Ok5uZvfaO4WVs50sKe/MJkTbxM/A=;
 b=CX5kVkbZiUQL73XVlyYfM3nvo6pmUTW4AAcNhkwWdrVqR/QzQVGaeCuvloT0JdJHHj
 ELlp+y6zVVhKL/XxBwNcMT4ZO5K/o/Wu2F2j9MXJ4DOn2vZrkoDUctli2PPzvR5ef+EX
 wsWO6KlWBUfLjinFgLdsG6jRn3dbsb1vUqZn+Cy77ySNx3Jik7cfvoFfKDfucc1idwDo
 r5VLETremr3YJiR/FhZ2nZlZQTHfH913TymWSZy/UxCkAOTwJlG5rTUV7t0iEiHlE1VM
 iLuvpyyCgBGbXp7FXj1EluNwXSN2MFEnisgRPCTuJHR+61U5O7SZKqnxOrtVSJJEwJW4
 g/Sw==
X-Gm-Message-State: AOJu0Yy/u1c409+fB6I52ThDJUjTicUGTv4n+3tHCb09oAAcN0777MUQ
 k/PkkaDIXsjaxEfM3m2riA3S3w==
X-Google-Smtp-Source: AGHT+IGGf3DxnLmXUh/8ooiqH36z/FcCE89xJ/84ErQc6qp1PXYmH2I5WkLNZB0RuqPLTPUEX7QP3w==
X-Received: by 2002:a17:90a:15d0:b0:269:1860:c3bd with SMTP id
 w16-20020a17090a15d000b002691860c3bdmr1800192pjd.19.1692203476832; 
 Wed, 16 Aug 2023 09:31:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a17090adf8e00b0026971450601sm11427052pjv.7.2023.08.16.09.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 09:31:16 -0700 (PDT)
Message-ID: <988e3da9-62bb-441e-811c-58f5bad24b55@daynix.com>
Date: Thu, 17 Aug 2023 01:31:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/25] hw/core/cpu: Replace gdb_core_xml_file with
 gdb_core_feature
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-7-akihiko.odaki@daynix.com>
 <7bf4aaac-e952-6d3b-0128-06dcc7f7c780@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <7bf4aaac-e952-6d3b-0128-06dcc7f7c780@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/17 0:58, Richard Henderson wrote:
> On 8/16/23 07:51, Akihiko Odaki wrote:
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index f155936289..b54162cbeb 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -391,7 +391,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, 
>> void *data)
>>       cc->gdb_write_register = hexagon_gdb_write_register;
>>       cc->gdb_num_core_regs = TOTAL_PER_THREAD_REGS;
>>       cc->gdb_stop_before_watchpoint = true;
>> -    cc->gdb_core_xml_file = "hexagon-core.xml";
>> +    cc->gdb_core_feature = gdb_find_static_feature("hexagon-core.xml");
> 
> Missing the change to init cc->gdb_num_core_regs.
> (Which presumably itself will go away at some point.)

It is initialized earlier with:
cc->gdb_num_core_regs = TOTAL_PER_THREAD_REGS;

I had no motivation to change this since it has a macro definition for 
the number of registers used elsewhere.

> 
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 02b7aad9b0..eb56226865 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7381,9 +7381,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, 
>> void *data)
>>       cc->gdb_arch_name = ppc_gdb_arch_name;
>>   #if defined(TARGET_PPC64)
>> -    cc->gdb_core_xml_file = "power64-core.xml";
>> +    cc->gdb_core_feature = gdb_find_static_feature("power64-core.xml");
>>   #else
>> -    cc->gdb_core_xml_file = "power-core.xml";
>> +    cc->gdb_core_feature = gdb_find_static_feature("power-core.xml");
>>   #endif
>>       cc->disas_set_info = ppc_disas_set_info;
> 
> Likewise.

It is initialized earlier too but with values different from what the 
XMLs say for compatibility with old GDB.

> 
> 
> 
> r~

