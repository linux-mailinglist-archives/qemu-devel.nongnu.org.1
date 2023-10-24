Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C317D4DC0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEer-0003fl-I1; Tue, 24 Oct 2023 06:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvEeg-0003dZ-Dd
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:28:59 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvEea-0004Jn-LJ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:28:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so6329770a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698143329; x=1698748129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aRBM4xxdZYa+4ZDnyGngz8Sq7VYe1PSK/mXapf7mi4s=;
 b=fRQSCOCsJ8Aw5i6k0Cjs4m2muyECWDmWV0n8sk1P7bJH85diMu2E4+I1R2r4+WXE49
 10+gFNUBZiApQuKemw16pW7csxpQ8nOLUxAip/0flI09/vlZh5cU+g+EUXgG2RtDnNP4
 bAoFfDbYWpmUuPAgy1hXeFEiSPFU1FHK7t1yDA+hlhRSe9/TtvYDZ87S8I7JdlFeZPQ5
 sj+VxcsRnWk+a+H8Grkz1wnFvUp3dgeqqpPyvOm6JE2qhIhDnGyi9SuWz/rsfYYfJMB2
 tSrescPcHKU946W+yFKsO63ZUN7/6ifjcW+ZU+SHKmZQy7T2DCqUnmC/8uNE1/OybpG6
 TEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698143329; x=1698748129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aRBM4xxdZYa+4ZDnyGngz8Sq7VYe1PSK/mXapf7mi4s=;
 b=I2OCK3tbfNKqxyj+xZcBgizirvuAY/GbilXyRp+W7+NdwuqxcFKSm5v/52+V/4iany
 by+7ebPTcB5ZwfylMztkioLJd00o5mcrav5ZI0o4Ldx+X7XoEi7gHlHIIizJGoSB7aoF
 LhyB72AaDPcHQOhK6Ni34CUjc7GjbTWhUvN5zLeWD/gd2E6aGULDsy8c9DyjYkhGvhQL
 hq5eMdJyM/grH30bVwP5+7JI6JxgSqcqJDDtrP4nLdaxUUvd+3RUtrGCMZegHuRJfWVR
 6pYe2DC4dZ7itySsOU1xk9PVinX5miF2z3K84Qoa5iU1P5AydGV8wGl5eR25bOigqZ9v
 +zpg==
X-Gm-Message-State: AOJu0YwBXQGZDwzkwL3SSRAZbx1OciSoVc+qCrAQ1fxNYSeTyAPuthnN
 zjuu4qPInMfIFxOB5zB+Bo+UupPjRWoMD8YXzS6L9A==
X-Google-Smtp-Source: AGHT+IF41xwwy3F4gSBRTmfLfJi5niANgzhv93PN07B8rk+IbxbZxYGRtQo2cq2SbCDj7sXpPUlfqKClkcilLM2nnuk=
X-Received: by 2002:a50:f68b:0:b0:540:8fc6:dc89 with SMTP id
 d11-20020a50f68b000000b005408fc6dc89mr2295841edn.25.1698143328945; Tue, 24
 Oct 2023 03:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
In-Reply-To: <20231024094351.50464-1-quic_acaggian@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2023 11:28:37 +0100
Message-ID: <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 24 Oct 2023 at 10:45, Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> This looks like a bug. When the size is `UINT64_MAX`, it is reset to
> (Int128)`1 << 64` which actually is `UINT64_MAX + 1`.
>
> Then, an assert is triggered when the size is converted back to uin64_t
> by using the int128_get64() function, as the new value happens to be
> different than the previous one.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  system/memory.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index a800fbc9e5..d41fc6af88 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1193,9 +1193,6 @@ static void memory_region_do_init(MemoryRegion *mr,
>                                    uint64_t size)
>  {
>      mr->size = int128_make64(size);
> -    if (size == UINT64_MAX) {
> -        mr->size = int128_2_64();
> -    }

No, this is intentional. In these memory region creation APIs
that take a uint64_t size parameter, size == UINT64_MAX is a
special case that means "actually the full 64 bit address space"
(and there is no way to ask for an MR to have a size that is
truly UINT64_MAX bytes). When we create the MR, the size is
stored in the MemoryRegion struct as its true size, because
we have an Int128 field there.

What assertion (with backtrace) is being hit? The issue is
probably at that point, not here.

thanks
-- PMM

