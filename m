Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D2828F73
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNKIG-0007pm-9j; Tue, 09 Jan 2024 17:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rNKIE-0007nW-Ht; Tue, 09 Jan 2024 17:09:54 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rNKIC-0004Y2-G2; Tue, 09 Jan 2024 17:09:54 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so369623066b.1; 
 Tue, 09 Jan 2024 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704838188; x=1705442988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJtU3cH8/L9ElLV5ygkwhrU/E1fgow2ytaeAREi8TVI=;
 b=b+jQ3THcF1WnJ9HaD857d23IovvOLOmf4Tfykthf8QkxfEtuLk277suWiJT/WaCUp0
 IohtFk37RYcfZKhgiYFdz524DMVCZr66g3Ej1y46JLfgIFM/rV5NlaVQVuLfBi2i4Wvj
 HkWUR+m/6r8bJgpMqCFZKf3DIiczHcD2siZ0qDFgemTKV8mumDrpMI8Mn6eD13tLqnE+
 NrfjDFhr83Kls1WJ78AwZH8zWvg+kqtIK67vSpNQtXs8R0NKTxxEnpfQAJXq3KYHmsGx
 1w/+4T+mAZSXoqTawO1+Ac1Yb5EZWisStErmCZa9CgTMYW5DiPwAYBXK4sm4qrQx1DLF
 24/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704838188; x=1705442988;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJtU3cH8/L9ElLV5ygkwhrU/E1fgow2ytaeAREi8TVI=;
 b=q9fec6Y4tnr8S5kmMX4BuV5fpwtONU45NZYwfMG7q9nB28LkUiVCgCElCU6/w9v+vr
 gSfAUvubw9zDgjBIIpNfbIUXXI5Tc9g5Ogv5aFQWIOQ1pzXuKxreT/vLCCNd5oaFbKtL
 1Sb9vOYBLRQvf4czQ0be12gksjGF7mRRVyCbjm6/bEF/G37K8owcHOOFmaaZ24aH3kiE
 a5pSSJFvfJyxFrna8dKAarCg2hAhKtZ39Nj8/A5gQQJ4MrZv2NG3+qhY/jYFD0NQmlP8
 9bYrPX0rzY4vkudUxnoPSudmYMhPCPPs/bhKrkO4D4i+wHx5CVzVF/Asygm8kzRudXa0
 jm6g==
X-Gm-Message-State: AOJu0YyP86BFN+H98jqZluRLFzxViRTK1mlg6Y4o6agSyMI9Wpi5VSzu
 pFizVnYrGiqyIDo8gmubkNVwHtdzlxM=
X-Google-Smtp-Source: AGHT+IEU7D1GyoaBWxFz6ZIso+dTOvXxj9AcL6b5wmb54NgtRQOhPsC2XQfQpdWERyz8BFxNgR/uyQ==
X-Received: by 2002:a17:906:b4a:b0:a23:6075:52a2 with SMTP id
 v10-20020a1709060b4a00b00a23607552a2mr83125ejg.6.1704838187778; 
 Tue, 09 Jan 2024 14:09:47 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-075-077.77.183.pool.telefonica.de.
 [77.183.75.77]) by smtp.gmail.com with ESMTPSA id
 v12-20020a1709061dcc00b00a2af672cdd8sm1448048ejh.161.2024.01.09.14.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 14:09:47 -0800 (PST)
Date: Tue, 09 Jan 2024 22:09:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
CC: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_00/11=5D_hw/isa/vt82c686=3A_Implemen?=
 =?US-ASCII?Q?t_relocation_and_toggling_of_SuperI/O_functions?=
In-Reply-To: <077a06e2-476a-4efb-bd92-5cf30e29ceb5@ilande.co.uk>
References: <20240106210531.140542-1-shentey@gmail.com>
 <8e46217c-f28b-43b0-bea3-583d4b3cf42b@ilande.co.uk>
 <5393CA46-267C-444A-AE8E-BBD82DCDCC9A@gmail.com>
 <077a06e2-476a-4efb-bd92-5cf30e29ceb5@ilande.co.uk>
Message-ID: <5A46E62D-ED9A-47A4-9EA2-11A522923DF7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



Am 8=2E Januar 2024 22:12:12 UTC schrieb Mark Cave-Ayland <mark=2Ecave-ayl=
and@ilande=2Eco=2Euk>:
>On 08/01/2024 20:07, Bernhard Beschow wrote:
>
>> Am 7=2E Januar 2024 14:13:44 UTC schrieb Mark Cave-Ayland <mark=2Ecave-=
ayland@ilande=2Eco=2Euk>:
>>> On 06/01/2024 21:05, Bernhard Beschow wrote:
>>>=20
>>>> This series implements relocation of the SuperI/O functions of the VI=
A south
>>>> bridges which resolves some FIXME's=2E It is part of my via-apollo-pr=
o-133t
>>>> branch [1] which is an extension of bringing the VIA south bridges to=
 the PC
>>>> machine [2]=2E This branch is able to run some real-world X86 BIOSes =
in the hope
>>>> that it allows us to form a better understanding of the real vt82c686=
b devices=2E
>>>> Implementing relocation and toggling of the SuperI/O functions is one=
 step to
>>>> make these BIOSes run without error messages, so here we go=2E
>>>>=20
>>>> The series is structured as follows: Patches 1-3 prepare the TYPE_ISA=
_FDC,
>>>> TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL to relocate and toggle (enable/=
disable)
>>>> themselves without breaking encapsulation of their respective device =
states=2E
>>>> This is achieved by moving the MemoryRegions and PortioLists from the=
 device
>>>> states into the encapsulating ISA devices since they will be relocate=
d and
>>>> toggled=2E
>>>>=20
>>>> Inspired by the memory API patches 4-6 add two convenience functions =
to the
>>>> portio_list API to toggle and relocate portio lists=2E Patch 5 is a p=
reparation
>>>> for that which removes some redundancies which otherwise had to be de=
alt with
>>>> during relocation=2E
>>>>=20
>>>> Patches 7-9 implement toggling and relocation for types TYPE_ISA_FDC,
>>>> TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL=2E Patch 10 prepares the pegaso=
s2 machine
>>>> which would end up with all SuperI/O functions disabled if no -bios a=
rgument is
>>>> given=2E Patch 11 finally implements the main feature which now relie=
s on
>>>> firmware to configure the SuperI/O functions accordingly (except for =
pegasos2)=2E
>>>>=20
>>>> v4:
>>>> * Drop incomplete SuperI/O vmstate handling (Zoltan)
>>>>=20
>>>> v3:
>>>> * Rework various commit messages (Zoltan)
>>>> * Drop patch "hw/char/serial: Free struct SerialState from MemoryRegi=
on"
>>>>     (Zoltan)
>>>> * Generalize wording in migration=2Erst to include portio_list API (Z=
oltan)
>>>>=20
>>>> v2:
>>>> * Improve commit messages (Zoltan)
>>>> * Split pegasos2 from vt82c686 patch (Zoltan)
>>>> * Avoid poking into device internals (Zoltan)
>>>>=20
>>>> Testing done:
>>>> * `make check`
>>>> * `make check-avocado`
>>>> * Run MorphOS on pegasos2 with and without pegasos2=2Erom
>>>> * Run Linux on amigaone
>>>> * Run real-world BIOSes on via-apollo-pro-133t branch
>>>> * Start rescue-yl on fuloong2e
>>>>=20
>>>> [1] https://github=2Ecom/shentok/qemu/tree/via-apollo-pro-133t
>>>> [2] https://github=2Ecom/shentok/qemu/tree/pc-via
>>>>=20
>>>> Bernhard Beschow (11):
>>>>     hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
>>>>     hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
>>>>     hw/char/parallel: Move portio_list from ParallelState to
>>>>       ISAParallelState
>>>>     exec/ioport: Resolve redundant =2Ebase attribute in struct
>>>>       MemoryRegionPortio
>>>>     exec/ioport: Add portio_list_set_address()
>>>>     exec/ioport: Add portio_list_set_enabled()
>>>>     hw/block/fdc-isa: Implement relocation and enabling/disabling for
>>>>       TYPE_ISA_FDC
>>>>     hw/char/serial-isa: Implement relocation and enabling/disabling f=
or
>>>>       TYPE_ISA_SERIAL
>>>>     hw/char/parallel-isa: Implement relocation and enabling/disabling=
 for
>>>>       TYPE_ISA_PARALLEL
>>>>     hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O function=
s
>>>>     hw/isa/vt82c686: Implement relocation and toggling of SuperI/O
>>>>       functions
>>>>=20
>>>>    docs/devel/migration=2Erst       |  6 ++--
>>>>    hw/block/fdc-internal=2Eh        |  4 ---
>>>>    include/exec/ioport=2Eh          |  4 ++-
>>>>    include/hw/block/fdc=2Eh         |  3 ++
>>>>    include/hw/char/parallel-isa=2Eh |  5 +++
>>>>    include/hw/char/parallel=2Eh     |  2 --
>>>>    include/hw/char/serial=2Eh       |  2 ++
>>>>    hw/block/fdc-isa=2Ec             | 18 +++++++++-
>>>>    hw/block/fdc-sysbus=2Ec          |  6 ++--
>>>>    hw/char/parallel-isa=2Ec         | 14 ++++++++
>>>>    hw/char/parallel=2Ec             |  2 +-
>>>>    hw/char/serial-isa=2Ec           | 14 ++++++++
>>>>    hw/isa/vt82c686=2Ec              | 66 ++++++++++++++++++++++++++++=
------
>>>>    hw/ppc/pegasos2=2Ec              | 15 ++++++++
>>>>    system/ioport=2Ec                | 41 +++++++++++++++++----
>>>>    15 files changed, 172 insertions(+), 30 deletions(-)
>>>=20
>>> I think this series generally looks good: the only thing I think it's =
worth checking is whether portio lists are considered exclusive to ISA devi=
ces or not? (Paolo?)=2E
>>=20
>> The modifications preserve the current design, so how is this question =
related to this series?
>
>I was thinking about patches 1 and 3 where the portio_list variable is mo=
ved from the core object to the ISA-specific child objects=2E

I think of patches 1 - 3 more as cleanups where an attribute unused in the=
 core is moved one level up to where it is needed=2E In addition, the flopp=
y core had two attributes where only one was ever used in a specific device=
=2E From that perspective I think the question of whether the portio_list A=
PI is ISA specific or not is unrelated to this series, i=2Ee=2E should be d=
iscussed separately=2E

>
>> I'd appreciate feedback from the maintainers indeed since this part has=
n't received any comments so far=2E Thanks :)
>
>Agreed=2E I *think* the portio_lists are ISA-specific as far as QEMU is c=
oncerned, but a quick nod from an x86 maintainer would be a great help :)

A quick nod shall be in scope ;)

Best regards,
Bernhard

>
>>> The portio_list_set_enabled() API looks interesting, and could be cons=
idered for use by my PCI IDE mode-switching changes too=2E
>>>=20
>>> Apologies I don't have a huge amount of time for review right now, but=
 I wanted to feed back that generally these patches look good, and if peopl=
e are happy with the portio list changes then this series should be conside=
red for merge=2E
>>=20
>> Never mind, it's still nice getting some confirmation from your side!
>
>No worries!
>
>
>ATB,
>
>Mark=2E
>

