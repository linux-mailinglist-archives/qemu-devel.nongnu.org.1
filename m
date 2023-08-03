Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283776EB3A
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYkn-0001cT-9F; Thu, 03 Aug 2023 09:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYkl-0001cL-Tt
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:52:35 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYkj-00078Y-V6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:52:35 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe389d6f19so1692716e87.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691070752; x=1691675552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1YinNI0ycGmRMReUgdcoUUlAiQnN+zuipToNS4Yuq0=;
 b=qhfNeV/wN7CjowfWhUr/6m3lQpJpzalsYXBAU3PIF91vI71AltVp5pl+v3/KGqRTe8
 eLMLE5ZGmsDVNJfErncBhF4VcROKzHA/2FNtn4sglHJ8bARM/P7ajrqqzhY71OomGXiQ
 cwMuG73q7kUOdfS4+f+tl6i3QDh/rmi9kMvO0v8uYLFlohSpslmBGY9d/QQlqIVokQGg
 Yuigz8AuTMCR/keaWIm4V8PXe9/GckjNjL3Uk7rD6VJLaNY5xbIeinjj3CcaxXUH9Ca9
 ETBnsw/z5hVWfWI6BEO34CwAGF6Z3XYJhw63rHjbIL24sz8XZCL0svhNNYznMDEfJFtN
 Yz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691070752; x=1691675552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1YinNI0ycGmRMReUgdcoUUlAiQnN+zuipToNS4Yuq0=;
 b=icBxDbxri0iMKsejeegw8pDku5zmROtdX1GtHpnX1buO1E7VnSPpEOlp8utMSxH2G3
 Ydcir0lU25cu1YY3Nm4iqAwtrhgYeFP2pcXgKG3mDdA9yd/HUnrTr8wtncLGQOEXpUSD
 y9tmL/s1rMv6ECLY3eCatV8d2bG2vrdoiUePOQn+cGWTdo94mMsTkMFAS4TsRnFpPrON
 zybh0h5JKhHIwMHC2szoAr8ipV1lwdCaFj2bA4/1Xj4v0FFQWgEEBBr6fmvYwquGkdRT
 HBz4SKzzPAMdJ/ZwYwrjSaxl0m2y60N2u0brjJOfMQDcULmeyD11ItO0eY8hXDV4cb1V
 myNA==
X-Gm-Message-State: ABy/qLYFFnywp4V3H8lhhoqS86QxN9+Nz3l20YG6zuH83lEs6gKHM94Q
 OVzXPdJSyUB4Q20vg7P4+SoLwuqQZvoG+SFJr3a4rg==
X-Google-Smtp-Source: APBJJlF0D3T+HYXmVetGWb2s9/Ndq6KwPl3W7X+RL9DequKgpkj9tLntrIf23XV4QqiMQru9v6rMogXfE1sK7qpos48=
X-Received: by 2002:a05:6512:3293:b0:4fd:fc3e:722c with SMTP id
 p19-20020a056512329300b004fdfc3e722cmr7120483lfe.58.1691070751691; Thu, 03
 Aug 2023 06:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-9-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-9-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:52:20 +0100
Message-ID: <CAFEAcA-p0JdLsK9Y3By4fhfHvL7=FWopQKjSE4ON6NTfXcr_pA@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] hw/arm/versal: Connect the CFRAME_REG and
 CFRAME_BCAST_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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
> Connect the Configuration Frame controller (CFRAME_REG) and the
> Configuration Frame broadcast controller (CFRAME_BCAST_REG) to the
> Versal machine.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

> +    /* CFRAME REG */
> +    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
> +        char *name = g_strdup_printf("cframe%d", i);
> +
> +        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
> +                                TYPE_XLNX_VERSAL_CFRAME_REG);
[...]

> +        g_free(name);

g_autofree is nicer than this kind of explicit free, I think
(here and below)
> +    }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

