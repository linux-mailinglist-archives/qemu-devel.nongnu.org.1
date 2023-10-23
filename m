Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0087D3859
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:45:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvFT-0002pd-So; Mon, 23 Oct 2023 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvFR-0002nx-Qz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:45:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvFP-0007zc-Sw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:45:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40859c466efso15120715e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698068734; x=1698673534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB/hSairAROdsYSIE9h0e20JDDZV+g1mKPdOgxCBsFw=;
 b=BJLzdSTIGm3wE9HmHEqreW8cWn1TnZMzGaljN5po5oYTBOq74LUzvBcysIFSulJQCb
 M1pP9jXF6XX6tv+ZgE+4E7GxsC4GQhwS15re9IHOkEJ7/GDtEzhzKsAmv+619eC17rXz
 s9mlf++uG0iEVR5tjAqFruiqAJtCrHg6/KOr0JsXwfi56OK3KWflzs9QLEUgdssrAxT+
 Tg5OR6a15J76vQJW9/NZ12d8Yebv04rrC1H+yiHkjpjHd5C97GjZ9yfgM6imEcNRE7UM
 f1Ez60bnUHyen24bdshWF78qfjpF288btqQvU3h4jVBiyHOJQXQBl9sAKMcISfEmzyMp
 cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068734; x=1698673534;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CB/hSairAROdsYSIE9h0e20JDDZV+g1mKPdOgxCBsFw=;
 b=DsKO30nYjRi9zLvdZsMrZLXFRlRe/Hk1HA6Mg31qWHH1pgOy4uJ3lrxu7Tn6CXDwJo
 2M8FOQDRWAzhGu44hZJcgp/PKtF94C/agW9xzPTvsCyEVdktdbsIqZLjyTrP/OXjhgfC
 4p8K/uHNg1ez8Gd+JSbkLkc6s5X4P8cxkFqmgqS3U3E6ozGk+TVKkZ5I6ASy1BWBKyDW
 Ln1CSO8rjgj970La7Gu4JZnaZaKIutFNNcaONV5yUeibX2yt76qwOFdSrYR2bU73ZtQF
 B5VSnm/oCSUtp2Shg0tgXq6DRyjrusRVHJr52mbte4JMqNBNlbCNrorfXf/Dn4VdQ4WI
 luTQ==
X-Gm-Message-State: AOJu0YxmP2KGWOFLXWsw45Mwgbw6zuxf3JIKIbRb4si7/KbzJbaLNyP8
 yIZO82BHvktUZ0ba6c6CdOiMWA==
X-Google-Smtp-Source: AGHT+IGxAc28ZAiz9lWTlHwXit2c7hx392wqyJ8lRGR6NI9aR51fIEM47u94bRicWQebUWsc+/f5YQ==
X-Received: by 2002:a05:600c:1f83:b0:406:411f:742e with SMTP id
 je3-20020a05600c1f8300b00406411f742emr6838522wmb.34.1698068734466; 
 Mon, 23 Oct 2023 06:45:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1c7917000000b004063cced50bsm9360524wme.23.2023.10.23.06.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:45:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80E421FFBB;
 Mon, 23 Oct 2023 14:45:33 +0100 (BST)
References: <20231016093143.222551-1-liucong2@kylinos.cn>
 <20231018025225.1640122-1-liucong2@kylinos.cn>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cong Liu <liucong2@kylinos.cn>
Cc: Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] contrib/plugins: Close file descriptor on error return
Date: Mon, 23 Oct 2023 14:45:19 +0100
In-reply-to: <20231018025225.1640122-1-liucong2@kylinos.cn>
Message-ID: <87msw94flu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> This patch closes the file descriptor fd on error return to avoid
> resource leak.
>
> Fixes: ec7ee95db909 ("contrib/plugins: fix coverity warning in lockstep")
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  contrib/plugins/lockstep.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index f0cb8792c6fa..237543b43a76 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -257,6 +257,7 @@ static bool setup_socket(const char *path)
>      sockaddr.sun_family =3D AF_UNIX;
>      if (g_strlcpy(sockaddr.sun_path, path, pathlen) >=3D pathlen) {
>          perror("bad path");
> +        close(fd);
>          return false;
>      }
>=20=20
> @@ -303,6 +304,7 @@ static bool connect_socket(const char *path)
>      sockaddr.sun_family =3D AF_UNIX;
>      if (g_strlcpy(sockaddr.sun_path, path, pathlen) >=3D pathlen) {
>          perror("bad path");
> +        close(fd);
>          return false;
>      }

Sorry queued this version to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

