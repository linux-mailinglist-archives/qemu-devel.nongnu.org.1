Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F6777C1D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7X6-0000ss-Qh; Thu, 10 Aug 2023 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qU7X4-0000sc-Nn
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:25:02 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qU7X2-0000VH-SA
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:25:02 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bcae8c4072so913038a34.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691681099; x=1692285899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxV1ytHBtuwEj4BK9j4YrDkuqfRrb/9v0z1bR7ApUsg=;
 b=keSFfrxGvW9+vNTAeY+ZLLYXtTl076j9GB0mPdG7AjMWKWklL9M4JH0o6R6fEleA0u
 2Rsl8foXcpLkknJ3qdNh2ihYvxvfGyvf7RVyHBFOrJUBiH4suHRc2lpRfB8PA+HM8Qjv
 pOvybco23lVRrTemV89y5RN6vUCTxnVbwUkVJrRMsVPD9ZTuQKsoVreVehL6JsS5nDsD
 u1OFfmB5rzZi4tKzKpkeEQC9MkPCiLi7fvINowXgTZjl+JvcX0GU7gz6SscyeAwCtinz
 ddItWDoX5mveqdk4MxbAEH+CKtTLrik3UUn2+tTS1y6JkzDVhsuHar7ORJCeKKH11kbP
 UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681099; x=1692285899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxV1ytHBtuwEj4BK9j4YrDkuqfRrb/9v0z1bR7ApUsg=;
 b=Z5rnZP9ZPCz1lhjxdg6KwTukCHQYVoPxtE5hL81kl7lxaBT2EhloPmeq5e1TuzuyKO
 JiYA+cc+GXGKYHRNCVVSgbXrd9BYIMhF+FFMFPBKoVFhSVyCRlG3CffKXYhfueW7ORiE
 8uv2NrWWtxR9w98J2iJPZ+Ef/GlPfjAKJSyvlCz9Ef6wKqbWExmPYxkguwnZUtRkTd4o
 SrTQ/5WC1nXY4fjyzBE39S8lMWRziY21x7EwZLpoTJ7b6A2lmsUwicELS7Kb/NsrfnB5
 09HyXozMdr8+fKVBPxg1rGRJyNeRf62Ue3EPQVcabZQkcw427CoolAZ5/JZutdEPH7BH
 wWrw==
X-Gm-Message-State: AOJu0YzOYNRX0ihnFUBHMUi8ZCOadt9S9ZvIF/vUirjGEyVVyShQTWLT
 r4hWQZm/YdSkog1W5H710aGTtEMVadTyrht+Pv0=
X-Google-Smtp-Source: AGHT+IGd7kCDLmQrnXgLm6RiEGZyVgclWpjJ1SRgzCRNZHbOmYNGHUdaSxNfNGlZ54CN/PtIrQs1X+d9JXyC+03nRX0=
X-Received: by 2002:a05:6870:3412:b0:1bf:dc26:4947 with SMTP id
 g18-20020a056870341200b001bfdc264947mr2944492oah.46.1691681099260; Thu, 10
 Aug 2023 08:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
 <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
 <20230810141335.GA2931656@fedora>
In-Reply-To: <20230810141335.GA2931656@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 10 Aug 2023 11:24:47 -0400
Message-ID: <CAJSP0QX5Z=GFnjyGOgQ8hs6hkdUASznUPmuZJp11ViokSRZ0Tw@mail.gmail.com>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "longguang.yue" <kvmluck@163.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "mst@redhat.com" <mst@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 10 Aug 2023 at 10:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Aug 10, 2023 at 06:35:32PM +0800, longguang.yue wrote:
> > could you please give me some tips to diagnose?  I could do tests on qe=
mu 8.0, but product environment could not update.
> > I test on different kernel version 5.10.0-X, one is better and results =
show problem is more about host kernel  rather than qemu.
> >
> >
> > test cases are different combination of i440fx/q35 and virtio/scsi and =
kernel.
>
> Can you post the guest kernel messages (dmesg)? If the guest is hanging
> then it may be easiest to configure a serial console so the kernel
> messages are sent to the host where you can see them.
>
> Does the hang occur during the LTP code you linked or afterwards when
> the PCI device is bound to a virtio driver?

I didn't see your original email so I missed the panic. I'd still like
to see the earlier kernel messages before the panic in order to
understand how the PCI device is bound.

Is the vda device with hung I/O the same device that was accessed by
the LTP test earlier? I guess the LTP test runs against the device and
then the virtio driver binds to the device again afterwards?

>
> Which virtio device causes the problem?
>
> Can you describe the hang in more detail: is the guest still responsive
> (e.g. console or network)? Is the QEMU HMP/QMP monitor still responsive?
>
> Thanks,
> Stefan
>
> >
> >
> >
> >
> > thanks
> >
> >
> >
> >
> > ---- Replied Message ----
> > | From | Michael Tokarev<mjt@tls.msk.ru> |
> > | Date | 08/10/2023 17:08 |
> > | To | longguang.yue<kvmluck@163.com> ,
> > qemu-devel<qemu-devel@nongnu.org> ,
> > linux-kernel<linux-kernel@vger.kernel.org> |
> > | Subject | Re: LTP test related to virtio releasing and reassigning re=
source leads to guest hung |
> > 10.08.2023 11:57, longguang.yue wrote:
> > Hi, all:
> > A ltp test leads to guest hung(io hung), the test releases virtio devic=
e resource and then reassign.
> > I find device=E2=80=99s mem prefetchable resource 64-bit is changed.
> >
> > ltp
> > test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b=
252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_=
tpci.c#L428
> >
> > Do you know what cause the problem?
> >
> > Thanks very much.
> >
> > --------------------------
> > ENV: kernel 5.10.0, qemu 6.2
> >
> > Current qemu is 8.1 (well, almost, to be released this month;
> > previous release is 8.0 anyway).
> >
> > This might be interesting to test in a current version before
> > going any further.
> >
> > Thanks,
> >
> > /mjt

