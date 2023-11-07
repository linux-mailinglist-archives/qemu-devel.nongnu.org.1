Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6387E3B2C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:38:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KNm-0000Ys-WA; Tue, 07 Nov 2023 06:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0KNl-0000Yj-KA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:36:33 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0KNW-00024u-1b
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:36:33 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so4610411a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699356975; x=1699961775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W6fGdRUXJHae65cvuRpJSvVvFBdDYdzN3MrAqSHGVIw=;
 b=TQT+RfIe9YobF+A+ALO1uORyIqdyfUec7Xnb1LXLiJ9hgYnEXrm5RJO1eSP7NDWYZF
 dN0MeXhJjDhoRxoX9Ve8FAXz25aG15TYTAJQrW/ILLpCcVHE1ehLnMF8YkRBgyYHFZ5B
 WW1KPJjo7BnHVP7lsHEIi4qm6pfGpyEUMQpuGxdnJ9GCBh6k4TYl4pkW9CbQeh+msKJ/
 7Z5y2xNXnNOWGlWUyhMUra/HUKi24ns7+/vEZky5rbgUEeI0KcmFFgjI4KJ7iD5i7mML
 QiqJCMy2emA3sUyogjuTg3QJ9ti3rf+NtUkQXnXGIS/ukN9nwlbgGG7zC9pJ4GD3ud8v
 bD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699356975; x=1699961775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6fGdRUXJHae65cvuRpJSvVvFBdDYdzN3MrAqSHGVIw=;
 b=esUgkbG0eYTgnMWvG0oFHHSdlY91ynia7SSTqUePQy1Adwpu3Dx3YjcszjEX7232/J
 UMasC3Xeko7Wwg3zJ5pZtWxZuNItKL7svR3SXZfXK1CxITHCs2wuRgLmF/xKoY7HBLGO
 An32Q9ze+AJ0IOhisdzEGNabNXChZdftIwk0bHfL1o2slSdtwqZ1ZNTs7Z+CbcDDz4aN
 pf5OEFk7qcDosXURobBHsFpdhhvz9sFxX6BYWA4Tep7WyJ9c5L2vb2PWzR0f2O9A6e4k
 7G5D/R3ZRo2Z7RltWPz9lnXrjyOr6V9NGhutzQfqf1DuM+Sn47ID2/259mNZlSgrOkne
 uE9g==
X-Gm-Message-State: AOJu0YxnlxdLDSeMemlJnqtP7bz3DqwC8MSgfhu4x7tfHOhSlxmOnQ4P
 ArZuElnSigx6HvXurl7NEaqh08/6y/wXW+muB2BQFQ==
X-Google-Smtp-Source: AGHT+IFjjOwGy7/rErMGmNBhdYZlzEyoQTQo86jegr68Yw5xOaw56GoSCIFqmoaz9b9pmoQLm4ig69mldI0v6dzdjYA=
X-Received: by 2002:a05:6402:520d:b0:53b:3225:93c2 with SMTP id
 s13-20020a056402520d00b0053b322593c2mr32965622edd.8.1699356975584; Tue, 07
 Nov 2023 03:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20231020060936.524988-1-thuth@redhat.com>
 <20231020060936.524988-3-thuth@redhat.com>
In-Reply-To: <20231020060936.524988-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 11:36:04 +0000
Message-ID: <CAFEAcA_E06frVv5Q3DoKKf15R-Q4em_gubmXMFfMkOs-U2fmJw@mail.gmail.com>
Subject: Re: [PATCH 2/4] MAINTAINERS: Add hw/input/ads7846.c to the PXA2XX
 section
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Fri, 20 Oct 2023 at 07:09, Thomas Huth <thuth@redhat.com> wrote:
>
> The code from hw/input/ads7846.c is only used by hw/arm/spitz.c,
> so add this file to the same section where hw/arm/spitz.c is
> listed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14e8f7702d..34f9036df8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -938,6 +938,7 @@ F: hw/*/pxa2xx*
>  F: hw/display/tc6393xb.c
>  F: hw/gpio/max7310.c
>  F: hw/gpio/zaurus.c
> +F: hw/input/ads7846.c
>  F: hw/misc/mst_fpga.c
>  F: hw/adc/max111x.c
>  F: include/hw/adc/max111x.h
> --
> 2.41.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

