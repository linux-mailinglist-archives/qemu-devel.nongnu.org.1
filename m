Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F872CF04
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8msx-0003uG-AN; Mon, 12 Jun 2023 15:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8msu-0003pk-Jl; Mon, 12 Jun 2023 15:07:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mss-0000mM-1O; Mon, 12 Jun 2023 15:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zKBWPFcKe/S1cIOaZb7Cs+Th8+MuEqDvGePqW+VvoDk=; b=oR+konLBcEbFgx6IBy0f04mEGg
 3VBtjPEwJrB/TiSRVzEG52Ea4pAP3rQCC7NfPF6WGtK4xL1oFm2B8CUaJ1DTzdkhRQsdwPI3UYHeh
 HfLuaeToVSE3NEcUlGhR8daXzZuuO3u5FOEV2olfoE/wRXuv7ji0pP+hB+/BJASQM7NoEZZx2905c
 5drW4ez2OEKb1nifIOw04cJ2If/JcTBvZd0xnWyQqf+NrnpHz0ECpbxb6UmH520llGnTQB5qUqBNW
 vm+3F33JB4vFbtsg1haxMcdKcdzEI6JMBjEifN+bQepCWNTH/w49txlDKTloEvVrBkvNBAav9Ggwn
 GHC6JkpBOMPNHfcMxtNcMdArnd+vVOsPdFmkYlDoobxD59+nuaujGxpxphJSJKLrEbVU2YnhLrr0E
 8v744/Kv0XJx48UhoiHUoOI4T+Q0hze20hPRCvQHOscc0NqkvvFCWjXE4FMBYfy85AQ1DSzhPqQPX
 AdnDg7uuT8hXlsBf0p1ZGXbHywIIW/AE2rBPBhH+zGutAsnnvebdb0Cikn7J8LDRo32tdTnkqncpA
 GD4EjMi8Bmn206F6rTRmvAltCEpQdO8BBk83S4I03ceEV89P/4BY8QwUPs5UmkK1x9/iJz/SZOz6V
 GAyqEqoupUGUvEMsZT24gH4KgERLlBT296KcoRx+I=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mse-0009Jt-40; Mon, 12 Jun 2023 20:07:12 +0100
Message-ID: <138a3e15-604b-7ea9-20ef-202c0d426f58@ilande.co.uk>
Date: Mon, 12 Jun 2023 20:07:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230611110008.32638-1-shentey@gmail.com>
 <20230611110008.32638-3-shentey@gmail.com>
 <229b5f39-2a3e-e47b-5269-9ae2c43492ae@eik.bme.hu>
 <F47D47A6-B68A-46E7-BF36-C6447AC8E4CD@gmail.com>
 <24583ff5-542b-d645-378d-ce6a7b4affb7@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <24583ff5-542b-d645-378d-ce6a7b4affb7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] hw/char/parallel-isa: Export struct ISAParallelState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/06/2023 11:06, BALATON Zoltan wrote:

> On Mon, 12 Jun 2023, Bernhard Beschow wrote:
>> Am 11. Juni 2023 13:15:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>> On Sun, 11 Jun 2023, Bernhard Beschow wrote:
>>>> Allows the struct to be embedded directly into device models without additional
>>>> allocation.
>>>>
>>>> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> Patches missing SoB, checkpatch should have cought this.
>>
>> Thanks for catching again. Fixed in v2.
>>
>>>
>>> I don't see any of the machines or device models actually embedding 
>>> ISAParallelState or ParallelState so don't know what this patch is trying to 
>>> achieve. Please post the whole series with the patches that this is a preparation 
>>> for so we can se where this leads.
>>
>> No further plans from my side.
> 
> Then IMO these patches are not needed. Keeping the struct definitions in parallel.c 
> ensures they are not accessed by anything else and keeps the object encapsulation. I 
> don't see a point for moving the defs to a header if nothing wants to use them. This 
> is done for other devices to allow them to be embedded in other devices but if that's 
> not the case here then why this series? (The TYPE_ISA_PARALLEL #define seems to be 
> already in include/hw/chsr/parallel.h so if you only want to use that like in the 
> series you've referenced in the cover letter then that can be done without these 
> patches.)

The TYPE_ISA_PARALLEL constant was only moved there in commit 963e94a97b 
("hw/char/parallel: Move TYPE_ISA_PARALLEL to the header file") but having each 
separate type defined in its own file is how we've done things for some time: there 
is nothing new here.

In particular it is done this way so that ParallelState could be used on a non-ISA 
bus, and to allow users who are security conscious to compile out particular devices 
as needed.


ATB,

Mark.


