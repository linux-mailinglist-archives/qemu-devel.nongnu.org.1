Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E37F475D
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:08:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mw9-00053R-Fj; Wed, 22 Nov 2023 08:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5mw5-00052u-5i; Wed, 22 Nov 2023 08:06:33 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5mvv-0000jP-O8; Wed, 22 Nov 2023 08:06:32 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41feb963f60so6771621cf.1; 
 Wed, 22 Nov 2023 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700658381; x=1701263181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0e8eyeDKzMr1AJigHJ/kdGeY84rMGbwMKHAqhjqu9A=;
 b=F5Y7XSBJIwSkGXuQmdG6nHAnm7zzXUmz31gqH6O/cGi8pWGQNeMPWY2SrwzNBv4ySZ
 TSiK4S04uuSxzoF0G/OXILHEERS6qgpeON9nz3Wfa6nRFWMcKVWVW6iVg8XSdru4LmYj
 r8k3lVI6snPzcyKLWsNy7++PZfpusW995zfcjRP8WHxIoUxPk6Nhka8d0p6phxK7PkA3
 fAU1r7c/0EGABWJaVouPYQnIAZB8oPUJFcXkD/6XOp2LRh7V3l1Jmrl7m45hgVuVq5d+
 z3lwJFgGqAWIzCdti7E9X2i6Rm2mNFXZA1C8yR8ZnWhhee1iuTiZlZis74v2d7uCHW0e
 zFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658381; x=1701263181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0e8eyeDKzMr1AJigHJ/kdGeY84rMGbwMKHAqhjqu9A=;
 b=xRBN8AlQn4avI2+ZIVQzsqIcZFzDDPW/4AVg7aM1zJf398iy2VCVLhsB0XWEExy4Fl
 QHpGA0+dWo6dla/esiA3Sswp+zkHQeiRACT3mNHH85ssx2RxYMIp8Cf556jLqM0sJBW8
 LL5Qo+3P1Zn14JhkbYVNCOptYAG8xC/pz/DO0iYpkpXnACHCii9ZFVF8IlUFYHs2c6mk
 HsUfpcVX1EhV4WtUx7jF5XkbzV0MTr2zB/QAuRbrjHEFzK6NmAoSiE8oolUUexEtyzwj
 l1wigNhDOGwfEH0ufFtH39tO4ZnINiNiSYOZZfKd44lPgzLi//giZvOMQ8B/arg3iBmO
 2iRA==
X-Gm-Message-State: AOJu0YxV8BZ4FZz/Cu6EmpMDwFs0lhuZdWfKgZAjrunJ8R7zg1MAzyBU
 dZxlHddsAcXwLyQQzCMkjIVsG4j+zW6mZxfi+7Y=
X-Google-Smtp-Source: AGHT+IEU2zi4PyElEP/pDbiTpKUjIdA+NmtQBFJYw5bYgN2bLEH5GEjrTC4UxZhSEGg+c49bn8WnX4kvrDZWtYapFT4=
X-Received: by 2002:a05:622a:15c2:b0:417:af0a:70a0 with SMTP id
 d2-20020a05622a15c200b00417af0a70a0mr9378665qty.14.1700658381588; Wed, 22 Nov
 2023 05:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20231122125826.228189-1-f.ebner@proxmox.com>
In-Reply-To: <20231122125826.228189-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Nov 2023 17:06:10 +0400
Message-ID: <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, 
 mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 22, 2023 at 5:00=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
> inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
> required, because it can happen that stream.avail_in becomes zero
> before coming across a return value of Z_STREAM_END in the loop.

Isn't this an error from the client side then?

>
> This fixes the host->guest direction of the clipboard with noVNC and
> TigerVNC as clients.
>
> Fixes: d921fea338 ("ui/vnc-clipboard: fix infinite loop in inflate_buffer=
 (CVE-2023-3255)")
> Reported-by: Friedrich Weber <f.weber@proxmox.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  ui/vnc-clipboard.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> index c759be3438..124b6fbd9c 100644
> --- a/ui/vnc-clipboard.c
> +++ b/ui/vnc-clipboard.c
> @@ -69,6 +69,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t i=
n_len, uint32_t *size)
>          }
>      }
>
> +    *size =3D stream.total_out;
> +    inflateEnd(&stream);
> +
> +    return out;
> +
>  err_end:
>      inflateEnd(&stream);
>  err:
> --
> 2.39.2
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

