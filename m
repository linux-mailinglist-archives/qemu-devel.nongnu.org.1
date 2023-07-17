Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D5756032
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLDf-0000ar-80; Mon, 17 Jul 2023 06:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLDe-0000ai-4a
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:12:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLDc-0004bD-Ic
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:12:41 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso5742933a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689588759; x=1692180759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4MoU7g1+K32Niq+1YwdsCCvSWbcbPuq8dIWyzMovzN8=;
 b=FkwhzKKLAoYG4JskOwqrA2nG3YXmg0HKsRIqP9BaG9x1W7EmHTreglzftAYXHNwXZO
 nAOpFZx9/gUczNayNr94gwxFe5GeL8szbc9lZA0YrqrwvBYruHOwBEjrXXjk+eny4USF
 QkN5mP/1CmZsQKJ0HqPTdb1DNR0nDvg+z6oZWPfbRIAKAZSpEH383iI0LFnNKXGuYtLw
 W0bsYuciRhx6pErq/gOOzVeKje7tHT7T73yiE0J1dpCZ8i2cwsB5U3gwhMXd703Lk8ls
 3PU6M4D/zENWpcAlVpJuFKf3kPwwHUuYJhqMyL36rmVKSDWIYaRO36U6aoE8NnBFEbdg
 MYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689588759; x=1692180759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4MoU7g1+K32Niq+1YwdsCCvSWbcbPuq8dIWyzMovzN8=;
 b=e0StbEibIh6Pui4m73sVArNa/wc9AM2xbn/Zo6qvCcHrnHX9nANJ8jh2nd7XK/Ykp6
 YaIkAueH3H8En3Y+7nqyfpDR6xE30A7KR1FJyEGkWlD1gajIU9oSg8l/bw8R8gXKC6AO
 c7/ojFme8eQIEFWPKqkjMd1DYQuaPXnzxUQg1QqNftkhJmttporha24LFQB+yrDZhYf4
 LoM0v6rmm210fyUhHZzGaoD0/EPRDpD8I84EEeWhme+0wIx5tlesMsS2Ni6DE+FrhnCL
 mSSTkaYLXSSw9sCxguYEADTfM0PQgWF7c8Gp+q9NdMu6Ii/LobQNTYGIVUMTCFctFBov
 oLkg==
X-Gm-Message-State: ABy/qLaP/LCnybvSt1Q0bGp2cZ5SX5GDjTrKi+J3ByXVVdk6krtmpMyK
 2ASCOn5GxmjR9Elv46v/qA2OvAJ/o/bTp3KQQcf4Yw==
X-Google-Smtp-Source: APBJJlEVIGxyRYxniSMMXws1EedogVn/KbjHqVe5tHA6sMs1OSCxPYFcl67QNQ2arC44fqHK2UrFiKX70EjHpCYYfsM=
X-Received: by 2002:a05:6402:31e5:b0:51b:ec86:b49a with SMTP id
 dy5-20020a05640231e500b0051bec86b49amr10474420edb.7.1689588759105; Mon, 17
 Jul 2023 03:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230716170150.22398-1-richard.henderson@linaro.org>
In-Reply-To: <20230716170150.22398-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 11:12:28 +0100
Message-ID: <CAFEAcA9dD8SmAFQrt9eRfsMuG3vEh03ex9b+LsgTjg2TRcbiJQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 16 Jul 2023 at 18:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For user-only, the probe for page writability may race with another
> thread's mprotect.  Take the mmap_lock around the operation.  This
> is still faster than the start/end_exclusive fallback.
>
> Remove the write probe in load_atomic8_or_exit.  There we don't have
> the same machinery for testing the existance of an 8-byte cmpxchg.

"existence"

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/ldst_atomicity.c.inc | 54 +++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index 4de0a80492..e7170f8ba2 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -152,19 +152,6 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>          return load_atomic8(pv);
>      }
>
> -#ifdef CONFIG_USER_ONLY
> -    /*
> -     * If the page is not writable, then assume the value is immutable
> -     * and requires no locking.  This ignores the case of MAP_SHARED with
> -     * another process, because the fallback start_exclusive solution
> -     * provides no protection across processes.
> -     */
> -    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
> -        uint64_t *p = __builtin_assume_aligned(pv, 8);
> -        return *p;
> -    }
> -#endif

I don't really understand the comment in the commit message:
why would it be wrong to wrap this "test writeability and
do the operation" in the mmap-lock, the same way we do for the
16-byte case?

thanks
-- PMM

