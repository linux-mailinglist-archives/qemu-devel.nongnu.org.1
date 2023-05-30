Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B587162F8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zwc-0007UH-Km; Tue, 30 May 2023 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zwP-0007OA-Ft
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:03:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zwO-0004Og-1g
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:03:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5149429c944so5476553a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455390; x=1688047390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NUwwM161VYm/K56grPaWw1PvLdJAKiL8DAxI4jLH4GU=;
 b=rtaPZFuBTq6MMMvn/RWs/kU2y0CMxvYWv07RhDdLV16bb9r0fABDcd3sxYq0WbLDmQ
 P2/XBFiI1yxpqHx+KJ1e3ZUbG37GZicjdsp8vEVoqtbfij1fO2tZ2Yavx4K7RusTt6S3
 qWjpBOH+bC8pofrf2flssSXymc+Vnzt1aZ6DJj9aoYUC/t5ETvvWjZKObai0EkpA2pri
 9fMZeOMwDnZi7wTyvfwO/ICEoMlV0+vCHp5Ns7T/8kTDc/hikE+kgQSbmF4gq6XgyHpr
 mjopLOQRFxMru/1xWLFMSCVt6B5mSz69H/tpmNEoveXCF94RiKB3z0jZqbDbcWUfDzGn
 6bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455390; x=1688047390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NUwwM161VYm/K56grPaWw1PvLdJAKiL8DAxI4jLH4GU=;
 b=mD+stFspR8bSHVA6NqFZLFU9Lhni5gSGrmfbPG1/uXd0avygBy6dB/YrmPwl4/B6/J
 Hd2IjDbonC/guMNyTwJue9da1QuhA3hTm8MWGYs2gGMIXCSnpGyirmPEZrqNOyYxX5+Y
 XwaDuoq9btcI1AaSld+LqPzGYkhNcOzm78RR9imoPR3ik/ScOHzadxRAq7HgIKXshXiC
 c967ufppIg27JwCvs+VaSZJ/djaJWIeh52l/6R61ZMFLCOHdckYSC7OiEzjvAO+AWhDo
 dhD9nwj6F1E2Zf+8WHSK4jorUS34bHT2AYeigOpR+qDTQ+2sBmMBUCm1stPVMe6eWZag
 gH0g==
X-Gm-Message-State: AC+VfDzlT4+EpjXNIV/Ecu6roFTXAWyiLrTDFcrq2w2CB5BOpZIbNB+I
 zq55+WJWRr4nYM9ICigzPuUveBl8gka8Apy6/6HRkg==
X-Google-Smtp-Source: ACHHUZ6BU/vWlQ5icg/g+cPlVN927eXq5SsgCJcXlztwAVyDoIow96jBhc8InP/tO6KZUZCHZ4RDxj5LNKvg9zUIews=
X-Received: by 2002:aa7:d657:0:b0:514:987c:b028 with SMTP id
 v23-20020aa7d657000000b00514987cb028mr1503490edr.18.1685455390135; Tue, 30
 May 2023 07:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-16-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:02:59 +0100
Message-ID: <CAFEAcA8H9N9RHh2SmwpZ4JE_c0U9oriJngn8AZBYJ6wMw0BZsg@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] accel/tcg: Add aarch64 lse2
 load_atom_extract_al16_or_al8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 26 May 2023 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .../aarch64/host/load-extract-al16-al8.h      | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 host/include/aarch64/host/load-extract-al16-al8.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

