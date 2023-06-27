Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A673FC1D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE81A-0005Lz-CO; Tue, 27 Jun 2023 08:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qE817-0005La-VJ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qE816-00014F-1r
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687869715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YsXZ1rNS4BTe6puW+gYVb288uKJ+VeL5XVX1ZacTUk=;
 b=Ya7NIQtdPzCJMLv5Cit3BhuYwhDHgB/klcLg4sshW3jTLdYuKtxZwGuu4bmCDox2gsxpRb
 0xjIZ5Q+adwrS/+R3SpgRpA99K7uqLCc5FQGuFUSMK3DMb350LrH1RDf4X6RwxoniZm+p8
 K8xumvloKG/qYdiRs9Ty5ZqIRP3TnG8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-yDdoOinFO3apRYSg0gImPQ-1; Tue, 27 Jun 2023 08:41:54 -0400
X-MC-Unique: yDdoOinFO3apRYSg0gImPQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635a3b9d24eso28710776d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687869713; x=1690461713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YsXZ1rNS4BTe6puW+gYVb288uKJ+VeL5XVX1ZacTUk=;
 b=OEcm3blGtgTaRdfXaCzfIyprrtuRvPgshoyBmX7R5VknXPHzQyb1UMTubviQrZ4CN2
 8u5O/e2hJtwt/G0SuVxTmWZJYW+fjT4DzMVYLb3YghGY3URIc4uCF5chq2yAQN2lia2+
 R82/m3/5yBly3ToXeSgr2s/0CUs3JMqKHlyMewbPJoXDcVWtj/BpsLuIgjKVlvbXAh+R
 MxRXcBQDdRQjfEgYSCAqAcMWA/bW7NDVHjkS6KMMxBzm4wJqeLnjcsq+nJUBTnloKycy
 nIqWvzyUYRiuH068LFX7BNF4RXSewdu3VNdQmC7lumEko5adBrR8dTUKSwETNNqpIFaJ
 z08Q==
X-Gm-Message-State: AC+VfDytNBPNS1Z5f3gNgpWlholfqPDJsNIIiZ3BZntQAaeZ0iuxK0Or
 ZLSkM88/6qSmO2VQbD6j3fRXadhgLeaVCJF5Zcam+M2cojKZ7ddvssFHbCvjV+e959ux4NihCF6
 F4BOO5Txl0+E05co=
X-Received: by 2002:a05:6214:2129:b0:635:da2a:4706 with SMTP id
 r9-20020a056214212900b00635da2a4706mr8551278qvc.15.1687869713585; 
 Tue, 27 Jun 2023 05:41:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Gxbr2Hg8+S1y752ieHqYp5TBWQdwreGhGTUDOuZuUALoht5/xvOS9/kxSJrzlMZWdhBp4AQ==
X-Received: by 2002:a05:6214:2129:b0:635:da2a:4706 with SMTP id
 r9-20020a056214212900b00635da2a4706mr8551260qvc.15.1687869713333; 
 Tue, 27 Jun 2023 05:41:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 du7-20020a05621409a700b006301d31e315sm4532680qvb.10.2023.06.27.05.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:41:52 -0700 (PDT)
Message-ID: <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
Date: Tue, 27 Jun 2023 14:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
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
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/27/23 14:05, Howard Spoelstra wrote:
> 
> 
> On Tue, Jun 27, 2023 at 1:24 PM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
> 
>     On 27/06/2023 11:28, Howard Spoelstra wrote:
> 
>      > On Tue, Jun 27, 2023 at 10:15 AM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>
>      > <mailto:mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>>> wrote:
>      >
>      >     On 26/06/2023 14:35, Cédric Le Goater wrote:
>      >
>      >      > On 6/23/23 14:37, Cédric Le Goater wrote:
>      >      >> On 6/23/23 11:10, Peter Maydell wrote:
>      >      >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com <mailto:npiggin@gmail.com>
>      >     <mailto:npiggin@gmail.com <mailto:npiggin@gmail.com>>> wrote:
>      >      >>>>
>      >      >>>> ppc has always silently ignored access to real (physical) addresses
>      >      >>>> with nothing behind it, which can make debugging difficult at times.
>      >      >>>>
>      >      >>>> It looks like the way to handle this is implement the transaction
>      >      >>>> failed call, which most target architectures do. Notably not x86
>      >      >>>> though, I wonder why?
>      >      >>>
>      >      >>> Much of this is historical legacy. QEMU originally had no
>      >      >>> concept of "the system outside the CPU returns some kind
>      >      >>> of bus error and the CPU raises an exception for it".
>      >      >>> This is turn is (I think) because the x86 PC doesn't do
>      >      >>> that: you always get back some kind of response, I think
>      >      >>> -1 on reads and writes ignored. We added the do_transaction_failed
>      >      >>> hook largely because we wanted it to give more accurate
>      >      >>> emulation of this kind of thing on Arm, but as usual with new
>      >      >>> facilities we left the other architectures to do it themselves
>      >      >>> if they wanted -- by default the behaviour remained the same.
>      >      >>> Some architectures have picked it up; some haven't.
>      >      >>>
>      >      >>> The main reason it's a bit of a pain to turn the correct
>      >      >>> handling on is because often boards don't actually implement
>      >      >>> all the devices they're supposed to. For a pile of legacy Arm
>      >      >>> boards, especially where we didn't have good test images,
>      >      >>> we use the machine flag ignore_memory_transaction_failures to
>      >      >>> retain the legacy behaviour. (This isn't great because it's
>      >      >>> pretty much going to mean we have that flag set on those
>      >      >>> boards forever because nobody is going to care enough to
>      >      >>> investigate and test.)
>      >      >>>
>      >      >>>> Other question is, sometimes I guess it's nice to avoid crashing in
>      >      >>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>      >      >>>> command line option or something could turn it off? It should
>      >      >>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>      >      >>>> series up, I can propose a option for that if anybody is worried
>      >      >>>> about it.
>      >      >>>
>      >      >>> I would not recommend going any further than maybe setting the
>      >      >>> ignore_memory_transaction_failures flag for boards you don't
>      >      >>> care about. (But in an ideal world, don't set it and deal with
>      >      >>> any bug reports by implementing stub versions of missing devices.
>      >      >>> Depends how confident you are in your test coverage.)
>      >      >>
>      >      >> It seems it broke the "mac99" and  powernv10 machines, using the
>      >      >> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>      >      >>
>      >      >> Adding Mark for further testing on Mac OS.
>      >      >
>      >      >
>      >      > Mac OS 9.2 fails to boot with a popup saying :
>      >      >          Sorry, a system error occured.
>      >      >          "Sound Manager"
>      >      >            address error
>      >      >          To temporarily turn off extensions, restart and
>      >      >          hold down the shift key
>      >      >
>      >      >
>      >      > Darwin and Mac OSX look OK.
>      >
>      >     My guess would be that MacOS 9.2 is trying to access the sound chip registers which
>      >     isn't implemented in QEMU for the moment (I have a separate screamer branch
>      >     available, but it's not ready for primetime yet). In theory they shouldn't be
>      >     accessed at all because the sound device isn't present in the OpenBIOS device tree,
>      >     but this is all fairly old stuff.
>      >
>      >     Does implementing the sound registers using a dummy device help at all?
>      >
>      >
>      > My uneducated guess is that you stumbled on a longstanding, but intermittently
>      > occurring, issue specific to Mac OS 9.2 related to sound support over USB in Apple
>      > monitors.
> 
>     I'm not sure I understand this: are there non-standard command line options being
>     used here other than "qemu-system-ppc -M mac99 -cdrom macos92.iso -boot d"?
> 
> 
> 
> It must be my windows host ;-)
> 
> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
> crashes Mac OS with an address error. (with unpatched and patched builds).

Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.

C.



> 
> qemu-system-ppc.exe -M mac99 -hda C:\mac-hd\9.2.2-clean.img -boot c -L pc-bios sometimes crashes with an illegal instruction.
> 
> qemu-system-ppc.exe -M mac99,via=pmu -hda C:\mac-hd\9.2.2-clean.img -boot c -L pc-bios sometimes crashes with Sound manager address error.
> (with both patched and non-patched versions).
> 
> Best,
> Howard
> 
> 
>      > I believe It is not fixed by the patch set from the 23 of june, I still get system
>      > errors when running Mac OS 9.2 with the mac99 machine after applying them.
>      > Mac OS 9.2 has required mac99,via=pmu for a long time now to always boot
>      > successfully. (while 9.0.4 requires mac99 to boot, due to an undiagnosed OHCI USB
>      > problem with the specific drivers that ship with it.)  ;-)
> 
>     I always test MacOS 9.2 boot both with and without via=pmu for my OpenBIOS tests, so
>     I'd expect this to work unless a regression has slipped in?
> 
> 
>     ATB,
> 
>     Mark.
> 


