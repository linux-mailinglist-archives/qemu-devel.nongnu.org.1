Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9844A799E11
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:23:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJTI-0003Yz-65; Sun, 10 Sep 2023 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJTG-0003Yd-Cg
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:23:22 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJTE-0003i5-8b
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:23:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AA62C60C80
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD0C433CB
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348598;
 bh=BDwQEMjtuq9zklB8JjE9cNQmK2qo6CavMHvj/5xfN+k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ma4BTbERg+3HzGr+fOR1+8T0k+3Y/pMN84Wa+ow1WWVh0ZGxokwHG4EHAMviV3y+P
 /y+3K4EImK8ktl+YNfRbA7twBxklbMi7wHSTSt0e9CHlfD8vpBUA/wcsfUw1V4oRMF
 EU6vfgb1hYY2tt+Soe+D1i9+86VpLK8NQBL/yvZ3qDZ+kmpBDrrlwb773z4FXUOaFE
 InoJeXMWtAUilAdkDpErZTF3Bk7Ko+wzjoL3z6GePNdb/m8z682x6jdCii89dmjCR6
 lI/rg5z7blpQYJzByh7leto75h3ZHKaKTdJA8N7nTqIIRmB2Z9QzU8imMexkSi66eh
 jUA5/agihtnZg==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2bcc331f942so42839241fa.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:23:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNbiYeCgUJUJJIQQmmuspraHHsyLK+kJkiVpodEmwOnZrfUPiA
 sauRYB0kTyL2IdW39pByPw/ODJLekB0N0lxzF/0=
X-Google-Smtp-Source: AGHT+IFhNbOQDynAH89cbHln+kb0IJtkHfZSYybWUkdGZySAmS7mAnGfuluevQgHIctR2rG67M6NYtG2+WgGDNOxwak=
X-Received: by 2002:a2e:3001:0:b0:2b6:cbdb:790c with SMTP id
 w1-20020a2e3001000000b002b6cbdb790cmr2303444ljw.1.1694348596291; Sun, 10 Sep
 2023 05:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-10-richard.henderson@linaro.org>
In-Reply-To: <20230819010218.192706-10-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:23:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH79Hchi0_ou-UNAq9jyTQK8DyN_gxNMS8WpV4JHNZNjQ@mail.gmail.com>
Message-ID: <CAMj1kXH79Hchi0_ou-UNAq9jyTQK8DyN_gxNMS8WpV4JHNZNjQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] crypto: Add generic 32-bit carry-less multiply
 routines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Sat, 19 Aug 2023 at 03:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/crypto/clmul.h |  7 +++++++
>  crypto/clmul.c         | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
> index c7ad28aa85..0ea25a252c 100644
> --- a/include/crypto/clmul.h
> +++ b/include/crypto/clmul.h
> @@ -54,4 +54,11 @@ uint64_t clmul_16x2_even(uint64_t, uint64_t);
>   */
>  uint64_t clmul_16x2_odd(uint64_t, uint64_t);
>
> +/**
> + * clmul_32:
> + *
> + * Perform a 32x32->64 carry-less multiply.
> + */
> +uint64_t clmul_32(uint32_t, uint32_t);
> +
>  #endif /* CRYPTO_CLMUL_H */
> diff --git a/crypto/clmul.c b/crypto/clmul.c
> index 2c87cfbf8a..36ada1be9d 100644
> --- a/crypto/clmul.c
> +++ b/crypto/clmul.c
> @@ -79,3 +79,16 @@ uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
>  {
>      return clmul_16x2_even(n >> 16, m >> 16);
>  }
> +
> +uint64_t clmul_32(uint32_t n, uint32_t m32)
> +{
> +    uint64_t r = 0;
> +    uint64_t m = m32;
> +
> +    for (int i = 0; i < 32; ++i) {
> +        r ^= n & 1 ? m : 0;
> +        n >>= 1;
> +        m <<= 1;
> +    }
> +    return r;
> +}
> --
> 2.34.1
>

