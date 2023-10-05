Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 210947BA4BD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQwc-0006SE-1u; Thu, 05 Oct 2023 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoQwa-0006ON-8s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:11:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoQwY-0002LV-5b
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:11:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so7700885e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696522276; x=1697127076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ty1KmPWMs7rMR4Emx2/s6vkvtpLxnS+3uDKFkP4Nyg=;
 b=hwHpS9c2daEQJmpZZaUIRXJjpqJjrsJKZBPHJjwIZ2zfWmV0bTUT98o4mVsrruTcSN
 58UlIGbED+7Yj/Fx6cw5QVJxBJ4j1F05fVPF3v/ZcqHqBZpbPAbZEyUXEakgjR1t7aOP
 VrbHlJUVBSxxsZKgQxDyQzy2zbgIx5Q0tI9MvYop0gEQW6oBudL18iAinqoAm68bCLPP
 h889wHiUYFOePpMeSHMfjqzdlRelFz5KKFEB2K3COt6uQxAmvKRkmrFHh8hUOi/zDoZR
 tI8SKLCxaTEyRSXgXpSKeXdKZ/aFpnY/Q2ECiccRPebzLQmYfAgWDXk1kAEpQVJ+wOU3
 ZZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696522276; x=1697127076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ty1KmPWMs7rMR4Emx2/s6vkvtpLxnS+3uDKFkP4Nyg=;
 b=DO6QY7drHBLb5y9iOGO3eE+JUdo2XCZm4DQfc0h6PniZTwbZOvuve4MXsmFeBeOoVP
 TsN2avLb39vKWbAzvlSYXAV2sSy+n+/wYECiwrufoIWK7sIPKZzAFCJ1A4h74jwuxdfC
 xj+1M0xE1t9TkTkfvz3TcyxjIyPaqAm3Kt4+Olxo/JR5zhnfqfE3swLvAz70uaCr8cY6
 tEoWd5xC5xHIMIMXCXs8DuG6AfWZi87hhnZM+/R4dtjglFe8QLfIsTEP316kdb3qW1eT
 YefqeQzzte3gIPP6wDvQbCHlLap0dE/wMjZU3kO1ssImtbN3/nFy3EU7mUbJhhxNb/M0
 wBrQ==
X-Gm-Message-State: AOJu0Yy5nulwZ18gMb/90vpatJR50pR5K1CfJB3oCWrODypMOluF+CZk
 +e2s4Jmqw1SkqC7Mi15PfG0soQ==
X-Google-Smtp-Source: AGHT+IEUHKXp+Lw+0v9f3MDb7PflmOYxXqwrhm1w19j3yWhJx2JoKjR6Ldz8rTzn664m0sjdmYrrcw==
X-Received: by 2002:a05:600c:827:b0:405:2d29:1648 with SMTP id
 k39-20020a05600c082700b004052d291648mr1639584wmp.19.1696522276370; 
 Thu, 05 Oct 2023 09:11:16 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b004065d67c3c9sm1852698wmk.8.2023.10.05.09.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:11:16 -0700 (PDT)
Message-ID: <efc8219a-5207-69a3-9b5f-49040b812f33@linaro.org>
Date: Thu, 5 Oct 2023 18:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v8 2/2] tpm: add backend for mssim
Content-Language: en-US
To: jejb@linux.ibm.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231004184219.6594-1-jejb@linux.ibm.com>
 <20231004184219.6594-3-jejb@linux.ibm.com>
 <afab0b07-51b4-81e5-2e7f-03099a7be858@linaro.org>
 <6a9b9967d1f94d423aa87e6da007d8b3c3f08d31.camel@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <6a9b9967d1f94d423aa87e6da007d8b3c3f08d31.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 5/10/23 15:57, James Bottomley wrote:
> On Thu, 2023-10-05 at 08:49 +0200, Philippe Mathieu-Daudé wrote:
>> Hi James,
>>
>> On 4/10/23 20:42, James Bottomley wrote:
>>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>>>
>>> The Microsoft Simulator (mssim) is the reference emulation platform
>>> for the TCG TPM 2.0 specification.
>>>
>>> https://github.com/Microsoft/ms-tpm-20-ref.git
>>>
>>> It exports a fairly simple network socket based protocol on two
>>> sockets, one for command (default 2321) and one for control
>>> (default
>>> 2322).  This patch adds a simple backend that can speak the mssim
>>> protocol over the network.  It also allows the two sockets to be
>>> specified on the command line.  The benefits are twofold: firstly
>>> it
>>> gives us a backend that actually speaks a standard TPM emulation
>>> protocol instead of the linux specific TPM driver format of the
>>> current emulated TPM backend and secondly, using the microsoft
>>> protocol, the end point of the emulator can be anywhere on the
>>> network, facilitating the cloud use case where a central TPM
>>> service
>>> can be used over a control network.
>>>
>>> The implementation does basic control commands like power off/on,
>>> but
>>> doesn't implement cancellation or startup.  The former because
>>> cancellation is pretty much useless on a fast operating TPM
>>> emulator
>>> and the latter because this emulator is designed to be used with
>>> OVMF
>>> which itself does TPM startup and I wanted to validate that.
>>>
>>> To run this, simply download an emulator based on the MS
>>> specification
>>> (package ibmswtpm2 on openSUSE) and run it, then add these two
>>> lines
>>> to the qemu command and it will use the emulator.
>>>
>>>       -tpmdev mssim,id=tpm0 \
>>>       -device tpm-crb,tpmdev=tpm0 \
>>>
>>> to use a remote emulator replace the first line with
>>>
>>>       -tpmdev
>>> "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote'
>>> ,'port':'2321'}}"
>>>
>>> tpm-tis also works as the backend.
>>>
>>> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> ---
>>>
>>> v2: convert to SocketAddr json and use
>>> qio_channel_socket_connect_sync()
>>> v3: gate control power off by migration state keep control socket
>>> disconnected
>>>       to test outside influence and add docs.
>>> v7: TPMmssim -> TPMMssim; doc and json fixes
>>>       Make command socket open each time (makes OS debugging easier)
>>> ---
>>>    MAINTAINERS              |   6 +
>>>    backends/tpm/Kconfig     |   5 +
>>>    backends/tpm/meson.build |   1 +
>>>    backends/tpm/tpm_mssim.c | 319
>>> +++++++++++++++++++++++++++++++++++++++
>>>    backends/tpm/tpm_mssim.h |  44 ++++++
>>>    docs/specs/tpm.rst       |  39 +++++
>>>    qapi/tpm.json            |  32 +++-
>>>    softmmu/tpm-hmp-cmds.c   |   9 ++
>>>    8 files changed, 451 insertions(+), 4 deletions(-)
>>>    create mode 100644 backends/tpm/tpm_mssim.c
>>>    create mode 100644 backends/tpm/tpm_mssim.h


>>> +.. code-block:: console
>>> +
>>> +  qemu-system-x86_64 <qemu-options> \
>>> +    -tpmdev
>>> "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remot
>>> e','port':'2321'},'control':{'type':'inet','host':'remote','port':'
>>> 2322'}}" \
>>> +    -device tpm-crb,tpmdev=tpm0
>>
>> Did you test running this command line on a big-endian host?
> 
> Well no, big endian machines are rather rare nowadays.  However, since
> the QIOChannelSocket abstraction is based on SocketAddress, which is a
> qapi wrapper around strings, what makes you think the endianness would
> matter?

You use ntoh/hton in tpm_mssim_handle_request(), so I wonder about
the 'uint32_t cmd' in tpm_send_ctrl().

> 
> James
> 


