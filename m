Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF673C4D2
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 01:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCqJZ-0003Bt-4K; Fri, 23 Jun 2023 19:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCqJX-0003BN-LR
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 19:35:39 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCqJS-00032P-2t
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 19:35:39 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-987c932883bso139395066b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687563332; x=1690155332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ngtU88/AKh/sJj4oB/DR0AoOwWGlpBrcaY0Vs20Xzao=;
 b=hGv/3AK/HfyrDjlr2K4UJvWIWjAEel3rcdJz+R/Uk+0JPZOzAYlmh8rWsgIsIrM+jA
 d18nq2joN0mT+iOM28oPWixutjsgyMiveFwnJze1vjqhkzTKDpvlTrBsuApOvk08zA92
 i/A12euv8f0bo5Gi+ocflnJZNQstodeHxTaeB5AZYypX0odfDVxDQOwaLfypjsUHk8bF
 /gW3Z/TbHVdXadt48eQL+5elhd1HT+4Vv14FY1D9A9kTrxJU41z7tP51JYYfXJZ+cVhP
 XeN4tzvMZMnJcQxT27We6oVanqowa+cga+jpMBvkR8XmqXZAQmabqftCzvVflj2RCn56
 9P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687563332; x=1690155332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ngtU88/AKh/sJj4oB/DR0AoOwWGlpBrcaY0Vs20Xzao=;
 b=Gd1edSg//ebW3jgc0y62F6DFpQzSgfSE9baLK2uijy/7DnBfbm15QZRV5yZOWvV45L
 TmvSy7L6o0Mgftpssn4qjsSnGb+yjjVs3D/nGJR9LZmbdzkstfHeK8O6cASgReAmNvQW
 XbpwbErgHQ8bqf9wZ6HIA9AqwnMGlMNdcsRWxKF3NGTTLY5YUmxqI8su+Ey2EULprdQ8
 zUrcuGW8iR4p2c+A0KaQa0fK9cXysE0/wLBAilhROuHSckTXoWlrkMGg9J/y0JtGZd/n
 8A+jqdKySncYZCpBmgGMueeqjBa+G/lQRE4YlXcCmn5z1dZGFxSjosZ2RgMK6FoKTZgC
 qD6A==
X-Gm-Message-State: AC+VfDytJvIFjiVsEhwk26oFf9zvMLdSEFuILEdpjgZowLA7HYqpE2f4
 qofcCCqP2G29Gf76Lul3IUTypQ==
X-Google-Smtp-Source: ACHHUZ46jgoYXDnjQsSNSSyvuJfY0cE4Q57yhwSV82zhNuUFifx12eJmfSHK06xq86jZL2C5RT8GMQ==
X-Received: by 2002:a17:906:5198:b0:98d:dfde:eb80 with SMTP id
 y24-20020a170906519800b0098ddfdeeb80mr279242ejk.27.1687563332094; 
 Fri, 23 Jun 2023 16:35:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170906068c00b00969f25b96basm186823ejb.204.2023.06.23.16.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 16:35:31 -0700 (PDT)
Message-ID: <cf674f48-c083-9ad9-3801-8cbd37aecbb1@linaro.org>
Date: Sat, 24 Jun 2023 01:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/6/23 14:37, Cédric Le Goater wrote:
> On 6/23/23 11:10, Peter Maydell wrote:
>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> ppc has always silently ignored access to real (physical) addresses
>>> with nothing behind it, which can make debugging difficult at times.
>>>
>>> It looks like the way to handle this is implement the transaction
>>> failed call, which most target architectures do. Notably not x86
>>> though, I wonder why?
>>
>> Much of this is historical legacy. QEMU originally had no
>> concept of "the system outside the CPU returns some kind
>> of bus error and the CPU raises an exception for it".
>> This is turn is (I think) because the x86 PC doesn't do
>> that: you always get back some kind of response, I think
>> -1 on reads and writes ignored. We added the do_transaction_failed
>> hook largely because we wanted it to give more accurate
>> emulation of this kind of thing on Arm, but as usual with new
>> facilities we left the other architectures to do it themselves
>> if they wanted -- by default the behaviour remained the same.
>> Some architectures have picked it up; some haven't.
>>
>> The main reason it's a bit of a pain to turn the correct
>> handling on is because often boards don't actually implement
>> all the devices they're supposed to. For a pile of legacy Arm
>> boards, especially where we didn't have good test images,
>> we use the machine flag ignore_memory_transaction_failures to
>> retain the legacy behaviour. (This isn't great because it's
>> pretty much going to mean we have that flag set on those
>> boards forever because nobody is going to care enough to
>> investigate and test.)
>>
>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>> command line option or something could turn it off? It should
>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>> series up, I can propose a option for that if anybody is worried
>>> about it.
>>
>> I would not recommend going any further than maybe setting the
>> ignore_memory_transaction_failures flag for boards you don't
>> care about. (But in an ideal world, don't set it and deal with
>> any bug reports by implementing stub versions of missing devices.
>> Depends how confident you are in your test coverage.)
> 
> It seems it broke the "mac99" and  powernv10 machines, using the
> qemu-ppc-boot images which are mostly buildroot. See below for logs.

Since commit 21786c7e59 ("softmmu/memory: Log invalid memory accesses")
you can log the failed transaction with '-d guest_errors'. See for
example commit a13bfa5a05 ("hw/mips/jazz: Map the UART devices
unconditionally"):

   $ qemu-system-mips64el -M magnum -d guest_errors,unimp -bios NTPROM.RAW
   Invalid access at addr 0x80007004, size 1, region '(null)', reason: 
rejected
   Invalid access at addr 0x80007001, size 1, region '(null)', reason: 
rejected
   Invalid access at addr 0x80007002, size 1, region '(null)', reason: 
rejected
   Invalid access at addr 0x80007003, size 1, region '(null)', reason: 
rejected
   Invalid access at addr 0x80007004, size 1, region '(null)', reason: 
rejected

Boards booting successfully with ignore_memory_transaction_failures
set can often remove this flag by mapping missing accessed ranges as
TYPE_UNIMPLEMENTED_DEVICE. (You can then log the same accesses using
'-d unimp').


