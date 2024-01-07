Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A4826468
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:05:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTlg-0005F0-06; Sun, 07 Jan 2024 09:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTle-0005EU-QE; Sun, 07 Jan 2024 09:04:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTlc-0006fX-W3; Sun, 07 Jan 2024 09:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEJoEgbFJSgvpGetzAYU6wr3cF/3P9Go4Hx6iYVVKaA=; b=OqAgtgcNQoFMX3dbDiQNqH8/uy
 2vgnguyIM4VRlpzCVABLwkmWHbbfm0b8yr6M77R1lX7TP1StjNzAH+BT/j9WPB5UUhkGNwjOebETl
 /OhZxOvGpzFMjTrsz/rEUz6CRgQAhwz1djz1IHq1QtfozDh54nL94dTP9/MrWR3+we+KU5+YbZhZO
 jtCFGKyhVMSBIX8hTw1QnvE8xYqBhmICY8hTWGTfOJap1hO+YOgLosFzA1v7+2yMaNAjuJ1rWkjYO
 JiX9kNjQW2kheoRbdAdFSzWRhm0v+RED998oTgXRPwDPudWM4v1bTgS6AI9JyfRI3+O7V/KPoI1Ny
 IIF17jiZkoMPCEpVtAu72nRK4vLNoDFib+JBM0IhalVAoIh1DlePuLjRB3l5ZGFKFCoV8nMgKLPmm
 FWi1JZuCsMBM33g3+pKPrZs5d11vVx92lmTf3Xbth6KJvYmvVBDQHqx/yMc/1ZPk3aNjAh5bOwF45
 XU6aKQBJx41d+ios06Q9m/e831yC5aP4TNZF1BKIHBFoBO3rY+MejIuHql8lH2PuE1XV3YmXcSGjE
 pghBVC3ZGdWv8/0KAUNUaIp5cgEHW/+84l5NcfFraFJdhaBNa2mnxHu7dfnn5Oocl+N50r5EzsI0/
 azqkCkM7xaVE2xVoHQFQ4esi21edL7GlDnZ+dQ6OU=;
Received: from [2a00:23c4:8bb1:9800:d580:3d66:e68a:4949]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTkx-0003dG-7K; Sun, 07 Jan 2024 14:04:07 +0000
Message-ID: <ab6ecb71-7c29-45e6-b69f-9e36d05fd6d6@ilande.co.uk>
Date: Sun, 7 Jan 2024 14:04:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 inesvarhol <inesvarhol@proton.me>, =?UTF-8?Q?In=C3=A8s_Varhol?=
 <ines.varhol@telecom-paris.fr>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
 <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
 <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:d580:3d66:e68a:4949
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/01/2024 10:13, Philippe Mathieu-Daudé wrote:

> (+Mark & Eduardo)
> 
> On 4/1/24 14:37, inesvarhol wrote:
>>
>> Le jeudi 4 janvier 2024 à 14:05, Philippe Mathieu-Daudé <philmd@linaro.org> a écrit :
>>
>> Hello,
>>
>>>> +static void test_edge_selector(void)
>>>> +{
>>>> + enable_nvic_irq(EXTI0_IRQ);
>>>> +
>>>> + / Configure EXTI line 0 irq on rising edge */
>>>> + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
>>>
>>>
>>> Markus, this qtest use seems to expect some stability in QOM path...
>>>
>>> Inès, Arnaud, having the SoC unattached is dubious, it belongs to
>>> the machine.
>>
>> Noted, we will fix that.
>> Should we be concerned about the "stability in QOM path" ?
> 
> Don't worry about this Inès, I wanted to raise Markus attention on this.
> 
> You showed a legit use of stable QOM path, and Markus told me recently
> there is no contract for QOM paths (it shouldn't be considered as a
> stable API). IIRC Markus explanation, "/unattached" container was
> added as a temporary hack to allow migrating QDev objects to QOM (see
> around commit da57febfed "qdev: give all devices a canonical path",
> 11 years ago).
> 
> I agree anything under "/unattached" can be expected to be stable
> (but we need a community consensus). Then the big question remaining
> is "can any qom-path out of /unattached be considered stable?"

For the moment I would definitely say no, and that is mainly because if we were to 
assume that QOM paths were stable today then I can see it being a barrier to updating 
older code to meet our current guidelines.

These days I think more about QOM paths being related to the lifecycle of the objects 
e.g. a machine object has child devices, which may also consist of a number of other 
children in the case of a multi-function device. For me this means that using 
object_resolve_path_component() to look up a child object seems reasonable, in 
contrast with expecting the entire path to be stable.

One thing I think about often is whether the use of device[n] is suitable within QOM 
tree. For example, if I have a command line like:

   -device foo,myprop=prop0,id=fooid0 -device foo,myprop=prop1,id=fooid1

currently they would appear in "info qom-tree" as:

   /machine
     /unattached
       /device[0] (foo)
       /device[1] (foo)

whereas it feels this could be done better as:

   /machine
     /unattached
       /foo[0] (fooid0)
       /foo[1] (fooid1)

This would automatically place devices of the same type within a QOM array to allow 
them to be accessed separately by type, or even directly via the "id" if we assume 
they are unique. In particular if you have a machine with 2 foo in-built devices you 
could then potentially configure them separately using -global foo[0].myprop=newprop0 
and/or -global foo[1].myprop=newprop1 which is something that currently isn't possible.


ATB,

Mark.


