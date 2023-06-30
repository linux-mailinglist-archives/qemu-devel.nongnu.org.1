Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6A7436A7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF96K-00005b-BV; Fri, 30 Jun 2023 04:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qF96C-0008Gv-N9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:03:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qF96A-0000gJ-1W
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:03:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313f61890fbso1726618f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688112199; x=1690704199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iLDh3eY9uGbVGuDZ2s+QUNONHnvJiiRXgVlj9yklVk=;
 b=Tao2FrqpykN7EBegtLVeauMs1QCF+z8jxwFw9UbZfNLgIojr/GtEkVgt0AayEzboQ3
 e0Ng5Gu98pmVHF36L7P+UFH1lzG1aYoMCOOowULnkZyrV1PXVn63XUA9J8VIWvYpc+7c
 eVIl7fn7EFs25Dmaq/iWogGwIlghuaMaxbIXYwPMWmv4uQYwG5eCw1I9L5YJN43AcLu9
 DWwLn6qrS+V4DCw5+6ZW6Yzo+1rcX1lSpQ1o4QQbyakbDPW6Izbe1xVqqpXDfNpUvQjd
 Eb1yY+kkq/GJk2IUP+ey/BKOWLGUHk7O4d9HieJz+qeW8GX1ibUwHjCyEGU6vZ/wCkeb
 BXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688112199; x=1690704199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iLDh3eY9uGbVGuDZ2s+QUNONHnvJiiRXgVlj9yklVk=;
 b=Csj29weczq4wXSnloVrODCTrCv9gi+1zYtBiJby7LzLlsq+4mVm46oWqEDp3j1FlYd
 S7vR647kkHLY/pF2P4V866acDgiv5ueE+n39uhFtKfpwwutAaTAiFqbHEvA02jFaxyn6
 0RtA286NebukdBDrB0lDcSzu5UV6tzaseDkVU5ttkVyBP+rMlKopjQ4B7tfPDhBrhMAI
 tOGo2lYlDppA4BslPA4CFc7a6P5EIqZve0nqqeBfgUqdOaIAUW2qdhyoI2JiHKwC83re
 uUjsN1VBB6kLJqERpoWmRIDvefVtI3hlabnHt7cfPZYWSBAH+yeeL6/NrNUfKqtGESzj
 ReJw==
X-Gm-Message-State: ABy/qLazt5enOOfeNSi8wP3O5KBHEe1p5TWRMbEB+ImFZkJtdrZWofEE
 T/KaBXri0Kh3Fx5JD7fcp4STYRqlHn0DN5vv7CYmQw==
X-Google-Smtp-Source: APBJJlF5VqEmp5FJmXxssHRDAw72ziRNfeeZSQZ+bA4jiPDRUaqVtGaPJrqPPgr3CmrQ3haTsfy/z0QD0yq3GhmAdVY=
X-Received: by 2002:a5d:6349:0:b0:313:e48a:d173 with SMTP id
 b9-20020a5d6349000000b00313e48ad173mr1230210wrw.68.1688112199281; Fri, 30 Jun
 2023 01:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 30 Jun 2023 10:03:05 +0200
Message-ID: <CAEg0e7hhkGC5YhvtZ03=gLrujbq6hfoxuxfHnDS10nMVoC3V_A@mail.gmail.com>
Subject: Re: [PATCH 0/4] fpu: Add float64_to_int{32,64}_modulo
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x42b.google.com
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

On Sat, May 27, 2023 at 4:19=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Extract some common code from Alpha and Arm, and which will
> shortly also be required by the RISC-V Zfa extension.
> Added a new test for Alpha; I already had a RISU test for Arm.

Thank you for providing a generic implementation of this conversion!

I've rebased the RISC-V Zfa patch onto this series and could
implement the fcvtmod.w.d instruction (with a little bit of flag manipulati=
on
after calling float64_to_int32()).

Reviewed-by: Christoph Muellner <christoph.muellner@vrull.eu>
Tested-by: Christoph Muellner <christoph.muellner@vrull.eu>

>
>
> r~
>
>
> Richard Henderson (4):
>   fpu: Add float64_to_int{32,64}_modulo
>   tests/tcg/alpha: Add test for cvttq
>   target/alpha: Use float64_to_int64_modulo for CVTTQ
>   target/arm: Use float64_to_int32_modulo for FJCVTZS
>
>  include/fpu/softfloat.h         |  3 ++
>  fpu/softfloat.c                 | 31 ++++++++++++
>  target/alpha/fpu_helper.c       | 85 +++++++--------------------------
>  target/arm/vfp_helper.c         | 71 +++++----------------------
>  tests/tcg/alpha/test-cvttq.c    | 78 ++++++++++++++++++++++++++++++
>  fpu/softfloat-parts.c.inc       | 78 ++++++++++++++++++++++++++++++
>  tests/tcg/alpha/Makefile.target |  2 +-
>  7 files changed, 221 insertions(+), 127 deletions(-)
>  create mode 100644 tests/tcg/alpha/test-cvttq.c
>
> --
> 2.34.1
>

