Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0387824FC
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzos-00053S-9b; Mon, 21 Aug 2023 03:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qXzol-00052w-67
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:59:20 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qXzoi-0003Nu-W2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:59:18 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-76d93cf8e13so181106085a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692604756; x=1693209556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GK8ZAAmo6Qu+cR/x9t1Aizb6kW9bSve+mWpXMwMwguE=;
 b=QLTwi1y+E7tnKWvPeWJ9PEFSUzlqJp5JDx7lo0c0I6g8bMnPrQT4/Z+bzyVmvUSAQc
 DWUxnML7aetC9W5U4NQfYwZ7dSiJnnVc1KYNYzxYlQ1hvapCleKk8A40It+ecFtIyNhu
 JZyA0x/FM6mIP5oxVxhvalF8Ll77FHs53B6Z4O6PGSJK2Ejh+TVcpeb/8ndimaRLcvQn
 NOqxo7L1roOkLWDJC7I345U1bE5rHZeg8YYqwD+6T8MYxl7RJyJWiInm/HNoiOxUBC+p
 w4DKQP7dvA9hkMhxYuGr4gja8TsxDWDUq5xwzI09XyTcgDFuqf/CTeiaDOhogxEUMXrC
 EkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604756; x=1693209556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK8ZAAmo6Qu+cR/x9t1Aizb6kW9bSve+mWpXMwMwguE=;
 b=i4yAbGDegjrwTQ3nhOHSNhYdvXDARk0fWyQAYgAWEu8EmZr1FSa9z45VKZ2hv0P3KJ
 /aX/zAFyCZc4IfPi+4cyrRhYMCU23mrRD2iNYzzpZTNNyElCvDxkVHH/pGqx/xwCG7rz
 JN6mh0vYFSZ1bF7PBDMVIlWvBBrxmkgLXfP8pPMJvXqU/LT50v/fUw+AvErTw0+xP/X5
 yVy/YV+lHyqPimrux9413dAIE2g470DCgHCs+xEZPlT6aWx9U5sSgMcSPlHatl16ybQa
 Oifcr+XSbljMBXXxpqdf8bKcNe2txl3xJ2gXxDt/mz5VhF9F9i/Jvzmuhoxyz24urmbC
 k/jA==
X-Gm-Message-State: AOJu0YzSC/rIx66NaOTEO4rYfcMAM4oj+qdmf7EKWfmMJpRLvX9RIWhy
 lCilcjmXjInHtjpyDzN6QzGagX5Nxnms4NAhN+g=
X-Google-Smtp-Source: AGHT+IFLXdRwYmZs+cGI+cKOCWyZAGn2exvQPK0v3L5yuo2DPZhAP3dlRGlI362n59xOP7cDvAzMPoRg0ATIFkp17Ic=
X-Received: by 2002:a05:622a:c7:b0:410:9111:4a0b with SMTP id
 p7-20020a05622a00c700b0041091114a0bmr6847140qtw.13.1692604755779; Mon, 21 Aug
 2023 00:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
 <20230818151057.1541189-3-peter.maydell@linaro.org>
In-Reply-To: <20230818151057.1541189-3-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Aug 2023 11:59:04 +0400
Message-ID: <CAJ+F1CJ7f-im=McBqrHP=TDWhAoSQV4Sg7h2YXBxcAL9J-TRHg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ui/vnc-enc-hextile: Use static rather than dynamic
 length stack array
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72f.google.com
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

Hi

On Fri, Aug 18, 2023 at 7:11=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In the send_hextile_tile_* function we create a variable length array
> data[].  In fact we know that the client_pf.bytes_per_pixel is at
> most 4 (enforced by set_pixel_format()), so we can make the array a
> compile-time fixed length of 1536 bytes.
>
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  ui/vnc-enc-hextile-template.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vnc-enc-hextile-template.h b/ui/vnc-enc-hextile-template.=
h
> index 0c56262afff..283c0eaefaf 100644
> --- a/ui/vnc-enc-hextile-template.h
> +++ b/ui/vnc-enc-hextile-template.h
> @@ -7,6 +7,8 @@
>  #define NAME BPP
>  #endif
>
> +#define MAX_CLIENT_BPP 4
> +

BPP is more often used to mean bits per pixel. Do you mind renaming
MAX_BYTES_PER_PIXEL ?


>  static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
>                                               int x, int y, int w, int h,
>                                               void *last_bg_,
> @@ -25,10 +27,13 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState=
 *vs,
>      int bg_count =3D 0;
>      int fg_count =3D 0;
>      int flags =3D 0;
> -    uint8_t data[(vs->client_pf.bytes_per_pixel + 2) * 16 * 16];
> +    uint8_t data[(MAX_CLIENT_BPP + 2) * 16 * 16];
>      int n_data =3D 0;
>      int n_subtiles =3D 0;
>
> +    /* Enforced by set_pixel_format() */
> +    assert(vs->client_pf.bytes_per_pixel <=3D MAX_CLIENT_BPP);
> +
>      for (j =3D 0; j < h; j++) {
>          for (i =3D 0; i < w; i++) {
>              switch (n_colors) {
> @@ -205,6 +210,7 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState=
 *vs,
>      }
>  }
>
> +#undef MAX_CLIENT_BPP
>  #undef NAME
>  #undef pixel_t
>  #undef CONCAT_I
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

