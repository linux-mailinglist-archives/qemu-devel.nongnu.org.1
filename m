Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E957986A5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qea8q-0001Rn-5b; Fri, 08 Sep 2023 07:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qea8k-0001Qe-D9
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:59:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qea8i-0006kd-6n
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:59:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so1877628f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694174346; x=1694779146; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+oss6jtXfXveXQVZVT2ztEHGZGYTmftkrj+eKblzuc=;
 b=Z2TbJ5nrm63HdsZ54clzfSOM2C0bWFmJa5z8w48n3lVOWbwzlLZiFtLz/Oi+NKaHwl
 s3Gx3stTntVMDuF6TJLFqtORxCDyP7AvYxmrDQ6FtnHhtPOCZVmWeZUcyu7Q2VgNjmVv
 Nt4l8oR/GUo6v4t2I5rjudu4iyna1SQRNhldqwCCAtKPknD1oANipou01EvOP/98BWrt
 HX5YJGvfz3AxggXRBAQsd31n7VrXB/akad5y1b0ALTZkj+j6dh3/xbw3V4HGicsFJmm/
 9qxmV0Wqm1hhPVyJhavmisER6YTZj3l+fN7y74X01DA5CHpHkfgiQx4glInY2lNpiCPc
 b8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694174346; x=1694779146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+oss6jtXfXveXQVZVT2ztEHGZGYTmftkrj+eKblzuc=;
 b=LZfTvPnuvWt2zsyRW9cxWlXxhT+1vMn/qh8l59HUvojNietJsuEDngO/asUyvaBEWS
 ANFiVX1J3Bp/6HbNEKwihZd4McThlUqGR1WMbiA9zp4A1GN/IvuaG7//Y8TGfTaD6pBm
 QwzS0uoQbVPdeqGvabptQgwiuML0FWZks+uGXMFOJOnFUih32v/8pB5+/Umog7rc18t5
 gQUcNkxvo0DbHVZMoVrErcEY7wpovObNY6oeSgDm1QZoiq3Zr6MBbpURbmSsiqIjJfZH
 zJDobw2BfxphQEjoej6TvGXyX0yd1iMkxnvueX8S3o+4ledYnhojJNM7KedjVkbITDcq
 r7nA==
X-Gm-Message-State: AOJu0YzaJwaGWPJKcwLnMJqNf00aAOGZe0rBYmaJRjs0FL2q8THKvAWd
 wd2eM+qQomadb+IkmuD4Nt9ZRa3cvtp83amEa3SuhA==
X-Google-Smtp-Source: AGHT+IETLjSa9cI3eq7/WuQz0WTvYbLpQy2uHri9IYQJ4/ghDo7GRZsUssq+0Thla8lScPV+OlgcIFzevhNvRDG4qK4=
X-Received: by 2002:a5d:6350:0:b0:317:6653:60b8 with SMTP id
 b16-20020a5d6350000000b00317665360b8mr2086955wrw.50.1694174345899; Fri, 08
 Sep 2023 04:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230831131348.69032-1-philmd@linaro.org>
In-Reply-To: <20230831131348.69032-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 12:58:55 +0100
Message-ID: <CAFEAcA9hqKkSRS+ChNk_zOn3gMUGJkd_+971npMKVzBPJ=nPxw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_its: Avoid maybe-uninitialized error in
 get_vte()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Thu, 31 Aug 2023 at 14:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix when using GCC v11.4 (Ubuntu 11.4.0-1ubuntu1~22.04) with CFLAGS=3D-Og=
:
>
>   [4/6] Compiling C object libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
>   FAILED: libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
>       inlined from =E2=80=98lookup_vte=E2=80=99 at hw/intc/arm_gicv3_its.=
c:453:9,
>       inlined from =E2=80=98vmovp_callback=E2=80=99 at hw/intc/arm_gicv3_=
its.c:1039:14:
>   hw/intc/arm_gicv3_its.c:347:9: error: =E2=80=98vte.rdbase=E2=80=99 may =
be used uninitialized [-Werror=3Dmaybe-uninitialized]
>     347 |         trace_gicv3_its_vte_read(vpeid, vte->valid, vte->vptsiz=
e,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>     348 |                                  vte->vptaddr, vte->rdbase);
>         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/intc/arm_gicv3_its.c: In function =E2=80=98vmovp_callback=E2=80=99:
>   hw/intc/arm_gicv3_its.c:1036:13: note: =E2=80=98vte=E2=80=99 declared h=
ere
>    1036 |     VTEntry vte;
>         |             ^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

