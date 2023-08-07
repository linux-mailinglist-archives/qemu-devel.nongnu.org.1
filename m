Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E676D771D16
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwUa-0007wK-Ka; Mon, 07 Aug 2023 05:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qSwUW-0007w7-29
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:25:32 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qSwUS-0006Pj-Nm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:25:31 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9bee2d320so65391911fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691400323; x=1692005123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIaWXMAqA6t0r/yDN4FuR+zb0SyElhXYeZgiZ//zOl0=;
 b=lvvaIGGtRV0odkmYYHPhOTkhCT1PyhZSmmt4nnvAApO+TQzA+bdsBJ710PN6Rq2t2D
 cJbTUySPpKr8qaFdovLuUVW/WB+tuyD5L8V98ZSuRWaowCtOrsyo83c/HHIK9rGmUyzu
 HPfKz4Ozi8Baocb1cV1vv3Ec9VUorxKJCSSU6uFJIOm8W/UxaN0rQ5TVSlG6yEtuj3of
 QWUt8ZnBFaQdCp+T7a/Esj84+T9noaxek27CL2arv7MGp+6V4Jo+wIO3vy6kyEhI0Wcn
 4kC1otBxfWyNHiP38/+MMI874qgh5t1Vh7/qcsjNDcYcWg/DUqn0W9RrtAksx1lIKg2l
 fBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691400323; x=1692005123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIaWXMAqA6t0r/yDN4FuR+zb0SyElhXYeZgiZ//zOl0=;
 b=g3Wrz2sIBHLj678mz6uL3T2Co15qBJH1qa58p4TK9JM/bnmwhb6ZxvAYPtSVdjy1Sp
 avMITpNBIQBREGZtGiLKIg04Z/xyPndV4lnaQq31brteK6kQ22ipNx9eBHnMRfnx+ASZ
 nShrqIEpLAYMJWTFg6vFtY7W17+m7BoMbL4+Fsh+n/2Itm70HayhRVltpEBKx2z0GAfb
 i8izS7EqoOYD30BkiemR4sN6khGP0tYSZKCHZ/iBBtKIr2+QoCsKtMazTC00roDk6/P+
 OO7LKLxaWvE7dLeOzSXQ26jtuEiPDLMcUWcsCBenm09WPRDUHFZfKv7TaFu0MpY0e/FW
 SMyA==
X-Gm-Message-State: AOJu0Yw+bbl2uENwQJZ1gfHhL49oe/Yc1HdW77BmCI0wAZwBoE7h225E
 0llMfcnb5kkYqDn0XRAsjPcq2iXFZHDhnmEEpK3jyg==
X-Google-Smtp-Source: AGHT+IGP4v4U8mgIWqdJYL45x9zdq6iTEr3E0Vc2wtN4uKcgL3OyafkSJfL4wtODcFh0mXEE4E2/BtjSgUfkV5J9lCw=
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id
 x18-20020a2e9dd2000000b002b9e24d21f6mr6815468ljj.20.1691400323127; Mon, 07
 Aug 2023 02:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230805125124.42482-1-negge@xiph.org>
 <848a140d-3855-8789-ff90-35952962651b@tls.msk.ru>
In-Reply-To: <848a140d-3855-8789-ff90-35952962651b@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 10:24:46 +0100
Message-ID: <CAFEAcA_+MMHsRPPp46Ho04gsQAoraW1DYP1GvYwaw3An010mKg@mail.gmail.com>
Subject: Re: [PATCH] Fix scripts/checkpatch.py style failures.
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Nathan Egge <negge@xiph.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Sat, 5 Aug 2023 at 17:44, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 05.08.2023 15:51, Nathan Egge =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: "Nathan Egge" <negge@xiph.org>
> >
> > Signed-off-by: Nathan Egge <negge@xiph.org>
>
> This needs at least some meaningful subject prefix.
> With the subject like it is now, it feels like the
> patch is about fixing checkpatch.py script itself.
>
> Something like:
>
>   linux-user/syscall.c: fix coding-style issue (space-around-or)
>
> I think one of the two places should be fixed in a
> patch which touches this place in tcg-next series
> instead of separately.

Also, this specific area of code (brk handling) is currently
being worked on quite heavily. I'm pretty sure there's a patchset
on list which touches these specific lines of code (and might
well have fixed the style issue in passing). So we should hold
off on the purely coding-style fixes here until after the dust
has settled on those changes.

thanks
-- PMM

