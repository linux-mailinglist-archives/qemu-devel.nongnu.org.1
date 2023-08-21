Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FF782931
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY45q-000371-LP; Mon, 21 Aug 2023 08:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY45f-00032d-55
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:33:05 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY45d-0003Jh-1N
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:33:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso1379946a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621179; x=1693225979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hOztm/taKr2gTMVzNRsYrt5Ec+2ScsV7F5g6NlQkKuU=;
 b=Sqs8ahFJCuK93+D1FVaOfirq0V+/8bZe3HyBg1EfcSc8+zD/Wwf7fr2XXyoVJ7HvGC
 1lWA6FmGHynMf8381/4YYE3NpmK6ow/G4r24mA9tXgcW2pDap17LhJ+h8eVam6nueMlK
 njmywpVM5iew/hVefy/4f/+ABIRorRTpUhzqe4DWvbrnLcOtwLR6Y2Xq5FEpWekJjG8H
 r1nAO+CX/mf1gvmRVqRx4i72a31FEDDqY0VIT7MoWqJ4OavD8ekxGniKwz7zsmnli2ti
 SPWb1M0HvdhH/n8z3C+mTy8tdUjCRIE3hV/zdQGgxfYgNaAtaioKdirBpi4LO8/pUfl/
 Jnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621179; x=1693225979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOztm/taKr2gTMVzNRsYrt5Ec+2ScsV7F5g6NlQkKuU=;
 b=TFvQjVEaQP+lGBq8NLse859H7VH93XXJb//fjKHEmwQtaQIYFoBb4Q/S2rDxZhrMZr
 2qHBpREzOzq/c5BLP0+pNKf6Cs+H1YVxJygFk4GzrTjoTelUNFSI4oPpk6qTOMfboONT
 xZSYrs1JCmkE8N5I4s0QWmAVr0Yb0VXFDfYGMVT/pz2joqUnu1bw15tBpK0+u6gxRPT2
 lR6xzG4qTLvn5rQPcbVgVPuPv3CebrSlF3b2ZqMry+MzCyS96hxGivJjrLa2mvD4ct4B
 5Qm0vj2mnnDkbkTkz0yfkQYVmGSGyvaF1ci7TMP8FCalTeXrxVAK3YGqSvd8J5yMb4hG
 KnIw==
X-Gm-Message-State: AOJu0YyVCM7+3SesQw8D4X9OsFv5EusytOeAli/wOgpVxUGBiciRpHD3
 Zg7mNS6S4ZidzlhX/zufJN6N9/Sq+DS78UUETqGRTg==
X-Google-Smtp-Source: AGHT+IH4Mdp4pbuApoRBZG4hMC6H1+2yoKJBsPjYcjwAfRE2m+iUlCLffhTRUTVI+1YSp8vTEWG/FjruuPUNwOQWWAk=
X-Received: by 2002:a05:6402:5154:b0:51d:95f2:ee76 with SMTP id
 n20-20020a056402515400b0051d95f2ee76mr4661637edd.27.1692621178960; Mon, 21
 Aug 2023 05:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-3-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-3-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 13:32:48 +0100
Message-ID: <CAFEAcA9Od+6QXr=jcAjOXwuBZizMYANbX-y7oebcTd6MapMLcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] hw/misc: Introduce a model of Xilinx Versal's
 CFU_APB
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of the software programming interface (CFU_APB) of
> Xilinx Versal's Configuration Frame Unit.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

