Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BB818DBD
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 18:15:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFdfw-0006BI-EX; Tue, 19 Dec 2023 12:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFdfu-0006Aw-HQ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:14:34 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFdfq-0007HE-DD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 12:14:34 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cc6ea4452cso33823001fa.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 09:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703006068; x=1703610868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ts0K1jX1SAV6ijWm6zAsLA8MOZ7qGrV3QSqUYBJW3pU=;
 b=JmSYAY4xopJ3nI6qEORuQmDBokpL1P1fG9gVLpZTSddNKLjKumRJPQQ6BkxX33KmAL
 Rr0jMEVJnBxvcWnqVjX054S/DGKjU+as3VjY70GXMAU9sS3CWHvBG9mmzFae9x8EvgXG
 FuMBUUtoXpf409OR2+VEtFyBYSr79gKnE4f1HPzilgvK9waIHHYjwYmSNdKuVmLDsjyv
 X5XW82wXuiCmjboCa1g8lSvhiJfmAQOtxn0Gb30VCzE+4a70y4bPCGeo/eWleziKJYmK
 xvyo6Edqcj0WApu+gNmbsX0Ky/r3kKOjgc9jNBEQsqZ4DTJ2s8fFebsexh962uHXr4yn
 HMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703006068; x=1703610868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ts0K1jX1SAV6ijWm6zAsLA8MOZ7qGrV3QSqUYBJW3pU=;
 b=TYpkQLE2X9Me2FSXUEcOxm3X3RFlq4XP0iv3uS49+oQclK9Km3ylH9TnwvI9piE1TQ
 hvLvJmMbmhiq3gKj5nqgvhQMwJrmgz2LKdn0LvTLPJ7ZlOkDpP34khodaYe3K+jZ5ARb
 E8UdQpqro81iz0bgS/l39i4nWOceCJySb+k6SuZxIrS7i/UfyDqIrAsHPeKoXOfTQ3Uu
 HTAieZRJX5O1mcty76yB+x7wlAmPVOOSlCpQrfc7F4rN4qC5yXbUr6FSRNuKUkQcFWv9
 y/LDLd3iQxfozirj6Y59HL2xx41XfS+yie2Bkg1ETLOPRyenDvISEL597JsgjCM4fLej
 dKFA==
X-Gm-Message-State: AOJu0YwTV1N0c5aFppeXrPlivKi6ty5e2WGK5lIPMNk0GExr+KUd6Y78
 RR8lSZvCYLC99okX/o1TfPr3lWlwt3wknpJ8ntMlGQ==
X-Google-Smtp-Source: AGHT+IESeB84CyG+EvDS1UqFeNDQyXWZWdRKpZi2V515kzUDKLqrVMELupAiaUMfa7nz8f9QjlcTx6Ijf6v+TvvyZHE=
X-Received: by 2002:a2e:a54b:0:b0:2cc:6ca3:2477 with SMTP id
 e11-20020a2ea54b000000b002cc6ca32477mr2530218ljn.80.1703006068267; Tue, 19
 Dec 2023 09:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20231214233055.2505387-1-sam@rfc1149.net>
 <20231214233055.2505387-2-sam@rfc1149.net>
In-Reply-To: <20231214233055.2505387-2-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 17:14:16 +0000
Message-ID: <CAFEAcA826_XkijfuL0V-2jziuVGd0yDwLcOS0DJcXyWEOcFZuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: Remove unreachable code
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Thu, 14 Dec 2023 at 23:32, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> The `fail_rx`/`fail` block is only entered while `buf_rx` is equal to
> its initial value `MAP_FAILED`. The `munmap(buf_rx, size);` was never
> executed.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2030
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

