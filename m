Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DD7D3855
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvEd-000264-Dx; Mon, 23 Oct 2023 09:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvEb-00025p-AV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:44:45 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvEZ-0007ZF-RR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:44:45 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c16757987fso48082291fa.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698068682; x=1698673482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4G1RPZ0ootCbObgKqBn1VHNOLJlCm1a4OFgfZNvNiw=;
 b=h6F0QQhiN3yP2p0y2LG5LvxmyUN1Ue/vG/y4KYi71ArJQ9+uMwo3X52YCJ5meG76AS
 wgJof+SGH/T3x+/YyRaCleNbB+7FV2sdlJtF3ErKsnIH50xwaJSULZRAQwkUcnoLpeH+
 cs0DM9LHxS0qvQ7AYPm63zYvkBExrZZwyM5pm1zJgBz+TCbrrffhYVEJI+GdYQAWAe5L
 6l1GI9ROgin4XW5NDIOEZybCxfeiyAQMR7mcZ8GybnMEANc4h2neaYfQgZqdA8MzVjGb
 pm86jwfxgnfravKqH6ZVW6MqswOa8UTB30mDkMS3RolfMBAypS3TshrIOtYZ1Jv2fhmg
 xiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068682; x=1698673482;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K4G1RPZ0ootCbObgKqBn1VHNOLJlCm1a4OFgfZNvNiw=;
 b=YCv+E/AmlV5/oXHeYj6aDd14doxiB9GSJPQwq8fExVoaCg49MeoDOJj4aE2yeTfj8F
 XHCHqBmAb5R57RwdOXFQ8SCMgxAuGqB8qRLvUQaNHeBfPM4w1C42UgB3ge15gTxzRhDk
 8TnFs6m3tkECjULjDbliUkJ1K0dmyhyK9N+13oWRGxuX/uIXFCCtxJc5vD0DdgYcdtE3
 uMXgr33uRhsOz+qGSyFcA3FEZGMbH/xoHvkgbwFwWgEmnBfRUhxFn1PkgWmy66io5fuh
 CM5v17mg2HTzxFOBv10L5ybK5SmzPSSKPkRQn759UyV9zGVQu28PB6vmwNoDW6hRnFXP
 ubQw==
X-Gm-Message-State: AOJu0Yx4azthKTZfK9VsL0lV5OxyfDxb79tViBoyzWLpQpsCdjyqiDZq
 2gDRASSE83oN9+4rneTXxLzcrzUjGhfseViI3vc=
X-Google-Smtp-Source: AGHT+IEuoOOJKW48BFxyHElwtJXNUOwXzejPg7NqK2rRLToM6WUrrhWE3lgVv5SR+QoBrYysLZAMfQ==
X-Received: by 2002:a2e:9a89:0:b0:2bc:b821:84ad with SMTP id
 p9-20020a2e9a89000000b002bcb82184admr5155434lji.16.1698068682018; 
 Mon, 23 Oct 2023 06:44:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c05ca00b004083729fc14sm14018619wmd.20.2023.10.23.06.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:44:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 261C31FFBB;
 Mon, 23 Oct 2023 14:44:41 +0100 (BST)
References: <20231016093143.222551-1-liucong2@kylinos.cn>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cong Liu <liucong2@kylinos.cn>
Cc: Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] contrib/plugins: Close file descriptor on connect failure
Date: Mon, 23 Oct 2023 14:44:36 +0100
In-reply-to: <20231016093143.222551-1-liucong2@kylinos.cn>
Message-ID: <87r0ll4fna.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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


Cong Liu <liucong2@kylinos.cn> writes:

> This patch closes the file descriptor fd on connect failure to avoid
> resource leak.
>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  contrib/plugins/lockstep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index f0cb8792c6fa..3c0f2b485181 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -303,6 +303,7 @@ static bool connect_socket(const char *path)
>      sockaddr.sun_family =3D AF_UNIX;
>      if (g_strlcpy(sockaddr.sun_path, path, pathlen) >=3D pathlen) {
>          perror("bad path");
> +        close(fd);
>          return false;
>      }

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

