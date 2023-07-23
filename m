Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1A75E290
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 16:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNZvX-0008JD-4F; Sun, 23 Jul 2023 10:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZvV-0008Ib-8u
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:19:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNZvT-0000ih-Re
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 10:19:13 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so7398959a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690121949; x=1690726749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wt/WL5is5bdE4kWQzQ74GoLmnk+DU8977xRwO0wmUcc=;
 b=gr+u4RWwzaosaTaFYpP1oZ+KGdhhAyNtRHHfQmVwZsWiJ3hfhQJRshz5iaPWJPrXKr
 bXH+NHWkXL2qJOf/p17x+8lZo/3cWuFUvk4TyQf8wVhL+daGEeREQp7LEJJtFM214f91
 pXTDl56tVr+5Us+XB8MTk9O5ywDW0liC/8hS1pQbNkZ3Kkr6yBxVEhdtPEk4l+nHgNVc
 wxvpMxfwgvVhdY64qMZq9aDu1CDcNOaeH5+L2Kt+S3qw8PjK3WFkNZhEogD5x5I4SnL/
 MxPXKz3pEoBZFl0BPg8ZC9U0ryXNsLNF1Pe7x+NFJHxEWNELOaRQdpFC3BZDE+PfY3PY
 pr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690121949; x=1690726749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wt/WL5is5bdE4kWQzQ74GoLmnk+DU8977xRwO0wmUcc=;
 b=cC6AnFBTfoDEVSMExxvJOIswL/GqRSdQZddNEJ8q/HLFaKKb0BEWG7jZz75/4SPBrV
 DleVqXnx6F2O8u6vCpIpY2KYoCZ9/waiQi/PwGAk+oLsePcIyZwjQ8aOtnXCMbD44Lc4
 VFKnH4RJ9DjkeM29CVMZPv0py/fdfdADItv2uK3VFSmo49VFPIKIhuwuRbRoOxR03kqV
 hbpFngOyAEEgNlXTZNoTrdjUMK/8RTQjqr7fhFCvl0yJE8iWHMttOKGAmxdCo7ZznRfj
 YnS3ZYQtF/GARLtYj64xqCWWW765qU8ypTjVGbgUoVWAS79Ey86u0aXMydHjUpRiwtQE
 8ALg==
X-Gm-Message-State: ABy/qLbZO8/Xusraj2vmPDPrpOP2GMvZfBGgVDouWMNQhnZWF6NtqE9V
 8yzPNXQ0iZO+VNmLkhI2NwLh5elgvu0CLCcZfzeW2w==
X-Google-Smtp-Source: APBJJlETDCwQUUIpTkWm7HBvdDT+C4kmMZkKs/a+YzfaZvj4uFShijjII9gv/yiZbobYx3607yRNbLNowjEpU6E4OvM=
X-Received: by 2002:a05:6402:35c5:b0:521:ef0f:8ef9 with SMTP id
 z5-20020a05640235c500b00521ef0f8ef9mr6562058edc.19.1690121949586; Sun, 23 Jul
 2023 07:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230722113507.78332-1-richard.henderson@linaro.org>
 <20230722113507.78332-2-richard.henderson@linaro.org>
In-Reply-To: <20230722113507.78332-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2023 15:18:58 +0100
Message-ID: <CAFEAcA_G1TCCUiCTKN4JGBvMji5YFpUn74P+uEeXsSnCUJbJ=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] include/exec: Add WITH_MMAP_LOCK_GUARD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 22 Jul 2023 at 12:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/exec-all.h | 10 ++++++++++
>  bsd-user/mmap.c         |  1 +
>  linux-user/mmap.c       |  1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 5fa0687cd2..d02517e95f 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -629,6 +629,15 @@ void TSA_NO_TSA mmap_lock(void);
>  void TSA_NO_TSA mmap_unlock(void);
>  bool have_mmap_lock(void);
>
> +static inline void mmap_unlock_guard(void *unused)
> +{
> +    mmap_unlock();
> +}
> +
> +#define WITH_MMAP_LOCK_GUARD()                                            \
> +    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
> +         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)

All our other WITH_FOO macros seem to use g_autoptr rather than
a raw attribute((cleanup)); is it worth being consistent?
(This one also doesn't allow nested uses, I think.)

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

since it would be nice to fix this for the next rc.

thanks
-- PMM

