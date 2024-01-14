Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B182D0CD
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 15:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP15s-0005h6-68; Sun, 14 Jan 2024 09:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rP15q-0005gl-Me; Sun, 14 Jan 2024 09:04:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rP15o-000071-Ns; Sun, 14 Jan 2024 09:04:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e69b3149fso19566705e9.3; 
 Sun, 14 Jan 2024 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705241042; x=1705845842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxyDUvgW2cnQpesRlCerihs4F24qs62/ck7n1s7wDmA=;
 b=VHWd0cLvVYF2cYVBNeqfekLpWcHQuy/cLEF7zEavKzpksX9TRGqDhSeUYku1XY/1pb
 2Tfb5SMaypAxjIM78NP4vu1CxjhQztzt/CsCfUP9Eh8FtgVuyA65IboECnxqTrDcyfxw
 AEJIJQ5XqUs9OOUlreqSXrL7783qa6s0BHOXZ5EqGJiJ2Qo7WyCXjOpGSFi23USIJuv+
 9+p1ezM/ODmkbOG0EG8dN2FiOh7G3yD7B9P/MPsVFM9v7b+8eAqAF/ZE+TUWFELhA0IM
 ZML3F5cKGjFWb85saxqyaiEBPO1Nurg5CJc/QcNJO8vUIQGLpRoQ+2h6LBlr4jqLJ60v
 H+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705241042; x=1705845842;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxyDUvgW2cnQpesRlCerihs4F24qs62/ck7n1s7wDmA=;
 b=inmQWFmF4wX9UTSzdMo/xHyS9DAnZBPihePl4x8b/JxxKXvasZV3nJ8357vU8iZ4j0
 4kb3DTuPZXQHq76vMP4pLem48fLafZymUmszPwjY8LUAjgQ3cAf1mioJ6rOuRu/5/ngh
 y2Ct/1Hm5GKw2120HZG9vGHzc3RziwrLhljIQpDztznVEney+bhGUCskgozOxOt9d7+I
 sBGBSXT4zw2EaQlvmarlFlRLSNraKZcglQQ9q4EEnh1OWqHtyvhXUNcZoiPsKNca5r7q
 CQbBjFf7a8cpztg+dyGDw4bYu87Tz8QZbFnmgTtjjWPLaH3Fs7mZ6HW5HR1tNPwV9x3g
 2Dtw==
X-Gm-Message-State: AOJu0YzKIoS2y95UgyOuMF8dGwShvO610mCRR8hEugS2Y58Db0JZub6B
 /nnIYYGtS8mBQ/WjQRhThLE=
X-Google-Smtp-Source: AGHT+IH8V7/x72MMdGl/ByTKoAZG4QiQXkG1QYXatthWwwKLMXZXg6eFOUzTclLax+AUKLvc1rTOKw==
X-Received: by 2002:a7b:c853:0:b0:40e:7556:45a7 with SMTP id
 c19-20020a7bc853000000b0040e755645a7mr442382wml.136.1705241042083; 
 Sun, 14 Jan 2024 06:04:02 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 p10-20020a1709060dca00b00a26d20a48dasm4102196eji.125.2024.01.14.06.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 06:04:01 -0800 (PST)
Date: Sun, 14 Jan 2024 14:03:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_00/11=5D_hw/isa/vt82c686=3A_Implemen?=
 =?US-ASCII?Q?t_relocation_and_toggling_of_SuperI/O_functions?=
In-Reply-To: <20240114080249-mutt-send-email-mst@kernel.org>
References: <20240114123911.4877-1-shentey@gmail.com>
 <05B650FF-EA74-471D-B427-A0AC037423DF@gmail.com>
 <20240114080249-mutt-send-email-mst@kernel.org>
Message-ID: <3A2BB5C4-1C6E-4490-810E-4462291D6C95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
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



Am 14=2E Januar 2024 13:03:07 UTC schrieb "Michael S=2E Tsirkin" <mst@redh=
at=2Ecom>:
>On Sun, Jan 14, 2024 at 12:52:53PM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 14=2E Januar 2024 12:39:00 UTC schrieb Bernhard Beschow <shentey@gma=
il=2Ecom>:
>> >This series implements relocation of the SuperI/O functions of the VIA=
 south
>> >
>> >bridges which resolves some FIXME's=2E It is part of my via-apollo-pro=
-133t
>> >
>> >branch [1] which is an extension of bringing the VIA south bridges to =
the PC
>> >
>> >machine [2]=2E This branch is able to run some real-world X86 BIOSes i=
n the hope
>> >
>> >that it allows us to form a better understanding of the real vt82c686b=
 devices=2E
>> >
>> >Implementing relocation and toggling of the SuperI/O functions is one =
step to
>> >
>> >make these BIOSes run without error messages, so here we go=2E
>> >
>> >
>> >
>> >The series is structured as follows: Patches 1-3 prepare the TYPE_ISA_=
FDC,
>> >
>> >TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL to relocate and toggle (enable/d=
isable)
>> >
>> >themselves without breaking encapsulation of their respective device s=
tates=2E
>> >
>> >This is achieved by moving the MemoryRegions and PortioLists from the =
device
>> >
>> >states into the encapsulating ISA devices since they will be relocated=
 and
>> >
>> >toggled=2E
>> >
>> >
>> >
>> >Inspired by the memory API patches 4-6 add two convenience functions t=
o the
>> >
>> >portio_list API to toggle and relocate portio lists=2E Patch 5 is a pr=
eparation
>> >
>> >for that which removes some redundancies which otherwise had to be dea=
lt with
>> >
>> >during relocation=2E
>> >
>> >
>> >
>> >Patches 7-9 implement toggling and relocation for types TYPE_ISA_FDC,
>> >
>> >TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL=2E Patch 10 prepares the pegasos=
2 machine
>> >
>> >which would end up with all SuperI/O functions disabled if no -bios ar=
gument is
>> >
>> >given=2E Patch 11 finally implements the main feature which now relies=
 on
>> >
>> >firmware to configure the SuperI/O functions accordingly (except for p=
egasos2)=2E
>> >
>> >
>> >
>> >v5:
>> >
>> >* Use cpu_physical_memory_write() in pegasos2 (Zoltan)
>> >
>> >* Use an int as for loop variable (Zoltan)
>> >
>> >
>> >
>> >v4:
>> >
>> >* Drop incomplete SuperI/O vmstate handling (Zoltan)
>> >
>> >
>> >
>> >v3:
>> >
>> >* Rework various commit messages (Zoltan)
>> >
>> >* Drop patch "hw/char/serial: Free struct SerialState from MemoryRegio=
n"
>> >
>> >  (Zoltan)
>> >
>> >* Generalize wording in migration=2Erst to include portio_list API (Zo=
ltan)
>> >
>> >
>> >
>> >v2:
>> >
>> >* Improve commit messages (Zoltan)
>> >
>> >* Split pegasos2 from vt82c686 patch (Zoltan)
>> >
>> >* Avoid poking into device internals (Zoltan)
>> >
>> >
>> >
>> >Testing done:
>> >
>> >* `make check`
>> >
>> >* `make check-avocado`
>> >
>> >* Run MorphOS on pegasos2 with and without pegasos2=2Erom
>> >
>> >* Run Linux on amigaone
>> >
>> >* Run real-world BIOSes on via-apollo-pro-133t branch
>> >
>> >* Start rescue-yl on fuloong2e
>> >
>> >
>> >
>> >[1] https://github=2Ecom/shentok/qemu/tree/via-apollo-pro-133t
>> >
>> >[2] https://github=2Ecom/shentok/qemu/tree/pc-via
>> >
>> >
>> >
>> >Bernhard Beschow (11):
>> >
>> >  hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
>> >
>> >  hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
>> >
>> >  hw/char/parallel: Move portio_list from ParallelState to
>> >
>> >    ISAParallelState
>> >
>>=20
>>=20
>> >  exec/ioport: Resolve redundant =2Ebase attribute in struct
>> >
>> >    MemoryRegionPortio
>> >
>> >  exec/ioport: Add portio_list_set_address()
>> >
>> >  exec/ioport: Add portio_list_set_enabled()
>> >
>> >  hw/block/fdc-isa: Implement relocation and enabling/disabling for
>> >
>> >    TYPE_ISA_FDC
>> >
>> >  hw/char/serial-isa: Implement relocation and enabling/disabling for
>> >
>> >    TYPE_ISA_SERIAL
>> >
>> >  hw/char/parallel-isa: Implement relocation and enabling/disabling fo=
r
>> >
>> >    TYPE_ISA_PARALLEL
>> >
>>=20
>> Ping for the above six patches=2E These are critical for this series an=
d haven't had comments from maintainers for five iterations, so pardon for =
the annoyance=2E
>
>Was hoping for more reviews=2E Oh well=2E
>Tagged=2E

You made my day=2E Thanks!

>
>
>> Best regards,
>> Bernhard
>>=20
>> >  hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions
>> >
>> >  hw/isa/vt82c686: Implement relocation and toggling of SuperI/O
>> >
>> >    functions
>> >
>> >
>> >
>> > docs/devel/migration=2Erst       |  6 ++--
>> >
>> > hw/block/fdc-internal=2Eh        |  4 ---
>> >
>> > include/exec/ioport=2Eh          |  4 ++-
>> >
>> > include/hw/block/fdc=2Eh         |  3 ++
>> >
>> > include/hw/char/parallel-isa=2Eh |  5 +++
>> >
>> > include/hw/char/parallel=2Eh     |  2 --
>> >
>> > include/hw/char/serial=2Eh       |  2 ++
>> >
>> > hw/block/fdc-isa=2Ec             | 18 +++++++++-
>> >
>> > hw/block/fdc-sysbus=2Ec          |  6 ++--
>> >
>> > hw/char/parallel-isa=2Ec         | 14 ++++++++
>> >
>> > hw/char/parallel=2Ec             |  2 +-
>> >
>> > hw/char/serial-isa=2Ec           | 14 ++++++++
>> >
>> > hw/isa/vt82c686=2Ec              | 65 ++++++++++++++++++++++++++++---=
---
>> >
>> > hw/ppc/pegasos2=2Ec              | 12 +++++++
>> >
>> > system/ioport=2Ec                | 41 +++++++++++++++++----
>> >
>> > 15 files changed, 168 insertions(+), 30 deletions(-)
>> >
>> >
>> >
>> >-- >
>> >2=2E43=2E0
>> >
>> >
>> >
>

