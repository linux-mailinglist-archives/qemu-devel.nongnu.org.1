Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD17E2C6A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:54:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04jA-0003Kf-C9; Mon, 06 Nov 2023 13:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r04j6-00035h-51
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:53:33 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r04j3-0001Lt-LP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:53:31 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso741332966b.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699296804; x=1699901604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvezSN2jJpAYK7j7CUTaQfw7kMn0xMWGYU6eD5jFk+g=;
 b=Qdd2thuFAsahpi9JsNqkm88pTUFo+xT5dVU7n4fNwVILdptyqQf9zWt15fGwBk8KMh
 Bt5r2meSzvBWVddfy1uE2gwEa0LWQHTXJmD/lwd3+L+BqYjuSAKRyBYZ1PrVWbu7dfSY
 fxSN2x82RqAFFbR+03rtDCtf0o6VG3BjxtKDZth/aoeP7c33GIYZ5XgXOdFbnF2ESpL6
 HMAmXjvCqHN77W7L29Pac3wvGCk+OSnbRQm5cl8VrhXf2ADl5lu0OHa3f8fo3IEcd3EM
 J20C7JnSv7Mj86CbG1uuIhpplBPJKiU5tVIsTVq9MDuGGH01/CqKO4eGnUWNqeMOLMS1
 M40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296804; x=1699901604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AvezSN2jJpAYK7j7CUTaQfw7kMn0xMWGYU6eD5jFk+g=;
 b=vbNbxDw/RW00V8+1SssGnE5Lcy5MdAuVS0Xry/O0WPxXYTmY4I54+tRUykOBUnzvsm
 xw5XBh06sajJbIne3xQV63zi2kZYB3gmhC96+B5zbYbdwjUkjtAKUo+AiQkVXopOaC6d
 XTXoSi1QifU2Bd/TwaGU8choaPv9bnGTyM21ZxALC4fr4zhxqfoMoMncZTFyGKtIKJqa
 K4KzUwgUIsDfaM2IGi1ycEusYBCg+bi8LFS6D6SDaWmFB9FTsWJTRHVtgmJYoHAfHB/T
 6lu7Ru6nDYFdtE8oT1+okEQRpLR/L29K7FstQ5falysM6eLaf+wTHPKvNeq5HuGaGcX6
 hDeg==
X-Gm-Message-State: AOJu0Ywcmlvh6N91etP+3z0sjJjk2CgKo6GidAGnjR5vS8awFhaaJxVi
 oiW/t+aFCIX33ivhP/+cAJdvem0A9jFAatd2qxOrkszuifiOZ+9F
X-Google-Smtp-Source: AGHT+IHx0OJL+JY5shdJCys5leKZwHv2sibPwjGSaTqLhwziuvZTX9fzyuiNQ4abjwWLIawdFGdfhvhmMVIDcRHs1Lo=
X-Received: by 2002:a17:906:4f96:b0:9dc:2291:d384 with SMTP id
 o22-20020a1709064f9600b009dc2291d384mr9161184eju.22.1699296803977; Mon, 06
 Nov 2023 10:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com> <87zg041c42.fsf@suse.de>
 <CAAYibXh+E-ZJ7SKMJie=NG8x8_hP9B5AxYZMXxXY2cK9QuuPrw@mail.gmail.com>
 <87msw0nrfb.fsf@suse.de>
In-Reply-To: <87msw0nrfb.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 6 Nov 2023 10:53:13 -0800
Message-ID: <CAAYibXgPr_8wYOqf8QaWcytPRJUGcjhJmtWCni8J1dej27Jf+Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 01/16] Cherry pick a set of patches that
 enables multifd zero page feature.
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Oct 30, 2023 at 6:58=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Fri, Oct 27, 2023 at 5:30=E2=80=AFAM Fabiano Rosas <farosas@suse.de>=
 wrote:
> >>
> >> Hao Xiang <hao.xiang@bytedance.com> writes:
> >>
> >> > Juan Quintela had a patchset enabling zero page checking in multifd
> >> > threads.
> >> >
> >> > https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.=
com/
> >>
> >> Hmm, risky to base your series on code more than an year old. We shoul=
d
> >> bother Juan so he sends an updated version for review.
> >>
> >> I have concerns about that series. First is why are we doing payload
> >> processing (i.e. zero page detection) in the multifd thread. And that
> >> affects your series directly, because AFAICS we're now doing more
> >> processing still.
> >>
> >
> > I am pretty new to QEMU so my take could be wrong. We can wait for Juan
> > to comment here. My understanding is that the migration main loop was o=
riginally
> > designed to handle single sender thread (before multifd feature). Zero
> > page checking
> > is a pretty CPU intensive operation. So in case of multifd, we scaled
> > up the number
> > of sender threads in order to saturate network traffic.
>
> Right. That's all fine.
>
> > Doing zero page checking in the
> > main loop is not going to scale with this new design.
>
> Yep. Moving work outside of the main loop is reasonable. Juan is
> focusing on separating the migration code from the QEMUFile internals,
> so moving zero page into multifd is a step in the right direction from
> that perspective.
>
> > In fact, we
> > (Bytedance) has merged
> > Juan's change into our internal QEMU and we have been using this
> > feature since last
> > year. I was told that it improved performance pretty significantly.
> > Ideally, I would love to
> > see zero page checking be done in a separate thread pool so we can
> > scale it independently
> > from the sender threads but doing it in the sender thread is an
> > inexpensive way to scale.
>
> Yep, you got the point. And I acknowledge that reusing the sender
> threads is the natural next step. Even if we go that route, let's make
> sure it still leaves us space to separate pre-processing from actual
> sending.

Totally agree. Right now, pre-processing is more than zero page
checking. One can turn on compression/decompression and those are done
before actual sending as well. Currently, using CPU (even multiple
threads) to do compression/decompression doesn't quite match today's
large network throughput but hardware acceleration like Intel's QAT
can really make a difference. To make that happen, there needs some
refactoring on the multifd sender/receiver path.

