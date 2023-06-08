Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B87282D8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GkF-0006tJ-6M; Thu, 08 Jun 2023 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GkC-0006sQ-Mo
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:36:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gk9-0006Kj-Lg
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:36:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-973bf581759so129598766b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686234964; x=1688826964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNgZ0eJmlc956bFtj131ysP7IFncrFVU/LsvjIum3RI=;
 b=g0YWidAk4B6pnTgxwqXYBpKOk/fWtDodFaMMTdsC9WCjayF1Fp6IKNTJC5mnemuuKb
 2dHBdS2jT7cSY+yA7uhj3PwF3aBFnebl2d1IpmTfSQZffy3F4Xp+FNslJzRQclWd/GF1
 zrfzU55NIemBfyXHiyxbOeKH/TWv1n3/1qxn3myQz/SZVSI1tMu1HXVCRrHxhdPO74q1
 MeJ9uAX1u1tW6Nb7PFh+3x/zIWYpWLVq+nw0zJ9aV7zDyMfrmQWzNPLEaCI6n1uS44Ut
 GxgWoVF7e3NoziPQUd56Z1+9uN+ncXunLFaVN/zuALPGllWul++6FdFs7ST+9JF/RwRz
 eLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686234964; x=1688826964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNgZ0eJmlc956bFtj131ysP7IFncrFVU/LsvjIum3RI=;
 b=b/scUrm21C/l5YpIAVw0lfZ06qT+uP/UMkMIX6pUUoKr9RpmvwobP4vgPGZdBokkeW
 S3wFK+wZOFwm6ZX8c+BJnfWPNTtJi7Qq9dMMQ0nZjxcJF7VJAGfyMzoCXQhUByEgkj3h
 ofVpbcbAkQtyJqCpibuRgczQl/NN9WnymcsNpAf82yZ5ehkHUNJK9cIvAfPI+BgYCRyK
 53/xpIbeER3ExkHgtnXBywEQlXxicgoA3T40+tFXscWb3RxlsKMldAyTY2zrgTV2UpTM
 myxPE5z/zk8Os76Pco9UcfUkjaQmN66GvhzbYIYJ84jh41swlWSYTcFzsDXTzfVz7xrb
 Bo/w==
X-Gm-Message-State: AC+VfDwj56kBU+s06xM+3hgZl1DYbskpILHVqrPcUTVl7FsP8R997c44
 zIDgC43F9C5SU+t5vwNiHdtQ0FDpw6NhXI+EpI0Q5A==
X-Google-Smtp-Source: ACHHUZ7vqBA/25gIl9NFmC27YlzJo20q7eqICWZNQGBNTldEdCwSJwZf9P/e7LV1laSjzToIPvgVHBmz5yEIby91M2Y=
X-Received: by 2002:a17:907:7f0c:b0:973:93d6:189f with SMTP id
 qf12-20020a1709077f0c00b0097393d6189fmr11332281ejc.61.1686234963906; Thu, 08
 Jun 2023 07:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-2-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:35:53 +0100
Message-ID: <CAFEAcA8+Ad6MiGiMy_XReKOSOOVURCF9wc63KuT7Mx2_yL0V5g@mail.gmail.com>
Subject: Re: [PATCH 01/15] hw/timer/arm_timer: Declare QOM types using
 DEFINE_TYPES() macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. Replace
> the type_init() / type_register_static() combination.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

