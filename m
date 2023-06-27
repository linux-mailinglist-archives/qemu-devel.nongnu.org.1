Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0177404F6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 22:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFFM-0004Ah-UD; Tue, 27 Jun 2023 16:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFFI-0004AF-Q5; Tue, 27 Jun 2023 16:25:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFF6-0006LI-Cf; Tue, 27 Jun 2023 16:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JHeqH5mRkRGfeiFSko6R5wIOJNPyazQPPSU2Yqbbq/E=; b=Sn4Jfu/mPTFbBj58WpuzYU/fQJ
 gse/26G20sHqUQE4Rh2FI73MK/pNOtoFFIKdwi84Gv79vDnuzNWrpmd4jNj8660sqa7LzvEs1aKZk
 pa/CXLlDGR2mc5jY1sXsZyfa9Wxk0za8RwMaz3ixOTXZn5ih4YypdCeeoT+hBTtiHGkdt0Rpgj8uQ
 YMYp+dG3lcH80DxMuh0nzIcy1fHld7eOgPykGb5nud372vrvCFtilC7twYVPWzLi8r4F/tA6UvVsl
 s3jbFwIh6dLlE5qzU648I08PbkNNJvQ5kBqaciAyuJ/yvr3EZFWqGTAHD98bo559QMN3KcsKf7102
 jEj7F+xaegKPAUqjkr2SyCp/bE7pWVN7JTePX+osBYX4CFjTKDlh+mskfoR5U47thfitHVeAWAtkQ
 9p1o762uiwd3bwmtmtlF88KuEspeOn69RAZqOxSWtqMwyrl/M5+74PApOwdPLvaE08SJYPIc0dekc
 40XrPg963a1SUgLtzHBfjgXqJiootXGG1T23Em7QJrsZOnlWs/J5x+m2jydgSc3hMvJpmSdLQ28GV
 msIVZF+nF7oZjqSJI1khZq/WY2kG9+9tb7RnI1HqUHacR1l0RNs3EtvyVe1uWd4pBrr/A2wKjsFkN
 7d5fTHb2EJLOVp8oJjx/A0PgCpL8UJDIDlb38DNlY=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFEp-0006jd-2H; Tue, 27 Jun 2023 21:24:35 +0100
Message-ID: <82f73027-c219-c759-8d02-66b6161deb81@ilande.co.uk>
Date: Tue, 27 Jun 2023 21:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <ce56f339-461f-0854-cd4e-03ec750d6770@kaod.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <ce56f339-461f-0854-cd4e-03ec750d6770@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 27/06/2023 13:03, Cédric Le Goater wrote:

>>> Mac OS 9.2 fails to boot with a popup saying :
>>>          Sorry, a system error occured.
>>>          "Sound Manager"
>>>            address error
>>>          To temporarily turn off extensions, restart and
>>>          hold down the shift key
>>>
>>>
>>> Darwin and Mac OSX look OK.
>>
>> My guess would be that MacOS 9.2 is trying to access the sound chip registers which 
>> isn't implemented in QEMU for the moment (I have a separate screamer branch 
>> available, but it's not ready for primetime yet). In theory they shouldn't be 
>> accessed at all because the sound device isn't present in the OpenBIOS device tree, 
>> but this is all fairly old stuff.
>>
>> Does implementing the sound registers using a dummy device help at all?
> 
> Nope. OS 9 loops earlier (little black/white disk spinning).
> 
> Thanks,
> 
> C.

Hmmm that's annoying. Another one to add to the TODO list then...


ATB,

Mark.


