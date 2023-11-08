Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A107E51B2
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ddF-0007Jd-Bm; Wed, 08 Nov 2023 03:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dd8-0007JD-AY; Wed, 08 Nov 2023 03:09:42 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dd6-0007B2-TJ; Wed, 08 Nov 2023 03:09:42 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cda69486eso43665321cf.3; 
 Wed, 08 Nov 2023 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699430979; x=1700035779; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cfl2MiedisAHQs4dplmh3iddyfb9uLMnSum/VncmNcI=;
 b=TPUd3aFaxsx6oNw6aWdx4yfNZEMnID83/fOHsMtiGL/cX/YoHUW3LgzJ87x7f81IZw
 hHmFjEZaq/s+8GqYx4/yaFSKOmGsg3Arvfv+sOooYBOyUbCL+lVI6K0RBqSsE4jx9oYd
 sMCc4NQztb4meHQa/IyFFEJsutda5UJZObrwcvup7Oaui6OSn3zisXKn9nPoWvCnOsOE
 ocYalqMiZtIVkzGviw/h5R+7phFor2MzMUrMUiG42iGiE14M6UhbuSrCbnGwGKA9akph
 mYxBXxIeZODjNw6ce9tq9H/5NcYjCAqG/sOljhaHJDmcD1vZmSn6YihIHNFPXkQHzl9l
 TB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699430979; x=1700035779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cfl2MiedisAHQs4dplmh3iddyfb9uLMnSum/VncmNcI=;
 b=MOQ5uDRxAzGNbAaOKf12FDei8iY0+5nWvFVjqA4DRVNjsckfkCSiqU0MSzBaQsSfus
 Jp9dqUv6IGBAaAY0wgWiTJdngSOhwI6V+XUfke6jvTBIzWvQPcY6JZbXMInC9lDzJPiK
 sAEYXSowdZa6S5WvIh5Pn1guhB6zPWZbJ2mbkb0ufvlbUdvVwFq4tezpolcK+ryuvzo3
 15rpzhapokZpa2sNXQKYRqUKXLNtWpIzrqVRGbou9JIU+LMSKhDatlZs9O4JrwoNCBzc
 0sXvoCABb1UbohS+EY1e8ZrtANXOowLplTryhibnFE6irkCQJSpEWzJ4GAjVbh729u7K
 OiWA==
X-Gm-Message-State: AOJu0YxxUJYj8WC6yfFgLzVgVc+gQ8h4Nj79N4Ep33EG2KgbFLVke8qD
 V/BX6v17fmJEyWbEmp3bexWgSXa8oVthaDJqLCE=
X-Google-Smtp-Source: AGHT+IEohPqD3GD5mvCGa1HTKrsiQgsDjr0t6A/BxFv83WWoG+wHMzmmNOXVbeh9pb1PgZy1SYFchGGcrCdI4xFxxBU=
X-Received: by 2002:ac8:570b:0:b0:41e:2aab:8dc with SMTP id
 11-20020ac8570b000000b0041e2aab08dcmr1438032qtw.37.1699430979474; Wed, 08 Nov
 2023 00:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20231107142048.22422-1-frankja@linux.ibm.com>
 <20231107142048.22422-3-frankja@linux.ibm.com>
In-Reply-To: <20231107142048.22422-3-frankja@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2023 12:09:28 +0400
Message-ID: <CAJ+F1C+oP_dDjo5fyog+GDYVcFvG6vYE=ikdwLfNo+fYhqeRag@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/s390x/dump: Remove unneeded dump info function
 pointer init
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, 
 imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Nov 7, 2023 at 6:22=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> dump_state_prepare() now sets the fucntion pointers to NULL so we only

function

> need to touch them if we're going to use them.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

regardless if the previous patch is applied, this patch lgtm

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  target/s390x/arch_dump.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
> index 51a2116515..bdb0bfa0e7 100644
> --- a/target/s390x/arch_dump.c
> +++ b/target/s390x/arch_dump.c
> @@ -448,10 +448,6 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          info->arch_sections_add_fn =3D *arch_sections_add;
>          info->arch_sections_write_hdr_fn =3D *arch_sections_write_hdr;
>          info->arch_sections_write_fn =3D *arch_sections_write;
> -    } else {
> -        info->arch_sections_add_fn =3D NULL;
> -        info->arch_sections_write_hdr_fn =3D NULL;
> -        info->arch_sections_write_fn =3D NULL;
>      }
>      return 0;
>  }
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

