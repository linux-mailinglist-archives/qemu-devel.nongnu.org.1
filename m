Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC578FC4B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2Lu-0004Ez-Jc; Fri, 01 Sep 2023 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc2Ls-0004E1-Pk
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:30:12 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc2Lq-0003o3-4y
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:30:12 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so2440747a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693567809; x=1694172609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNT8hjywM3hateRXY/fPBXDS/ULk/xkyL06caX8Wwxw=;
 b=oKC33rPgcVFXhIFRVdfSuCbSdBYjzzq9FDXjEdNqfhS6Dz9G0uEVruQImnoHLRwuk3
 GBwDSAfcWoRrOnOtuZNa/NRIAH99+RfY5u5288jfeaS77G51eA9zcwIDDO6wGdMWxA7s
 rmAEUGfJ++hCA28dJ9xnkSdHf0J4P9VNhsdbfUWQfpkeBquxTG26dXELD5c3NpWdQS9c
 QPURM94jpBWpLrQD4ofwTLxbaloT799eww2SwEdA5DJVylvfJfnw90Y9ztJvmX0STuiV
 ngGa9B2OGX2Xn9vb8sWQhKRkU7alIrJJuBVX/GpyEIeqRkhuA55Q2FWemtC9TejrBeVE
 +rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693567809; x=1694172609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNT8hjywM3hateRXY/fPBXDS/ULk/xkyL06caX8Wwxw=;
 b=gZvzc0p0Sp8nE85xlLSziFed/c/lmdbtvTNu/U7MKbT1qay/IOeA3w8h0t/8gCFtP2
 FxWX068Y17ygm68jFBEJq7giNYAB+CP8NxYfJLwkz5CdQB64K6Xo23kG2dn4/0D0Ye+J
 czyuZg1M5PCaw6/hGZiEmYKfrmDe9wA6PQmwi69GQnwLJDMEt2VieywViyyg2iX59P+y
 hGMHHJLWiHtqVPzZtSVtJXF501qI6P8s3K4iGvzEgG/4iMZXEpSFXJE0yeWU9qqBgZlK
 dcB89YRMwBzzvrZEGLaY3IHrs05/T73rX1Aa7z9lxkhCgwuEBbwvdOCudSo+HWyy4Jfl
 jm2w==
X-Gm-Message-State: AOJu0Yzh4Ycq+YEonSvFAvP4FK4ms1hsThUwCPmj9QbiRh4U+8hlRmyX
 4kAJsYRWL/nOk66DsEmJ10BQQ7SoDwODV98miW0ECw==
X-Google-Smtp-Source: AGHT+IFNEV4q9Oc7bjh+pli7jeptXe3SuYeqRyapQXttxY6VmBwhUN65GXfpjXLuaxau5eFMvoc5gwlNKKhyyh13p0E=
X-Received: by 2002:aa7:da09:0:b0:523:1053:9b50 with SMTP id
 r9-20020aa7da09000000b0052310539b50mr1636435eds.20.1693567808819; Fri, 01 Sep
 2023 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-7-philmd@linaro.org>
In-Reply-To: <20230831225607.30829-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Sep 2023 12:29:58 +0100
Message-ID: <CAFEAcA-kLGnxNesUKGSUpC4DT5Bhpcz30zu3ce18=2vH2EnxGw@mail.gmail.com>
Subject: Re: [PATCH 06/11] hw/arm/allwinner: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 31 Aug 2023 at 23:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   hw/arm/allwinner-r40.c:412:14: error: declaration shadows a local varia=
ble [-Werror,-Wshadow]
>     for (int i =3D 0; i < AW_R40_NUM_MMCS; i++) {
>              ^
>   hw/arm/allwinner-r40.c:299:14: note: previous declaration is here
>     unsigned i;
>              ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

