Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C481DAFC
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 15:45:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHPiB-0007AS-Aq; Sun, 24 Dec 2023 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rHPi7-00078u-I1; Sun, 24 Dec 2023 09:44:11 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rHPi3-00060b-N9; Sun, 24 Dec 2023 09:44:10 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbd71f33cd3so2490886276.3; 
 Sun, 24 Dec 2023 06:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703429044; x=1704033844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1txHoRkgsl0aEqlPdutv+eooUxcQU51gqF+3cxgyYGc=;
 b=aewcZQ9ZvXNMqTW6QV0crZ7e7BPjeTUCZX7XFM79t22eJkocyEvJQ0S5nvB5ujK4LU
 oFeWa9PL0bFudBgKZyG5kquzTDmdNAz0WfcjCS69xRzn9DGSKMpahgH9SKWf8J+pMBHk
 mpXqIwhhlfK175OOftHBACgOu6UpQwTgEysw5FWesP3mGWf62ZpSc4Yv+7YS3IiO9Efz
 HJ+YONGeKhQCzvtrNBi/sNYEaNH0UmLCIJ4G9LisoKeQ1sdhxyymqOf7mm/EyWVQ5bVU
 lXr3NYfTmOcgLVRLSHN4aWe0ZjA4Jg5OFdgwQN69PbMP4OtoFzLN6WmvM26P0+cYw26a
 iwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703429044; x=1704033844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1txHoRkgsl0aEqlPdutv+eooUxcQU51gqF+3cxgyYGc=;
 b=AbDC6dJXSpt2pOJ61D7lssD7CA8FVjovYf6+F1mf4cITnX4T3I4DzQWyQqwbX6y4E2
 sibNy91kx5pJ7WSl4xu4GZFpoYVNSwA3zZDkfwR2YQ5r7us5z90zOKIUTuC2q+PAb3I2
 SDOuobzeksrenfGk1L/pBOi5pBZuXglN/s68yFDJdkePGMX+U43Vq8FfxyIFnDmA+sJi
 2nMmeeaup7BCyif4FhCtr1WzlP4Ce9Yu000CEtL/kbOSNUbf+AD2dfl46qt89fNVybil
 jy9IizGmDllZFW3uWdJh/t2YqZD/wojOnv1F8rVn2ajQDEtxhoIQgscdJqkKyy4Sxlv5
 NoWQ==
X-Gm-Message-State: AOJu0Yx+CYxZc0JEG5RI+YW5tmkfp/TpM+//P86vagTms1TU9XJJe4iZ
 hoiGHjGGMDVRqsG2P6VNsy46T1XILEaGaClE+qGLeziX
X-Google-Smtp-Source: AGHT+IHxh8e4W29lSRI5re16BMt7C9OOoDbTBxkp46V3C1R3sGYorwwbFCORykgx55XYRbs1YUAgzGOtRsQELYjwBCA=
X-Received: by 2002:a25:4108:0:b0:dbd:c444:bf35 with SMTP id
 o8-20020a254108000000b00dbdc444bf35mr2031842yba.76.1703429044499; Sun, 24 Dec
 2023 06:44:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
 <2bf508bc-ce4b-870c-1828-b349c96f8102@eik.bme.hu>
In-Reply-To: <2bf508bc-ce4b-870c-1828-b349c96f8102@eik.bme.hu>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Sun, 24 Dec 2023 16:43:53 +0200
Message-ID: <CAHzK-V2tSJNpTsNe7=Na7_Bg-YR4kP_6THJCKfAN9tumVAXeVg@mail.gmail.com>
Subject: Re: PCIe with Designware RC.
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=shlomopongratz@gmail.com; helo=mail-yb1-xb29.google.com
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

Thank you, see comment inside.

On Sun, Dec 24, 2023 at 1:11=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Sun, 24 Dec 2023, Shlomo Pongratz wrote:
> > Hi,
> > I'm working on a AARCH64 project that uses the designeware
> > (hw/pci-host/designware.c).
> > I've copied the designware initialization from hw/arm/fsl-imx7.c and I
> > hope I've updated the dtsi correctly.
> > After fixing an issue with the iATU windows (see patch
> > https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02643.html)
> > I've tried to add virtualized NVMe controller.
> > When I added the lines:
> >        -device nvme,serial=3Ddeadbeef,drive=3Dnvme0,bus=3Dpcie \  (Or w=
ithout bus=3D)
> >        -drive file=3D/home/pliops/disk-1.img,if=3Dnone,id=3Dnvme1 \
>
> You define drive with if=3Dnone,id=3Dnvme1 but have drive=3Dnvme0 in your
> device. You should refer to the drive you want the device to use so I
> think it should either be -device nvme,drive=3Dnvme1 or the if of drive
> should be nvme0.

This was a typo, All are nvme0.

 I don't know how this works for nvme but for CD drives
> for example adding a device would add it without disk and drive defines
> the disk to use. Not sure this makes sense for hard disks or nvme device
> but maybe the command line options don't consider that.
>
> > I could see in QEMU monitor that the NVMe device was preset i.e.
> > (qemu) info pci
> >  Bus  0, device   0, function 0:
> >    PCI bridge: PCI device 16c3:abcd
> >      IRQ 0, pin A
> >      BUS 0.
> >      secondary bus 1.
> >      subordinate bus 255.
> >      IO range [0xf000, 0x0fff]
> >      memory range [0xfff00000, 0x000fffff]
> >      prefetchable memory range [0xfff00000, 0x000fffff]
> >      id ""
> >  Bus  0, device   1, function 0:
> >    Class 0264: PCI device 1b36:0010
> >      PCI subsystem 1af4:1100
> >      IRQ 0, pin A
> >      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
> >      id ""
> > However in lspci it was missing
> > # lspci
> > 00:00.0 Class 0604: 16c3:abcd
> >
> > If I used the following command
> >        -drive file=3D/home/pliops/disk.img,if=3Dnone,id=3Dnvme0 \
> >        -device nvme,serial=3Ddeadbeef,drive=3Dnvme0,bus=3Ddw-pcie \
>
> Here you correctly define both media and drive so it works as expected.
> There are some shortcuts for -drive with media=3Ddisk or media=3Dcdrom an=
d
> if=3Dide or scsi that don't need a separate drive option as if=3Dnone doe=
s but
> not sure if that supports nvme. You probably have to check documentation
> or code to find out.
>
> > Then in the monitor I see:
> > (qemu) info pci
> >  Bus  0, device   0, function 0:
> >    PCI bridge: PCI device 16c3:abcd
> >      IRQ 0, pin A
> >      BUS 0.
> >      secondary bus 1.
> >      subordinate bus 255.
> >      IO range [0xf000, 0x0fff]
> >      memory range [0x40000000, 0x401fffff]
> >      prefetchable memory range [0xfff00000, 0x000fffff]
> >      id ""
> >  Bus  1, device   0, function 0:
> >    Class 0264: PCI device 1b36:0010
> >      PCI subsystem 1af4:1100
> >      IRQ 1, pin A
> >      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
> >      id ""
> > That is the NVMe is on BUS 1.
> > And in lspci I can now see the device but on bus 1.
> > # lspci
> > 01:00.0 Class 0108: 1b36:0010
> > 00:00.0 Class 0604: 16c3:abcd
> >
> > Is this expected?
> >
> > But the main problem is that during the initialization of the
> > controller registers in BAR0 all the read and writes are actually done
> > into the config space.
>
> I don't know what this is but don't think it's related to the above.
>
> Regards,
> BALATON Zoltan
>
> > Any ideas?
> >
> > Thank you
> > Shlomo Pongratz.
> >
> >

