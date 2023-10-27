Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FC7D9941
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMVB-0006v7-AR; Fri, 27 Oct 2023 09:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMV8-0006uS-7G
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:03:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMV6-0005Kf-K4
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:03:45 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso3136905a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698411823; x=1699016623; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OmaGEdYLfcwVW8My/wzbArbg0lEcMY/dWqxgdaVVC3Y=;
 b=XO6eKtJf80cEFys6eUSgYKS714mNNmDDj6t8XSkfRKgDRzAixRmxHBPNXyfOiuOrxX
 cQQ0kVqsOS6GNSwFtTIyxl6WA9ovPGR/RBYyb/vSfdeLxdR0vAOu/0Nryd8W7P9dWeCn
 Xz8poWhpaLwpYdwnUH0e0kyhrslKfaw9gvrguyLncG4C1s3UY7Fv/vm6NRd80KsBeq2l
 bb/vviNJaBzJ/+/XE5lSSW5O+KDBhRGhlyunIQjwT1SGFiGrVvgSb1xMc28GB+2AlGBh
 wOrRkzr/OZIxv49Z3mGBYms2fHW+6rLqoJURSkhh60ZwloK7wntN4vZuNEAvKyTHyrbs
 BkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698411823; x=1699016623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OmaGEdYLfcwVW8My/wzbArbg0lEcMY/dWqxgdaVVC3Y=;
 b=Pe9HhK6Q+P7U4nh/ZF9kJyuBi3JLSXmJN9IWDVYw9RxGVPTMEg7InFGDwgstax3Jq5
 E9YPNn8HygTbZp8quauV2fj2xENlniogYHmfq6vfMyMQvHeKbLL/7zF4/TjBnBPJJeIo
 UqMGGRmvabQ1R/5nAe4Xal2AHuwJuD5B4E542bHCQKrRVdAsd7kdK+7x/yAHUsDnNYgf
 be6ByVXbImrQ3O+5G/nsJE6krt3T/eYToQ2vzYSqPgnjxEKNiCJKaU9BlP5pfdZhqFZu
 7uwGwaZPHyK0Oqr3mifvP0CA07yHFlKSjuj1jePTwzhxdYhIY3eY0Lc3lH8Sgi2YA36C
 gDrQ==
X-Gm-Message-State: AOJu0YwjR0raAcsBDhw0pdDhrnl+br8QbjvFPLeO/eTFzoWvTVTOFqCV
 vbteVWjagzlvm8d4xMjcEvpAlFYdqUvrJmhB0Iuk7w==
X-Google-Smtp-Source: AGHT+IFirKe64jYE6Ndr0DT7yOgibi+3HshpnvSzCRxU+7MAUp8cEkL1Yilq+rVvY2PhaiAsdDXoxAjdN2z6IJ81jfI=
X-Received: by 2002:aa7:d613:0:b0:533:9df5:ede with SMTP id
 c19-20020aa7d613000000b005339df50edemr2045806edr.14.1698411823037; Fri, 27
 Oct 2023 06:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-3-tong.ho@amd.com>
In-Reply-To: <20231017193217.1512868-3-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 14:03:32 +0100
Message-ID: <CAFEAcA9v+E0UEkV6T=_jhB656Z+eugR_JA3kQitamHUWcAK9Aw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG
 device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, richard.henderson@linaro.org, 
 frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 17 Oct 2023 at 20:32, Tong Ho <tong.ho@amd.com> wrote:
>
> Connect the support for Versal True Random Number Generator
> (TRNG) device.
>
> Warning: unlike the TRNG component in a real device from the
> Versal device familiy, the connected TRNG model is not of
> cryptographic grade and is not intended for use cases when
> cryptograpically strong TRNG is needed.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

