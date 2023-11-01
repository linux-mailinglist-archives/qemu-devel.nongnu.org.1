Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BF7DE042
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 12:23:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy9Ik-0006AK-Q7; Wed, 01 Nov 2023 07:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qy9Ih-00069z-BO
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:22:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qy9If-0006eO-Go
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:22:19 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so11570386a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698837735; x=1699442535; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NlDOaQzNuQrcwVa/JDZkXD3WLKWyWk8sUIJ6HDdIGIA=;
 b=ubztIcIYXuRa3ELZbsPQXd0nmlkR8b2Titume0TWHw0/Mn7G8Z4rcNTnDjvKD46F/k
 FGLXUzvWcDI6F5jRvVcAl6UYjEWVRsrY6/s+1KQgc3Wllm6tJ4Je3QwyFq2RaEWaZ1Er
 Fhn0yCJt2kySKKvjg5+WoGCAFvCxJalpGWA7TjzAEXvfV2hEljDVZQTA8OLZhaYyDYO+
 gwlqIcVVUlL38XrMBUlF0nhbddphi8/N4ZJS1vzkWdep3+S0SolwcUSUvU5GfZR3z6ZQ
 LX2J80toyKHyBWyKLByvDUHo/GwODSFVaahAu97OnNO2sthSF6mrp69P+a4/mgQKUs8R
 aG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698837735; x=1699442535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlDOaQzNuQrcwVa/JDZkXD3WLKWyWk8sUIJ6HDdIGIA=;
 b=c8sTPHjdteSpEbEFlyIgwgFVd5VbmNZ9ktHBPCraP0DbO5XArT26Uy6DnDJzDFGqt3
 nHNZ0VFxfex2sfhS24PmS/AtTnrofnmvBRJDoPQG+jRKltuQb+Qd8cDJdllWNVuqRnwa
 304fJSKwSUgxhgkwNEnc1YF+WwU13AayHGJbWceeBT8JR9R+1+B/N615/9zLk9/B1s+X
 YMm47NTjQNCRjSHEQjKOkFycdaeH9cAROWFXZ8MB4xulS0nc0+FBqRJYoOw99UppPjlL
 lTzZb+Lr52SwL2xp4FvLDFj8//177Ftm1zlIu2xpUuXQDBi96tA03JuUlNrfBINXDxYA
 DpFg==
X-Gm-Message-State: AOJu0YwbI4yX2BNFZMr+DL/cOC+4XYfkCL77PXlFK6b9XaLp1Mwe5Wv6
 PQ39Axg3z5leN0shTNJKaEmnxM0qhFhKOmgAI+6DgA==
X-Google-Smtp-Source: AGHT+IGv1uEfuQo5r4Q9Rj+mwLl/+K6gclXlMriOCctW9IcZSy3Z4SRTDmez0qQS1soTR2tBiX6PJ7ulFKY1EuRxm40=
X-Received: by 2002:a50:cddc:0:b0:543:5a71:85be with SMTP id
 h28-20020a50cddc000000b005435a7185bemr4481740edj.23.1698837734876; Wed, 01
 Nov 2023 04:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
In-Reply-To: <ZUFK/BHG2WMhAiWG@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Nov 2023 11:21:29 +0000
Message-ID: <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
Subject: Re: -drive if=none: can't we make this the default?
To: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 31 Oct 2023 at 18:45, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 16.10.2023 um 13:58 hat Michael Tokarev geschrieben:
> > Almost everyone mentions -blockdev as a replacement for -drive.
>
> More specifically for -drive if=none. I honestly don't know many common
> use cases for that one.

One use case for it is "create a drive with a qcow2 backend to use
for -snapshot snapshots, but don't plug it into anything". See
https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
I dunno whether that counts as "common", though :-)

> For management tools, -blockdev is indeed what should be used, and that
> things are more explicit there is actually a feature, not a bug, for
> management tools.
>
> As a human user, in the common case where I don't care about the
> details, I don't want to type up an explicit -device. if=virtio gives me
> more directly what I want.

I can never remember if if=virtio is going to give me virtio-pci or
virtio-mmio, so my scripts all explicitly create a drive with "-drive if=none"
and a virtio-blk-pci device with "-device". I don't much mind being a
bit long-winded in a script file.

> So you only need it when you want to specify one of the more exotic
> -device options, which shouldn't happen that often. Well, it doesn't for
> me anyway, other people may have other use cases. Is that your case? If
> so, which options do you usually want to give to -device?
>
> > But I have to remind several issues with it:
> >
> > 1. While documentation has improved a lot, -blockdev is still mostly unknown
> >    to the masses.
>
> And for manual human use, that's okay anyway - you probably don't want
> to use it. But if you're writing scripts or even advanced management
> software, then you should use it.
>
> (Of course, in complex cases you may have to use it manually anyway
> because -drive has some limitations, but that should be the absolute
> exception.)
>
> > 2. -blockdev is just too verbose, one have to specify a lot of parameters just to
> >    do a simple thing which is solved with an extra parameter with -drive.
> >    Including various backing stores/chains for qcow2 files - this is terrible for
> >    using things manually from command line
>
> You don't have to specify the backing chain explicitly if you're happy
> with the default options with which the backing files are opened.
>
> -blockdev options are typically a bit longer than -drive ones, but not
> extremely. The separate -device that if=none gives you is already a
> similar amount of extra typing.
>
> -drive if=virtio,file=test.qcow2
> -drive if=none,file=test.qcow2,id=disk -device virtio-blk,drive=disk
> -blockdev qcow2,file.driver=file,file.filename=test.qcow2,node-name=disk -device virtio-blk,drive=disk

How did -blockdev end up with a different syntax for specifying the
ID of the drive (i.e. "node-name=foo" rather than "id=foo")
than everything else uses?

> > 3. -blockdev does not work with -snapshot
> >
> > 4. Something else I forgot while typing all the above :)
> >
> > In my view, -blockdev is not a substitute for -drive, not at all, and it is
> > very user-unfriendly.  This is why -drive seems to be a good trade-off between
> > things like -hda (which is just too simplistic) and -blockdev which which is
> > way too verbose and lacks some automatic sugar like -snapshot.
>
> I would agree with that, but if=none already feels a bit unfriendly.
>
> Honestly, I would like to throw away the existing -drive and replace it
> with one that has a simpler implementation (as a wrapper around
> -blockdev) and I would be happy if it gained some additional options for
> passing through things to -device so that you don't have to bother with
> if=none even in the more complex cases any more.
>
> It would be pure syntactic sugar with a similar compatibility promise as
> in HMP (we won't break it just for fun, but we'll also not stop making
> sensible changes just because they make things look a bit different).

You really need to make -blockdev work with -snapshot first, though.
Pretty much none of my use cases will ever switch over to it until
that happens.

Also, you can't arbitrarily change the command-line compat
requirements because of how you've chosen to (re-)implement an
option. That doesn't mean the current syntax is set in stone, but
I'm pretty sure the command line isn't at the HMP "we can change
it without deprecation" level of compat promises.

thanks
-- PMM

