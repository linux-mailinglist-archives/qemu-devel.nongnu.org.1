Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0776EA82
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYRo-0001vv-G1; Thu, 03 Aug 2023 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYRl-0001vf-VR
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:32:58 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYRk-0006Wh-7p
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:32:57 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so1169180a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691069574; x=1691674374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z5mbFiYbegSw77DyIJ0e7PwJxfpY5kTqM/HVSOBME5Q=;
 b=d8eM9ToRHBUz9vq9nAvhAsVBwWLcPWTpUZQ3RcAXFz+FaueMEEvgDTvgbf2vhVnXAU
 BSBtR1iMT1aa5jX+YSLQqn4ZhUARZwDDEjtoZXwLBnAwv1PEjbhJGqbVjk91YmlQVeAv
 kuvc+ZGTmoH9EHvfLA8cW1g68iwCVqtbKhZbQX/glmZ4RidR+yRSkjqdFX5T+vZZVrt8
 butLxAHuL0klOxGX5xLriKXVx2vWt5dbNY6MXxCzUDJjZRPlw53FpCAk1SX529ziOnlT
 UogUCFYcUZ5yucyHpgxlkCU2NAKmAgbYZkdycCFbId+BDGuZno992QtR1TXSsfsErFNI
 giPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691069574; x=1691674374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5mbFiYbegSw77DyIJ0e7PwJxfpY5kTqM/HVSOBME5Q=;
 b=EkppxZmbH4qAnF0MMg9VclmRLe+L+XX2YjrcsYwJLEr/KTtn9J4TOPWWgCBRBzyqUV
 D9bY4OLjqvWsJ9HOb6HmfqpvT1q8pjaa4m3t4lFYuzjM0EgDLTKfFWQG3yOFH8IRTyl3
 35H1+d/aVle/x/7kdVlypmiT9NF0F9Cn4IYMMilaNzYKKqtwLtrVKmN6brUxfqOwuL0+
 Ncery0WKcEupVdbhOyo/JSrT8RpuIqJsAz3w/znppCEJbZQAOE/nZqlbxu73kfPezueQ
 O+INlbCZ2PlyvkaCXhKwC3kWEk5uhDG1AF5FHp8gmvJgMUykq5dx26y91B8ql4w6UCnK
 0lcw==
X-Gm-Message-State: ABy/qLaT4TAc+vG9fA5v0OnSimT7ahd6HSmMwjZoMFzPPTbRqLvmmMzV
 BTXHFQwxtmaH7UOLrQQUXQ1mDrHXjbVs0pNUMle8/w==
X-Google-Smtp-Source: APBJJlGeUM4p5beqj7fhEhWYraGNXvVVenSS4xvYKT3IOOhb0IJbEutEEfL7fSOXc9PRH+1NBXY7N1OBB8BxrPA5dmc=
X-Received: by 2002:a05:6402:1602:b0:522:2160:c5d5 with SMTP id
 f2-20020a056402160200b005222160c5d5mr7729971edv.27.1691069573854; Thu, 03 Aug
 2023 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-3-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-3-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:32:42 +0100
Message-ID: <CAFEAcA8-Kjd57PWz3Drxgq3__5OcatacqSyZ3VNDoFRv5nDZYg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] hw/misc: Introduce a model of Xilinx Versal's
 CFU_APB
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of the software programming interface (CFU_APB) of
> Xilinx Versal's Configuration Frame Unit.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

