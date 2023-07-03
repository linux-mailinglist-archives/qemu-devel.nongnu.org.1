Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2474596D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGHi-0007vl-57; Mon, 03 Jul 2023 05:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGGHa-0007v6-Fh
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:55:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGGHX-00040P-R5
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:55:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3142860734aso1784370f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378142; x=1690970142;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALiKFl34QkCz7Npw8R/TtgqXSoNQEa7uED4rrPX+4/Q=;
 b=ZvDR6NCbwGKbfd6iABCxhdpioMmJA1YaUTjSELSfm/v7hwmhxBNSG2NyMmpLXr4r24
 Eozg98st3D4AAo5ORybC3+xwYKMUDta61VttX+4A5vCJ5yqUNquaNHF1M0fQOdsIZfKW
 OHQ5xjmQppER5v8EFCIbomc4Fh3BfclSJPeKkpDP/dfkpPzQOkaoi2IZsuFHLUIPyGM+
 5fjB0noeGLCMpuaeyO7y6LWbaQIMvGvBxYXJ8rkOqod/Pr4UNIPl+k5WVwI8ZOs15Nnu
 pHOibI8SUb8SOyhAufijF5jMcCFPrRkbalz1P/4VA2gRDlzXj+kGYKltX+mTvAx3twxm
 daZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378142; x=1690970142;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ALiKFl34QkCz7Npw8R/TtgqXSoNQEa7uED4rrPX+4/Q=;
 b=jomKcY4zna71XZnyWocSe4JOUSytYCftJ7n+1CRZ0Y3LcChJCND4ob4VwGTEVe0fXs
 sZYDYTM8pO6gOyLWGID+h7S+b7+jbR0mPZg9vbpCvWsOO0Lcp3JpOWITG4ihiT5laOtx
 SF9FuQOTqluKXYWyCAa6fwPUbRF9LW3WESY402zueA8X+3McFu9MGeeQWzZju6N45yTP
 mDCJ4BYwDtKv74d/y7+2bmsFCzaVubRfiKwGzPyu+fJ/3Q4RLNHAxP+xNy1BlmWvbjuG
 UFEtaicdY8XBrUzNSOV7d/rXw/NznYxvzlBcUCZgcrGM4bOfYmbvhd4hvHVeU79jLUHm
 IxkA==
X-Gm-Message-State: ABy/qLZA/7DA0QQtF/DThb/B8W5fWlf44On0jNVSfo3HN91HSHstgQqF
 XYN29RDntILlXGBd8U/VEt4JQw==
X-Google-Smtp-Source: APBJJlFrwPLuicfmis9azksI6s7h8CeKUWoP56JzGmYDOKuDY8hlKnPyEX61zEw+reykZyBe2xPERA==
X-Received: by 2002:a5d:66c8:0:b0:314:1096:6437 with SMTP id
 k8-20020a5d66c8000000b0031410966437mr9200729wrw.19.1688378141974; 
 Mon, 03 Jul 2023 02:55:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a5d5682000000b00313ec7dd652sm22226287wrv.44.2023.07.03.02.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:55:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37DB41FFBB;
 Mon,  3 Jul 2023 10:55:41 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-10-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 09/24] linux-user: Implement MAP_FIXED_NOREPLACE
Date: Mon, 03 Jul 2023 10:51:51 +0100
In-reply-to: <20230630132159.376995-10-richard.henderson@linaro.org>
Message-ID: <87y1jxiajm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index cb5369d2d1..41c2f09fd5 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -502,7 +502,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int target_prot,
>       * If the user is asking for the kernel to find a location, do that
>       * before we truncate the length for mapping files below.
>       */
> -    if (!(flags & MAP_FIXED)) {
> +    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>          host_len =3D len + offset - host_offset;
>          host_len =3D HOST_PAGE_ALIGN(host_len);
>          start =3D mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
> @@ -544,7 +544,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int target_prot,
>          }
>      }
>=20=20
> -    if (!(flags & MAP_FIXED)) {
> +    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>          unsigned long host_start;
>          void *p;
>=20=20
> @@ -593,6 +593,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
 int target_prot,
>              goto fail;
>          }
>=20=20
> +        /* Validate that the chosen range is empty. */
> +        if ((flags & MAP_FIXED_NOREPLACE)
> +            && !page_check_range_empty(start, end - 1)) {
> +            errno =3D EEXIST;
> +            goto fail;
> +        }
> +
>          /*
>           * worst case: we cannot map the file because the offset is not
>           * aligned, so we read it
> @@ -608,7 +615,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int target_prot,
>                  goto fail;
>              }
>              retaddr =3D target_mmap(start, len, target_prot | PROT_WRITE,
> -                                  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOU=
S,
> +                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPL=
ACE))
> +                                  | MAP_PRIVATE | MAP_ANONYMOUS,

I thought we always MAP_FIXED because we've already jumped the hoops to
work out where in the memory space this allocation is going. Now if the
guest doesn't specify MAP_FIXED the kernel might decide to put the
memory somewhere else, potentially out of reach of the guest addressing?

IOW I thought the MAP_FIXED here was an internal QEMU implementation
details rather than reflecting the guests wishes.

>                                    -1, 0);
>              if (retaddr =3D=3D -1) {
>                  goto fail;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

