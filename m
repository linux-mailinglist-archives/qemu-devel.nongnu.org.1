Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D667E7A511A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiICk-0002Sx-F0; Mon, 18 Sep 2023 13:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiICg-0002RS-Al
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:38:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiICe-0006Gb-IR
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:38:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-532addba879so259252a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695058710; x=1695663510; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0x3x0+HyNY1ow9LmzDi5TJ3WW6he099l2ZwR/NxrN/A=;
 b=PqBlYsMrzRev+hD4MK9xovBQYQfUPlX2Mle81C5sARcGcPyOTmimr27SVDlweZMcsP
 VuIACHE2FUOpKrBQGBjBFgR7h6pYmVQCbbDTNOE5KQqM1cDDoeEMROCscwEdFddIQzP7
 DzfK2T1efykSVAub8Iw2GzU2WAvZkkpharloexOfDPnf/VLhz5khG1hwyBPzNLXk2nE5
 YsqxxOeuyYrEsHB8YNlwkN/H1yYTPTDOS04bg65c0xePkd+THkIzkxmQDxxlVOHwcc64
 b7nqF9Bm0eb+KA1w7aRssdMoL979jLNbeNfRH2Jofb8KurfFvFywbs2XWy+CUjSzjn3C
 L9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695058710; x=1695663510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0x3x0+HyNY1ow9LmzDi5TJ3WW6he099l2ZwR/NxrN/A=;
 b=MJrHASt2qMvmRy854T3Ar4YjcJdHThbwCXBzkjyW8G/XPcpADlRfMwYojH+wi8828B
 i/ke6dFPlr3e4kK7ntoZjFOe5aPasqBzEi5SnOqyTX1kwatZLjvfmOh4jnJ30evzQYkj
 5EXK38hg3K4R1mQ944nWUpNUsXb59wj6WPFltvdf/LRhB2zQuirvDWZjK9ayz0Y6gU78
 c12ypBCwKuO4yI7isFoQRSLsyaKnq1LPwHOGO9dftIPiZx+/NNW21R+aSY+sI2eTFdHB
 syrM/Dr1X63N+xvQ+hxr2jEjl+ZT1p74tsqnaWI95sJQ2iTgaY9iUrqNkD8B/8GXNOLI
 JPVQ==
X-Gm-Message-State: AOJu0YwpicRMFVnjbyUzILv2CrZcVUZstGB/4TTgYtV0P5PBpO0PvPF+
 udb+s3aFfYxpcFrHtueOZczmTyiuljK3SKIeoMROyg==
X-Google-Smtp-Source: AGHT+IEy5FaJKBlvnbm3wtSkbySpCGftw7r9Ts0q7Uktu7xV6HT/ZACTRhxoz6I75TIZaQcU3y8qYIu/OyLXjdQfu7Q=
X-Received: by 2002:a05:6402:28c9:b0:522:b876:9ef5 with SMTP id
 ef9-20020a05640228c900b00522b8769ef5mr403606edb.8.1695058710235; Mon, 18 Sep
 2023 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
 <5083ba81-f74d-3698-6418-72d288917df5@intel.com>
In-Reply-To: <5083ba81-f74d-3698-6418-72d288917df5@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 18:38:10 +0100
Message-ID: <CAFEAcA_ROGZ1jDPP59NBD2td-R7e9VjJ=2mNEY01cPL8ZMYgkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linuxarm@huawei.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 18 Sept 2023 at 18:26, Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 9/18/23 10:00, Jonathan Cameron wrote:
> > On Mon, 18 Sep 2023 17:31:38 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> >> On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
> >> <Jonathan.Cameron@huawei.com> wrote:
> >>>
> >>> This has been missing from the start. Assume it should match
> >>> with cxl/cxl-component-utils.c as both were part of early
> >>> postings from Ben.
> >>
> >> Sounds plausible -- is there an Intel person who could give us
> >> an acked-by for this?
> >>
> >> (Ideally we wouldn't have let more gpl-2-only code into the
> >> codebase without a rationale...)
> >>
> >
> > I've +CC'd the kernel CXL maintainers from Intel a few of whom
> > have also contributed some of the QEMU CXL code.
> > Hopefully someone can ack.
>
> I see that nvdimm.c from Intel is under LGPL 2.1. What is the typical license this should be applied for QEMU?

The project has a mix of licenses, for mostly historical reasons.
The overall license is thus GPLv2 (as the most-restrictive of the set).
Our preference (as noted in the top level LICENSE file) for new
code is for GPL-v2-or-later; we can take other GPL-2-compatible
licenses (preferably GPL-v2-or-later compatible) if there's a
good rationale from the submitter. (Historically, one reason
for the GPL-v2-only code has been "this came from the Linux
kernel and so it's GPL-2-only"; "we copied a lot of this code
from some other file in QEMU and that has license X" is
the other one.)

thanks
-- PMM

