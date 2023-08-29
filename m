Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5B78C53C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayjS-0001MB-BA; Tue, 29 Aug 2023 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayjQ-0001Gs-3h
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:26:08 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayjL-0004zK-UL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:26:07 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso1262287a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315562; x=1693920362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdI3kTJa9wWKSxEW6/ssCuItIQigwKz+8/zwb3QJrQU=;
 b=Ozd5tzbEvtVtJ/tvuIl16VlUbiCLCtKPsX57Zb4Eprz5G64kSkmnkCG0N859pbqW05
 NyVuACFGrqcI2ub7HAIiX8Mj+Ke14vuVomGz6krtR/4chCxEdX+diiZBVm1/3JzjZ5vX
 4i/04dp9yLSXmxOXN36YEsqz92G6nkf1CQJKwUv08iypTO3l8yzgbAFmqB5WL+OZa2Cs
 HhUkRwVFABAxMwycrVKzLRvQ0RMCJ0RZnLOMqBM7zWHa19n/9o6M/7Vy+WbToKkMbfvi
 fP+iV9ZMcSXrFkGAWYR3MZZjTr6qCzP2SAIzDLoEVbeBRkRkls4yiDpKu3TFhpKwzD+r
 YfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315562; x=1693920362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdI3kTJa9wWKSxEW6/ssCuItIQigwKz+8/zwb3QJrQU=;
 b=LfBmBHkc677mFMNLuKchJlnNRw4Tx/cOWAh8oEQybSNF6owT8m2dIZh0Rq/WO4WQsf
 w0DPcDOPv0NzAW3QS6JuO3YYimx0PggnJTzQ66PXSIaraTOLCwBA60ZQ6pV2BVnTb0Cn
 b21/+ELwZP1dWyPYHC/TM81Fkj9SKkqQ8MkQ+/+7sVfl60/e6ZSqEzMhVHsYW+HNLXj7
 GaY6QJJlJJfaia8DQ0q9ttsi5Iskj0x/rXjW6g53OzzPBVd+bb5bJ1oIylJlD0bX3tUw
 2yZvO20orIvhY8dTKT8FJ9aRhwAbDVZGlcV2KyOPCXhlSd4Nt1DzP8ghyUxKuwO9x/iT
 wzcA==
X-Gm-Message-State: AOJu0YxLZg3a7yCYY3w4afzRv872/hJ5V6283+fupF7txpSFpei2NNeH
 1mH92GXsA2EtJ365sYSMfxpRuStk4YDV9IJyKsBwdLG1/O4/Ew/M
X-Google-Smtp-Source: AGHT+IF+C7qpiuvFdyH9HsPOaLUp/ZC8wKnwCtQAScHqmTxtqV0RoqRjfDG6sK199shAEEaQYa81kgQQB2ITrfw0Hdc=
X-Received: by 2002:aa7:c603:0:b0:527:ab3f:4350 with SMTP id
 h3-20020aa7c603000000b00527ab3f4350mr20747944edq.38.1693315562278; Tue, 29
 Aug 2023 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692964891.git.jcd@tribudubois.net>
 <48681bf51ee97646479bb261bee19abebbc8074e.1692964892.git.jcd@tribudubois.net>
In-Reply-To: <48681bf51ee97646479bb261bee19abebbc8074e.1692964892.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:25:51 +0100
Message-ID: <CAFEAcA-Dtemduj_v9vwfQU1kZsZ9aaf_t5Yz-oYeccqC9zRJHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] Remove i.MX7 IOMUX GPR device from i.MX6UL
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Fri, 25 Aug 2023 at 13:22, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> i.MX7 IOMUX GPR device is not equivalent to i.MX6UL IOMUXC GPR device.
> In particular, register 22 is not present on i.MX6UL and this is actualy
> The only register that is really emulated in the i.MX7 IOMUX GPR device.
>
> Note: The i.MX6UL code is actually also implementing the IOMUX GPR device
> as an unimplemented device at the same bus adress and the 2 instantiations
> were actualy colliding. So we go back to the unimplemented device for now.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

