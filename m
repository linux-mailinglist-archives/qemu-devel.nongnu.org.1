Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F07B6F47
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnisd-00067j-Cq; Tue, 03 Oct 2023 13:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnisX-00065l-My
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnisT-0002e0-82
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696352888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXE0vN/L0rreRVqxrefBCnsku8gz9f4PQP+8NsmXuj0=;
 b=Mb0c8gA8XRHdDR2Ri0lY3EtEN99x8BeimVUd1ZNzjmnp9RUOmeAQibebM6GMUU9hnFPF1W
 7AlwWrzvvSEqAZXwDZZNkEpP5IyknjI4fLNcODM/oeUCRZwc26wxayX/owFENEezDHE6qd
 VXa+mu2tHegDvnFltBIt7vN9DytGFmA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-jEiRsPDWP_OJ8rbHLHvQiA-1; Tue, 03 Oct 2023 13:08:06 -0400
X-MC-Unique: jEiRsPDWP_OJ8rbHLHvQiA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3af5a2a0c8fso1704272b6e.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696352885; x=1696957685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXE0vN/L0rreRVqxrefBCnsku8gz9f4PQP+8NsmXuj0=;
 b=urJo7HJTpp2fVQ8FFknqgG8s/GlVZoEBiCn80DBEChkTCePYLQwuwek70GtptPrU+M
 04SyJQeWyRstVJKG40akc2dzpx4typz11m08F4lUviGayr0Ww+HsqBqyY/qsPsWMQ5i1
 sFe5k91ag5XJxk5ajNAPkTOcf4hLEH353G6qgchcF7AbPSFPjqUg0v8ettt7D1wI7PHM
 CEYGmQzZb4Ev0my6LYbzojNEb2iXSt9H8lWaE8ETDEiG0+L+5FE+m6xfeTk9w0/lr9Mj
 bel0pPuUEAvnoxMgApitG6zAkiWCKR+d9aSEed0Yk2zbpzrI3kbEdvhRM8qnZigCtmtl
 EF9Q==
X-Gm-Message-State: AOJu0YzkMku3a0gU4u+Tm6TntFzBk/HbU4Z0unumRssEy71/Q/ho2Zyr
 CuCJ7m5easTcXmXbLrsWY1080w/eE4td9aUk30hj0Q0vYKZyUF1EhlnosWUumnSzp5u1GclfVFw
 xQ6hk3bPlMBjlUXNUOmUQWVnlEJQoIArjGzph3o8=
X-Received: by 2002:a05:6808:3023:b0:3a7:8f94:743a with SMTP id
 ay35-20020a056808302300b003a78f94743amr257059oib.10.1696352885690; 
 Tue, 03 Oct 2023 10:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSjOfv2quaqdtjZPz9he8AwLF3x/A3Eo4BMSoyU3RyxGv0Wh35dvT7ib/w7AhjByp/3rIXok7eYYA+ic8BSIM=
X-Received: by 2002:a05:6808:3023:b0:3a7:8f94:743a with SMTP id
 ay35-20020a056808302300b003a78f94743amr257035oib.10.1696352885385; Tue, 03
 Oct 2023 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
 <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
 <CAFn=p-a5hbbKTABxrE2+7jfq7fB6+Y46uQhLsWAwbj_xFMhhMA@mail.gmail.com>
In-Reply-To: <CAFn=p-a5hbbKTABxrE2+7jfq7fB6+Y46uQhLsWAwbj_xFMhhMA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Oct 2023 13:07:54 -0400
Message-ID: <CAFn=p-YkDzGxZuABYoCfd3cKd7X4u=E3OPjyYj_E_CHc=pCP1A@mail.gmail.com>
Subject: Re: FreeBSD 13.2 installer does not see AHCI devices on
 aarch64/sbsa-ref and x86-64/q35
To: Niklas Cassel <nks@flawful.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="00000000000025ca3d0606d2ef67"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

--00000000000025ca3d0606d2ef67
Content-Type: text/plain; charset="UTF-8"

While I'm poking at IDE today ... any news here?


On Tue, Sep 26, 2023, 12:35 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On Tue, Sep 26, 2023, 8:06 AM Niklas Cassel <nks@flawful.org> wrote:
>
>> Hello Marcin,
>>
>> I will have a look at this.
>>
>>
>> Kind regards,
>> Niklas
>>
>
> Thanks. You have my blessing in advance to get any hot fixes for this
> merged ASAP, as long as another block maintainer is willing to give it an
> ACK. (I'll try to be prompt. Please send me a message on IRC to get my
> attention if you need to. Sorry I'm so hard to get hold of.)
>
> Also CC mjt - we might need a fix for stable if you merged these patches.
>
>
>
>>
>>
>> On 26 September 2023 13:23:46 CEST, Marcin Juszkiewicz <
>> marcin.juszkiewicz@linaro.org> wrote:
>>
>>> I work on SBSA Reference Platform (sbsa-ref) at Linaro. And yesterday I
>>> wanted to check how non-Linux operating systems work on sbsa-ref machine.
>>>
>>> One of them was FreeBSD 13.2 - the latest one. Fetched bootonly ISO
>>> image [1] and booted system.
>>>
>>> 1. https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso
>>>
>>> QEMU command line arguments:
>>>
>>> -drive if=ide,file=disks/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso,media=cdrom
>>> -machine sbsa-ref
>>> -m 4096
>>> -smp 2
>>> -cpu neoverse-n1
>>> -drive file=fat:rw:/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/virtual/,format=raw
>>> -drive format=raw,file=/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/full-debian.hddimg
>>> -watchdog-action none
>>> -no-reboot
>>> -monitor telnet::45454,server,nowait
>>> -serial stdio
>>> -device igb
>>> -nographic
>>> -drive if=pflash,file=SBSA_FLASH0.fd,format=raw
>>> -drive if=pflash,file=SBSA_FLASH1.fd,format=raw
>>>
>>>
>>> Firmware loaded FreeBSD loader, kernel booted but it does not see
>>> any AHCI devices:
>>>
>>> ahci0: <AHCI SATA controller> iomem 0x60100000-0x6010ffff irq 1 on acpi0
>>> ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
>>> ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
>>> ahcich0: <AHCI channel> at channel 0 on ahci0
>>> ahcich0: Caps:
>>> [..]
>>> ahcich0: AHCI reset...
>>> ahcich0: SATA connect time=0us status=00000113
>>> ahcich0: AHCI reset: device found
>>> ahcich0: AHCI reset: device ready after 0ms
>>> ahcich1: AHCI reset...
>>> ahcich1: SATA connect time=0us status=00000113
>>> ahcich1: AHCI reset: device found
>>> ahcich1: AHCI reset: device ready after 0ms
>>> ahcich2: AHCI reset...
>>> ahcich2: SATA connect time=0us status=00000113
>>> ahcich2: AHCI reset: device found
>>> ahcich2: AHCI reset: device ready after 0ms
>>> [..]
>>> Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AARCH64_BO [ro]...
>>> Root mount waiting for: CAM
>>> [..]
>>> Root mount waiting for: CAM
>>> ahcich0: Poll timeout on slot 1 port 0
>>> ahcich0: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017
>>>
>>> And finally it gives up.
>>>
>>>
>>> v8.1.1 was bad, v8.0.5 was bad so I did git bisecting.
>>> Which gave me this commit:
>>>
>>> commit 7bcd32128b227cee1fb39ff242d486ed9fff7648
>>> Author: Niklas Cassel <niklas.cassel@wdc.com>
>>> Date:   Fri Jun 9 16:08:40 2023 +0200
>>>
>>>     hw/ide/ahci: simplify and document PxCI handling
>>>
>>>     The AHCI spec states that:
>>>     For NCQ, PxCI is cleared on command queued successfully.
>>>
>>>
>>>
>>> I built x86_64-softmmu target and checked both "pc" and "q35"
>>> machines.
>>>
>>> ./build/x86_64-softmmu/qemu-system-x86_64
>>> -cdrom FreeBSD-13.2-RELEASE-amd64-bootonly.iso
>>> -m 2048 -serial stdio  -monitor telnet::45454,server,nowait
>>>
>>> PC target ("-M pc") booted fine. But Q35 ("-M q35") failed
>>> similar way as aarch64/sbsa-ref did:
>>>
>>> ahci0: <Intel ICH9 AHCI SATA controller> port 0xc060-0xc07f mem 0xfebd5000-0xfebd5fff irq 16 at device 31.2 on pci0
>>> ahci0: attempting to allocate 1 MSI vectors (1 supported)
>>> msi: routing MSI IRQ 26 to local APIC 0 vector 52
>>> ahci0: using IRQ 26 for MSI
>>> ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported
>>> ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports
>>> ahcich0: <AHCI channel> at channel 0 on ahci0
>>> ahcich0: Caps:
>>> ahcich1: <AHCI channel> at channel 1 on ahci0
>>> ahcich1: Caps:
>>> ahcich2: <AHCI channel> at channel 2 on ahci0
>>> ahcich2: Caps:
>>> [..]
>>> ahcich2: AHCI reset...
>>> ahcich2: SATA connect time=0us status=00000113
>>> ahcich2: AHCI reset: device found
>>> ahcich2: AHCI reset: device ready after 0ms
>>> [..]
>>> Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO [ro]...
>>> ahcich2: Poll timeout on slot 1 port 0
>>> ahcich2: is 00000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017
>>> (aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
>>> (aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>>> (aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>>> ahcich2: Poll timeout on slot 2 port 0
>>> ahcich2: is 00000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 serr 00000000 cmd 0000c017
>>> (aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 00
>>> (aprobe2:ahcich2:0:0:0): CAM status: Command timeout
>>> (aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted
>>> mountroot: waiting for device /dev/iso9660/13_2_RELEASE_AMD64_BO...
>>> Mounting from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO failed with error 19.
>>>
>>> Same thing happens with current qemu HEAD:
>>>
>>> commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014
>>> Merge: 29578f5757 b821109583
>>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>>> Date:   Mon Sep 25 10:10:30 2023 -0400
>>>
>>>     Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging
>>>
>>>
>>> Any ideas?
>>>
>>>

--00000000000025ca3d0606d2ef67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br>While I&#39;m poking at IDE today ... any news h=
ere?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Sep 26, 2023, 12:35 PM John Snow &lt;<a href=3D"mailto=
:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 26, 2023, 8:06 AM Niklas C=
assel &lt;<a href=3D"mailto:nks@flawful.org" target=3D"_blank" rel=3D"noref=
errer">nks@flawful.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div><div dir=3D"auto">Hello Marcin,<br><br>I will have a look at this.<=
br><br><br>Kind regards,<br>Niklas<br></div></div></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks. You have my blessing =
in advance to get any hot fixes for this merged ASAP, as long as another bl=
ock maintainer is willing to give it an ACK. (I&#39;ll try to be prompt. Pl=
ease send me a message on IRC to get my attention if you need to. Sorry I&#=
39;m so hard to get hold of.)</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Also CC mjt - we might need a fix for stable if you merged these patc=
hes.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><d=
iv dir=3D"auto"><br></div><br><br><div class=3D"gmail_quote"><div dir=3D"au=
to">On 26 September 2023 13:23:46 CEST, Marcin Juszkiewicz &lt;<a href=3D"m=
ailto:marcin.juszkiewicz@linaro.org" rel=3D"noreferrer noreferrer" target=
=3D"_blank">marcin.juszkiewicz@linaro.org</a>&gt; wrote:</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<pre><div dir=3D"auto">I work on SBSA Reference Platform (sbsa-ref) at Lina=
ro. And yesterday I<br>wanted to check how non-Linux operating systems work=
 on sbsa-ref machine.<br><br>One of them was FreeBSD 13.2 - the latest one.=
 Fetched bootonly ISO<br>image [1] and booted system.<br><br>1. <a href=3D"=
https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/13.2/FreeBSD=
-13.2-RELEASE-arm64-aarch64-bootonly.iso" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAG=
ES/13.2/FreeBSD-13.2-RELEASE-arm64-aarch64-bootonly.iso</a><br><br>QEMU com=
mand line arguments:<br><br>-drive if=3Dide,file=3Ddisks/FreeBSD-13.2-RELEA=
SE-arm64-aarch64-bootonly.iso,media=3Dcdrom<br>-machine sbsa-ref<br>-m 4096=
<br>-smp 2<br>-cpu neoverse-n1<br>-drive file=3Dfat:rw:/home/marcin/devel/l=
inaro/sbsa-qemu/sbsa-ref-status/disks/virtual/,format=3Draw<br>-drive forma=
t=3Draw,file=3D/home/marcin/devel/linaro/sbsa-qemu/sbsa-ref-status/disks/fu=
ll-debian.hddimg<br>-watchdog-action none<br>-no-reboot<br>-monitor telnet:=
:45454,server,nowait<br>-serial stdio<br>-device igb<br>-nographic<br>-driv=
e if=3Dpflash,file=3DSBSA_FLASH0.fd,format=3Draw<br>-drive if=3Dpflash,file=
=3DSBSA_FLASH1.fd,format=3Draw<br><br><br>Firmware loaded FreeBSD loader, k=
ernel booted but it does not see<br>any AHCI devices:<br><br>ahci0: &lt;AHC=
I SATA controller&gt; iomem 0x60100000-0x6010ffff irq 1 on acpi0<br>ahci0: =
AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not supported<br>ahci0: Ca=
ps: 64bit NCQ 1.5Gbps 32cmd 6ports<br>ahcich0: &lt;AHCI channel&gt; at chan=
nel 0 on ahci0<br>ahcich0: Caps:<br>[..]<br>ahcich0: AHCI reset...<br>ahcic=
h0: SATA connect time=3D0us status=3D00000113<br>ahcich0: AHCI reset: devic=
e found<br>ahcich0: AHCI reset: device ready after 0ms<br>ahcich1: AHCI res=
et...<br>ahcich1: SATA connect time=3D0us status=3D00000113<br>ahcich1: AHC=
I reset: device found<br>ahcich1: AHCI reset: device ready after 0ms<br>ahc=
ich2: AHCI reset...<br>ahcich2: SATA connect time=3D0us status=3D00000113<b=
r>ahcich2: AHCI reset: device found<br>ahcich2: AHCI reset: device ready af=
ter 0ms<br>[..]<br>Trying to mount root from cd9660:/dev/iso9660/13_2_RELEA=
SE_AARCH64_BO [ro]...<br>Root mount waiting for: CAM<br>[..]<br>Root mount =
waiting for: CAM<br>ahcich0: Poll timeout on slot 1 port 0<br>ahcich0: is 0=
0000000 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c=
017<br><br>And finally it gives up.<br><br><br>v8.1.1 was bad, v8.0.5 was b=
ad so I did git bisecting.<br>Which gave me this commit:<br><br>commit 7bcd=
32128b227cee1fb39ff242d486ed9fff7648<br>Author: Niklas Cassel &lt;<a href=
=3D"mailto:niklas.cassel@wdc.com" rel=3D"noreferrer noreferrer" target=3D"_=
blank">niklas.cassel@wdc.com</a>&gt;<br>Date:   Fri Jun 9 16:08:40 2023 +02=
00<br><br>    hw/ide/ahci: simplify and document PxCI handling<br><br>    T=
he AHCI spec states that:<br>    For NCQ, PxCI is cleared on command queued=
 successfully.<br><br><br><br>I built x86_64-softmmu target and checked bot=
h &quot;pc&quot; and &quot;q35&quot;<br>machines.<br><br>./build/x86_64-sof=
tmmu/qemu-system-x86_64<br>-cdrom FreeBSD-13.2-RELEASE-amd64-bootonly.iso<b=
r>-m 2048 -serial stdio  -monitor telnet::45454,server,nowait<br><br>PC tar=
get (&quot;-M pc&quot;) booted fine. But Q35 (&quot;-M q35&quot;) failed<br=
>similar way as aarch64/sbsa-ref did:<br><br>ahci0: &lt;Intel ICH9 AHCI SAT=
A controller&gt; port 0xc060-0xc07f mem 0xfebd5000-0xfebd5fff irq 16 at dev=
ice 31.2 on pci0<br>ahci0: attempting to allocate 1 MSI vectors (1 supporte=
d)<br>msi: routing MSI IRQ 26 to local APIC 0 vector 52<br>ahci0: using IRQ=
 26 for MSI<br>ahci0: AHCI v1.00 with 6 1.5Gbps ports, Port Multiplier not =
supported<br>ahci0: Caps: 64bit NCQ 1.5Gbps 32cmd 6ports<br>ahcich0: &lt;AH=
CI channel&gt; at channel 0 on ahci0<br>ahcich0: Caps:<br>ahcich1: &lt;AHCI=
 channel&gt; at channel 1 on ahci0<br>ahcich1: Caps:<br>ahcich2: &lt;AHCI c=
hannel&gt; at channel 2 on ahci0<br>ahcich2: Caps:<br>[..]<br>ahcich2: AHCI=
 reset...<br>ahcich2: SATA connect time=3D0us status=3D00000113<br>ahcich2:=
 AHCI reset: device found<br>ahcich2: AHCI reset: device ready after 0ms<br=
>[..]<br>Trying to mount root from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_B=
O [ro]...<br>ahcich2: Poll timeout on slot 1 port 0<br>ahcich2: is 00000000=
 cs 00000002 ss 00000000 rs 00000002 tfd 170 serr 00000000 cmd 0000c017<br>=
(aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 00 00 00 00 00 00 00 00 00 00 =
00<br>(aprobe2:ahcich2:0:0:0): CAM status: Command timeout<br>(aprobe2:ahci=
ch2:0:0:0): Error 5, Retries exhausted<br>ahcich2: Poll timeout on slot 2 p=
ort 0<br>ahcich2: is 00000000 cs 00000006 ss 00000000 rs 00000004 tfd 170 s=
err 00000000 cmd 0000c017<br>(aprobe2:ahcich2:0:0:0): SOFT_RESET. ACB: 00 0=
0 00 00 00 00 00 00 00 00 00 00<br>(aprobe2:ahcich2:0:0:0): CAM status: Com=
mand timeout<br>(aprobe2:ahcich2:0:0:0): Error 5, Retries exhausted<br>moun=
troot: waiting for device /dev/iso9660/13_2_RELEASE_AMD64_BO...<br>Mounting=
 from cd9660:/dev/iso9660/13_2_RELEASE_AMD64_BO failed with error 19.<br><b=
r>Same thing happens with current qemu HEAD:<br><br>commit 494a6a2cf7f775d2=
c20fd6df9601e30606cc2014<br>Merge: 29578f5757 b821109583<br>Author: Stefan =
Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" rel=3D"noreferrer noref=
errer" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>Date:   Mon Sep 25 =
10:10:30 2023 -0400<br><br>    Merge tag &#39;pull-request-2023-09-25&#39; =
of <a href=3D"https://gitlab.com/thuth/qemu" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://gitlab.com/thuth/qemu</a> into staging<br><br><br=
>Any ideas?<br></div></pre></blockquote></div></div></blockquote></div></di=
v></div>
</blockquote></div></div></div>

--00000000000025ca3d0606d2ef67--


