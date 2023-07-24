Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0075FBBA
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyFU-0008Cp-FU; Mon, 24 Jul 2023 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyFS-0008CT-Fr
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:17:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyFQ-00073e-Vl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:17:26 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-522294c0d5bso1927878a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690215443; x=1690820243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JN3MDCdPNG2g6560ElPxOu7MMO4UMoPxvRTcDXdyEfA=;
 b=tEyjYvgkCWZyfb32AuAg5H0jBR+lS+hSUKKHIhArEoaplVCgjKC4uQ382Hzrdgut1S
 Q86UtDm5HD+q/oaMhdhzR0tYwjrqEqzTzYqTrLoy/oquXrTcc1l9lImyNwCc3KxytZRu
 jVKVgrw6Z9aEbZ3RAhL7vCTizAjFn8WE1imw1ScJnRXpvOsixUp66fJglwcgJHaF48H/
 fl3xBbakqe7HIC5rbbegRpMfYEmxnb+Iep7W2sex2Ft5PWuPdz1hvs3ApGHx2RUfifN+
 +5QgiJd7vbFbYsPnV0g+ptNt4Q5kTFj2k4NsDgjF+ZzzPsHlmLMxJ8490/ogrtVKP+x/
 /KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690215443; x=1690820243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JN3MDCdPNG2g6560ElPxOu7MMO4UMoPxvRTcDXdyEfA=;
 b=GPGqKKMB4u6V7yj88wqCmk5qa8HUkS86zDFxRKYWkACusGwzV5+wbQVo7Wk1zAsqc1
 gL1qJ35tDRdq+42Cd1pIo8g1S5lUaWFvhtaHaPTOEaES8lsuyhf2UUGCcr5f8o3siqwx
 Xx7GCnJT95KPPIn9WRs/YWpOhJ2moRQiio/2prZWFot5xImTLqI53WTE00C9LQ0O75EO
 229wanEMUk4klYVPnrP/YdezogCpmH7qIgke8Xd/eTYW6eJ48xkoISGaZWTY7ZqnKmMN
 +nWcXDqN7yiHNT3vGLUFmMspMmPRTjCgvhkoYrJFP3NpSB10qcJXL33hUSpAtEcfZMh3
 6i2w==
X-Gm-Message-State: ABy/qLbgZdYOot7FZiV7tJ+Yc+oaO5Gf1L6Y/Q6iLBsG/7FMgm0MmCEQ
 /xO/IQYG6W+KTebYCHfLbbwuMeLY3UnkHjcf668Cz8jbk0TZWyj6
X-Google-Smtp-Source: APBJJlE/WyeDhHQiHo8hH3yeHxR7mC1I9LbV4em7YEvWuUIbXsTwO7v+cwuwTUiGnAT3+1LipWm0Xygqd+FGw0EqMh8=
X-Received: by 2002:a05:6402:3453:b0:51d:e498:201 with SMTP id
 l19-20020a056402345300b0051de4980201mr8750672edc.27.1690215443123; Mon, 24
 Jul 2023 09:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
 <20230714232659.76434-4-chris@laplante.io>
In-Reply-To: <20230714232659.76434-4-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 17:17:12 +0100
Message-ID: <CAFEAcA8NPQP23Gnf8fURudWt_3O0OhR2eUuwqzG9A3mm2Stuhw@mail.gmail.com>
Subject: Re: [PATCH 3/6] qtest: bail from irq_intercept_in if name is specified
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 15 Jul 2023 at 00:27, Chris Laplante <chris@laplante.io> wrote:
>
> Named interception of in-GPIOs is not supported yet.
>
> Signed-off-by: Chris Laplante <chris@laplante.io>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

