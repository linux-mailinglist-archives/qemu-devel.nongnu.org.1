Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C587F5B13
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 10:30:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r660s-00005T-Kj; Thu, 23 Nov 2023 04:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r660p-000050-Fx
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 04:28:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r660n-0000MA-JE
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 04:28:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332d5c852a0so410963f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700731720; x=1701336520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LhzwxHV+Bdiyx5bPUyokPHdYwQaX3xP8WnSIJkZBw6k=;
 b=gRHyj1lXIb13dUXJhILDkN/AbZZSmrh8Kyg6UmLOedTyFVFfdMjCYmO1Ahs2zLCq1S
 T9H2qrRf7W7KM1Fjf7hjGSoH9oK0LUkeLIIbrACx56Z9rSuaGKALTV4IsxTR87TWdurn
 P5NK5LFvJ23LMOPRlDjRV4KyQDwhXfoBOxrhb7OJSowr9OprG5mjLbuoXmCo5tHpIPZZ
 NeUdR1f03H/G6dj0ba1Th5r6bz7+jFW8NnVDqpQnyJqefgcMsXsrEt82hpnonai0nDQC
 HLxzMnlFY3CokpmABEPAoI4fuwrdG7ZvjntzPEFLwer8X8DTdAPG7iLSzj/baTEV2vga
 nc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700731720; x=1701336520;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhzwxHV+Bdiyx5bPUyokPHdYwQaX3xP8WnSIJkZBw6k=;
 b=b7pG5znzfIa0MFLfd5YAZDAZBGuspKud/I4f4NhisMDZ8xOB83kJepRkzV26uOrXIW
 G3geObJImm/C+8ePz4Ygwmwq5PbKu+0zjMq0wjyKp9kSqHLbUnkX3sohvNjMeAAp+xG7
 JE0OZl54dwKxvUX1D6iNb0qWEx/bPccEG/BzY9/lmlOXzSLcaxZbfWbMPe1Ed5Fl7VW6
 6Bm8QZoPCkrO5d9sNYHBjI7m0XmA04QmB2H4c1Km020drwkEOf+q61CPKetwywOViDam
 lm1ojUWHxOUrQVy/LtnwLQ51Tme0Y3g71jGq52L41CkgxmdkhtuxYmZUsfPabc+REhCK
 M/Yg==
X-Gm-Message-State: AOJu0Yx6MSv7j3Nn+g/NnJi7zQGh6mj3/UfZ4pNN5/1UowhhsUr0vQI2
 Jc1veyCRrui2G9BR4yp3m5w=
X-Google-Smtp-Source: AGHT+IHQg35CBXWM7ovP6a+uuURYIDYPDMvLcCf1tCeYG05bGkoXJV359Re8tnwnd/6OVfkUgZwzIg==
X-Received: by 2002:a5d:4dc3:0:b0:31f:ef77:67e4 with SMTP id
 f3-20020a5d4dc3000000b0031fef7767e4mr3306792wru.37.1700731719676; 
 Thu, 23 Nov 2023 01:28:39 -0800 (PST)
Received: from [192.168.13.100] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adf978f000000b00332d41f0798sm1133102wrb.29.2023.11.23.01.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 01:28:39 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <dce4efb0-4fdc-404c-8e5d-c90ed732eb8a@xen.org>
Date: Thu, 23 Nov 2023 09:28:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
 <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221515010.2424505@ubuntu-linux-20-04-desktop>
 <87r0khz6zj.fsf@epam.com> <87cyw1z61i.fsf@epam.com>
Organization: Xen Project
In-Reply-To: <87cyw1z61i.fsf@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/11/2023 00:07, Volodymyr Babchuk wrote:
> 
> Hi,
> 
> Volodymyr Babchuk <volodymyr_babchuk@epam.com> writes:
> 
>> Hi Stefano,
>>
>> Stefano Stabellini <sstabellini@kernel.org> writes:
>>
>>> On Wed, 22 Nov 2023, David Woodhouse wrote:
>>>> On Wed, 2023-11-22 at 15:09 -0800, Stefano Stabellini wrote:
>>>>> On Wed, 22 Nov 2023, David Woodhouse wrote:
>>>>>> On Wed, 2023-11-22 at 14:29 -0800, Stefano Stabellini wrote:
>>>>>>> On Wed, 22 Nov 2023, Paul Durrant wrote:
>>>>>>>> On 21/11/2023 22:10, Volodymyr Babchuk wrote:
>>>>>>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>>>>
>>>>>>>>> Instead of forcing the owner to domid 0, use XS_PRESERVE_OWNER to
>>>>>>>>> inherit the owner of the directory.
>>>>>>>>
>>>>>>>> Ah... so that's why the previous patch is there.
>>>>>>>>
>>>>>>>> This is not the right way to fix it. The QEMU Xen support is *assuming* that
>>>>>>>> QEMU is either running in, or emulating, dom0. In the emulation case this is
>>>>>>>> probably fine, but the 'real Xen' case it should be using the correct domid
>>>>>>>> for node creation. I guess this could either be supplied on the command line
>>>>>>>> or discerned by reading the local domain 'domid' node.
>>>>>>>
>>>>>>> yes, it should be passed as command line option to QEMU
>>>>>>
>>>>>> I'm not sure I like the idea of a command line option for something
>>>>>> which QEMU could discover for itself.
>>>>>
>>>>> That's fine too. I meant to say "yes, as far as I know the toolstack
>>>>> passes the domid to QEMU as a command line option today".
>>>>
>>>> The -xen-domid argument on the QEMU command line today is the *guest*
>>>> domain ID, not the domain ID in which QEMU itself is running.
>>>>
>>>> Or were you thinking of something different?
>>>
>>> Ops, you are right and I understand your comment better now. The backend
>>> domid is not on the command line but it should be discoverable (on
>>> xenstore if I remember right).
>>
>> Yes, it is just "~/domid". I'll add a function that reads it.
> 
> Just a quick question to QEMU folks: is it better to add a global
> variable where we will store own Domain ID or it will be okay to read
> domid from Xenstore every time we need it?
> 
> If global variable variant is better, what is proffered place to define
> this variable? system/globals.c ?
> 

Actually... is it possible for QEMU just to use a relative path for the 
backend nodes? That way it won't need to know it's own domid, will it?

   Paul


