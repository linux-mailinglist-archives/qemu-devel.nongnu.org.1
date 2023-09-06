Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1037941AF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 18:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdvfi-00026a-6t; Wed, 06 Sep 2023 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdvfd-00026S-F2
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:46:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdvfY-0005xG-Gk
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:46:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso878545e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1694018778; x=1694623578; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6FpBZASspo5o3zZvtngqYk6wyzygh9cDmOI/Z1YC9kg=;
 b=TKjdQD6tMp9XvmzVvq9qjFKotnNXpSdFMviTshp9ZMe3TZy8jJ+dpMmgbO5rr2ymnj
 hzmfufmgt3LSfRBB9hketutU4VggIW3wiv0UpoOW7WjjHsklod/fkuCLWkA6iiNNqIVd
 2KJRpTqL4jl8v/GKAn+jboEjMhUF/QxeCx9Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694018778; x=1694623578;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6FpBZASspo5o3zZvtngqYk6wyzygh9cDmOI/Z1YC9kg=;
 b=FkzZbsr8ms5ZEY+89p/B6jsrrNdWHisTw1ab8LYTwsXKhYcINcFWriAqvIm/iQWHWH
 WAopdQzeF2fiCBg8tPeZu8RhxUXgoquz0L5c8zHnSUA/eyZrRQHHOpYufORyNL7ng+tw
 lK3fdaMo7gvwhCCmLCHQHfv/olNHsWiPkHHzg7wcSd45gxG0xObJ5RSd6JJ4QT/N9nYJ
 O6JTDdex4uUGpwluYd7kNyyWitSZXaWS3l3x8/6Bz/bABycOSdeHRDakHDilskZFqqok
 KwvqFn/4419W3d/+9Av6nFJaN/PliSeQDSJ38SO/AnfC8ovO50BEPD6YXX1dG27Kwef5
 rGVA==
X-Gm-Message-State: AOJu0YzkT1e6tnzwb6b7C04Dtd7EkheuE3/xVBYlOmkRXb/MxNou7BTm
 qT6DYg/+1IuSmaBqTTN81gsVbQ==
X-Google-Smtp-Source: AGHT+IG0re7fz537xxkUuIdXM9o6N4hEKzFi45I47qTILI2mbTF6MyTUzdBwgM6PRtYIMgI+7g8W6g==
X-Received: by 2002:a1c:721a:0:b0:401:519:c5 with SMTP id
 n26-20020a1c721a000000b00401051900c5mr2669710wmc.41.1694018778469; 
 Wed, 06 Sep 2023 09:46:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:81e2:ebec:c0f0:bc4f?
 ([2001:8b0:aba:5f3c:81e2:ebec:c0f0:bc4f])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c0b4900b003fe2b081661sm19665wmr.30.2023.09.06.09.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 09:46:18 -0700 (PDT)
Message-ID: <d7aa3b44e97a13f87259e23aea9eb71ebaaaa754.camel@linuxfoundation.org>
Subject: Re: mips system emulation failure with virtio
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David
 Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Date: Wed, 06 Sep 2023 17:46:17 +0100
In-Reply-To: <67d4c8dc-24d7-afa3-27b1-d6e756a597b9@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
 <67d4c8dc-24d7-afa3-27b1-d6e756a597b9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 2023-09-06 at 17:50 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> +rth/pm215/dhildenb
>=20
> On 5/9/23 16:50, Richard Purdie wrote:
> > On Tue, 2023-09-05 at 14:59 +0100, Alex Benn=C3=A9e wrote:
> > > Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> > >=20
> > > > With qemu 8.1.0 we see boot hangs fox x86-64 targets.
> > > >=20
> > > > These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmm=
u:
> > > > Use async_run_on_cpu in tcg_commit) but if I add that commit, mips =
and
> > > > mips64 break, hanging at boot unable to find a rootfs.
> > >=20
> > > (Widen CC list)
> > >=20
> > > >=20
> > > > We use virtio for network and disk and both of those change in the
> > > > bootlog from messages like:
> > > >=20
> > > > [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 00=
03)
> > > > [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 00=
03)
> > > > [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 00=
03)
> > > > ...
> > > > [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
> > > > [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical
> > > >=20
> > > > to:
> > > >=20
> > > > [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 00=
03)
> > > > [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 00=
03)
> > > > [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 00=
03)
> > > > ...
> > > > [    1.894852] virtio_rng: probe of virtio1 failed with error -28
> > > > ...
> > > > [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
> > > > [    2.064260] virtio_blk: probe of virtio2 failed with error -28
> > > > [    2.069080] virtio_net: probe of virtio0 failed with error -28
> > > >=20
> > > >=20
> > > > i.e. the virtio drivers no longer work.
> > >=20
> > > Interesting, as you say this seems to be VirtIO specific as the basel=
ine
> > > tests (using IDE) work fine:
> > >=20
> > >    =E2=9E=9C  ./tests/venv/bin/avocado run ./tests/avocado/tuxrun_bas=
elines.py:test_mips64
> > >    JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
> > >    JOB LOG    : /home/alex/avocado/job-results/job-2023-09-05T15.01-7=
1f3e3b/job.log
> > >     (1/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test=
_mips64: PASS (12.19 s)
> > >     (2/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test=
_mips64el: PASS (11.78 s)
> > >    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRU=
PT 0 | CANCEL 0
> > >    JOB TIME   : 24.79 s
> > >=20
> > > > I tested with current qemu master
> > > > (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
> > > > there.
> > > >=20
> > > > Is this issue known about?
> > >=20
> > > Could you raise a bug at:
> > >=20
> > >    https://gitlab.com/qemu-project/qemu/-/issues
> >=20
> > Done, https://gitlab.com/qemu-project/qemu/-/issues/1866
> >=20
> > > I'm curious why MIPS VirtIO is affected but nothing else is...
> >=20
> > Me too, it seems there is a real code issue somewhere in this...
>=20
> This seems to fix the issue for me, but I'm not really sure what
> I'm doing after various hours debugging, so sharing here before
> I take some rest:
>=20
> -- >8 --
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 18277ddd67..ec31ebcb56 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2517,7 +2517,7 @@ static void tcg_commit(MemoryListener *listener)
>        * That said, the listener is also called during realize, before
>        * all of the tcg machinery for run-on is initialized: thus halt_co=
nd.
>        */
> -    if (cpu->halt_cond) {
> +    if (cpu->halt_cond && !qemu_cpu_is_self(cpu)) {
>           async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas=
));
>       } else {
>           tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));

I tested with the above and confirmed it does fix 8.1.0 for the mips
test I was using.

Thanks!

Richard

