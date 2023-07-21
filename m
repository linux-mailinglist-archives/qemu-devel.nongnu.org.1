Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49475CD48
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsgl-00047O-E3; Fri, 21 Jul 2023 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qMsgZ-00045i-Gz; Fri, 21 Jul 2023 12:08:55 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qMsgY-00078P-1U; Fri, 21 Jul 2023 12:08:55 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9f3b57c4fso1480105a34.1; 
 Fri, 21 Jul 2023 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689955732; x=1690560532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7TDs1S7HykBaBhzxLOHqQZIFyHPmfZu+Yk5XF/5qRg=;
 b=ki6+SixKUpThrd43oTM0gV4M1xr5wu4IVZxNRpbousOf64EorvCB4savDQ/SC/9yL6
 kUd40b9w/Lwh2NucJVUbDrGXBFF/wSSPyLzrosd4sc3I0M5yuR8ZkGGhdV50xBtvPUZe
 EjI2TwdH333H87yyH0KVgzh8tsY8ebe1A2NTBocBB4kq5m9asHjOcDjuSjJH8XCZqNvF
 c6f3aMgiYEICoRcDeVZ4qMPU6yQryOxQvuRMB1b2DljGqSEqzRDUh4gnhA3Go21Ugn7j
 tEegTI15d6QHmyt7kg/ZcCtd8AcAiXHDVDOvD1o8cU10GMbbJAXmB5+J+kCzsstQl6B9
 32Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689955732; x=1690560532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7TDs1S7HykBaBhzxLOHqQZIFyHPmfZu+Yk5XF/5qRg=;
 b=EwguduI7tDItWSZ0qhRtNTRaqb3ajGpU7miQZ/unQ+6Z0cT+RqPF9Us6gPZ90+r0le
 RcwdwjEs/2glums05vkmS9YgQ8LLVXm5q50hPLkYLMwz5z1P7d7AFGp3oYLDapfkIrT6
 zp54rfVVyRc6sRluYMr6hxCbNj4tkW6fD4J5RDViIf/mFiSqf42nxgJutjcoWwkiYr/h
 LoJwgZVzdgxDaQn+m/GmQR3quO+AdImCPjEzZvoCBwq9XKSreOArvB20ugneeHp6IBQn
 rvu4Sqmr+sJQU+O1yzGbXHcTv46peO9XGmpolHyJFdvqQVnvgooVTbP/t963A7ixRQHa
 AHQw==
X-Gm-Message-State: ABy/qLZQwsOp5GZ8H4MshJKFcFgjEZnOKAGCQux84wVDkWsugIecguwJ
 sfXO/dnsXKL9aUUFJ6J98CY=
X-Google-Smtp-Source: APBJJlGiitEZMRfDqGcXd1263++jDsV0yK4BhkFOTCzNNZsozomw/kJBhjwPGOG4ofpskY2swXVsng==
X-Received: by 2002:a05:6870:f587:b0:1ba:c1e7:6b00 with SMTP id
 eh7-20020a056870f58700b001bac1e76b00mr1821834oab.3.1689955731879; 
 Fri, 21 Jul 2023 09:08:51 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 t6-20020a056870180600b001b02a3426ddsm1651597oaf.14.2023.07.21.09.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 09:08:43 -0700 (PDT)
Message-ID: <53f9edf9-1796-340a-ceb7-4b6ed1963748@gmail.com>
Date: Fri, 21 Jul 2023 13:08:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/ppc: Generate storage interrupts for radix RC
 changes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230712161322.2729950-1-sanastasio@raptorengineering.com>
 <c76c0d05-4c69-aa4f-5d20-3dfdb165a765@kaod.org>
 <1004ffbe-8855-75d1-45e7-65360bfd1807@raptorengineering.com>
 <CU7I2BT516P3.1NJPQWALJTVR@wheely>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CU7I2BT516P3.1NJPQWALJTVR@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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



On 7/20/23 23:38, Nicholas Piggin wrote:
> On Thu Jul 13, 2023 at 3:35 AM AEST, Shawn Anastasio wrote:
>> On 7/12/23 11:56 AM, Cédric Le Goater wrote:
>>> Hello Shawn,
>>>
>>> On 7/12/23 18:13, Shawn Anastasio wrote:
>>>> Change radix model to always generate a storage interrupt when the R/C
>>>> bits are not set appropriately in a PTE instead of setting the bits
>>>> itself.  According to the ISA both behaviors are valid, but in practice
>>>> this change more closely matches behavior observed on the POWER9 CPU.
>>>
>>> How did you spotted this dark corner case in emulation ? Do you have
>>> MMU unit tests ?
>>
>> I'm currently porting Xen to Power and have been using QEMU's powernv
>> model extensively for early bring up. I noticed the issue when my radix
>> implementation worked in QEMU but failed on actual hardware since I
>> didn't have a proper storage interrupt handler implemented.
> 
> Cool. This was on my todo list because we rely on it for nested HV
> KVM too.
> 
> I actually didn't know about that odd effLIPD=0 exception, but it
> looks right. How did you test that, by running with MSR[HV]=0 and
> LPIDR=0 ?
> 
> For the patch,
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Cedric, do you think this is 8.1 material?


Daniel

> 
> Thanks,
> Nick

