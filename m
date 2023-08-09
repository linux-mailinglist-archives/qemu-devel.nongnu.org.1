Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C3877564D
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfS3-0003Jg-Jl; Wed, 09 Aug 2023 05:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTfRy-0003Ir-RN; Wed, 09 Aug 2023 05:25:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTfRx-0003BG-76; Wed, 09 Aug 2023 05:25:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so525590b3a.1; 
 Wed, 09 Aug 2023 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691573151; x=1692177951;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg7TfBkAIZ7COlp962qSLwU4ReQBJ+jz7s8vhxQiVMY=;
 b=bu0VdSNKMT/H5s+Kt45AI1GSLFvuw8iSPlj9Q4ixZN6HsjpiYn0LLo/b15zRB8SfnL
 srqRhRCny3gb5kNHEAFI4G+s73KyMqLaLAsTB/ij8hFWumBdevazZ4hMh2joftFhM5pu
 C5pnaTHoEoJn8nwb7UYJs/ULInDj7JacYhFwmK9CbmX1rWtJiOTuXPkty6eCfEELXWSV
 lmYHRVTux9lqYkfF1LNSpfgoWC1kXQj9A8jFM5o59rvlIbhWTpS2x+ENlgOhSJAkf2SJ
 ROWeqg28SwbD45L5Q9tisTt2MzVIopWpQb+l9gvs7DvHrluiUQ9idP25VY/piJAEhwed
 shkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573151; x=1692177951;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jg7TfBkAIZ7COlp962qSLwU4ReQBJ+jz7s8vhxQiVMY=;
 b=TIH18b1ZTS4VoBBH2WGcKwvKet4HxJLSxdS3R0XTubDTtvwKR7Wx6RsNgV6mDQSE5h
 vDo6suTGuRQrVtrc7YCzTmTU9Fo/+bllwV/bOw3ztF0wWQo8+GGB8neyp97Wz/rOPnRE
 6ZBcQIE4w/caME+OqsZrmrQVi9L6Om9z9cwfGqNKKG6qU2YV2hN/CUkbYo9L6Q8Q4oCB
 qRd5ixc6fK6dIx2xnqV+H1yFe+IWTVWps9BR30uOIy7Nrr8mW6l1K24kwvuoH/O0XE/1
 1Q2rmhj5OUPDqMFigh/+7gx3Q9NQDpfJsrcfoALkcVDivx7LziK3/IWTJFDWgv12IIsT
 gptA==
X-Gm-Message-State: AOJu0Yy7nmFMr8eyfeTPSUfgGrhcaMhpByuX5cN6E7KbGPXPRyJGBtuO
 kf/XdPjXGP2YGV6GHb22giw=
X-Google-Smtp-Source: AGHT+IFDJVuvHcnxaiolPORQ8i3qgOG5A9WfG/j5FURSBYJcLSsiQ2EHTA6zVA71J3M1oQjR8tgWEQ==
X-Received: by 2002:a05:6a00:1948:b0:666:b22d:c6e0 with SMTP id
 s8-20020a056a00194800b00666b22dc6e0mr3015696pfk.11.1691573151265; 
 Wed, 09 Aug 2023 02:25:51 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa783c8000000b00682c864f35bsm9820910pfn.140.2023.08.09.02.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 02:25:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 19:25:45 +1000
Message-Id: <CUNWMUZJLXTN.3R78CO579P9ID@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming
 too many events
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-5-npiggin@gmail.com>
 <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
 <CULFQXOOUWDB.3GMPJXRWAWSDW@wheely> <CUMU01SZ63FP.3B3F5NBPCVQT0@wheely>
 <7903fa1d-1bcd-fd72-5dff-0ac665eb1ddd@ispras.ru>
In-Reply-To: <7903fa1d-1bcd-fd72-5dff-0ac665eb1ddd@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Tue Aug 8, 2023 at 1:52 PM AEST, Pavel Dovgalyuk wrote:
> On 08.08.2023 06:09, Nicholas Piggin wrote:
> > On Sun Aug 6, 2023 at 9:46 PM AEST, Nicholas Piggin wrote:
> >> On Fri Aug 4, 2023 at 6:50 PM AEST, Pavel Dovgalyuk wrote:
> >>> BTW, there is a function qemu_register_reset_nosnapshotload that can =
be
> >>> used in similar cases.
> >>> Can you just use it without changing the code of the reset handler?
> >>
> >> I didn't know that, thanks for pointing it out. I'll take a closer loo=
k
> >> at it before reposting.
> >=20
> > Seems a bit tricky because the device tree has to be rebuilt at reset
> > time (including snapshot load), but it uses the random number. So
>
> It seems strange to me, that loading the existing configuration has to=20
> randomize the device tree.

Building the device tree requires a random number for one of the
properties.

Other architectures that don't have this "cas" firmware call that
changes the device tree and so requires it is rebuilt at machine
reset time just build the device tree once at machine creation time
I believe.

So spapr is already weird in that way. We could go the way that
other archs have and just save that random number once at
creation and then reuse it for each reset. I thought that was not
so good because for a normal reset I think it is better to get a
new random number each time, no?

So I think it's natural enough to take a new random number for a
regular reset, but keep the existing one for a snapshot reset. I
could be misunderstanding something though.

Thanks,
Nick

>
> > having a second nosnapshotload reset function might not be called in
> > the correct order, I think?  For now I will keep it as is.
>
> Ok, let's wait for other reviewers.
>
>
> Pavel Dovgalyuk


