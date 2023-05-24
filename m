Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9670F42C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1lhy-0007Yi-2h; Wed, 24 May 2023 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1lht-0007XW-KJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:27:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1lhT-0000Fl-3w
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:27:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-510f525e06cso1759389a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684923990; x=1687515990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a9f6EDMg8YEdFnJeREidO18b8o+K6y8nrTE5EGasYD0=;
 b=Gic+DaeNBUmQCM+IrL8TpQuH2rnqW2vNVFZN32/uGduafgyfy/c9NrKKjSVbXJmuvh
 oDnm4aEugeaQTFnwurIvTzpEPtjAlQoHFuqGvAP44uoR1tlJtNKcno1OkqVgC3avsFEZ
 pK/lNW38SuKIqlE6IkEWBV1Y7AwlCP3/crNzhzq83PFeb4fdgTmYyVAyR7w663WmZghq
 S7gbnCUyb4OIl+5uf3eSJii3r0U58q6uJXEPZhQew/IFV8lgJmrkAsr81h8yipKQ7+5p
 6xJyYpQF4EL5K/NrjDtBTn07bVjiJzbwoOA/KUuyYHSzcp0Aaysoq89G1LCv9zeZnezH
 EbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684923990; x=1687515990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9f6EDMg8YEdFnJeREidO18b8o+K6y8nrTE5EGasYD0=;
 b=BIqUdFZCRd+2EBQXiPudZPj7QF6QbePcwLrXn9W8YsbKV56udTmjGZr2huyljIi+0p
 4U3C0FQcQyWv3w0KbY7vohy6YiUZBUaZ9it8kx7BtwI96kTq+pZ9PJWuub5yFS67B4M/
 vjNqRRDzDs8kuUmqLvMP9mDPxMJOwgq6ik7j2ibkvrm8hTvF/zEzEgx3tLBN+mWDLn2e
 mqrPiZuvPtpeYFOur6iDrLfdTPCtnzwqRuMvaLiPRQ/WCzlYp7xNsh0FkpCwK8lXDW+U
 lMwGzJcuATlK0oZ7q6gzc9hCwTy/s97f2YLzuQvl3N/N8mtQVOGqcWPh/gvXdcvb2SDg
 VmqQ==
X-Gm-Message-State: AC+VfDzmYlR+7bleVbox9LQ5WI31V2swbaATa1yNrtGMvQRnisgro15c
 nFcRAcC7gc5omOFrKmiuacbF5+U4K4WZ0K4Gaka2IsTrxlR0WHwn
X-Google-Smtp-Source: ACHHUZ44Ns4/8YfxFOaZw7vFXbswC1pmHwpL0vrYqtK0igcamxvJobNl0eOOFZoWaYwsL9lA8yCBL5G158PIxHARc6A=
X-Received: by 2002:aa7:d9c3:0:b0:50b:cae1:d7a3 with SMTP id
 v3-20020aa7d9c3000000b0050bcae1d7a3mr1796293eds.14.1684923990265; Wed, 24 May
 2023 03:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-7-peter.maydell@linaro.org>
In-Reply-To: <20230523120447.728365-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 May 2023 11:26:04 +0100
Message-ID: <CAFEAcA-5DvFB1JiCwj1Gb7WUST4-OAyJ8nYDQax_msFZuFNhnQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] tests/decode: Add tests for various named-field cases
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 May 2023 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add some tests for various cases of named-field use, both ones that
> should work and ones that should be diagnosed as errors.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/decode/err_field1.decode       |  2 +-
>  tests/decode/err_field10.decode      |  7 +++++++
>  tests/decode/err_field7.decode       |  7 +++++++
>  tests/decode/err_field8.decode       |  8 ++++++++
>  tests/decode/err_field9.decode       | 14 ++++++++++++++
>  tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
>  6 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 tests/decode/err_field10.decode
>  create mode 100644 tests/decode/err_field7.decode
>  create mode 100644 tests/decode/err_field8.decode
>  create mode 100644 tests/decode/err_field9.decode
>  create mode 100644 tests/decode/succ_named_field.decode
>
> diff --git a/tests/decode/err_field1.decode b/tests/decode/err_field1.decode
> index e07a5a73e0e..85c3f326d07 100644
> --- a/tests/decode/err_field1.decode
> +++ b/tests/decode/err_field1.decode
> @@ -2,4 +2,4 @@
>  # See the COPYING.LIB file in the top-level directory.
>
>  # Diagnose invalid field syntax
> -%field asdf
> +%field 1asdf

I just realized that this specific change needs to go before patch 5:
it's updating an existing test because "asdf" used to be invalid
syntax and now is not. Otherwise bisection will break.

-- PMM

