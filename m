Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE1275A99C
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPNm-00058m-Mm; Thu, 20 Jul 2023 04:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMPNl-00058U-Aw
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:51:33 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMPNh-0003Pd-KO
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:51:33 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e99584a82so694772a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689843088; x=1690447888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RKRTskmyGs6D4tU9n+6+D/AHiTSkatbWXwuz20OCmCg=;
 b=Oh4fkyA5MmafuSEWtw69Sv0P7Nf5llJDmETTnsGgHTm1GIfYAezC31YE9hjqlR4jt+
 lBvTW6pPr/Brfc49u0msNz9Ys7Df7AOBGmVwvYWegGdBO5YJRIpVCjeqs73KxB+bOcKv
 9PcPlyh6sB8bjT13rgeytptsW06hylRYb+ewvchy7/MxDOXDnaBwvWpAJOgeM/ixeho/
 rciIS04369YtNMLG7if8EfQXY56tSFfmuk49cOGM6eOYNoQOdVF8fkevUFgwTdB3d92h
 Ne/hyvkg1XIXtwwYePB5ZXcgADF8XLjYwYu+BK0vwXIyGoRooGg7XgEnyZSLod9z+fdI
 rbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689843088; x=1690447888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKRTskmyGs6D4tU9n+6+D/AHiTSkatbWXwuz20OCmCg=;
 b=eCidk2wRckqTL+MJ80lb6/d1rA1t0XhmBK1vOxqoQyVFPaNLiZy0RPz6yWRmakD7D1
 gIeDFOHmhIQOQoxq7L3kY3zpcvYTNInBtl2GrKa0w3jQOUN4oRlqfS4Q/DNafWFHmal3
 MvM4F4+KTNy2UCgZLn/GX4E/DZy15Z65cWmyMRV5NC08sq3fBRgFYWuh49d1lzCEUBzu
 BtHaQUknxrBgnL638u1boyk1czh03HTjhXWDkRIqxxuZXaPdlq4Z7qxaXfbw27v2Zawv
 UqpRH1+rJalioVPD9Gzwz2nQf32jJdaAUIpnjbGOzLAW8O2s4CCNdZPdO8xiQMWQ5Zmw
 o+GA==
X-Gm-Message-State: ABy/qLYSGa7W02pXlnw/vOJjjd8zukZ/4zQ0zi4U6q0pADOE48/+Qiw8
 tE/g3COSENKNn6nUzsjEFzqOO69bCyfagsiYQXwN5w==
X-Google-Smtp-Source: APBJJlENfPbulJO1FYmQeHbNxhq4Oi7ZuNN4acHl9CT4fZ/Bn8KjziAso2aEMFM/SACNt8XgJ02aM0GPXGXve0nTI7I=
X-Received: by 2002:aa7:d444:0:b0:51d:9195:400f with SMTP id
 q4-20020aa7d444000000b0051d9195400fmr4015785edr.17.1689843087736; Thu, 20 Jul
 2023 01:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230719073605.98222-3-its@irrelevant.dk>
 <20230719073605.98222-4-its@irrelevant.dk>
 <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
 <CAFEAcA-BwdoxeiFjA8Xce-fX9j8Qf2FcrJBKBhgKbONVfrJ7ew@mail.gmail.com>
 <ZLj1DzCrEcorn6va@cormorant.local>
In-Reply-To: <ZLj1DzCrEcorn6va@cormorant.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 09:51:16 +0100
Message-ID: <CAFEAcA_nLmZi1uQmYTQ7WdrQ9snj85SiWDZnX+wEQ_Z+7fw3Rw@mail.gmail.com>
Subject: Re: [PULL 1/1] hw/nvme: fix endianness issue for shadow doorbells
To: Klaus Jensen <its@irrelevant.dk>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 20 Jul 2023 at 09:49, Klaus Jensen <its@irrelevant.dk> wrote:
>
> On Jul 20 09:43, Peter Maydell wrote:
> > On Wed, 19 Jul 2023 at 21:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
> > >
> > > 19.07.2023 10:36, Klaus Jensen wrote:
> > > pu(req->cmd.dptr.prp2);
> > > > +    uint32_t v;
> > >
> > > >           if (sq) {
> > > > +            v = cpu_to_le32(sq->tail);
> > >
> > > > -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
> > > > +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
> > >
> > > This and similar cases hurts my eyes.
> > >
> > > Why we pass address of v here, but use sizeof(sq->tail) ?
> > >
> > > Yes, I know both in theory should be of the same size, but heck,
> > > this is puzzling at best, and confusing in a regular case.
> > >
> > > Dunno how it slipped in the review, it instantly catched my eye
> > > in a row of applied patches..
> > >
> > > Also, why v is computed a few lines before it is used, with
> > > some expressions between the assignment and usage?
> > >
> > > How about the following patch:
> >
> > If you're going to change this, better to take the approach
> > Philippe suggested in review of using stl_le_pci_dma().
> >
> > https://lore.kernel.org/qemu-devel/376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org/
> >
>
> Yup, that was my plan for next. But the original patch was already
> verified on hardware and mutiple testes, so wanted to go with that for
> the "fix".
>
> But yes, I will refactor into the much nicer stl/ldl api.

FWIW, I don't think this bug fix was so urgent that we
needed to go with a quick fix and a followup -- we're
not yet that close to 8.1 release.

thanks
-- PMM

