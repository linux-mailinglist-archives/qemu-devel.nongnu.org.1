Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F977396C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 11:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTJGv-0005ZU-HD; Tue, 08 Aug 2023 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTJGt-0005Z8-0q
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:44:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTJGr-0002AY-E7
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:44:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-317715ec496so4708323f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691487895; x=1692092695;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOZwEDu8FuDrk8M32FsPkIJ432bf8goqtyXqbXhmkbg=;
 b=hnuSmsx2GtD/2gkz92JDzlbWuRJZQ4rpEcMhuqVfAmJfFuDmZ3m22NFt6YlCfxNhzd
 mqF6pHCJSsfwW/p6VnTir2tfqHTZY5xpKpaUibdka0qWZ82r0Lyk7f7NqE/sAgdtd09p
 tq7yqH+R4RGxQVm6NkTLwTwlGD8HIb0tWp03VHS7xC3t95p2LQg+Q3iOkdAj3iKYBfkA
 v0xeKDCFLVUGTTscnlcvSk3vK6xBbl+Arn69iklxIv5p8yjvW1WImrOnE7+RaiYYXkHz
 jB5Zm52JJInLWxsWTHlWtKkd9YDHvjwSODW8Zb0CnAdUwbuBdgTf1r5ATLJDdlVhfzbW
 tVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691487895; x=1692092695;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UOZwEDu8FuDrk8M32FsPkIJ432bf8goqtyXqbXhmkbg=;
 b=TKygUtcpUCy3lKoBfZz4DeVmib70+8Rpw1mKZ98YrY6qm2Qzxx15KzzB2h1Ad+PZc/
 KhK8mAsPzXl4MpHKykuV8Wi39Z4e7ArGboABixOJP5WAhXjPqYmlQWJqGYeJZ5YroHk6
 9J4cTBzmlONmQPxgTCi/JGMvZb+vLJE9YzwwjhrYiP0eA01LApm1IvQBreNhr9kg6Niz
 n6dXkxTdvtmW2qX+nJb7B6amI+xHVJflckvoHMaBOnSZPjaHq+7cn2lFiNzHtnQptQ8A
 9VDh8hM3t/frJpyeof2uIeNSEMOfUFEzzrAm8rYpDjAcQmegqmpZ4xPWwKvlME1ECpFC
 unaA==
X-Gm-Message-State: AOJu0Yw/gmn4RLxU76aImbZpR0ZvOhThFsAWF8GUfPSbC1/co/IdUID2
 Z0p+hVI9b2j5WnUwqsJYIPV/Bg==
X-Google-Smtp-Source: AGHT+IHfdBpD0TmFpzVLPvHii15Ffxeg9DGXbFzm/jnLkNaipViv0QV5b3Zf8hEWWIrjDHHxVof2kQ==
X-Received: by 2002:a5d:410e:0:b0:313:e8b6:1699 with SMTP id
 l14-20020a5d410e000000b00313e8b61699mr9168367wrp.55.1691487895209; 
 Tue, 08 Aug 2023 02:44:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a5d490a000000b00317ab75748bsm13086921wrq.49.2023.08.08.02.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 02:44:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D59C1FFBB;
 Tue,  8 Aug 2023 10:44:54 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE
 for initial image mmap
Date: Tue, 08 Aug 2023 10:43:09 +0100
In-reply-to: <20230807163705.9848-5-richard.henderson@linaro.org>
Message-ID: <87o7jh98bt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Use this as extra protection for the guest mapping over
> any qemu host mappings.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 36e4026f05..1b4bb2d5af 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
>      /*
>       * Reserve address space for all of this.
>       *
> -     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
> -     * exactly the address range that is required.
> +     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we =
get
> +     * exactly the address range that is required.  Without reserved_va,
> +     * the guest address space is not isolated.  We have attempted to av=
oid
> +     * conflict with the host program itself via probe_guest_base, but u=
sing
> +     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
>       *
>       * Otherwise this is ET_DYN, and we are searching for a location
>       * that can hold the memory space required.  If the image is
> @@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_name, =
int image_fd,
>       */
>      load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_=
NONE,
>                              MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
> -                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED : 0=
),
> +                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED_NOR=
EPLACE : 0),
>                              -1, 0);

We should probably also check the result =3D=3D load_addr for the places
where MAP_FIXED_NOREPLACE isn't supported as we have this in osdep.h:

  #ifndef MAP_FIXED_NOREPLACE
  #define MAP_FIXED_NOREPLACE 0
  #endif

See 2667e069e7 (linux-user: don't use MAP_FIXED in pgd_find_hole_fallback)

>      if (load_addr =3D=3D -1) {
>          goto exit_mmap;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

