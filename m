Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D547DF2CE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyX8q-0002Us-LE; Thu, 02 Nov 2023 08:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyX8e-0002Rk-Qi
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:49:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyX8b-0001K4-LT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:49:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so1522003a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698929359; x=1699534159; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSm9DyQetVPb6jlU4cQLlkQipfYMhlWfeg15pRdgncA=;
 b=hAs29Fq9W6Sle1vyV1ujpkoSxK7rKDTSPYJP1ZKJ3sdDyLqsWwTKlsRW4h+ArWHPlJ
 A/xUTgV8cf05KU5wztldz1T83o/NwxULEkpAwjiHIfYb8+3yM9bcTht4SvEzQX42NYwC
 KliiuDqXprvibCVfWMAYANKGQgplaR8F1ljMOor6LvThLZqvVw3wx7tDTC5o5iZ4oK0V
 YIGBJe+OVamcFuT4EDxjkDFzG/0UPLW+bkCrvoNYjKCyhzHI3T6N8q30wLYBY6TXf7PI
 TjWCgW9Kb1fOUcq+12IQrtAtvCDr4I6KW9P1VbmHWgbwiHDSb10kPgY+ruV/PTe2w/6m
 poKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698929359; x=1699534159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSm9DyQetVPb6jlU4cQLlkQipfYMhlWfeg15pRdgncA=;
 b=BnxY8htSweT9SrVuvswOBE61FFFMIBgwrZP8RgXQ95bgSueVRt50HwEDgv3Udx3+J3
 eT812S7XiqXGLi17frmTQ2whsIBRAOK8LfTUoqFDYB7kInXZBJYAhcFUUD4CSHZNPzaK
 6KQAg7MyMRlsHDUpOdxAqEDrBizNhfXrMLYp9U5upi2hsD5T6PGF5mPN29XvPz/VKEpf
 zJ9aY1w0AcAM1IfB9jvaj2N/wV1YGI2Y3Y70CtENDwBQdm5u0c3aOO+uaUjDBlRT+cqS
 gGepMxElltZeHqGs606Dn53X1So+zgX13hmUb5Ze8jVNg2BjQ3H7nfcPC9oZnj7nfnIl
 ORyw==
X-Gm-Message-State: AOJu0YzMdK/DuzEJ1lkGCWebxbynVsUP0TM7MY1s1HYMMRYWK/Ay76p7
 S7tdU2QUlZpND/RtM7koxqDsBIJwQIXj+c22l+rBmw==
X-Google-Smtp-Source: AGHT+IFEypcG6iwjIW/4oayMEaOGoUdyUcrfPWUN1gEGYwy1T94/0gg5EInXECCBmiSW5HWKumxsj1i7ygNvifA2jnQ=
X-Received: by 2002:a50:8e58:0:b0:543:4fdb:de84 with SMTP id
 24-20020a508e58000000b005434fdbde84mr8761198edx.7.1698929359073; Thu, 02 Nov
 2023 05:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-10-richard.henderson@linaro.org>
In-Reply-To: <20231030211727.165090-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 12:49:07 +0000
Message-ID: <CAFEAcA-byuebJTYoHbVH2tvBffNRtwM4JvEUR8_B9iMGFkb66Q@mail.gmail.com>
Subject: Re: [PULL 09/21] linux-user: Add gen-vdso tool
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 30 Oct 2023 at 21:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This tool will be used for post-processing the linked vdso image,
> turning it into something that is easy to include into elfload.c.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi; Coverity complains about the lack of error-checking
here (CID 1523742):

> +    /*
> +     * Read the input file into a buffer.
> +     * We expect the vdso to be small, on the order of one page,
> +     * therefore we do not expect a partial read.
> +     */
> +    fseek(inf, 0, SEEK_END);
> +    total_len =3D ftell(inf);
> +    fseek(inf, 0, SEEK_SET);
> +
> +    buf =3D malloc(total_len);

We don't check for errors from fseek() or ftell(). In particular
this means that if ftell() returned -1 we pass -1 to malloc(),
which isn't valid.

> +    if (buf =3D=3D NULL) {
> +        goto perror_inf;
> +    }

This could all be sidestepped by using glib, which would give
us the higher level g_file_get_contents(), rather than spending
20 lines doing it with POSIX APIs.

thanks
-- PMM

