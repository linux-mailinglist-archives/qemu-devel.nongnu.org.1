Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD5E78F728
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtwb-0008ON-Gp; Thu, 31 Aug 2023 22:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qbtwV-0008N0-Kn
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:31:27 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qbtwQ-000395-GW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:31:24 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-44d4c3fa5beso712445137.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693535481; x=1694140281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuq3cRJ0HlSGxczmAT+J8JFanVd+kSpPGkCOSmcq+w0=;
 b=YZTtopKvD8umyRZPyzKZ4F8a6P3iwcS3JM7hzToZxT+ULfTis4WutUwYA1IN3lE0Cp
 D56bmS5cX5qBv7pwAVoayJPhUk6bUBhR3tu5XTvX4TO2d+ZkNeZIWEyXA5nwKM3dTUYd
 ImnsKuJG6HSvBPM8GXurMMPGJUXLZglOkefPVDQgExapsPOX5QO+w1HHaf2dvGLTZdpl
 J2vvzgPjthpO+yA/l+UKoK/3SIeJBuQcuPpJ6ctXGv8RqauIROMzkaKcheGRUVWFxn8x
 nce6TIyzfV5ipq4L2aGjXhubeA8oKsa+LDOnzd5hcTjP8aMxP37AC25RFQH8EqjKPK+p
 FROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535481; x=1694140281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuq3cRJ0HlSGxczmAT+J8JFanVd+kSpPGkCOSmcq+w0=;
 b=PoOI8NB0f2ys/31bVkRRChZ5H9FZQf3ya+qM+pXKPZd+R0f12Q5rAOhmrkWwQJ+DPA
 tsvwWX4HLQ26GRuIUKEZMRHaGTOLhLqCcltbMV/1LaEfSN5d8jqkRj3iHSqgj4sN5JZP
 JmJYbpcJ5PRKUNR6KESQS7GahmQweAYzBYu2+9Y0RYWyy6nghFQ0aH1xPW4yJJ8krNEj
 WeQMrTbu6Uas5EVqf+SNlO9tmZ9p7owz/wmPtDFarIVAR4ds3Cn9kgNsdY0UJbZMkOCK
 S5eRb+wLU7KQpdnPVs/c8dQyPniFNkTqhCNpa9py7ALbjqWIzA+mNHR6u0SsLP2z5Ey6
 V8Rw==
X-Gm-Message-State: AOJu0YyegfV2o7G4B3uX+vM3oMCejRzEN5Rn6P6il728wUQ7UZgfPgsy
 61IiImv3rZV3ADtGOvftvTo8VlspcLP+d2v55k5vKKB+Jpy6/A==
X-Google-Smtp-Source: AGHT+IGzqkOaseIBtAWs/iqmtlI1flOXroF40AK0G9JaN2Gh+qOo2glzcVkDf+euiKuI9RQ8Lgxut7VfkSUG/ny+mBI=
X-Received: by 2002:a67:b60a:0:b0:44d:3bc0:f1bc with SMTP id
 d10-20020a67b60a000000b0044d3bc0f1bcmr1379934vsm.18.1693535481293; Thu, 31
 Aug 2023 19:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230831154118.138727-1-ardb@kernel.org>
In-Reply-To: <20230831154118.138727-1-ardb@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 Sep 2023 12:30:54 +1000
Message-ID: <CAKmqyKPO2GLFMJtn3uA8yXXOXcA+fA9zcpPz_+6dfV-C-TuJjA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Use accelerated helper for AES64KS1I
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 1, 2023 at 3:12=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
> implement the first half of the key schedule derivation. This does not
> actually involve shifting rows, so clone the same value into all four
> columns of the AES vector to counter that operation.
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2: assign round constant to elements 0 and 1 only
>
>  target/riscv/crypto_helper.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
> index 4d65945429c6dcc4..bb084e00efe52d1b 100644
> --- a/target/riscv/crypto_helper.c
> +++ b/target/riscv/crypto_helper.c
> @@ -148,24 +148,17 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, ta=
rget_ulong rnum)
>
>      uint8_t enc_rnum =3D rnum;
>      uint32_t temp =3D (RS1 >> 32) & 0xFFFFFFFF;
> -    uint8_t rcon_ =3D 0;
> -    target_ulong result;
> +    AESState t, rc =3D {};
>
>      if (enc_rnum !=3D 0xA) {
>          temp =3D ror32(temp, 8); /* Rotate right by 8 */
> -        rcon_ =3D round_consts[enc_rnum];
> +        rc.w[0] =3D rc.w[1] =3D round_consts[enc_rnum];
>      }
>
> -    temp =3D ((uint32_t)AES_sbox[(temp >> 24) & 0xFF] << 24) |
> -           ((uint32_t)AES_sbox[(temp >> 16) & 0xFF] << 16) |
> -           ((uint32_t)AES_sbox[(temp >> 8) & 0xFF] << 8) |
> -           ((uint32_t)AES_sbox[(temp >> 0) & 0xFF] << 0);
> +    t.w[0] =3D t.w[1] =3D t.w[2] =3D t.w[3] =3D temp;
> +    aesenc_SB_SR_AK(&t, &t, &rc, false);
>
> -    temp ^=3D rcon_;
> -
> -    result =3D ((uint64_t)temp << 32) | temp;
> -
> -    return result;
> +    return t.d[0];
>  }
>
>  target_ulong HELPER(aes64im)(target_ulong rs1)
> --
> 2.39.2
>
>

