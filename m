Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C17DF0FF
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:15:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVeB-0000EV-O2; Thu, 02 Nov 2023 07:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVe9-0000Do-Pg
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:13:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVe6-0007XX-Qo
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:13:57 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1272877a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698923633; x=1699528433; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5vyu9PHp0Aw8E3pP4mRtnr3DhTmhFgBDl474HunyP2g=;
 b=SCKM+a5MxR9fsuiRYlz2Ux9Ni7JunQ8uy4K/KXsR4E7+NXXzHm9M9+Jlt4YTjECWcA
 GvVJmI++Uws9DYrXHI1WPC/vLWFKGiRzIhSbRHCp9VimslipJRskPcQDXw4E6gxa2yJz
 F05tqPdfMdZhYNqsn+PBW8XXbNYB0diEB3iWi5iquLguOTGWUW5kIbq9vSiiyESt2+zR
 3ZH6UXmxUawJT7GLDxzVI/SESGeyqRfhHawPyCmp/CoGtz8u/MsZ0dNBcWipCYc5Nm4i
 GP+3Tbtl/qkdcSilgNxyJqKpwQPyK76q1uYkcwYRkuUEmH2KyQedlWcEZOiFj4LBhI/+
 3IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923633; x=1699528433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vyu9PHp0Aw8E3pP4mRtnr3DhTmhFgBDl474HunyP2g=;
 b=Ol1HkZOmIF570x88r1uMXFagKU3Y9Wo1C+PYrMqNyO0GtLd2glSvWVokg5plzwEisR
 J3P8VQuV/fOKnf217JQiUabgh/YpmcEI7tmpZ4pnH1gNk7LG6fSiyAAm9IFbAC/qlqfF
 QA4VNDpxT8p0ALMAq4z89NHSQYw6FA3foUlBdDHGFmzraYV0aR0nBC1MCyF77Q55l2Bm
 sroupnErs57TFOqtarYAMMqysSnklpBjYSyAnu63If+oVFtktEmjYHoZkO52QC4QxWc9
 ev+olvZYWjluX7obmEo8aNhHIqzwCQr+KGdqgo0J7dh3gysmlyTn0buH0MNFxRPp8DhV
 nT7A==
X-Gm-Message-State: AOJu0Yyay0OhrDlqk5SSv5OycN+7dAImhdJdSSQV9KftwDZnSw5Kgy+y
 ZePakOLpqKtE1Pe9Ie2vvaxFOEOFVzuw3TqGfhzY0Q==
X-Google-Smtp-Source: AGHT+IE6x2ZoqQQw9TrZga2875T6fOI7OdLsh9BZ6rmwvYWW1D6MFVfokolj9UfrA8tAbflGJ+qvqNk7rmHReSpsvng=
X-Received: by 2002:a50:ccd5:0:b0:543:caf5:46d4 with SMTP id
 b21-20020a50ccd5000000b00543caf546d4mr2923939edj.37.1698923633179; Thu, 02
 Nov 2023 04:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231031143215.29764-1-richard.henderson@linaro.org>
In-Reply-To: <20231031143215.29764-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 11:13:42 +0000
Message-ID: <CAFEAcA9=6=0PbGNKkYqAVwQ=CDAZG1RtiT8tgHGqSKXQ-dr1Zg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
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

On Tue, 31 Oct 2023 at 14:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The previous change missed updating one of the increments and
> one of the MemOps.  Add a test case for all vector lengths.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I'm told that with this fix we now pass the llvm-test-suite
when built for SVE2, with a variety of vector lengths.

Applied to target-arm.next, thanks.

-- PMM

