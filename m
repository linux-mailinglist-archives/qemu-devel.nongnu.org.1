Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172F7CB341
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT7Q-00048B-VD; Mon, 16 Oct 2023 15:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT7M-00045D-9x; Mon, 16 Oct 2023 15:19:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT7K-0005BS-QA; Mon, 16 Oct 2023 15:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3tfodNnojarQDHZRC1nyfFo95HeVqYori+pF9cTMMNw=; b=VH5uXLdWWe5AvhQBGBlCCH+jWq
 rkcQHrdMclqvrfwmPSFeUCtn/7l/FIWw63wLXsbYqlZFkVONVsFs4ez6F+NOOQdqsvt/B6FrJyvpo
 CsGG6Q554ktcQmacph+JxUAMPirdcF9ZyFqko2dUdapxtlfHc8+7cn1SNkxkqEd3A8RB2Ft7l9aZw
 Cs//EyfBc/lY3RCLuHX19wtD2fc7OymqK6Zs+0/BA67prIFwzEe5BYBZgSu+y/NnTq0ATew/J2vBY
 PBH+UL1i+v4a7k60QDSWpBX9Mqs2JpqK9kj2WvsoRkwVI0BthEk+n0ls3GQG2jD3lmavApk64wI16
 ecugq9/pf5pKs66w4Ac9+zdgOh0sUjg9SXpdfWvUL4Wv60vHvfm1tApTjMo0dM3zkDD/9Or3X3oyn
 0tZFEbTwFIoybc9qAGauwc6PL3gRzXAMTVVfOH0ud+iWvxBnyt61E4FnQHX6d5i5tLA0HbBVhCGCS
 gec0PHi+4SZzDioUvU6JVZqnP3CKpW3oghyvj0SbN32X9PeBVkVLx74sfLO/U3nCTUT7RhiLfY8JC
 wFoLCoyhsP7zZwX1o4ndRPJCtRrtw6gpYGrif1oMUtyRxUF6Fk/Kb43SYjXDcvdrxOFu2VTqwuByt
 IPcSYfPj0Rf4IKGoeuxNd8n+6dlK2ih5aBaEE4yIY=;
Received: from [2a00:23c4:8baf:fd00:ce7b:a14e:3566:a0fe]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT7A-000431-RI; Mon, 16 Oct 2023 20:19:00 +0100
Message-ID: <d9048b40-2667-4d0d-a8c6-3d26d92607bf@ilande.co.uk>
Date: Mon, 16 Oct 2023 20:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-2-philmd@linaro.org>
 <de55b967-a00a-41e4-b95c-c7dc4d3823e4@ilande.co.uk>
 <de48be92-4553-eaa5-6e73-59543552a95d@linaro.org>
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
In-Reply-To: <de48be92-4553-eaa5-6e73-59543552a95d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:ce7b:a14e:3566:a0fe
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/7] hw/ppc/spapr: Restrict PPCTimebase structure
 declaration to sPAPR
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16/10/2023 05:49, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 13/10/23 20:32, Mark Cave-Ayland wrote:
>> On 13/10/2023 13:56, Philippe Mathieu-Daudé wrote:
>>
>>> The PPCTimebase structure is only used by the sPAPR machine.
>>> Move its declaration to "hw/ppc/spapr.h".
>>> Move vmstate_ppc_timebase and the VMSTATE_PPC_TIMEBASE_V()
>>> macro to hw/ppc/spapr.c, along with the timebase_foo()
>>> migration helpers.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/ppc/spapr.h |   6 +++
>>>   target/ppc/cpu-qom.h   |  22 --------
>>>   hw/ppc/ppc.c           | 107 -------------------------------------
>>>   hw/ppc/spapr.c         | 116 +++++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 122 insertions(+), 129 deletions(-)
> 
> 
>> I saw this series when it was original posted, but I failed to spot that it didn't 
>> apply to the PPC Mac machines. I have a feeling this should solve a long-running 
>> issue I've been having with decrementer migration, in which case can it be moved 
>> (or left) somewhere where this is still possible?
> 
> I'm not sure I understand what you ask. Do you want this code to
> still be available for non-sPAPR machines? If so, I could move the
> declarations to target/ppc/internal.h.

Yes, that's indeed what I meant. Sorry for not being completely clear about it!


ATB,

Mark.


