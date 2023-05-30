Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530517162C5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zpa-0007XK-VF; Tue, 30 May 2023 09:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zpS-0007W0-BO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:56:02 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zpP-0002Sz-5Q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:56:01 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af225e5b4bso47007471fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685454957; x=1688046957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60unZDDwGfuvdk6dG9tDoSIcS216KxmEu9cvt5rLniQ=;
 b=iy+lKUdgNFeNBemU+idh+r9QkhNYOCYby9SLtR+CDyd5OLwbrfvIpRsFYXxCEX8uZU
 th98jfR9eL88O3+VobqUA+FJvFxkw3jE3RoWj/JoG1Pu+YgmRojSIvlxIm/JCQ0+/F26
 0kWEk5Yi09OGcDff0puqEgljPaDaqMpsnHWT+yYpL2JnmtB3qhrL/+kGzdhbglJsI3hk
 KZyTiKZ3FdqdTgTtmQG6FG64/hNb1t49VofPCRb60I/VZZwgRdgYZSUSvoxWM98KdjkK
 3fB8SPf8ae/+jRXoQ4zsCvfZfINkpBNcn5ejxCA2DFzKKgCZN4XrzC7Bwzd2Hpo2dm29
 rOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454957; x=1688046957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60unZDDwGfuvdk6dG9tDoSIcS216KxmEu9cvt5rLniQ=;
 b=X6fxwOJKP02XuJ/ltfix1EOgmQJ3YNng7e2QXsopUEFe5d8g2Eq1bV1Y4Le2J5PrZn
 QstoWDFtBleOhXmrXnOKTvDffjhVQNEr2Vpa1icsMG3jlS7NtZmkFlAtAOJr1zdGvX7u
 ldnky5E3tXBrFyph736+yEtGmR2ZEr7MH66eT3yAHtrFRWZWin/CkGD1U8rBEsfn2BKH
 hTqvo6VQ3tRxpMuI5ZdBcHli5kknpZofUA4IAbjamjv+7meHYL+XM0qojRw5omJcaJ6x
 7QdZ6PNJb+xMZIMkaFfHFq9OVvANy8nA0EnkP4SnlNYUVZK+PxvIniVTbtpnFH5/riR4
 r3yg==
X-Gm-Message-State: AC+VfDxsyI8PfiruUmGdpzN22yZIuHF6dldTlUrmISprc3/yKMdjoLPj
 rxqgvE/UuNraQliXzZotAj3qhbefhfQ6LJyYfT4jLg==
X-Google-Smtp-Source: ACHHUZ5LJu1ZWoQSimcrzeg2M8oDxYvYrDzcrNUlF+OGAfGBN7lKS/xGOUGVwLBa4bywoy4U9nnVQJXJBs3hs9Q2Fyk=
X-Received: by 2002:a2e:868e:0:b0:2af:1c91:d712 with SMTP id
 l14-20020a2e868e000000b002af1c91d712mr884174lji.39.1685454957414; Tue, 30 May
 2023 06:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-9-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:55:46 +0100
Message-ID: <CAFEAcA8e9b3ivsyEK=knxrb1S24x8DYgynj2Htm3diWUOrUv=Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] tcg/aarch64: Simplify constraints on qemu_ld/st
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Fri, 26 May 2023 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Adjust the softmmu tlb to use TMP[0-2], not any of the normally available
> registers.  Since we handle overlap betwen inputs and helper arguments,
> we can allow any allocatable reg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

