Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 103BB7162E0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zsq-0001vT-C7; Tue, 30 May 2023 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zsF-0001ab-HR
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:58:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zsC-00033B-6d
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:58:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5149429c944so5467189a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455130; x=1688047130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0DpdQlAz0cb9SoWMpce1jvoE8z2VnSLG/dl85u0yh8w=;
 b=g7Dxa3m1npiPNdNAXIwl9eWdoMV0TfbrHwNApLO+XUXG3+bLiATH/QYnpRLUeO7Hcg
 23Bd7rXkP1jHkJjh/4h9BgzHu9C/6X59SDkRis6WtyGQBUrmzdZDsZ8ZTrHhnQYNc3uT
 oO9IzHD+OmfJso8G9wooeBBviEPGm096Id93D670fnZRW9NtPHe43h+J237u6zWUNMpX
 bK23gheAFYkERs5Y9eJPeszCdimwYqtQBzC+AJ9rinf5Q9+NhcZBeWqf6pbB0BqNQwqX
 j9eMTfUt5L00hBa+wL9E/Bd/p5NsolHZYIiPfvVhvUIpGWx70p4W5Awux9OrMH4Q2623
 +PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455130; x=1688047130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0DpdQlAz0cb9SoWMpce1jvoE8z2VnSLG/dl85u0yh8w=;
 b=eKJRr9+w4SUrsyk0/DBGlwrlXkub2Qkyva1Bv4qQDls65iapVFy41+hQZJ+nR/BkOO
 nZnv4H3tDae9KNPXnicQVwKNY0EIrF1bEZPPNpWmjIU3oqHg98QQ6kkwVYGV/s9Q4Ol9
 6upB2Y+rBMOeKRH4RROuoCMCKVA80YnXxJD2pPrejLkr8uFzCQKKZPrwmvqDqxHEVwCW
 5j0TYmL6nnIK84RF9Y3dWXDAevzKP0nVbdbf+5azEO6tAhYruEyy8LiR2t64O8KBdN/k
 IfJpVFYcU80n3M5n4hA8yR98HwNal77/idi0dPA/RTGdapxJ7X7yDzds8lDZtV91LxTu
 +IAQ==
X-Gm-Message-State: AC+VfDyC5303ECA4pcpEl3bT27cmQZohDfqCgsb1FC1HxgezzzIOg8MJ
 /GI6n4NrqM4IeTtjkWWKbOYr8U29Nu/xtv0V+U565Q==
X-Google-Smtp-Source: ACHHUZ7oTgZPjKSKSFXPU4pS+zcZOPg9MtBz7DNfsCJALMqoY1ZT2QLSdLWnDIMT/EdRmdhWnEav5/sQv77Ebe4QUQY=
X-Received: by 2002:aa7:c61a:0:b0:514:9c74:4cdc with SMTP id
 h26-20020aa7c61a000000b005149c744cdcmr1870374edq.15.1685455130595; Tue, 30
 May 2023 06:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-13-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:58:39 +0100
Message-ID: <CAFEAcA9YoR4WegRiHSTOjx+cPtYUV8gL3z692so2oADGeEWpEw@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] accel/tcg: Extract load_atom_extract_al16_or_al8
 to host header
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 26 May 2023 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .../generic/host/load-extract-al16-al8.h      | 45 +++++++++++++++++++
>  accel/tcg/ldst_atomicity.c.inc                | 36 +--------------
>  2 files changed, 47 insertions(+), 34 deletions(-)
>  create mode 100644 host/include/generic/host/load-extract-al16-al8.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

