Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A2710B03
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28o8-0001EG-AF; Thu, 25 May 2023 07:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q28o6-0001Dj-4s; Thu, 25 May 2023 07:06:58 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q28o4-00025F-Ah; Thu, 25 May 2023 07:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jblAJnPWnvyFnA3yCYClNSMrQGHrKEvjN/RQraOXqjI=; b=M0qSm4wdY10z7ZDQRR9haA57ZQ
 SxjMKePIFyN8XeTs9mFx8vQ5aHDBHfeiUjNlGP7tWxEJCDfEx9jYRIW9C2PtNM6hn646LrDJOJPgQ
 USS/DGFiSNsMDl4MKvXdoO7Q/8ccgj/OKngf2AjBko9JhMiBLCUZgKbFrHhNLIMb6VRMSAbP5sfRL
 3sJjbkx5CoIjlxwy1WDfC9W0BRT8Omyov1iwmu31RoPMSnT1y/ixoRMaLnTtfEocaVzfL1VDVcdAS
 9Gb2ZWKDO1R8zzb1Yls6ybNYRCmxh0za4uxxk5SD6Lcu+UJi9ARXG0pcXg2v+pW10T7itvC4DgRWZ
 YrucreEuUMJfOZ83U6iUJatJJl+LqtQo5x+1sSrUDEplkBFZcnN85yl+wtvG+VOdbKGzodDyK36Ni
 HNWcuWFwmYzZzhWLa/29NK/CzsRsblpHS5gNc6vHPS3jrGaNeT89XNyNDEOcIwCeNXTD4Fg8YNxO3
 KdybIcC9D8yRI3YpCQQtvyVu9XcDOcEMASOncew3fAoMXDQdDv4SmUCsBdVwH7xxonCTQCpct5/xF
 n80M92OKMq6wp7rJgZxGHZfuuI1v07uNzqVn+97r2Sy//k7tEx08dEDmmPgvLYlAUGoolcgFMWwEB
 z4RLY9+vrl9uqaYHo/tZCA9+Y/217dewyDzOGgRW8=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q28nx-000CG5-Fj; Thu, 25 May 2023 12:06:49 +0100
Message-ID: <87675164-50ce-a387-12a8-f965b450eb28@ilande.co.uk>
Date: Thu, 25 May 2023 12:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
 <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
 <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
 <e6444d41-62ba-2381-3b26-78e75c2da56e@redhat.com>
 <CAFEAcA-BX6n3YWy+PtSED=Jex9waiez4vxqBK0+Ob3hT-SZmPg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <CAFEAcA-BX6n3YWy+PtSED=Jex9waiez4vxqBK0+Ob3hT-SZmPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/05/2023 11:44, Peter Maydell wrote:

> On Thu, 25 May 2023 at 11:32, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 25/05/2023 12.05, Peter Maydell wrote:
>>> On Tue, 23 May 2023 at 19:41, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 23/05/2023 19.30, Marcin Juszkiewicz wrote:
>>>> ...
>>>>>> (is there a reason why it can't be disabled with "-vga none" or
>>>>>> "-nodefaults"?)
>>>>>
>>>>> That's something I need to check how it should be done.
>>>>
>>>> Other boards set mc->default_display in their ...class_init
>>>> function and then use pci_vga_init() (or vga_interface_type)
>>>> to instantiate their default display adapter ... however, that
>>>> does not seem to support the bochs adapter yet (see
>>>> vga_interfaces[] in softmmu/vl.c).
>>>>
>>>> Not sure whether it's worth the effort to extend vga_interfaces[]
>>>> in vl.c
>>>
>>> Isn't that a legacy-command-line-option thing? I feel like
>>> the recommended way to select a different graphics card
>>> these days would be to use -device my-pci-vga-card ...
>>
>> "-vga" is kind of legacy, indeed, but currently the sbsa-ref hard-codes the
>> graphics card to be always available, so if you add a "-device
>> something-vga-card" on the command line, you'd get two graphic cards on your
>> machine, even if you use -nodefaults.
> 
> At least some boards do "only create the default graphics
> type if vga_interface_type != VGA_NONE".
> 
> Mostly what I would like here is consistency. But also, we
> haven't added a new item to the '-vga' option list since
> 2014, which makes me strongly suspect it's legacy and we
> should only be keeping it for backwards compatibility.
> 
>> So there needs to be at least some logic dealing with vga_interface_type if
>> we want to be able to select a different graphics card for this machine.
>> Then why not go the full way and use pci_vga_init() here, too? ... that's
>> certainly the least confusing way for the users.
> 
> Is it? From an Arm perspective, having "-vga" do anything
> at all is pretty confusing: it's a rather PC-centric option name.
> (Also pretty noticeable for the Sparc TCX/CG3 framebuffers,
> which are not VGA in any way.)

Right. From the SPARC perspective it was added to allow the user to select either the 
TCX (default) or CG3 framebuffers from the command line.

However I guess that shouldn't be needed anymore now that mc->default_display exists. 
Presumably there is now some kind of -global sun4m.default_display=cg3 command line 
option that could set the machine default_display property value instead?


ATB,

Mark.


