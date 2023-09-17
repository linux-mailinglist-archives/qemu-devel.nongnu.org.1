Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE37A3561
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhq9A-0005AS-M9; Sun, 17 Sep 2023 07:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq94-00059S-Jd; Sun, 17 Sep 2023 07:40:58 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq91-00058n-Um; Sun, 17 Sep 2023 07:40:57 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59c0b9ad491so21239357b3.1; 
 Sun, 17 Sep 2023 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694950853; x=1695555653; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sfy6MIBEqyNj6tJIV+fm3O82uZWQpYjF61i+9lViaA=;
 b=SNek3NYtf1vLtip4A+nzWq4x41UjDoFuhsMHzl4m5Lm3lw+nYAKnQGLe23IUE8vhnd
 n9p39YXCzly8CxwexP+M+3bobNDXKwXOpcSO8w7KboUWErRRGZDHeZeM9g+J/CGoMleF
 mUtShBD9IAnfiOJjUIVoYcCUAEUViYsRMWrT1Pcq2nnbR9fHj7pvE7dUkyQiG0GsT896
 09wEv62Wyk31CvCUInbTyGNGSNisFABO4TR2LkIbLHHJHJ8h4Et0cWGJpJs8qQ4GqlZ3
 T2p7Tus1if10MiOJbDaQAeF3xc93kEC2LtRgCp91p4+t5S8hh+sDlAEGu4NzPhPxmz8h
 /Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694950853; x=1695555653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sfy6MIBEqyNj6tJIV+fm3O82uZWQpYjF61i+9lViaA=;
 b=Vle3nYPh4X7k2SrXnGifH6bdOT/xISentEa06Rm2AszGLee7xyYpUsOEOblS0LQs4z
 2YcyPlBL7AwC4JaJUsMtYwNSnScbcn5GEVIp4uz8ekcXOYyGDDa4vs35ohZOZLtD3unH
 Uc9RRgIq6f4kdYXUdA0xEM3JW6+chibA12n4EdCc0kvLcjF73UjhLeU7aixwKpjjh8QG
 cCYaT4ePNh2dLmTzP0m+CBWedNOE9uCqjte/zq12BhCt8ezRSz42OVAq5yjJ0EAgj/8P
 qr8lUZJVogqaUibScb/BRcTP/sAoUsSelZ5YDietI/sYMP5s7RkTAQEixxNxDEOEVDAK
 qCtw==
X-Gm-Message-State: AOJu0YwVjd3O09xlCha0j6Ufn/3ireJg+j10a90TMBFFDbFEy9/Do/P6
 HKUtuSIkjm2B2K2ljo5/ZhaVsNVSTIMM1TSTJE0JFe+E8lkp9Q==
X-Google-Smtp-Source: AGHT+IHWVoJiDhSnWxoJTZiyZwF9umPiuSNWfek+aCPZH3l+ykaq5f0y7s+Eh1bxsjvUtg9imeVSCi86kSJzPJWp9bw=
X-Received: by 2002:a0d:fa42:0:b0:589:f9f0:2e8c with SMTP id
 k63-20020a0dfa42000000b00589f9f02e8cmr6231089ywf.48.1694950853406; Sun, 17
 Sep 2023 04:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-8-den@openvz.org>
In-Reply-To: <20230915184130.403366-8-den@openvz.org>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sun, 17 Sep 2023 14:40:17 +0300
Message-ID: <CAL77WPB7nRaWzzkQDqOJCQLpvWYd-=RpBiFn2Roi5wKzZONPFQ@mail.gmail.com>
Subject: Re: [PATCH 06/21] parallels: refactor path when we need to re-check
 image in parallels_open
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 alexander.ivanov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x1132.google.com
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

This patch generates a warning.

On Fri, Sep 15, 2023 at 9:41=E2=80=AFPM Denis V. Lunev <den@openvz.org> wro=
te:
>
> More conditions follows thus the check should be more scalable.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8f223bfd89..aa29df9f77 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1065,7 +1065,7 @@ static int parallels_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>      int ret, size, i;
>      int64_t file_nb_sectors, sector;
>      uint32_t data_start;
> -    bool data_off_is_correct;
> +    bool need_check =3D false;
>
>      ret =3D parallels_opts_prealloc(bs, options, errp);
>      if (ret < 0) {
> @@ -1133,11 +1133,12 @@ static int parallels_open(BlockDriverState *bs, Q=
Dict *options, int flags,
>      s->bat_bitmap =3D (uint32_t *)(s->header + 1);
>
>      if (le32_to_cpu(ph.inuse) =3D=3D HEADER_INUSE_MAGIC) {
> -        s->header_unclean =3D true;
> +        need_check =3D s->header_unclean =3D true;
>      }
>
> -    data_off_is_correct =3D parallels_test_data_off(s, file_nb_sectors,
> -                                                  &data_start);
> +    need_check =3D need_check ||
> +                 !parallels_test_data_off(s, file_nb_sectors, &data_star=
t);
> +

../block/parallels.c:1139:18: warning: variable 'data_start' is used
uninitialized whenever '||' condition is true
[-Wsometimes-uninitialized]
    need_check =3D need_check ||
                 ^~~~~~~~~~
../block/parallels.c:1142:21: note: uninitialized use occurs here
    s->data_start =3D data_start;
                    ^~~~~~~~~~
../block/parallels.c:1139:18: note: remove the '||' if its condition
is always false
    need_check =3D need_check ||
                 ^~~~~~~~~~~~~
../block/parallels.c:1067:24: note: initialize the variable
'data_start' to silence this warning
    uint32_t data_start;
                       ^
                        =3D 0
1 warning generated.


Regards,
Mike.

