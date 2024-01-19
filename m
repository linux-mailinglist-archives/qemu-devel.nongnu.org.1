Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BF832D94
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:58:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsBH-0005gX-RP; Fri, 19 Jan 2024 11:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQsBE-0005fi-7x
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:57:20 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQsBC-0006Rf-K6
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:57:19 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cd853c159eso12360151fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705683436; x=1706288236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4FCqIHqGBn0EIj3tJzU929L370wNjr2+F3kjp425x8=;
 b=hH1aV4qyv7S4jp7iVLqavxcCMvVs4YYef8rqjW7jRIra57js23rED6CdHCmfHMAnfp
 azRvp7zZ5A2Bq9uo6Tl+XHCf6ZScfVNi30mQl8rwO6MO/OEAhomIM3DXs0alOcpfOuS6
 E/hJCj/vGzHfNBz/GMGT0ywu94FcE/6xuwier4U8nfj3QxmN4mS0V1IExEHvn3eS3eFX
 eMfLeBKP+0lfH4WUjL2YiUCHSgi8jVhtH7HiyZxsGZW2/sF6fTbMQITRTJeMUXp4Tdjf
 1GqiGP3Cz72UqXcrgFc+0zcdNjaacF8KwT2xjst2fvDDVpF+VYh7+efeeq4lQRbd+f4a
 adJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683436; x=1706288236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4FCqIHqGBn0EIj3tJzU929L370wNjr2+F3kjp425x8=;
 b=fY+lWNSTIlWMJAsMTc2M3Pel3eJ9k/Cmy1CARwoyjcf0ISHvT8tefA734qh2vKeEI8
 +uIyLR5Ie4OBZlmUbem9FIRCzeOsETZXRuO+zQJ9BrCktpt67zZDsFC9GjEkfYnoLAkr
 NpF/tm5NHkDX3/ll17fQLns+WlT9vscGAYQTDqo0ejRe+bk8gNMoteFVA7EVW0mSCzW7
 kiwKy99+OCRCNS4y9OxZ5QNRwzwNqpvcl3peu+Efagvzj/yKfpW5AfQSrXAo80FGw1+u
 Hav87/9/pJ+SkEOYE476iEEAAULCqM44uaGwmBahUyTCEbxAeKKZml4vnQfWFnZnlsAm
 IBLA==
X-Gm-Message-State: AOJu0Ywapm0xOQcs20alLggjVfvBJ8ZV3W1Y7HWXbqDrakj4dg30xbcq
 fxckql8KRzv+7G1AUypC6n2VyOJ4YzB1EbRQUeMEth8qvV0nSqDyhtkTlIxlA15GZ4bfxo82+xq
 5NlOFy0LWLBjg9jTyI9+Qwxv9k6bgeauqHfbTuQ==
X-Google-Smtp-Source: AGHT+IGGDJSmTsgiOe2NJ59vx+SiwJUymxNZV2+f44aEtwvsgF2DTVOdiWEob8g89WOqkSCfp4yJm7UzAK/vupjNHpc=
X-Received: by 2002:a2e:730b:0:b0:2cc:f126:8b16 with SMTP id
 o11-20020a2e730b000000b002ccf1268b16mr1828423ljc.69.1705683436641; Fri, 19
 Jan 2024 08:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20240115182757.1095012-1-linux@roeck-us.net>
In-Reply-To: <20240115182757.1095012-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:57:05 +0000
Message-ID: <CAFEAcA9xMRWv1FRbAVoQZNQw7Tj2=yewn-Uw2F3ddoqxBYbarg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/arm: Add support for USB, SATA, and watchdog to
 Allwinner R40
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 15 Jan 2024 at 18:28, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Add support for
>
> - USB 2.0 EHCI/OHCI
> - SATA/AHCI
> - Watchdog
>
> to Allwinner R40. The hardware is quite similar to Allwinner A10 and H3,
> so the code is derived from the implementations for those SOCs.
>
> Tested with bpim2u emulation by instantiating EHCI and OHCI keyboards,
> by booting from USB, by booting from ATA/SATA drive, and by manually
> testing watchdog operation.
>
> v2:
> - The USB Controllers are part of the chipset, so instantiate them
>   unconditionally
> - Add Reviewed-by: tag to patch 2/3
>



Applied to target-arm.next, thanks.

-- PMM

