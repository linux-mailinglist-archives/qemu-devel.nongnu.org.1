Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13179D35F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4BG-0000ak-MT; Tue, 12 Sep 2023 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1qg3Lo-0001p5-CC; Tue, 12 Sep 2023 09:22:44 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1qg3Lk-00038F-VH; Tue, 12 Sep 2023 09:22:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26ef24b8e5aso4611580a91.0; 
 Tue, 12 Sep 2023 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694524959; x=1695129759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiskIvqTFXfoT0VHOQLJINwqPNhB6s8n0umzjd3eE9o=;
 b=Q/2W9hQglvIpPIEP/dPKLnk89S7uOm+uXXyLqTwR/Alx8UjnE4Pu3xhw1eJN1RtITR
 myLCVijhZqcCESvlU26na0laYmzXqUfor9a1PZErBbrl1jpx9YDt6xFwLidPS2GuPTwL
 mnVMTYNWM+izdeCZwyI0cYi/lEuiQ/B+tl8C7IsQrjVj+qYQfkcWaY6gDo5LoXXj4XAE
 Vktk+8eTIv4VnCI1JisTu7YbLVjWu18okrAqAJSsEe1asRg/slwPY8xTBbrqv9reVvAX
 Grn6XGbGITvvmqlY5xHbE9ZgUbASVFqkFKEv2uDJzykB66dMBk6v6nGiyhoHZoyP+RZ0
 6EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694524959; x=1695129759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiskIvqTFXfoT0VHOQLJINwqPNhB6s8n0umzjd3eE9o=;
 b=sHexp/LmeVzjO97pvdeG9adUvbO8HGM6xNxp8p+UG5FPj8Pr/MqbzOrI/yYIeoP7g5
 wXA5KQ/hhKWiiTwtphvNV/SPyhYWWdJe8A+nA+8y3jLaEqmY0/isldCFdOBZ2MqQ49Y3
 N3yhRvVIrjp62fEXRNkqhVcbmEkxRMEx3s0u6KFmzLfAYRLl9re2bFcg+YlqWNOxeHVK
 jmD7/X2/7H9g/89HlatjhTTUEDk7bzCsGRCRKvpGM0eBZgHGwACtrh97QqcsFtUX7vzH
 62qn4hD3T7X2Hy0b+5/en8Q0gWJ+wezlmkuZybMj0WDi+lPBQCIht6sbFwhP8UWDz3gp
 DNcg==
X-Gm-Message-State: AOJu0YzJ9aM6TgeKl47FPt/x9XaEbNvz7zz2woW9j17heAGSLg8ctt5D
 AzRq4mB7+/W2hugmk2gEv1TMbtAMoPN8s9L2eh0=
X-Google-Smtp-Source: AGHT+IGXbM4hKq74vJKB04al6iuUWF0suMGYk/7EM4eacO2/yuErX1YxNzQ3RH3wKgw9rS4hDaQ1hidzb10mmlHUO7I=
X-Received: by 2002:a17:90a:3cc6:b0:273:f229:a479 with SMTP id
 k6-20020a17090a3cc600b00273f229a479mr7842200pjd.34.1694524958923; Tue, 12 Sep
 2023 06:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
 <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
 <20230912065753.37de2393.alex.williamson@redhat.com>
In-Reply-To: <20230912065753.37de2393.alex.williamson@redhat.com>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Tue, 12 Sep 2023 16:22:27 +0300
Message-ID: <CAHzK-V2JxX7Gur_dDN2JtUbV=vWVaNefcinwLbKfu+AML2pE8A@mail.gmail.com>
Subject: Re: Usage of vfio-pci without KVM.
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=shlomopongratz@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Sep 2023 10:15:52 -0400
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

Hi,
What can I as a user do to honor this requirement.
Are you suggesting that I should patch the QEMU code as it is not
supported out of the box?

Thank you.

S.P.

On Tue, Sep 12, 2023 at 3:58=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 12 Sep 2023 14:47:41 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
>
> > Cc'ing VFIO maintainers.
> >
> > On 12/9/23 14:39, Shlomo Pongratz wrote:
> > > Hi,
> > > I'm running qemu-system-aarch64 (QEMU emulator version 7.0.93) on
> > > Ubuntu 20.04.4 LTS i with Intel's i7.
> > > I'm trying to pass a Samsung NVME device using vfio-pci. I detached
> > > the device from the nvme driver and attached it to the vfio-pci.
> > > Using lspci I can see "Kernel driver in use: vfio-pci"
> > > In QEMU script I've written "-device vfio-pci,host=3D0000:03:00.0" wh=
ere
> > > 0000:03:00.0 is the device PCI address.
> > > I get the error
> > > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: VFIO_MAP_D=
MA
> > > failed: Invalid argument
> > > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: vfio
> > > 0000:03:00.0: failed to setup container for group 15: memory listener
> > > initialization failed: Region mach-virt.ram:
> > > vfio_dma_map(0x55855c75bf00, 0x40000000, 0x100000000, 0x7f5197e00000)
> > > =3D -22 (Invalid argument
> > >
> > > My question is vfio-pci is supported with cross architecture?
>
> It does, but reserved address ranges need to be honored.  x86 has a
> reserved range at 0xfee00000 for MSI mapping, so the VM address space
> needs to be such that it avoids trying to place mappings there.  Thanks,
>
> Alex
>

