Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27A7AF0D8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlB2q-0006GQ-Bg; Tue, 26 Sep 2023 12:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qlB2n-0006Fn-Ip
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qlB2l-0000mD-1P
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695746174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXSWz+bclYqrm5uNPU4ZXBWD/owP9b2XWxwqhOXcNJ4=;
 b=C2Nf8mCqXpKDvh+Y940NmaOE35MCXMAXANhKFj0SqIu30nh+rEhMOmYzEcHMkyvrH3eLyO
 gFbA81UfH055ygCplwYHGra0x2/9RAmL8iyJcqGp0+gAqs7+gJLOhfP4rvd97m5US84WYc
 tV0V/Cce2K1ZYe6Z0Bh0ogbhZZ85IkM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-jzHEhJEwOFGg0vCp1_Llcg-1; Tue, 26 Sep 2023 12:36:10 -0400
X-MC-Unique: jzHEhJEwOFGg0vCp1_Llcg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-578e2187f02so8103482a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746169; x=1696350969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hXSWz+bclYqrm5uNPU4ZXBWD/owP9b2XWxwqhOXcNJ4=;
 b=YRp6oOfdP775TpBHPUnQCKm6vd7sB5qZAj1xEQF1OyRf7sbXjE18yF4ETOByJ5tWJk
 H7x3MfjorXCi0mP51cEzcRS1tWlEKCE6CCDO85lPDXujo7ULGprHQIaq2hpAATAGpcbQ
 wyp2b3HcxPl6ewXq9kY0QK1zJeJJOOY7JxLzOnzTogAT+36jTweV1jzCpAce+jnCsY1m
 G1nbLDjcQXEtfxbqN2b++Vt/CXB0X5M2Fkk0KETBOTckqbH7OgTdyop898sxpbo16jo+
 y26XsW3MDITclmNVyEJPJq53Dk+1rUrXBSwQRCmGmLKpEWMMNcLO/v+acryH8m+cajij
 y7gg==
X-Gm-Message-State: AOJu0YxLUhAu4tcuAzdPy9tFmA2VGRKiXd0Pds+A32EovUxhesphSt6/
 zwUjpJoooGExjYhcQij/E/4S6UzL2Jrl3YGq+8zRSE5JOmH/81j2BKPM+YQO/0m8wNEW60L6h0f
 rZsyz+a6o7Odz6551nRgMgTC5JIaYrO4=
X-Received: by 2002:a05:6a20:734f:b0:15f:b5:bfee with SMTP id
 v15-20020a056a20734f00b0015f00b5bfeemr6202798pzc.5.1695746169047; 
 Tue, 26 Sep 2023 09:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECiX1CV8VKZDVNUtcRSfPZ4jGqUKLmp3xaAx4+h2NaIyqHuHmt4D3GQHeoRyb5cZuNtUBIOhYxlXU1H06IWA0=
X-Received: by 2002:a05:6a20:734f:b0:15f:b5:bfee with SMTP id
 v15-20020a056a20734f00b0015f00b5bfeemr6202772pzc.5.1695746168630; Tue, 26 Sep
 2023 09:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
 <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
In-Reply-To: <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 26 Sep 2023 12:35:57 -0400
Message-ID: <CAFn=p-a5hbbKTABxrE2+7jfq7fB6+Y46uQhLsWAwbj_xFMhhMA@mail.gmail.com>
Subject: Re: FreeBSD 13.2 installer does not see AHCI devices on
 aarch64/sbsa-ref and x86-64/q35
To: Niklas Cassel <nks@flawful.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="00000000000002c4d2060645ac8a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000002c4d2060645ac8a
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 26, 2023, 8:06 AM Niklas Cassel <nks@flawful.org> wrote:

> Hello Marcin,
>
> I will have a look at this.
>
>
> Kind regards,
> Niklas
>

Thanks. You have my blessing in advance to get any hot fixes for this
merged ASAP, as long as another block maintainer is willing to give it an
ACK. (I'll try to be prompt. Please send me a message on IRC to get my
attention if you need to. Sorry I'm so hard to get hold of.)

Also CC mjt - we might need a fix for stable if you merged these patches.



>
>
> On 26 September 2023 13:23:46 CEST, Marcin Juszkiewicz <
> marcin.juszkiewicz@linaro.org> wrote:
>
>> I work on SBSA Reference Platform (sbsa-ref) at Linaro. And yesterday I
>> wanted to check how non-Linux operating systems work on sbsa-ref machine.
>>
>> One of them was FreeBSD 13.2 - the latest one. Fetched bootonly ISO
>> image [1] and booted system.
>>
>> 1. https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso
>>
>> QEMU command line arguments:
>>
>> -drive if=ide,file=disks/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso,media=cdrom
>> -machine sbsa-ref
>> -m 4096
>> -smp 2
>> -cpu neoverse-n1
>> -drive file=fat:rw:/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/virtual/,format=raw
>> -drive format=raw,file=/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/full-debian.hddimg
>> -watchdog-action none
>> -no-reboot
>> -monitor telnet::45454,server,nowait
>> -serial stdio
>> -device igb
>> -nographic
>> -drive if=pflash,file=SBSA_FLASH0.fd,format=raw
>> -drive if=pflash,file=SBSA_FLASH1.fd,format=raw
>>
>>
>> Firmware loaded FreeBSD loader, kernel booted but it does not see
>> any AHCI devices:
>>
>> ahci0: <AHCI SATA controller> iomem 0x60100000-0x6010ffff irq 1 on acpi0
>> ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
>> ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
>> ahcich0: <AHCI channel> at channel 0 on ahci0
>> ahcich0: Caps:
>> [..]
>> ahcich0: AHCI reset...
>> ahcich0: SATA connect time=0us status=00000113
>> ahcich0: AHCI reset: device found
>> ahcich0: AHCI reset: device ready after 0ms
>> ahcich1: AHCI reset...
>> ahcich1: SATA connect time=0us status=00000113
>> ahcich1: AHCI reset: device found
>> ahcich1: AHCI reset: device ready after 0ms
>> ahcich2: AHCI reset...
>> ahcich2: SATA connect time=0us status=00000113
>> ahcich2: AHCI reset: device found
>> ahcich2: AHCI reset: device ready after 0ms
>> [..]
>> Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_BO [ro]...
>> Root mount waiting for: CAM
>> [..]
>> Root mount waiting for: CAM
>> ahcich0: Poll timeout on slot 1 port 0
>> ahcich0: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017
>>
>> And finally it gives up.
>>
>>
>> v8.1.1 was bad, v8.0.5 was bad so I did git bisecting.
>> Which gave me this commit:
>>
>> commit 7bcd32128b227cee1fb39ff242d486ed9fff7648
>> Author: Niklas Cassel <niklas.cassel@wdc.com>
>> Date:   Fri Jun 9 16:08:40 2023 +0200
>>
>>     hw/ide/ahci: simplify and document PxCI handling
>>
>>     The AHCI spec states that:
>>     For NCQ, PxCI is cleared on command queued successfully.
>>
>>
>>
>> I built x86_64-softmmu target and checked both "pc" and "q35"
>> machines.
>>
>> ./build/x86_64-softmmu/qemu-system-x86_64
>> -cdrom FreeBSD-13.2-RELEASE-amd64-bootonly.iso
>> -m 2048 -serial stdio  -monitor telnet::45454,server,nowait
>>
>> PC target ("-M pc") booted fine. But Q35 ("-M q35") failed
>> similar way as aarch64/sbsa-ref did:
>>
>> ahci0: <Intel ICH9 AHCI SATA controller> port 0xc060-0xc07f mem 0xfebd5000-0xfebd5fff irq 16 at device 31.2 on pci0
>> ahci0: attempting to allocate 1 MSI vectors (1 supported)
>> msi: routing MSI IRQ 26 to local APIC 0 vector 52
>> ahci0: using IRQ 26 for MSI
>> ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
>> ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
>> ahcich0: <AHCI channel> at channel 0 on ahci0
>> ahcich0: Caps:
>> ahcich1: <AHCI channel> at channel 1 on ahci0
>> ahcich1: Caps:
>> ahcich2: <AHCI channel> at channel 2 on ahci0
>> ahcich2: Caps:
>> [..]
>> ahcich2: AHCI reset...
>> ahcich2: SATA connect time=0us status=00000113
>> ahcich2: AHCI reset: device found
>> ahcich2: AHCI reset: device ready after 0ms
>> [..]
>> Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]...
>> ahcich2: Poll timeout on slot 1 port 0
>> ahcich2: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017
>> (aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
>> (aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>> (aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>> ahcich2: Poll timeout on slot 2 port 0
>> ahcich2: is 00000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 00000000 cmd 0000c017
>> (aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
>> (aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>> (aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>> mountroot: waiting for device /dev/iso9660/13_2_RELEASE_AMD64_BO...
>> Mounting from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO failed with error 19.
>>
>> Same thing happens with current qemu HEAD:
>>
>> commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014
>> Merge: 29578f5757 b821109583
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Mon Sep 25 10:10:30 2023 -0400
>>
>>     Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging
>>
>>
>> Any ideas?
>>
>>

--00000000000002c4d2060645ac8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Sep 26, 2023, 8:06 AM Niklas Cassel &lt;<a hre=
f=3D"mailto:nks@flawful.org">nks@flawful.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div><div dir=3D"auto">Hello Marcin,<br><br>I will=
 have a look at this.<br><br><br>Kind regards,<br>Niklas<br></div></div></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks.=
 You have my blessing in advance to get any hot fixes for this merged ASAP,=
 as long as another block maintainer is willing to give it an ACK. (I&#39;l=
l try to be prompt. Please send me a message on IRC to get my attention if =
you need to. Sorry I&#39;m so hard to get hold of.)</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Also CC mjt - we might need a fix for stable if=
 you merged these patches.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div><div dir=3D"auto"><br></div><br><br><div class=3D"gmail_=
quote"><div dir=3D"auto">On 26 September 2023 13:23:46 CEST, Marcin Juszkie=
wicz &lt;<a href=3D"mailto:marcin.juszkiewicz@linaro.org" target=3D"_blank"=
 rel=3D"noreferrer">marcin.juszkiewicz@linaro.org</a>&gt; wrote:</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<pre><div dir=3D"auto">I work on SBSA Reference Platform (sbsa-ref) at Lina=
ro. And yesterday I<br>wanted to check how non-Linux operating systems work=
 on sbsa-ref machine.<br><br>One of them was FreeBSD 13.2 - the latest one.=
 Fetched bootonly ISO<br>image [1] and booted system.<br><br>1. <a href=3D"=
https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/FreeBSD=
-13.2-RELEASE-arm64-aarch64-bootonly.iso" target=3D"_blank" rel=3D"noreferr=
er">https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/Fre=
eBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso</a><br><br>QEMU command line a=
rguments:<br><br>-drive if=3Dide,file=3Ddisks/FreeBSD-13.2-RELEASE-arm64-aa=
rch64-bootonly.iso,media=3Dcdrom<br>-machine sbsa-ref<br>-m 4096<br>-smp 2<=
br>-cpu neoverse-n1<br>-drive file=3Dfat:rw:/home/marcin/devel/linaro/sbsa-=
qemu/sbsa-ref-status/disks/virtual/,format=3Draw<br>-drive format=3Draw,fil=
e=3D/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/full-debian.h=
ddimg<br>-watchdog-action none<br>-no-reboot<br>-monitor telnet::45454,serv=
er,nowait<br>-serial stdio<br>-device igb<br>-nographic<br>-drive if=3Dpfla=
sh,file=3DSBSA_FLASH0.fd,format=3Draw<br>-drive if=3Dpflash,file=3DSBSA_FLA=
SH1.fd,format=3Draw<br><br><br>Firmware loaded FreeBSD loader, kernel boote=
d but it does not see<br>any AHCI devices:<br><br>ahci0: &lt;AHCI SATA cont=
roller&gt; iomem 0x60100000-0x6010ffff irq 1 on acpi0<br>ahci0: AHCI v1.00 =
with 6 1.5Gbps ports, Port Multiplier not supported<br>ahci0: Caps: 64bit N=
CQ 1.5Gbps 32cmd 6ports<br>ahcich0: &lt;AHCI channel&gt; at channel 0 on ah=
ci0<br>ahcich0: Caps:<br>[..]<br>ahcich0: AHCI reset...<br>ahcich0: SATA co=
nnect time=3D0us status=3D00000113<br>ahcich0: AHCI reset: device found<br>=
ahcich0: AHCI reset: device ready after 0ms<br>ahcich1: AHCI reset...<br>ah=
cich1: SATA connect time=3D0us status=3D00000113<br>ahcich1: AHCI reset: de=
vice found<br>ahcich1: AHCI reset: device ready after 0ms<br>ahcich2: AHCI =
reset...<br>ahcich2: SATA connect time=3D0us status=3D00000113<br>ahcich2: =
AHCI reset: device found<br>ahcich2: AHCI reset: device ready after 0ms<br>=
[..]<br>Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_=
BO [ro]...<br>Root mount waiting for: CAM<br>[..]<br>Root mount waiting for=
: CAM<br>ahcich0: Poll timeout on slot 1 port 0<br>ahcich0: is 00000000 cs =
00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017<br><br>=
And finally it gives up.<br><br><br>v8.1.1 was bad, v8.0.5 was bad so I did=
 git bisecting.<br>Which gave me this commit:<br><br>commit 7bcd32128b227ce=
e1fb39ff242d486ed9fff7648<br>Author: Niklas Cassel &lt;<a href=3D"mailto:ni=
klas.cassel@wdc.com" target=3D"_blank" rel=3D"noreferrer">niklas.cassel@wdc=
.com</a>&gt;<br>Date:   Fri Jun 9 16:08:40 2023 +0200<br><br>    hw/ide/ahc=
i: simplify and document PxCI handling<br><br>    The AHCI spec states that=
:<br>    For NCQ, PxCI is cleared on command queued successfully.<br><br><b=
r><br>I built x86_64-softmmu target and checked both &quot;pc&quot; and &qu=
ot;q35&quot;<br>machines.<br><br>./build/x86_64-softmmu/qemu-system-x86_64<=
br>-cdrom FreeBSD-13.2-RELEASE-amd64-bootonly.iso<br>-m 2048 -serial stdio =
 -monitor telnet::45454,server,nowait<br><br>PC target (&quot;-M pc&quot;) =
booted fine. But Q35 (&quot;-M q35&quot;) failed<br>similar way as aarch64/=
sbsa-ref did:<br><br>ahci0: &lt;Intel ICH9 AHCI SATA controller&gt; port 0x=
c060-0xc07f mem 0xfebd5000-0xfebd5fff irq 16 at device 31.2 on pci0<br>ahci=
0: attempting to allocate 1 MSI vectors (1 supported)<br>msi: routing MSI I=
RQ 26 to local APIC 0 vector 52<br>ahci0: using IRQ 26 for MSI<br>ahci0: AH=
CI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported<br>ahci0: Caps=
: 64bit NCQ 1.5Gbps 32cmd 6ports<br>ahcich0: &lt;AHCI channel&gt; at channe=
l 0 on ahci0<br>ahcich0: Caps:<br>ahcich1: &lt;AHCI channel&gt; at channel =
1 on ahci0<br>ahcich1: Caps:<br>ahcich2: &lt;AHCI channel&gt; at channel 2 =
on ahci0<br>ahcich2: Caps:<br>[..]<br>ahcich2: AHCI reset...<br>ahcich2: SA=
TA connect time=3D0us status=3D00000113<br>ahcich2: AHCI reset: device foun=
d<br>ahcich2: AHCI reset: device ready after 0ms<br>[..]<br>Trying to mount=
 root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]...<br>ahcich2: Po=
ll timeout on slot 1 port 0<br>ahcich2: is 00000000 cs 00000002 ss 00000000=
 rs 00000002 tfd 170 serr 00000000 cmd 0000c017<br>(aprobe2:ahcich2:0:0:0):=
 SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00<br>(aprobe2:ahcich2:0=
:0:0): CAM status: Command timeout<br>(aprobe2:ahcich2:0:0:0): Error 5, Ret=
ries exhausted<br>ahcich2: Poll timeout on slot 2 port 0<br>ahcich2: is 000=
00000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 00000000 cmd 0000c01=
7<br>(aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 0=
0 00 00<br>(aprobe2:ahcich2:0:0:0): CAM status: Command timeout<br>(aprobe2=
:ahcich2:0:0:0): Error 5, Retries exhausted<br>mountroot: waiting for devic=
e /dev/iso9660/13_2_RELEASE_AMD64_BO...<br>Mounting from cd9660:/dev/iso966=
0/13_2_RELEASE_AMD64_BO failed with error 19.<br><br>Same thing happens wit=
h current qemu HEAD:<br><br>commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014=
<br>Merge: 29578f5757 b821109583<br>Author: Stefan Hajnoczi &lt;<a href=3D"=
mailto:stefanha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@r=
edhat.com</a>&gt;<br>Date:   Mon Sep 25 10:10:30 2023 -0400<br><br>    Merg=
e tag &#39;pull-request-2023-09-25&#39; of <a href=3D"https://gitlab.com/th=
uth/qemu" target=3D"_blank" rel=3D"noreferrer">https://gitlab.com/thuth/qem=
u</a> into staging<br><br><br>Any ideas?<br></div></pre></blockquote></div>=
</div></blockquote></div></div></div>

--00000000000002c4d2060645ac8a--


