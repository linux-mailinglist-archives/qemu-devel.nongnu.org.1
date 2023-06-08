Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2077282D9
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gkg-00076D-EC; Thu, 08 Jun 2023 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GkR-00072y-3l
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:36:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GkO-0006MP-Bn
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:36:21 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5169f920a9dso1508689a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686234977; x=1688826977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sj8jEcdZiUOzpAI1HTm+tLR32HPM4AFQ2R/g9aVS4Y=;
 b=XvJACvfhcx+o6w1A57R91WORjcxHF0f+8/SXjw2/lAskdC3lgyyoQPG9oD9qBg8hwX
 kByaU/IUpCaHJv2qRQTg5ih/ubo9/+GatmVeFZrbIPb+Qog8dd9/l1Mm+2BubwUWb6fi
 QeU11GhW1rWvO9hU6JTWLV7t/9elXNdc9cadEpFBP+LVZM9Tlx6drYifK1v55BwFJzYn
 8FiKg6CV7gY6Z2msZe4yV+2Z764WQlmGo/mUGSHP/qQH9YqTJCvkDG+kxAvcPU2+MfsJ
 XOmz92EjNY+JrOvJaPiKw6SAnKtzYkUjMXfFlygpSKBXjkCd+ZeeiKjR1K/NPi9ta8o5
 EQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686234977; x=1688826977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sj8jEcdZiUOzpAI1HTm+tLR32HPM4AFQ2R/g9aVS4Y=;
 b=ZoPT6z1NP7nNoJV/yELeswhDbatIpmxAPxX6ycQaqnxMf8WkVmqOm3gh4SZY1E9oOm
 4HskAuVYfLFE3i2T+qqxLqsXrZIX6JBO3+gONCuTZmrkW3rvBnbabU43ar7E5gPGEdYI
 tQPrB4QYLfpWG7YYm6iIb87gP9sewtlVtsnUKxQEJWk5wYOOOQPTXRHBdhyR/HW/YC8a
 Bsnu35tOUr0eu1rzCQVI70Pwlv5dTdIhFGrLbLutrZT5MEPi3e+YtWKcN53S58Ex0vGi
 raVuVINKnVFVR74Lh/CtnkG//7vQm3lsN+bGKnwyndcyZRGOIGOBTjIGaaLyCBYrmtMk
 HJlg==
X-Gm-Message-State: AC+VfDyemchxiGy8gIVnct3mgmBn/u5kY6eA7pN/U/WtTn4iBp2HEB+b
 B/R401xB1jhlqDesHsKyxgkHr6OJDw0RqaAaM2o1sA==
X-Google-Smtp-Source: ACHHUZ7ka/TMAWw0nYR+R0A/syaMk6UnegbhwCP9fXWoYtEDdeZI/duKOdewjlliaNioqq/EgTOLyN635gPZtvhAevU=
X-Received: by 2002:a05:6402:518a:b0:506:bbf8:5152 with SMTP id
 q10-20020a056402518a00b00506bbf85152mr2628649edd.9.1686234977483; Thu, 08 Jun
 2023 07:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-3-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:36:06 +0100
Message-ID: <CAFEAcA9Gd=6=DXkW0GoZF+_ROgnhPWG8VrwhxzuFsr4UjeBdZA@mail.gmail.com>
Subject: Re: [PATCH 02/15] hw/timer/arm_timer: Move SP804 code around
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Move sp804_properties[] and sp804_class_init() around
> with the rest of SP804 code code. What follows the
> "Integrator/CP timer module." is strictly ICP related.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

