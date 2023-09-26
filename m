Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E27AEC22
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6qE-0003PS-AB; Tue, 26 Sep 2023 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1ql6q7-0003Om-Jx; Tue, 26 Sep 2023 08:06:55 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1ql6q4-0007Nh-HK; Tue, 26 Sep 2023 08:06:55 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-502e7d66c1eso13997522e87.1; 
 Tue, 26 Sep 2023 05:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695730009; x=1696334809;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:dkim-signature
 :dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSp6fof8CjHAx57jXw+tHkBf2Xm52SXeqkwyAjQX7I4=;
 b=sn3XvADFq9MxSmCeBs5y6+Z9lXaks3RN8a/5jEKoHhThlr5JesEeOzMnUIy9S1MRPR
 QIZNXz7WVwWQij5HfL+K2O1WCpv5nq5LRrfuDaXVhW35YYiJmTvJsXGBH11CrhvhLxlw
 yS2dWd7dyVnGWV1e54/z2+8SiLsO1Sj5UETl652vUG6tYBeb13VDO5UTADNmnB+YQkLF
 jwbf3OzrO++sYsQ2I/i8y6fj1olPa0ZHbB1fDrjDRGvuhuIY4PmbjCbZQjAxFarFdVQx
 GAWfxbPdAeRkgpBLTel/dy6kuWlCNww9gZNxB3/hDvX2qWqKJT4/PgB5/zxODgd21rBp
 Afnw==
X-Gm-Message-State: AOJu0YzGJ5Ly7o8/yg27kC+yYLcHXEq6IEjecD8LC6jMfqCoSxYVSG2i
 kyd4O6SK0jV1aEHs+0l1ewWrVEbkG/7l14Lu
X-Google-Smtp-Source: AGHT+IGh0pbJuezV31igohC073t2iux5tGiGIXitQpborLO3kvOb4MTK32G/SyWdxwlreE9eRN89Tw==
X-Received: by 2002:ac2:5e3a:0:b0:503:446:c7b0 with SMTP id
 o26-20020ac25e3a000000b005030446c7b0mr7035947lfg.32.1695730008327; 
 Tue, 26 Sep 2023 05:06:48 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 i3-20020ac25223000000b004f9c44b3e6dsm2204386lfl.127.2023.09.26.05.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:06:48 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 4218DB9FF; Tue, 26 Sep 2023 14:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1695730006; bh=nzao7j/V2u8hRUm3spxUobE72ZPg4tZAuyj9Q+uPQ/Y=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=LbRwUpAaOLanm5PCwnNaC9xMrraV6Y7Iho1hW5/kuVbTrGKamQMhMc+L6KkU4ViXO
 tfMYMFO9knXbssjbv4s2kYsnuTrVOOsUpFSGiv8YR8SUzMhu910BWhn/5k1XfjXjHi
 a7WF5fG2EZ2R3wF452uAIyXYjl6utDffZAOZEy1E=
Received: from [127.0.0.1] (host-95-193-105-182.mobileonline.telia.com
 [95.193.105.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 8371AB9B9;
 Tue, 26 Sep 2023 14:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1695729971; bh=nzao7j/V2u8hRUm3spxUobE72ZPg4tZAuyj9Q+uPQ/Y=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=LKr0rdA6G5uWVrAop2zWiWgIomKwC0qnsFW4G+kRP6TJu8xDqpQ8Dko4PJxmKvfGR
 JdgW6N+chDaoBi0X4FOBO+lDFkvYfZAO8ptfbYbEqY5pZ7wG3pdQlZV1iEvlQmeVFF
 llgp+acEGEKY7ztFv6IV60As05izfJYkO8F20LHM=
Date: Tue, 26 Sep 2023 14:05:48 +0200
From: Niklas Cassel <nks@flawful.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
CC: qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_FreeBSD_13=2E2_installer_does_not_see_AHC?=
 =?US-ASCII?Q?I_devices_on_aarch64/sbsa-ref_and_x86-64/q35?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
Message-ID: <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----7FRSP7BBA2XNPP5KJ9UWU76SPNFUMK
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------7FRSP7BBA2XNPP5KJ9UWU76SPNFUMK
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Marcin,

I will have a look at this=2E


Kind regards,
Niklas



On 26 September 2023 13:23:46 CEST, Marcin Juszkiewicz <marcin=2Ejuszkiewi=
cz@linaro=2Eorg> wrote:
>I work on SBSA Reference Platform (sbsa-ref) at Linaro=2E And yesterday I
>wanted to check how non-Linux operating systems work on sbsa-ref machine=
=2E
>
>One of them was FreeBSD 13=2E2 - the latest one=2E Fetched bootonly ISO
>image [1] and booted system=2E
>
>1=2E https://download=2Efreebsd=2Eorg/releases/arm64/aarch64/ISO-IMAGES/1=
3=2E2/FreeBSD-13=2E2-RELEASE-arm64-aarch64-bootonly=2Eiso
>
>QEMU command line arguments:
>
>-drive if=3Dide,file=3Ddisks/FreeBSD-13=2E2-RELEASE-arm64-aarch64-bootonl=
y=2Eiso,media=3Dcdrom
>-machine sbsa-ref
>-m 4096
>-smp 2
>-cpu neoverse-n1
>-drive file=3Dfat:rw:/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/=
disks/virtual/,format=3Draw
>-drive format=3Draw,file=3D/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-s=
tatus/disks/full-debian=2Ehddimg
>-watchdog-action none
>-no-reboot
>-monitor telnet::45454,server,nowait
>-serial stdio
>-device igb
>-nographic
>-drive if=3Dpflash,file=3DSBSA_FLASH0=2Efd,format=3Draw
>-drive if=3Dpflash,file=3DSBSA_FLASH1=2Efd,format=3Draw
>
>
>Firmware loaded FreeBSD loader, kernel booted but it does not see
>any AHCI devices:
>
>ahci0: <AHCI SATA controller> iomem 0x60100000-0x6010ffff irq 1 on acpi0
>ahci0: AHCI v1=2E00 with 6 1=2E5Gbps ports, Port Multiplier not supported
>ahci0: Caps: 64bit NCQ 1=2E5Gbps 32cmd 6ports
>ahcich0: <AHCI channel> at channel 0 on ahci0
>ahcich0: Caps:
>[=2E=2E]
>ahcich0: AHCI reset=2E=2E=2E
>ahcich0: SATA connect time=3D0us status=3D00000113
>ahcich0: AHCI reset: device found
>ahcich0: AHCI reset: device ready after 0ms
>ahcich1: AHCI reset=2E=2E=2E
>ahcich1: SATA connect time=3D0us status=3D00000113
>ahcich1: AHCI reset: device found
>ahcich1: AHCI reset: device ready after 0ms
>ahcich2: AHCI reset=2E=2E=2E
>ahcich2: SATA connect time=3D0us status=3D00000113
>ahcich2: AHCI reset: device found
>ahcich2: AHCI reset: device ready after 0ms
>[=2E=2E]
>Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_BO [ro=
]=2E=2E=2E
>Root mount waiting for: CAM
>[=2E=2E]
>Root mount waiting for: CAM
>ahcich0: Poll timeout on slot 1 port 0
>ahcich0: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 000=
00000 cmd 0000c017
>
>And finally it gives up=2E
>
>
>v8=2E1=2E1 was bad, v8=2E0=2E5 was bad so I did git bisecting=2E
>Which gave me this commit:
>
>commit 7bcd32128b227cee1fb39ff242d486ed9fff7648
>Author: Niklas Cassel <niklas=2Ecassel@wdc=2Ecom>
>Date:   Fri Jun 9 16:08:40 2023 +0200
>
>    hw/ide/ahci: simplify and document PxCI handling
>
>    The AHCI spec states that:
>    For NCQ, PxCI is cleared on command queued successfully=2E
>
>
>
>I built x86_64-softmmu target and checked both "pc" and "q35"
>machines=2E
>
>=2E/build/x86_64-softmmu/qemu-system-x86_64
>-cdrom FreeBSD-13=2E2-RELEASE-amd64-bootonly=2Eiso
>-m 2048 -serial stdio  -monitor telnet::45454,server,nowait
>
>PC target ("-M pc") booted fine=2E But Q35 ("-M q35") failed
>similar way as aarch64/sbsa-ref did:
>
>ahci0: <Intel ICH9 AHCI SATA controller> port 0xc060-0xc07f mem 0xfebd500=
0-0xfebd5fff irq 16 at device 31=2E2 on pci0
>ahci0: attempting to allocate 1 MSI vectors (1 supported)
>msi: routing MSI IRQ 26 to local APIC 0 vector 52
>ahci0: using IRQ 26 for MSI
>ahci0: AHCI v1=2E00 with 6 1=2E5Gbps ports, Port Multiplier not supported
>ahci0: Caps: 64bit NCQ 1=2E5Gbps 32cmd 6ports
>ahcich0: <AHCI channel> at channel 0 on ahci0
>ahcich0: Caps:
>ahcich1: <AHCI channel> at channel 1 on ahci0
>ahcich1: Caps:
>ahcich2: <AHCI channel> at channel 2 on ahci0
>ahcich2: Caps:
>[=2E=2E]
>ahcich2: AHCI reset=2E=2E=2E
>ahcich2: SATA connect time=3D0us status=3D00000113
>ahcich2: AHCI reset: device found
>ahcich2: AHCI reset: device ready after 0ms
>[=2E=2E]
>Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]=
=2E=2E=2E
>ahcich2: Poll timeout on slot 1 port 0
>ahcich2: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 000=
00000 cmd 0000c017
>(aprobe2:ahcich2:0:0:0): SOFT_RESET=2E ACB: 00 00 00 00 00 00 00 00 00 00=
 00 00
>(aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>(aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>ahcich2: Poll timeout on slot 2 port 0
>ahcich2: is 00000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 000=
00000 cmd 0000c017
>(aprobe2:ahcich2:0:0:0): SOFT_RESET=2E ACB: 00 00 00 00 00 00 00 00 00 00=
 00 00
>(aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>(aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>mountroot: waiting for device /dev/iso9660/13_2_RELEASE_AMD64_BO=2E=2E=2E
>Mounting from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO failed with error=
 19=2E
>
>Same thing happens with current qemu HEAD:
>
>commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014
>Merge: 29578f5757 b821109583
>Author: Stefan Hajnoczi <stefanha@redhat=2Ecom>
>Date:   Mon Sep 25 10:10:30 2023 -0400
>
>    Merge tag 'pull-request-2023-09-25' of https://gitlab=2Ecom/thuth/qem=
u into staging
>
>
>Any ideas?

------7FRSP7BBA2XNPP5KJ9UWU76SPNFUMK
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Hello Marcin,<br><br>I will have=
 a look at this=2E<br><br><br>Kind regards,<br>Niklas<br><br></div><br><br>=
<div class=3D"gmail_quote"><div dir=3D"auto">On 26 September 2023 13:23:46 =
CEST, Marcin Juszkiewicz &lt;marcin=2Ejuszkiewicz@linaro=2Eorg&gt; wrote:</=
div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail"><div dir=3D"auto">I work on SBSA Reference Platform =
(sbsa-ref) at Linaro=2E And yesterday I<br>wanted to check how non-Linux op=
erating systems work on sbsa-ref machine=2E<br><br>One of them was FreeBSD =
13=2E2 - the latest one=2E Fetched bootonly ISO<br>image [1] and booted sys=
tem=2E<br><br>1=2E <a href=3D"https://download=2Efreebsd=2Eorg/releases/arm=
64/aarch64/ISO-IMAGES/13=2E2/FreeBSD-13=2E2-RELEASE-arm64-aarch64-bootonly=
=2Eiso">https://download=2Efreebsd=2Eorg/releases/arm64/aarch64/ISO-IMAGES/=
13=2E2/FreeBSD-13=2E2-RELEASE-arm64-aarch64-bootonly=2Eiso</a><br><br>QEMU =
command line arguments:<br><br>-drive if=3Dide,file=3Ddisks/FreeBSD-13=2E2-=
RELEASE-arm64-aarch64-bootonly=2Eiso,media=3Dcdrom<br>-machine sbsa-ref<br>=
-m 4096<br>-smp 2<br>-cpu neoverse-n1<br>-drive file=3Dfat:rw:/home/marcin/=
devel/linaro/sbsa-qemu/sbsa-ref-status/disks/virtual/,format=3Draw<br>-driv=
e format=3Draw,file=3D/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/d=
isks/full-debian=2Ehddimg<br>-watchdog-action none<br>-no-reboot<br>-monito=
r telnet::45454,server,nowait<br>-serial stdio<br>-device igb<br>-nographic=
<br>-drive if=3Dpflash,file=3DSBSA_FLASH0=2Efd,format=3Draw<br>-drive if=3D=
pflash,file=3DSBSA_FLASH1=2Efd,format=3Draw<br><br><br>Firmware loaded Free=
BSD loader, kernel booted but it does not see<br>any AHCI devices:<br><br>a=
hci0: &lt;AHCI SATA controller&gt; iomem 0x60100000-0x6010ffff irq 1 on acp=
i0<br>ahci0: AHCI v1=2E00 with 6 1=2E5Gbps ports, Port Multiplier not suppo=
rted<br>ahci0: Caps: 64bit NCQ 1=2E5Gbps 32cmd 6ports<br>ahcich0: &lt;AHCI =
channel&gt; at channel 0 on ahci0<br>ahcich0: Caps:<br>[=2E=2E]<br>ahcich0:=
 AHCI reset=2E=2E=2E<br>ahcich0: SATA connect time=3D0us status=3D00000113<=
br>ahcich0: AHCI reset: device found<br>ahcich0: AHCI reset: device ready a=
fter 0ms<br>ahcich1: AHCI reset=2E=2E=2E<br>ahcich1: SATA connect time=3D0u=
s status=3D00000113<br>ahcich1: AHCI reset: device found<br>ahcich1: AHCI r=
eset: device ready after 0ms<br>ahcich2: AHCI reset=2E=2E=2E<br>ahcich2: SA=
TA connect time=3D0us status=3D00000113<br>ahcich2: AHCI reset: device foun=
d<br>ahcich2: AHCI reset: device ready after 0ms<br>[=2E=2E]<br>Trying to m=
ount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_BO [ro]=2E=2E=2E<br=
>Root mount waiting for: CAM<br>[=2E=2E]<br>Root mount waiting for: CAM<br>=
ahcich0: Poll timeout on slot 1 port 0<br>ahcich0: is 00000000 cs 00000002 =
ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017<br><br>And final=
ly it gives up=2E<br><br><br>v8=2E1=2E1 was bad, v8=2E0=2E5 was bad so I di=
d git bisecting=2E<br>Which gave me this commit:<br><br>commit 7bcd32128b22=
7cee1fb39ff242d486ed9fff7648<br>Author: Niklas Cassel &lt;niklas=2Ecassel@w=
dc=2Ecom&gt;<br>Date:   Fri Jun 9 16:08:40 2023 +0200<br><br>    hw/ide/ahc=
i: simplify and document PxCI handling<br><br>    The AHCI spec states that=
:<br>    For NCQ, PxCI is cleared on command queued successfully=2E<br><br>=
<br><br>I built x86_64-softmmu target and checked both "pc" and "q35"<br>ma=
chines=2E<br><br>=2E/build/x86_64-softmmu/qemu-system-x86_64<br>-cdrom Free=
BSD-13=2E2-RELEASE-amd64-bootonly=2Eiso<br>-m 2048 -serial stdio  -monitor =
telnet::45454,server,nowait<br><br>PC target ("-M pc") booted fine=2E But Q=
35 ("-M q35") failed<br>similar way as aarch64/sbsa-ref did:<br><br>ahci0: =
&lt;Intel ICH9 AHCI SATA controller&gt; port 0xc060-0xc07f mem 0xfebd5000-0=
xfebd5fff irq 16 at device 31=2E2 on pci0<br>ahci0: attempting to allocate =
1 MSI vectors (1 supported)<br>msi: routing MSI IRQ 26 to local APIC 0 vect=
or 52<br>ahci0: using IRQ 26 for MSI<br>ahci0: AHCI v1=2E00 with 6 1=2E5Gbp=
s ports, Port Multiplier not supported<br>ahci0: Caps: 64bit NCQ 1=2E5Gbps =
32cmd 6ports<br>ahcich0: &lt;AHCI channel&gt; at channel 0 on ahci0<br>ahci=
ch0: Caps:<br>ahcich1: &lt;AHCI channel&gt; at channel 1 on ahci0<br>ahcich=
1: Caps:<br>ahcich2: &lt;AHCI channel&gt; at channel 2 on ahci0<br>ahcich2:=
 Caps:<br>[=2E=2E]<br>ahcich2: AHCI reset=2E=2E=2E<br>ahcich2: SATA connect=
 time=3D0us status=3D00000113<br>ahcich2: AHCI reset: device found<br>ahcic=
h2: AHCI reset: device ready after 0ms<br>[=2E=2E]<br>Trying to mount root =
from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]=2E=2E=2E<br>ahcich2: Po=
ll timeout on slot 1 port 0<br>ahcich2: is 00000000 cs 00000002 ss 00000000=
 rs 00000002 tfd 170 serr 00000000 cmd 0000c017<br>(aprobe2:ahcich2:0:0:0):=
 SOFT_RESET=2E ACB: 00 00 00 00 00 00 00 00 00 00 00 00<br>(aprobe2:ahcich2=
:0:0:0): CAM status: Command timeout<br>(aprobe2:ahcich2:0:0:0): Error 5, R=
etries exhausted<br>ahcich2: Poll timeout on slot 2 port 0<br>ahcich2: is 0=
0000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 00000000 cmd 0000c=
017<br>(aprobe2:ahcich2:0:0:0): SOFT_RESET=2E ACB: 00 00 00 00 00 00 00 00 =
00 00 00 00<br>(aprobe2:ahcich2:0:0:0): CAM status: Command timeout<br>(apr=
obe2:ahcich2:0:0:0): Error 5, Retries exhausted<br>mountroot: waiting for d=
evice /dev/iso9660/13_2_RELEASE_AMD64_BO=2E=2E=2E<br>Mounting from cd9660:/=
dev/iso9660/13_2_RELEASE_AMD64_BO failed with error 19=2E<br><br>Same thing=
 happens with current qemu HEAD:<br><br>commit 494a6a2cf7f775d2c20fd6df9601=
e30606cc2014<br>Merge: 29578f5757 b821109583<br>Author: Stefan Hajnoczi &lt=
;stefanha@redhat=2Ecom&gt;<br>Date:   Mon Sep 25 10:10:30 2023 -0400<br><br=
>    Merge tag 'pull-request-2023-09-25' of <a href=3D"https://gitlab=2Ecom=
/thuth/qemu">https://gitlab=2Ecom/thuth/qemu</a> into staging<br><br><br>An=
y ideas?<br></div></pre></blockquote></div></body></html>
------7FRSP7BBA2XNPP5KJ9UWU76SPNFUMK--

