Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CC782862
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 13:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3WR-0003jF-EJ; Mon, 21 Aug 2023 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY3WH-0003Vl-EL
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 07:56:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY3WC-0003yb-2R
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 07:56:29 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52580a24128so4029946a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692618982; x=1693223782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BHbqbw9lCv5JbzlWO4/rmwrp+1ykFuyqXQjbq/f4UEY=;
 b=lcswyzAe8h2BcwHoioN+dlMVvqacPRm/sOyA6gsNCm8fWcopANlrAgP6SMxMOghiHl
 cVKdMMSk8Wrm+HxETFENh/iOYub35K4hs1Cr6VNTpFHRf3JIHLVWpzILa7aHJ6jLPlF4
 ewYaykupV4ElZmdc3fy/iuu/WFSR6fPsXGVNlAi3JOPNg3F7z3LaBbRrp+aYZ1Am4tWk
 uoDLSHbr1JF0FrM64sKuecjNxNy0vI9T5u9Y4U3ddDOhf6DezEkMtUoueiabRnQViqB6
 PJyylQD1FvwqSECjQZeOGXnxbLS28NRQnKp1xXqH6adUZZuZn2ZNLWNFyFaqmPmBFA69
 fifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692618982; x=1693223782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHbqbw9lCv5JbzlWO4/rmwrp+1ykFuyqXQjbq/f4UEY=;
 b=dWAbeaILm/oDbtLLN8rMnAjFKUTyBAALNRvNVIYtc2qGo489BhD3QfDVlU5XG7Jhq8
 Vhpl+MDb1sdtJsaG0BpZj9aem8THsMGlEbjFdbwdCUx/1ZDLbjXhZl/bUTKHw0/tuGIz
 6EHjQm/ow2rnG7PAmfL4rHQZBPP6fwd6zUYInS6UjG3PA4CrIXG4teKFqbXsp/3ma9Y4
 KOg0Od9+1ZtHwQBPWge1zbKeadsHczOlcHGRYt3kMNai/ZQjJqi7crSMtWjIf1Cn4SLQ
 Ed1kIlC+8urlu4ZvtqZhl4A/c+jZGDcUXDPEfm0XY603lZyotHlaKjL1Fm7mHubFZgXN
 ha2Q==
X-Gm-Message-State: AOJu0YxjcjhblriKKQDuyAUWOcqPpU7Q0LvOHtWKZMD4fqW5YScy/1aU
 eflBj+IoERWCuAUHHppFE3uYKn4UYhIC7ulG804R8w==
X-Google-Smtp-Source: AGHT+IHP7A0FwsavmxRlO9GzXj5cTTvv+zGjHuRP3BwWUt4tD0iD0ibTqm/x+MPiLoVtAccXD3bus40o+WLD9WeWK7U=
X-Received: by 2002:aa7:d6cd:0:b0:526:9cfb:c12 with SMTP id
 x13-20020aa7d6cd000000b005269cfb0c12mr4985171edr.38.1692618982420; Mon, 21
 Aug 2023 04:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821022025.397682-1-richard.henderson@linaro.org>
In-Reply-To: <20230821022025.397682-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 12:56:11 +0100
Message-ID: <CAFEAcA9n_AMw5LYdwhgmsGMRCzQ4uoEtxUyjQjhJp+AALVUZrw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix 64-bit SSRA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 21 Aug 2023 at 03:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Typo applied byte-wise shift instead of double-word shift.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 631e565450c ("target/arm: Create gen_gvec_[us]sra")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm-for-8.2 with the gitlab URL fixed, thanks.

-- PMM

