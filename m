Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D640A7CC22A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsinb-0006hL-CB; Tue, 17 Oct 2023 08:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsinX-0006cU-8Z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:03:43 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsinV-0007gU-5O
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:03:42 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so9795055a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697544219; x=1698149019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUeaxBaOc7Wv+t4ELfQyHh34pM0I147kXcS0++IH2Ao=;
 b=ktpS4tpkeRzsPSGPOYnfdE1UMz/vDtowx6OcSwVzB3aUk7wt9vi/r5AHuE3o0iVONv
 PTWKBebN9n3EzHhukLRZ22mIh7/TdgwmqlehujvxWAZhaC2W607GsJgjd+I1Hq3PKwAc
 Z5nSXtvDOoquPSo9Nyhe1SYUrS/60k6cA2wf3WaiG0H88mLRuDSlhGeO65/J1DK4WKfl
 nz4eFzWxvkz9s3VVWa+tZ7bGiEKLvC/chdcccRRLNWReOhs2t9tpLhM6SDBkuFMBLZNJ
 iOkYPP/Md6Rq64JWAD+cLIECJMTraLwbmgICrTBJ3zMCt1AajoOMAkYeO3601bmd2Fh5
 wqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697544219; x=1698149019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUeaxBaOc7Wv+t4ELfQyHh34pM0I147kXcS0++IH2Ao=;
 b=eDkTOVjXIMOdqttxVzezYNY1mAO2fYbRja+gaWZp8h87e8MT1pvWq14+DQk6aa9uTn
 DlCV7qEXhusJxpitiemmAWRzdrEhFlZcDXJR/14L0z/zipdqhzYTFnUYLvGtrJXkrA/Y
 9w+IWtimwL2hDWpAcgHrtTyrmJjVftDV9sVm/I1vbmDh62FQfuUiubFcSD7GVOCF4YN6
 S8kydgtGrFb6xkj8tIioyYyro9wyyla3UkslpBu8s9RI1pP0BMiSQ8j37zYs5XVORep9
 eVte91YzPeGGQ9L8y07GzsPncDGzOjquDiOQizi8+kODJCCKT0DIRLiqncJ2pwUx2va+
 wi4w==
X-Gm-Message-State: AOJu0YzWVC5lJmI3knbhyJCBPgQ/LSwwqXTMGX8hguO9XnmKdz0HqKeZ
 pjtXui1dtfnPwmV6pep51tDpFYO+gQi7Bw0yK34zmA==
X-Google-Smtp-Source: AGHT+IG9FlwcfqwgWyp48riDhp30SBgYErKRSbwH1XXts4L0ho6kR2dqVHoAe7BbHfe7NYnxPref8G9Rp887OZu8fx0=
X-Received: by 2002:a50:c102:0:b0:527:ab3f:4350 with SMTP id
 l2-20020a50c102000000b00527ab3f4350mr1495342edf.38.1697544219445; Tue, 17 Oct
 2023 05:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231005062610.57351-1-philmd@linaro.org>
 <CAFEAcA_P3s07PpNeDVvy8xB7HLM5+Uvnv=NDycVWW3LR7iT_vg@mail.gmail.com>
 <00a51d67-18c6-37de-eb15-679032af0679@linaro.org>
In-Reply-To: <00a51d67-18c6-37de-eb15-679032af0679@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:03:28 +0100
Message-ID: <CAFEAcA-+Tk=zv5DCQ1wZfivup8cTJrR+bGr2g9fuB++WmFgMyg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 17 Oct 2023 at 12:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 16/10/23 18:08, Peter Maydell wrote:
> > On Thu, 5 Oct 2023 at 07:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> >>
> >> Per the "Semihosting for AArch32 and AArch64" spec. v2 (2023Q3) [*]:
> >>
> >>    6.5   SYS_EXIT (0x18)
> >>    6.5.2   Entry (64-bit)
> >>
> >>      On entry, the PARAMETER REGISTER contains a pointer to
> >>      a two-field argument block:
> >>
> >>      . field 1
> >>        The exception type, which is one of the set of reason
> >>        codes in the above tables.
> >>
> >>      . field 2
> >>        A subcode, whose meaning depends on the reason code in
> >>        field 1.
> >>
> >>      In particular, if field 1 is ADP_Stopped_ApplicationExit
> >>      then field 2 is an exit status code, as passed to the C
> >>      standard library exit() function. [...]
> >>
> >> Having libc exit() is declared as:
> >>
> >>    LIBRARY
> >>         Standard C Library (libc, -lc)
> >>
> >>    SYNOPSIS
> >>
> >>         void
> >>         exit(int status);
> >>
> >> the status is expected to be signed.
> >>
> >> [*] https://github.com/ARM-software/abi-aa/blob/2023q3-release/semihos=
ting/semihosting.rst#652entry-64-bit
> >
> > Is this actually a visible change in behaviour? It makes
> > more sense to use 'int', I agree, but unless I'm confused
> > about C type conversions then I don't think it actually
> > changes the result in any case, does it?  Given we start with a
> > guest 64 or 32 bit signed integer value and put it into a
> > 'target_ulong' (arg1), it doesn't seem to me to make a
> > difference whether we put it into a 'uint32_t' or an
> > 'int' (ret) before passing it to either exit() or
> > gdb_exit() (which both take 'int')...
>
> There should be no behavioral change, it is a cleanup
> to avoid asking "why are we using a uint32_t here?" in
> future reviews. Do you rather I mention it in the commit
> description?

Yeah, I think it would be best to say specifically in
the commit message that it's not a behaviour change.
I tend to think that Fixes: tags imply that we're fixing
an actual problem in the original commit (and eg that
we might want to consider backporting the change), so I
would also drop that tag.

(I would have just fixed this up on applying this, but this
patch depends on some other one that isn't upstream yet.)

thanks
-- PMM

