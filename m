Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC138CBF6DA
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Dec 2025 19:27:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVDGp-0003g6-2g; Mon, 15 Dec 2025 13:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vVDGm-0003bx-0b
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:26:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vVDGk-0001X2-Ak
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:26:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so42887865e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765823160; x=1766427960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3dzsXqkHvwqoBXvxlu95nqIsRk0MCO35JmcU23X3QE=;
 b=nBtili/PKexAvP+nlDiEsqxpoWSRVWyOusQX7Ygku9b0bkgn0e2DTb4mYVv7Ij1/nN
 ulDubpXq3KFs05ll3XV/yYWZfZPULLg7RtMeSGOezk8EOH6A/6HHmNobBPBJvzTnF4AE
 EFjvQY7HCS7v2GeyGGyI6beAEP/tqseOagIIhxCS4t6ekrrWPHbvCU5MZw247o30YWmX
 jkTrSBU7/lngMopoeZO+Ur4Vki3QZpCHN3TUaEWFbhnae2o8EhXh2v5LQJIBMY6jDgIY
 97XrF5NvzZJUhcao4/JlexYE9LKt2yhT3z7wpGn80OPNCvofaFSPzMMlN5tQ/M9mEXIe
 KbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765823160; x=1766427960;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3dzsXqkHvwqoBXvxlu95nqIsRk0MCO35JmcU23X3QE=;
 b=OBWPcdhawieWTvBuMH+CQkwrVZD4vQuAj5Mpu9EWzKiYVdTmTD5/AormxkDnYj+OjF
 aWE6PjwuzPKDFBGyyrjMQxsZZolhVawjpZJ3DY7TAgbe0zWdLn/KAKxegySVDB8kmude
 RBLDAbcBVRHSqOnSs8oi7vWc9vy7O1/F+uAi7OIUiMXefez3HLF2v5soq+WSKyDv/lb8
 f3y/gz3ePWoJ/mzqQBuvDV6lHk4oOOOgdpZAVrhItM37I7Ac+tIso/NP5ffwswLgvcn0
 LGBp9BHnY7Tc076s87xlTAUTyp+lU8+1koO+oymZ3qxUkRLrjLP3pqE2biXNIdCdK21E
 ZpSg==
X-Gm-Message-State: AOJu0YyqQty1flQXsh3UUTPvYIXRrpYi8DPrvCFe87yhN4Z/nntd9eFp
 PUKtivBTifnnvFOCQ2cq+3aCfQsnS9A/PF3SlV6S9TrbKr3ZrnfoLnKIvfTMrA==
X-Gm-Gg: AY/fxX497SG/7VWKHdGBfLpLGC43SxAMXqIR8U+gizrP8AHFnIRYkPLC7OPSAceNLgm
 dZsddhwuUachOZD7gNMkwkFbahAO2N63jWJ8WniatjyB02w7JwntS5FYM7pDkyqKFzKvY49En7I
 Pb020di72gZ/41opX/C/bFTqOxdbFKhpMLi/fhg5C9ssiHy4tV+g4vbMOObx8nN6erOzVzrxDgu
 urBPJfq62Y/cCISuord7OowHA3o+kyLFFdfAKkM2O2PfvMyMVGeZA5Cc5KMXnwpZOsYfApgSA0e
 g1fqRFhiHt353fltVli+bVyjXvUmDVc2vVs7S7mujQv6zXj0iSo9cZHcFlCuMUbh4n7JCN9Fr8H
 ZKvUZOinTm3kuz0E/IRWbQ+K4QmcUvpsvFOrL5esvOfFFtcHvxx3vLnGwU32eYuhkyCM9bz5yMf
 WCE1xUBjAMsJVM6szUOp/BOcQNJg8ZpTbQb9zGOi+jDyNM9SKDfov0hWrwoS1VsbhoNZHFRZ6Ub
 I8msOhn
X-Google-Smtp-Source: AGHT+IEuuyFXZI/d8Zz3t8+fTMtoxBZo/9Em/gcRx0DHhv79J6i7UbWhh4gPW9YHpzza6x8/rVUpfQ==
X-Received: by 2002:a5d:5d0e:0:b0:430:f40f:61bb with SMTP id
 ffacd0b85a97d-430f40f656cmr9971579f8f.15.1765823160072; 
 Mon, 15 Dec 2025 10:26:00 -0800 (PST)
Received: from ehlo.thunderbird.net
 (p200300faaf27140000b3712bc8ea4066.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:b3:712b:c8ea:4066])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b1fsm32649407f8f.9.2025.12.15.10.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 10:25:59 -0800 (PST)
Date: Mon, 15 Dec 2025 18:14:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Matyas Bobek <bobekmat@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: i.MX6 SabreLite FlexCAN emulation for QEMU progress/working
In-Reply-To: <20250710-carrot-pillbug-of-election-eca4ab-mkl@pengutronix.de>
References: <202507101258.05760.pisa@fel.cvut.cz>
 <20250710-carrot-pillbug-of-election-eca4ab-mkl@pengutronix.de>
Message-ID: <1B709815-4D9A-4C4A-B5DA-C69B432F7B5E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 10=2E Juli 2025 12:50:41 UTC schrieb Marc Kleine-Budde <mkl@pengutronix=
=2Ede>:
>On 10=2E07=2E2025 12:58:05, Pavel Pisa wrote:
>> Hello Marc and others,
>>=20
>> Matyas Bobek has implemented FlexCAN emulation for i=2EMX6
>> targets in the frame of his bachelor thesis
>>=20
>>   https://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-B=
obek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>=20
>> with reviews there
>>=20
>>   https://dspace=2Ecvut=2Ecz/handle/10467/122779
>>=20
>> Please, if you have problems to access documents, try that later,
>> our large archive with theses and publications is under
>> "AI" scrape-bots attacks almost permanently=2E=2E=2E or send me note
>> and I send the document directly=2E
>>=20
>> The project continues and on base of Marc Kleine-Budde
>> review, Matyas Bobek has implemented timestamping
>> which should ensure correct messages ordering
>> even if FIFO mode is not used in the drivers,
>> Linux driver default case=2E There is even workaround
>> to advance timestamp if the the QEMU virtual time
>> is too coarse to provide unique values for for
>> too fast delivered messages through virtual bus
>> without real bits serialization=2E
>
>Nice! Good work!

Indeed!

>
>> The actual code is available on the "flexcan"
>> branch of the repository
>>=20
>>   https://gitlab=2Efel=2Ecvut=2Ecz/bobekmat/qemu-flexcan
>>=20
>> The clean, minimal patches sequence will be prepared
>> for review for the proposal for inclusion into QEMU
>> mainline, hopefully soon=2E
>>=20
>> In longer term perspective, I have interrest in i=2EMX8
>> and other FlexCAN variants with FD support, etc=2E
>> I do not know if Mr=2E Bobek will have time and interest
>> to continue in this direction=2E I can offer that as the
>> another thesis or can offer that as summer job
>> etc=2E But latter would need some funding for students
>> motivation and their time compensation and I have had
>> never and do not have any QEMU related project for such
>> funding now and even minimal chance is even in future
>> for other than CTU CAN FD IP core where we support
>> silicon and FPGA products=2E So no timing, chances,
>> estimates for something beyond i=2EMX6 FlexCAN=2E=20
>
>ACK, I think getting things mainline is more important than CAN-FD
>support=2E

Any news?

I've been playing with Matyas' flexcan branch and integrated the FlexCAN d=
evice model into the imx8mp-evk machine [1]=2E With some minor modification=
s such as allowing for 64-bit access I am able to run cangen+candump on eit=
her side and see the communication!

I think Matyas' work should be upstreamed=2E How shall we proceed? If desi=
red, I could do the upstreaming process, leaving all credits to Matyas of c=
ourse=2E IIUC we'd need Matyas' Signed-off-by tags (of the *squashed* branc=
h) in this case for legal reasons, correct?

What do you think?

Best regards,
Bernhard

[1] https://github=2Ecom/shentok/qemu/tree/imx8mp-flexcan

>
>regards,
>Marc
>

