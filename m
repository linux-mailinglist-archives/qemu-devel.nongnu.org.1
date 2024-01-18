Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF9831D41
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUyK-0007GO-1L; Thu, 18 Jan 2024 11:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQUy4-0007Bm-88
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:10:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQUy2-0001K3-In
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:10:11 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559edcf25b5so1963197a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705594209; x=1706199009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrH0mIYHprZLIUAYPD1cfFK/ZFwG/GspzFaUtL6IKEU=;
 b=zbLvEQf/LGfsrftCqDqVVfOb2Hl5+sG/MJWq91htaTuoh5qCAqIE4vLp++FZAyebku
 jUttEHwlKWuqrYt95nddYg6YvC0TX85wd+6AgdlRIlo1xc9qO/5xYY76h+rU/lYnhuCj
 L6DuDZhEh4NIpqseHXKeqqlEUQ4TLyDnO1vuwISYLx1husB2DyGdl6a9KbiuIP3/Xllu
 O60r+tpMeBo3z1TNRef5Zll/3vhFlp95BZm5D0Ak0R+JGXqzsawU1zqcb15DqnxSwZnE
 j6/b+rA4Y0Wc9HKPFiAwxNp+7HWHQnEVHQltkthDW2KTO/L4SoP9Le/6zSeIjIWqFRpP
 KoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705594209; x=1706199009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrH0mIYHprZLIUAYPD1cfFK/ZFwG/GspzFaUtL6IKEU=;
 b=WkWI8O2qeT52I5+FQ4zudyO9f4FswzKsnDvT+oGvZ2fQ97sbmUdcOvzkmoPgryyatG
 ZUo8hwSuUPxygWXSeYD8sTfMl+N+iVkcCncOdeTIi8t5Ds1JMHfYJx0UdpMwuN/lPVsW
 V4YyFcQdCwvQdjZo2MPsU12KBIEcroEVVrdodG8C41ha8DCWgOs3KNXUFDP5lCZ3yDez
 527KPy5wQHRF1JdnVFjmBoye0em19CPn+mc3ls1ROY2hrgpdgQoE8biGc1CITW5+sqE4
 p4P+CHMIbAg/K40MSECGPmMbPhwHQdvIeUfGqGUgQxPwwirx2QZ1qXKOsUQlDxbvrVo/
 h0OQ==
X-Gm-Message-State: AOJu0YwszS/AsMBhg7eDsYuOJHCsRLe9YJKs5uvtpOk0/pClQWG2+qDn
 DpH0QCkpxYpOPS8Nx/0wK9vzAEO0TR7sjoccfQNGsqzxOoI+bjsXZNSLwgYews7gCuKP/EH2cDu
 +QV6fH0dpIjm0Trvvj7FpNNvzS5eKdzZARfdmUg==
X-Google-Smtp-Source: AGHT+IH35UlaRPe9gIC3Hyx+OoU5WxXX8yK1848nu78r+G2nITCEA9z7MHKXweG0+dmvhUOs+f/sR9EsTeYYzMx4EAs=
X-Received: by 2002:aa7:ca59:0:b0:559:3a84:7fc5 with SMTP id
 j25-20020aa7ca59000000b005593a847fc5mr607451edt.2.1705594208817; Thu, 18 Jan
 2024 08:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20240118131649.2726375-1-peter.maydell@linaro.org>
 <1f34e941-5b0a-4091-95f9-0d0c8e302aa9@linaro.org>
 <5531b75e-86ef-4543-b62a-1457666d9585@linaro.org>
In-Reply-To: <5531b75e-86ef-4543-b62a-1457666d9585@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 16:09:57 +0000
Message-ID: <CAFEAcA8hfdZAkCodJZHxuOF2YAnKp=XR2_SeezJkcyaCAHOMaw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Remove newline from error_report() string
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 18 Jan 2024 at 15:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/1/24 16:17, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 18/1/24 14:16, Peter Maydell wrote:
> >> error_report() strings should not include trailing newlines; remove
> >> the newline from the error we print when devices won't fit into the
> >> address space of the CPU.
> >>
> >> This commit also fixes the accidental hardcoded tabs that were in
> >> this line, since we have to touch the line anyway.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >>   hw/arm/virt.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> BTW there is another case:
>
> $ spatch \
>    --macro-file scripts/cocci-macro-file.h \
>    --sp-file scripts/coccinelle/err-bad-newline.cocci \
>    --keep-comments --use-gitgrep --dir .
> ./hw/arm/virt.c:1775:38:"Addressing limited to %d bits, but memory
> exceeds it by %llu bytes\n"
> ./ui/gtk.c:1094:56:"gtk: unexpected touch event type\n"
>
> We could run this some of these coccinelle scripts on CI,
> as a new job in .gitlab-ci.d/static_checks.yml or extending
> the check-patch job...

checkpatch catches it, if you read the output, which is
how I noticed this in the first place (I was originally
touching the line to fix the tab damage).

-- PMM

