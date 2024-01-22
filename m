Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A54836C94
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:11:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxob-0005MN-HU; Mon, 22 Jan 2024 12:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxoW-0005LP-8X
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:10:24 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxoU-0007Hq-IX
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:10:24 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so2932910a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705943421; x=1706548221; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p8YugZvMdT0b8VPQ4RcGVeqHX2x2y0QhSFg4FXEBSzg=;
 b=O1InR2AWw8Esb+VqDES/fYqdKABnLpEf4FQhBngsyyeP/QDyRDJQwO3yQsITe7PTa/
 EVq+PYVMviqvNj25V2OKaGccDeh9lJ5um3ir2Ad25QVOVrw5PAXdSK43Pk6XLBi3glgj
 7O/RZ5kGCnA9eOiqM/MCmyH5I561sSCDQgrtaBDeMJNU/oeAZ7SDCCARiZRqsyco7ZcI
 WPx5YUvGfW7TeOlz64CHlp/PXlVyhvfZh2UAcke39cJHZE4qVGbc40Fy3ilt2FwiVoSc
 NssUP5CibLRQkQrtrPXLPatBIn2f1Ee6IJBFDKM9Knys1TkEa7C6rpMOUMEsb+HR4HCa
 u52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943421; x=1706548221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8YugZvMdT0b8VPQ4RcGVeqHX2x2y0QhSFg4FXEBSzg=;
 b=EN/kpb4B/W5hZsIatZ7qesr0aLX1LdMDuQW1pLscLVSz7/RZesaPk021wqv7iZLKU9
 RGMguBkJyLhCMQS07Ggy5wVpzN9o/dyvDZXMIazQ5AwVyqBW1A7NvaNYoCiNexZSQKnb
 WgT0md42lVkelc7prIpNxEoiLds1u/dYqLqQSsj0ugijm3AW4gXOtrnwc0Q4d2Ub9xzd
 Z5ei2nU2NVuVr4xX9wROP7QUfJktPvqfxmYGNIY21xKMhIwiVPLDy5Owoh7Ljmnj3M5+
 sOO2wcQtVomhTd3v9PvFQL1p/PR5Br6aCi45kBHuvErPjf6lnoRDhdevvHAG66fhE3K0
 TjLA==
X-Gm-Message-State: AOJu0Yx/UHlKpTNkSazI6+SKmy8Oe3nL1FYmRvHas/svmipJCVPRBH8N
 HvVBBm/tkVQ+xeGMGn44+7lWttZ2UyYR7uCqxH7I/Gz4giZuHcB6Kgssze6KbUrO27iDFmeGiDM
 pNfYKsoPyNPpukj/eI0+K7Bot+mckj+I3jBAyxw==
X-Google-Smtp-Source: AGHT+IHhNgxjvUcPfLYLVsQObCORD3tgq/lMLJ02vcZndrrMf/vZy+4F1spMXOFFEgShz9XL4yw4ufVU3itIrUN+BcI=
X-Received: by 2002:a50:fb0e:0:b0:55c:584:d6d with SMTP id
 d14-20020a50fb0e000000b0055c05840d6dmr121102edq.3.1705943420979; 
 Mon, 22 Jan 2024 09:10:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkKDyvxXaK6L3RcfhSY6JKXV4qSu677TDkr-KCBJ+oquA@mail.gmail.com>
In-Reply-To: <CAHP40mkKDyvxXaK6L3RcfhSY6JKXV4qSu677TDkr-KCBJ+oquA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:10:10 +0000
Message-ID: <CAFEAcA-Hy2Y3XjDHwFNrbSyAfKBjw3SLCP6aJwP1JqmLUfhbyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Add the GNU/Hurd as a target host
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Thu, 18 Jan 2024 at 16:04, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index 21ab9a64e9..fb11ede5b2 100755
> --- a/configure
> +++ b/configure
> @@ -353,6 +353,8 @@ elif check_define __NetBSD__; then
>    host_os=netbsd
>  elif check_define __APPLE__; then
>    host_os=darwin
> +elif check_define __GNU__; then
> +  host_os=hurd
>  else

Meson's official value for the OS name for GNU Hurd
is "gnu":
https://mesonbuild.com/Reference-tables.html#operating-system-names

so we should use the same string here in configure too.

thanks
-- PMM

