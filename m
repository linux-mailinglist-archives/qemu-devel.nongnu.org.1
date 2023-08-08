Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9C773AFF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOhN-0001cs-5c; Tue, 08 Aug 2023 11:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTOhL-0001ck-Ke
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:32:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTOhK-00068A-5o
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:32:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c10ba30afso1455180966b.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691508756; x=1692113556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DIhEEooCxnnbnGmnG7N7p+eSATTWrrSJfDAdwagAaJ0=;
 b=ymg3YO3nCP+GB3/pK3UVqGwoe3LTq1Fx0dBkAifSIiskZXNkhXWlt76bcjwwZzSfRU
 w2/STZMEVVd+3w/VCD5gxv44lpH2NWztzn8/812pu44mr2m2LrGulItxfXhr7E5v6gSv
 Lda1um7VIaf5JLHK1pvdL9AX4FvWjMaho2wXZTowUWKWxsgxSro7eZGs+OdX86wR9Hsl
 7mukqFuNosxCDZsmXiRFPjgiT3XjL6XUDzB0c2ZQ6Yfk911mOA7pahKA9JwBA1kmvIqB
 4azesuoaghE7LnPBGwl0eB+30ASoW6Pt/EDmqvIq+Qqlfhzguq5D73rnuwYXYsKWPYHc
 wMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691508756; x=1692113556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DIhEEooCxnnbnGmnG7N7p+eSATTWrrSJfDAdwagAaJ0=;
 b=lWwMAeZs/DIMZLXtRt0jN1j5uvHH81cPJvAftp8p2LQt4OWYZl5TcjpVd+KkIIExkc
 9UOZoL9BvPUUdsuMJ08LdKU94YSrgdiziHvGUzQZYs7c9ScYmbub838aaA/9TtrADXQc
 jpEIzkKY774SEcvQRTi3yyuWSUyjsVFiqjL/Sx7USgdUhOPQ6aBkhZjWp46S32Vklz0c
 9lJ6QgR0fwHQ9nVZvM4uCvBSNW3Div1M+tfb3XMI7qV1Q1RHa342jbA8HAp4YqsocYO3
 /DezgczLJFQ2U2eeTGPPcBkLJRMEoT4oU+NQ9bQ35Bq0X0TrL1EtGcJ5TNdDr+N7xNNV
 KWng==
X-Gm-Message-State: AOJu0Yy5xMsBHXyk0k11Id83GnaEUIoSezyj8m4Vj7UbXeAttWfepq8y
 xO5460PauevckuSO5Ih7jprLuWWVMxcbGz2yn5fd1A==
X-Google-Smtp-Source: AGHT+IH7btPvJ9lVrhJsXLqfApYgXH88SsEUdqjY3dvb2TbAyagzlszbt8o/3cOWwDo0xWy2JlNa3ZvR7Xuz8VduX30=
X-Received: by 2002:a17:907:6096:b0:974:fb94:8067 with SMTP id
 ht22-20020a170907609600b00974fb948067mr12044962ejc.23.1691508756009; Tue, 08
 Aug 2023 08:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230808152314.102036-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230808152314.102036-1-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2023 16:32:24 +0100
Message-ID: <CAFEAcA_F2oSWVcwxLxYZxqgmE03n3c8+aD5_kS0L7LFW4ivTwQ@mail.gmail.com>
Subject: Re: [PATCH] thunk: Delete checks for old host definitions
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, 8 Aug 2023 at 16:23, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Alpha, IA-64, and PA-RISC hosts are no longer supported.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/exec/user/thunk.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index 300a840d58..d9c131ec80 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
>          if (is_host) {
>  #if defined(HOST_X86_64)
>              return 8;
> -#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS) || \
> -      defined(HOST_PARISC) || defined(HOST_SPARC64)
> +#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
>              return 4;
>  #elif defined(HOST_PPC)
>              return sizeof(void *);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

