Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC081CF1E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 21:04:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGljw-0007HC-5T; Fri, 22 Dec 2023 15:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rGljt-0007Gh-5q; Fri, 22 Dec 2023 15:03:21 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rGljr-0004uR-Kg; Fri, 22 Dec 2023 15:03:20 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-427a3887483so8941771cf.3; 
 Fri, 22 Dec 2023 12:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703275397; x=1703880197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfU3OhCWGUW9nJjt2MDsvecwAM8b9doej3QD7bRJIaM=;
 b=UxnOcJbU3NkR3FJnRllFxmx7FXQQBKkaf9Z89vD79U6NNpZHpoRItvQplcipP4cuAR
 A2tEwZ49BO0uavhspMfighdHIBxLziC+MTTauKT2Cu/4xlKvWhOEo/gJJZyoQYcKf+3C
 FyCXWR+C/FCKopjS5ns6Y9FqRQXghLDUVcvm/9eo+9/8/BHh8MoMHez4qRuwe9PQlOEO
 MBrTCuLP2ENUqpzMrzbYOjHusfyPw5Qu8NFIRKbuE+EAPYtQ3SmbZnqKok8phhAzZnbe
 BEp7d+8rOJPxyJ+RDxjbyCTLolq3b4+JPLQn1h8nG6m3lbBogV+8+rM7BTu2N+16PDHU
 rfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703275397; x=1703880197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfU3OhCWGUW9nJjt2MDsvecwAM8b9doej3QD7bRJIaM=;
 b=uK82xG6OMrnD/lRrbTeNFwzTtMvl+h2q1A5UEHpc5k8jzIc84jruvVM2fGie3T/VT7
 Ubg2aG2ibYwjBhkqX49UBAmn6svGPxA/7bwS3Hibcn9iRsT3SsBbYSXaEpeJowRkSUB1
 Pu5ymqTR2mDEdS3c8RDCdbsgH0hD7sluUptGGV0g/hk23/q2V+trp4WPBxlEkkqHMTxR
 xiDn/bSSBwe3SrjQTG0NfQds2r8d04LW2WRiot8w2oYDjfduHT3rbaU/UuV1O0wY1RPB
 rT/gB/3tKeDFnLRJdxhfjVbCF72LPR5f/fq0Y87wZiOzGqpd7C82mQZWL5/iZ2VTp9mY
 P3Ow==
X-Gm-Message-State: AOJu0Yxics/ooY3bjCbS/E9hFkdPFPYPxKmi2vqtxMT1HO3xdw5eqPiI
 6vLCtWQKjPap8Nml4MhENxC5qvL+xQKhWOltFsA=
X-Google-Smtp-Source: AGHT+IFLcGEUyx+UMG4Al2HSZCGSW7CVTegxlKc7clszPir7AbGTJ7ISiMphv9sHUDTspdvwgMShsT9Q3HNaGJ6bhIY=
X-Received: by 2002:ac8:5a86:0:b0:425:9936:b092 with SMTP id
 c6-20020ac85a86000000b004259936b092mr2808234qtc.53.1703275397456; Fri, 22 Dec
 2023 12:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20231222191721.414176-1-mjt@tls.msk.ru>
In-Reply-To: <20231222191721.414176-1-mjt@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 23 Dec 2023 00:03:05 +0400
Message-ID: <CAJ+F1CJ1-VWBdha4U9LpYz+uJh2JouCAs+DLW2UWHpuMSQB_2A@mail.gmail.com>
Subject: Re: [PATCH] include/ui/rect.h: fix qemu_rect_init() mis-assignment
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Elen Avan <elen.avan@bk.ru>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Fri, Dec 22, 2023 at 11:18=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> From: Elen Avan <elen.avan@bk.ru>
> Signed-off-by: Elen Avan <elen.avan@bk.ru>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2051
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2050
> Fixes: a200d53b1fde "virtio-gpu: replace PIXMAN for region/rect test"
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

brown paper bag face...
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  include/ui/rect.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> (Re-sending this as a more accurate patch which actually can be applied)
> Stefan: please apply it directly as an obvious bugfix
>
> diff --git a/include/ui/rect.h b/include/ui/rect.h
> index 94898f92d0..68f05d78a8 100644
> --- a/include/ui/rect.h
> +++ b/include/ui/rect.h
> @@ -19,7 +19,7 @@ static inline void qemu_rect_init(QemuRect *rect,
>                                    uint16_t width, uint16_t height)
>  {
>      rect->x =3D x;
> -    rect->y =3D x;
> +    rect->y =3D y;
>      rect->width =3D width;
>      rect->height =3D height;
>  }
> --
> 2.39.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

