Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699377FB4D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfLm-0005yp-Vy; Thu, 17 Aug 2023 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfLk-0005yN-RX
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:55:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfLi-0002ZR-Ov
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:55:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5254f9eda36so6896244a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692287748; x=1692892548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dWKqOk47v308/+gttK2oyzm7+bsuGKkFiow1MURdLmw=;
 b=HoYEUqay1dOMKfnUGVzXO4PG/YZhB3f9IEHZVFg6wnYc+cJKCjMuhwGcXTvz79QAs/
 NlwDX8gFWD3nt4T0BWvH2eqqPrLZ2+oJAVz9SWUT3NJzmWjCb2v5WdFokS3/aFOhf9MG
 bk9xKwRUVZHYH91gzgOe6bGtoNPDwaiwwdM2BpU/t9yxFEFpRYYEYF+OUFHgfZ3Hlxmn
 n/+ugaAiHI+TwLu5UT2uTMksb+m0WVivZT9GTOnTGpsYc6sLXcl74e8zxuO46NJld43v
 JseEfjGGwoRiQlY2ZO7V9JsjZUY+1thomsgqYHaUWGFFLvaP+4Ln4AEB6QnHzmFOcZ6s
 7cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692287748; x=1692892548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWKqOk47v308/+gttK2oyzm7+bsuGKkFiow1MURdLmw=;
 b=ZiYVwp7+bbE7EKrOyS4rwX/9MPsnraaMNFIoUMioyOjgC/aDv/1mvqsO4H6cnBehj+
 tUy5pmkLaWvsvIzxvDWZg+CMLb9+UeUumMyNx4EgWuiWQgnHzcB42saMx//Z3EeGlk3e
 HpYKnviwXcNWPl8GKRUSrCUCXyVbuZWz7l+4ATwnLLUq/o/pKghFLmYlCZiiYXZr+hKR
 QOysApkjVkNZ0RWFW1Wf/ljfOa8U54UIujPxhGfworB3ZjDhP77TSHWdykGni4DV/wn3
 i8oaNyhiDvVYYUFvYR7gF+U+5KQeNqqFa64RIAmUJsZ8fR7xTOKL4JlxLziw98ja0rVg
 OAkg==
X-Gm-Message-State: AOJu0YzefMYcFEEbJJStg+8LeCRp/Oti0dp45A6fxdRhsBVm7S8ynaLh
 UTYnyIR3x/JCsD25EiojeUojLHgXrDliDYrzYw6kbA==
X-Google-Smtp-Source: AGHT+IEm27c+RPz10DuV7nTZWNExF8diTmsIKEevkT4EuVYIH2LIMsfNkiKkKcrtND9MzF52m1JOuGvxNfpYzOQxHvQ=
X-Received: by 2002:aa7:dcd9:0:b0:526:e585:e25a with SMTP id
 w25-20020aa7dcd9000000b00526e585e25amr90142edu.38.1692287748101; Thu, 17 Aug
 2023 08:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-4-richard.henderson@linaro.org>
In-Reply-To: <20230816145547.477974-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2023 16:55:36 +0100
Message-ID: <CAFEAcA_trBVvaFOAbJMmjwX01FSxsFFaYkUCxQ8phzYZ=DrphQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tcg/i386: Allow immediate as input to deposit_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 16 Aug 2023 at 15:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We can use MOVB and MOVW with an immediate just as easily
> as with a register input.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

