Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB727714A0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 13:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScOx-0007E7-6r; Sun, 06 Aug 2023 07:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScOo-0007Dr-R1; Sun, 06 Aug 2023 07:58:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScOn-0005IQ-B2; Sun, 06 Aug 2023 07:58:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc6624623cso4894515ad.3; 
 Sun, 06 Aug 2023 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691323095; x=1691927895;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jc3u+WY7m11BvQ9/qS9NgNbgwXYEoE899NQndDhEs+0=;
 b=ZEUhcHqq6mdiuNENWkiekNy6cbMUTyNjvgUvvnf2qgsYv2dr6kPR84rpgqifkWhldX
 /b8xlyLNyIXn0O2eTwF2BpAWHgfitVPb02p3yMWAgjEByhbPGief6lFMfIKoPZAW6h8/
 kz+sCeNZpLE+z3BsTVnbMyEFIKPpnxIRlPAeIso5OAzIlLZt45/PHBQnkEvw4ydOjUmr
 ZailzRvBEVCUAY1QsgQZII7paBRBNvbjmNuz0T0Ztl4yEj9WP/BiWyKb0IuIEoW11Lum
 GxBAC+Ag3a8I0fWi7qA9IloaLovTYGbfQkRdS85OyMzXaSXxt9i3OZURH8u+wgvOJp77
 8hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691323095; x=1691927895;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jc3u+WY7m11BvQ9/qS9NgNbgwXYEoE899NQndDhEs+0=;
 b=eqQIuESXNgAdLV1kOtU1tgsS1STDR2YU6gPQYoom6fVbvEwILQ/bu7E/MjqFrAJxJT
 U/Ig0hhcb12sP/e4vUNIrjBAyPUrhdBEFafbT9MP5/xH2iZdUrUvxJtr40UkeJ9NcSYD
 aJ9r3urVcaBzIO2SP0ate9uXOT/XWlFIoghJ/JpHhrqYns0NdirIZrl/TlieLji2BOaA
 1TrSNEOwTqO+YWOsAWpnwAj9r0+CCOYtFfIz/3S5jIsE5NJV3vXgplLjNPNR9kdr70+U
 hvLMq/A5FV87Qg/RcfOgeDCyuxm7NhnkML2n7ggVx7jm2sDx5e+EH6mTtlgxVpwHjx8V
 okBA==
X-Gm-Message-State: AOJu0Yzl/BpOg6Gk/Y8NH31g9j9WWQhB3sEGKUEh6F9PfWXnYCcxz6VV
 1fqU7QJKm8yPdS4sis54t3s=
X-Google-Smtp-Source: AGHT+IHXsV3l+ezr5oR3SGtiD85DFoZSpIJJTl0WVF07PRdrRLA3J/ddN7YALox/oXB7EsRqzL+j6A==
X-Received: by 2002:a17:902:e743:b0:1bb:8e13:deba with SMTP id
 p3-20020a170902e74300b001bb8e13debamr8366429plf.11.1691323095596; 
 Sun, 06 Aug 2023 04:58:15 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 jk21-20020a170903331500b001bbb7d8fff2sm4829890plb.116.2023.08.06.04.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 04:58:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Aug 2023 21:58:09 +1000
Message-Id: <CULFZWQ05ZC9.8XZ7OPX9KW0Y@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
Subject: Re: [PATCH 6/7] tcg/ppc: Disable USE_REG_TB for Power v3.1
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-7-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Patch 7 is not reqired for this?

Thanks,
Nick

On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
> With Power v3.1, we have pc-relative addressing and so
> do not require a register holding the current TB.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index e8eced7cf3..5b243b2353 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -83,7 +83,7 @@
>  #define TCG_VEC_TMP2    TCG_REG_V1
> =20
>  #define TCG_REG_TB     TCG_REG_R31
> -#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64)
> +#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64 && !have_isa_3_10)
> =20
>  /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
>  #define SZP  ((int)sizeof(void *))


