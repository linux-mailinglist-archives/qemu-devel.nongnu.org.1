Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DB753B56
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIH7-0000je-OF; Fri, 14 Jul 2023 08:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKIH5-0000jF-LW
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:51:55 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKIH4-0000d7-3R
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:51:55 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fbf1f6c771so3212359e87.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689339112; x=1691931112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ITf/kqcAbWKiUteud+m02bGvRT0KCZCBfrzgwH07mFU=;
 b=K2tJJX3RyyCicBr+K5XIz/Py9FcxVAhb7o+QaPAVjVfpKutiRITaaANo6fsMva+FEX
 H9Bf2ZYspsa71HQeWzERKz5sdEC1HSR7ODPH2urXjoK869h4OkZWQ7PnC07ZMCKKxXXn
 6ffoly9R0XRfuARdmCFBpWAhFTdJKgUBDNGfPSW1OIjlkPr5MwS90eMkKtFQNude0Eim
 f0cIu4U1TCuYb+U2IeXRI6BOR6FyaGi16UdJMfUi7iOpXC7PHNgYHdlE+Jp+zlKelrx/
 6gMsvGzpOdAzXFrrF7+YEFu6EG0a8zp8CdbMHIL4uvtbGsaBmai0XlKK29ql7SsHgk8s
 ppMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689339112; x=1691931112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITf/kqcAbWKiUteud+m02bGvRT0KCZCBfrzgwH07mFU=;
 b=IwdgscnFE6ftUnxpZi5rX/dIH6/Q1XhiE02Kc0o8KUTqpxojxOm7Rf5+kJ8BFCD3ab
 SgMjwm4XgfAo3GpW4m1o0yxp5YQxeBRcL2erdVS00Jv4ecWqgBE1XE8WacENGZfKIKlp
 tz44g5Xdd789npM9veB4Lv51VxNjw66kpjxDGhSAdiLWOTEJKhmoUapztmRuNmmXTAnO
 pHb44q+UA0o3BJ467YuaIo2CbsHkVZO+hg03HFmopcMJ+R4OIeFmUoT36x69SmIKEj8J
 ZntzETxVnYUf5Plgw5P5DXSP3QYRnre3TxM0C93fIafAhDJn6ZSxtBD5domWX5aixwor
 D23A==
X-Gm-Message-State: ABy/qLb0ha2Tm9nm0rcrirob+okpGTIduaIlGRVkQInlMNXi6pp9HLtS
 vsTOJKhrBQKdLM0OqAcwlTsN/XuCuVQTZ5p4TGIGaA==
X-Google-Smtp-Source: APBJJlFwmLSYuDRd/G8B3V6w0gOoaAIT4i8eP5bNm0HFs91pN02QfB8DVtohOii5TogYw2h0yAYWNt6jGOHvcarJj2k=
X-Received: by 2002:a05:6512:2013:b0:4fa:f96c:745f with SMTP id
 a19-20020a056512201300b004faf96c745fmr3313726lfb.38.1689339112338; Fri, 14
 Jul 2023 05:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-10-mjt@tls.msk.ru>
In-Reply-To: <20230714113834.1186117-10-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2023 13:51:41 +0100
Message-ID: <CAFEAcA8YgiN6N3C3SnXTM6P_sw9rOabW+FC-fX_YhPuwfpVggA@mail.gmail.com>
Subject: Re: [PATCH, trivial 08/29] tree-wide spelling fixes in comments and
 some messages: arm
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Fri, 14 Jul 2023 at 12:44, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/arm/aspeed.c                | 2 +-
>  hw/arm/mps2-tz.c               | 2 +-
>  hw/intc/arm_gic.c              | 4 ++--
>  hw/intc/arm_gicv3_redist.c     | 2 +-
>  hw/intc/armv7m_nvic.c          | 2 +-
>  include/hw/arm/fsl-imx7.h      | 2 +-
>  include/hw/intc/armv7m_nvic.h  | 2 +-
>  target/arm/cpu.c               | 2 +-
>  target/arm/cpu.h               | 2 +-
>  target/arm/cpu64.c             | 2 +-
>  target/arm/helper.c            | 4 ++--
>  target/arm/tcg/m_helper.c      | 2 +-
>  target/arm/tcg/translate-a64.c | 4 ++--
>  target/arm/tcg/translate-mve.c | 4 ++--
>  target/arm/tcg/translate-sve.c | 2 +-
>  target/arm/tcg/translate-vfp.c | 2 +-
>  target/arm/tcg/vec_helper.c    | 2 +-
>  17 files changed, 21 insertions(+), 21 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

