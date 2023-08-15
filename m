Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8316777CEF7
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvp0-0008Hz-5S; Tue, 15 Aug 2023 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qVvox-0008H0-Dq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:18:59 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qVvov-0003KU-11
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:18:59 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5633b7e5f90so3974294eaf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692112734; x=1692717534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3CRqLemgEUBP4zdbQ3kjUY5FyHbWQ2nJVCBDIJFBRI=;
 b=LjHHzTJOdbFKgZDi8pSe2tfhAyYlUJJF3WBqCeW5aY6Y/jWS+ZuhBYvP1x3wHUvsNX
 3Q1iHF0vcMhJfsdHbNMEGJFOCwr82EzNeh+cVONoqdHvVupXJUS3VQXz96+CULqjurpE
 Co7GcP8g3wzV+26Ny248zYjZohkEbFZVhz7Ii+qHFrT4yle8WUFXQjvYMw0nXHRJ1xvf
 h6A5J8vBBZciGfBuRHiycbDjPYM25Q9J+5SeXP4xW9wLlOLjy42s0MAtZhhi3a2nOHd6
 fwCsqcYcLHGlncW+SLwl01JWlbTQvZN+grGXuMctCs4aN+XOJdgwy8mpzdanQe7yKyoa
 BSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692112734; x=1692717534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3CRqLemgEUBP4zdbQ3kjUY5FyHbWQ2nJVCBDIJFBRI=;
 b=ZmTtUG3qL9adLUL4eB3AIH0FwfMZ0s2c96adciCsLASLrhgNjiSqRGjDXNf8lGZs84
 MjRsJ5obQKJoN99t1D4eetdOGjcBWQlls23HZK8mV4pTogCuzTsnw4bBIbMMp20W22RQ
 FBPJNFn5zZ+8TVvlQcJOtEqRRGYsjVNSpmt8Kk7qSuaDoDwIQarVudyUdxt8v14nV+Gs
 igOTgZmhJcKVFjtGiUkPE000ED3cSXFYX/56npgQr08SWFmFL6V60GjwArhzXrYouize
 SO3az3TtS+JqeT+v6B3uBGdB7YJn/CJx+eVYFxzAGM27rPVExqT2kzwOyonWWM+2ugGI
 nY0w==
X-Gm-Message-State: AOJu0YzA4IIn7m7oRENyQlRWu1hupvXud2QKOwHY2xEegIatyoo0Fh9c
 ScgqFy9YikBUzTgSFxsXL/fjxiBOtEgKDqfMvp8=
X-Google-Smtp-Source: AGHT+IG3TaAG2ACrM9XWPxHA2ca2SZEDt+NEUm4/ZJ1aCvonoIA97JwhGCCYJJwO0OpmQCxuZ4wmIAJBkDXjj3d6YII=
X-Received: by 2002:a4a:d284:0:b0:563:625b:e02e with SMTP id
 h4-20020a4ad284000000b00563625be02emr10045848oos.9.1692112734212; Tue, 15 Aug
 2023 08:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
 <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
 <20230810141335.GA2931656@fedora>
 <CAJSP0QX5Z=GFnjyGOgQ8hs6hkdUASznUPmuZJp11ViokSRZ0Tw@mail.gmail.com>
 <1c616fdb.17b27.189e26afed5.Coremail.kvmluck@163.com>
In-Reply-To: <1c616fdb.17b27.189e26afed5.Coremail.kvmluck@163.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 15 Aug 2023 11:18:42 -0400
Message-ID: <CAJSP0QXjzxjXcsfLMsKQmOvuzRbqxpT70iGsSdDu+qANCd729w@mail.gmail.com>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
To: "longguang.yue" <kvmluck@163.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "mst@redhat.com" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
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

On Thu, 10 Aug 2023 at 22:27, longguang.yue <kvmluck@163.com> wrote:
>
>
> =E4=B8=80=EF=BC=89
> Can you post the guest kernel messages (dmesg)? If the guest is hanging
> then it may be easiest to configure a serial console so the kernel
> messages are sent to the host where you can see them.
>
> Does the hang occur during the LTP code you linked or afterwards when
> the PCI device is bound to a virtio driver?
>
>
> >   I used conosle, the hang occurred afterwards.   dmesg shows that tpci=
 test is finished without error.
> LTP test case: https://github.com/linux-test-project/ltp/blob/522d7fba4af=
c84e07b252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kern=
el/ltp_tpci.c#L428
> kernel 5.10, qemu 6.2
>
> different guest-configuration tests show different results.  guest did no=
t crash if hung-task-panic=3D0, in my case  i enable hung-task-panic in ord=
er to trace.
>
> test case 1:
> xml machine pc,virtio disk, virtio net =E2=80=94=E2=80=94  guest's io hun=
g, network broke down, though console is avilable but io operation hung.
>
> #ps -aux| grep D
> root           7  0.0  0.0      0     0 ?        D    14:37   0:00 [kwork=
er/u16:0+flush-253:0]
> root         483  0.0  0.0      0     0 ?      D    14:37   0:00 [jbd2/vd=
a3-8]
>
> test case 2:
> xml machine q35,virtio/q35,scsi =E2=80=94=E2=80=94disk did not hung but n=
etwork broke down. ping errors though everything looks ok and no crash and =
no kernel error
>
>
>
> =E4=BA=8C=EF=BC=89
> I didn't see your original email so I missed the panic. I'd still like
> to see the earlier kernel messages before the panic in order to
> understand how the PCI device is bound.
>
> Is the vda device with hung I/O the same device that was accessed by
> the LTP test earlier? I guess the LTP test runs against the device and
> then the virtio driver binds to the device again afterwards?
>
> > the test is
> ```
> // iterate all devices
> =E2=80=A6=E2=80=A6
> for (i =3D 0; i < 7; ++i) {  // iterate current device's resources
>   if (r->flags & IORESOURCE_MEM &&
>   r->flags & IORESOURCE_PREFETCH) {
>   pci_release_resource(dev, i);
>   ret =3D pci_assign_resource(dev, i);
>   prk_info("assign resource to '%d', ret '%d'", i, ret);
>   rc |=3D (ret < 0 && ret !=3D -EBUSY) ? TFAIL : TPASS;
>   }
> }
> ```
> test does not do virtio device unbind and  bind.
> I only notice mem resource changed. see 'test-case 12'
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94
> [   88.905705] ltp_tpci: test-case 12
> [   88.905706] ltp_tpci: assign resources
> [   88.905706] ltp_tpci: assign resource #0
> [   88.905707] ltp_tpci: name =3D 0000:00:07.0, flags =3D 262401, start 0=
xc080, end 0xc0ff
> [   88.905707] ltp_tpci: assign resource #1
> [   88.905708] ltp_tpci: name =3D 0000:00:07.0, flags =3D 262656, start 0=
xfebd4000, end 0xfebd4fff
> [   88.905709] ltp_tpci: assign resource #2
> [   88.905709] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
> [   88.905710] ltp_tpci: assign resource #3
> [   88.905710] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
> [   88.905711] ltp_tpci: assign resource #4
> [   88.905711] ltp_tpci: name =3D 0000:00:07.0, flags =3D 1319436, start =
0xfe00c000, end 0xfe00ffff
> [   88.905713] virtio-pci 0000:00:07.0: BAR 4: releasing [mem 0xfe00c000-=
0xfe00ffff 64bit pref]
> [   88.905715] virtio-pci 0000:00:07.0: BAR 4: assigned [mem 0x24000c000-=
0x24000ffff 64bit pref]
> [   88.906693] ltp_tpci: assign resource to '4', ret '0'
> [   88.906694] ltp_tpci: assign resource #5
> [   88.906694] ltp_tpci: name =3D (null), flags =3D 0, start 0x0, end 0x0
> [   88.906695] ltp_tpci: assign resource #6
> [   88.906695] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
>
> [   88.906800] ltp_tpci: test-case 13

I don't know. Maybe the test case is leaving the device is a state
that conflicts with the virtio drivers that are bound after testing
finishes.

One approach is to trace the PCI BAR accesses after the test runs and
compare against a trace when the tpci driver hasn't been loaded. That
way you might be able to find out what is different.

Stefan

