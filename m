Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1247658E5
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Zm-0008Pi-HR; Thu, 27 Jul 2023 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3Zh-0008Mi-DI
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3Ze-0003TW-PX
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so12307705e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690474245; x=1691079045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vcTtwkWGdU1F4KBQra914R7C3roFK8xMk1BvBz/jcpo=;
 b=fyQlga/PG9p8wKKwJR71Y9uSdLFiiUUwYxHFPoksuHidjGFJ7EzHQH6plNl7UqWGOI
 woZcrkCV4KNtsNsmSKq7RliTGqgXpGW4VtWYL+8oe/2peks3pirUgr4wXlukIokZF0PT
 c0T/37hjWqltEhk7RYNfXq0djyrjDiqDBfhJMl0l70MzlMqzoQ/+BUpLyTju1m+1qIqf
 ry/HMkBS1kLEEhGJSqGb4QoAr4+aLnV1+4oyI/jo30WtH4E6N1GKvsoq5LBB/R5lBt8H
 85HhIDeW4EprDf41HiFOW9JvA0XQzj38/dv+CCllrwhmxba0KMzxwKPFKZJqhwV50OgA
 NJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474245; x=1691079045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcTtwkWGdU1F4KBQra914R7C3roFK8xMk1BvBz/jcpo=;
 b=iRHv2HPcJguHk4ysJXrdMl20G7yYpFzjnM3J9TmazrnDSL0XUJ5PPGQNYGwbO8ud61
 k+XjOhd23vVJidu4Rkmfy59BcHUZ5eSHgHlihvzNs7xl9Aggxc8yYiTf8zuR+MALi/3f
 QqoJtgRu+yjSnldI81A/JyAc5EsCOR5GhKseIcJGWDz0gV6QrSxGgg9oUlpz4xtzU5yD
 Hlth8Q6W2TSLduFWLtP1WXbuLnMmXkLE15eK7HpFhn67zgX4RKAZgW9Q/tgWzPa3/wGI
 Kl/qVE8FXSTHkG8mTp/1nBDvnnYDamV8Ssb+Ey3VZYD6sG0nfOBBClns3pHTHf6AOPQP
 Gw6w==
X-Gm-Message-State: ABy/qLYCgo1fdhNW6TWKWTmsdN+aNGEGWOusLCLhO+JbHCMnnd/ZgdUo
 Vr3U6vHOut7HMN8/ILIOPnX4XtnoIRHyIYgEaTeryOg9qOUBIxG6
X-Google-Smtp-Source: APBJJlFsukLtBslyt1rK9MjZhO/1glw8b34+NeVeQSrrcvgwVZ/8cjIJHE+69SXmUIYkq790yTNVyHW/w88MTV4Zvx8=
X-Received: by 2002:a7b:c8ca:0:b0:3fb:ffef:d058 with SMTP id
 f10-20020a7bc8ca000000b003fbffefd058mr2107149wml.0.1690474245271; Thu, 27 Jul
 2023 09:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230726030450.757462-1-chris@laplante.io>
 <20230726030450.757462-2-chris@laplante.io>
In-Reply-To: <20230726030450.757462-2-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:10:34 +0100
Message-ID: <CAFEAcA-7AbCjkxh72kZgHoE_4MhQex0tBUAaDoh9itw9hFjX1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/gpio/nrf51: implement DETECT signal
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

On Wed, 26 Jul 2023 at 04:32, Chris Laplante <chris@laplante.io> wrote:
>
> Implement nRF51 DETECT signal in the GPIO peripheral.
>
> The reference manual makes mention of a per-pin DETECT signal, but these
> are not exposed to the user. See https://devzone.nordicsemi.com/f/nordic-q-a/39858/gpio-per-pin-detect-signal-available
> for more information. Currently, I don't see a reason to model these.
>
> Signed-off-by: Chris Laplante <chris@laplante.io>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

