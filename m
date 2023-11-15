Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A47EBD00
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 07:20:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r39F4-0003h3-1o; Wed, 15 Nov 2023 01:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r39F2-0003gR-4t
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r39F0-0007Zc-No
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700029148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o3aqznT+Kh7VljLpwAJ0RkHajkEkRRhvSPe7DX2m2g=;
 b=JsofFtY7wmf4adB9Y76+n7Yg7H2Q2388ar4bVhY1tnVxRvDrz6m4DgK3NIovXZbYneB9ls
 UryEzl8iuwfVXJeBFHEvLcs50M3lF8H7Ei3Ffdjhm/LfIP3oQE4G/vj5tVkB/uMtQeBcXs
 OAiTfRuDbN1Bzecsc2YGJ/YH4UKpytM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-bIiZStlMNqai05exjhQIPw-1; Wed, 15 Nov 2023 01:19:06 -0500
X-MC-Unique: bIiZStlMNqai05exjhQIPw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-54554ea191bso4456316a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 22:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700029145; x=1700633945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+o3aqznT+Kh7VljLpwAJ0RkHajkEkRRhvSPe7DX2m2g=;
 b=FGUXekUmP2KSxuKEBvn1YnzaGcgKQkmSP6GBLh0plY/xdSNlnhSU2ap22RC/zOccda
 p79cstbjuTu5W0BjCg1tRhq9+AgGsExoizm/7Mt5LUI7p69XyJDtfBF/y106OTTeKILM
 p//I65fC52YEixr4wQaEqtV7e6unNZobnvXga6kScfTEuiZI9CNf3taukMIQj3reTHPZ
 n32gu6Q2xnnJWxpw/baYkTHry3PnWqZcCs5Pjzk+b9rykIN6bCzI+x2HzUXqxM2Psyet
 PmvBf2q9VabPhlIiBo25/8o8NSr8SibUX7hv47ZjZuntjdUUSEmQI0PVx3naiZdzoKYx
 K3YA==
X-Gm-Message-State: AOJu0Yx5TvR2isxvsU+q1PFKO49SON3QEwRTNzVicXyzjPCv+VmOGOWo
 S5FXvrdxH0VTNRE0UNozD/8ac5UaIvN8xVyRbH4jdXCnDmhcvgFunUpYskN6dhGmtfy5DUmoeJa
 Yoh7uNmLh0yW05UorlRvU58duu3YDKeE=
X-Received: by 2002:a50:e709:0:b0:544:a153:cd19 with SMTP id
 a9-20020a50e709000000b00544a153cd19mr7731975edn.41.1700029145854; 
 Tue, 14 Nov 2023 22:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb8KONTAVXxphS/pU2eK7HbpNh4Q8kCfvmb2Gy0JR1iQ3DoA+NYPS+GjXZZQ31ai7/WGgMVa+hr67MO5Rk3pE=
X-Received: by 2002:a50:e709:0:b0:544:a153:cd19 with SMTP id
 a9-20020a50e709000000b00544a153cd19mr7731965edn.41.1700029145566; Tue, 14 Nov
 2023 22:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-12-mjt@tls.msk.ru>
In-Reply-To: <20231114165834.2949011-12-mjt@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Nov 2023 10:18:53 +0400
Message-ID: <CAMxuvax5gv5zSRHf9vw_j7=q0Sx+VuHrX=nCJMrUNsocKCoH_g@mail.gmail.com>
Subject: Re: [PATCH trivial 11/21] contrib/vhost-user-gpu/virgl.c: spelling
 fix: mesage
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Erico Nunes <ernunes@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 14, 2023 at 8:58=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> Fixes: e3c82fe04f31 "contrib/vhost-user-gpu: add support for sending dmab=
uf modifiers"
> Cc: Erico Nunes <ernunes@redhat.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/vhost-user-gpu/virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virg=
l.c
> index 1da6cc1588..d1ccdf7d06 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -401,7 +401,7 @@ virgl_cmd_set_scanout(VuGpu *g,
>
>          if (g->use_modifiers) {
>              /*
> -             * The mesage uses all the fields set in dmabuf_scanout plus
> +             * The message uses all the fields set in dmabuf_scanout plu=
s
>               * modifiers which is appended after VhostUserGpuDMABUFScano=
ut.
>               */
>              msg.request =3D VHOST_USER_GPU_DMABUF_SCANOUT2;
> --
> 2.39.2
>


