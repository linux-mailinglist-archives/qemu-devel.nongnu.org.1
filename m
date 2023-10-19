Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE787D0321
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZZh-0000PH-FE; Thu, 19 Oct 2023 16:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtZZf-0000Ol-Bk
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:24:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtZZd-0000gW-8S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:24:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so610525e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697747091; x=1698351891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgzOY1mpwueJDG3rHA5K/iwtnkdPyxsrxzEAjXze2Ew=;
 b=IPgyGkQ+KJRV4vZBDD3a6+ndvJz4F0cl7axyZprUWthEZ5548HIundJeCVZ22onM6e
 sIJphjizlrxxMd7kw04XmIN6uNCtsISuBG/Qn/EG9Jd7bLpLp5bt0GpDGb0pbIfbAExR
 iWLAcg8/eUxEppRZoXRigy6JPL7guMKdt+FkXPJv4TePRi1rGrJuiIMenae/CbO3g+io
 IPWPtfD3N/N3c4vK2tzhDnSE3ZaW4a9K6owz3mNKDyxpc/mQUULzJHkarH6MwUIPmbSi
 2WtkhrfFBsmUzl8Xt9YsP+n/dutfpRD7w7gbyYPKUQJjL3m6YZ1mzmGScGHXdznhl+S2
 GQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697747091; x=1698351891;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TgzOY1mpwueJDG3rHA5K/iwtnkdPyxsrxzEAjXze2Ew=;
 b=m8seorkeJL9BeCsmHyGl+45Q9/e4Kre0ahskUzF8y6CnaiWRwB97268YO7z+zgviK1
 9BbfuF8LD1HhrZDeYomrF/dxLL+AjcZi9vUBS7WPtgrqYaUmgjl667PK5hqI1lusRrGe
 72WCEywJZAGHT1W+2vE+sgS3kYhrcuUXMNpW55SDGAGjByqlQlwZuLqvBuJkP5ichX99
 bZT/Z6znZpzxAAB7TjUY8m0FXfdNcaJX48zUlKXovRb7fP3lSHX5Ahi9ggbxvgCzyQdf
 624VxiFbXiWUw+cxLD4M2tdArPZDvT+einhM3paqgZF8M+nSxkQMsXZqjHfKv+cHVaZA
 a34A==
X-Gm-Message-State: AOJu0YxRlLTFXF2JUYFzGs5Pgvk8gsKJNC5np8ySC06sxrkGF61XkMwP
 LfC+xd3BreObhgItJxyw1vE8Nw==
X-Google-Smtp-Source: AGHT+IEYsFYr7O6RjI+rJCAB+T/wDMTi7ww765HK0iM+p1XMoqmp3EPr80KBK43rsTWP1FxxCAL0WQ==
X-Received: by 2002:a05:600c:4f90:b0:405:1baf:cedf with SMTP id
 n16-20020a05600c4f9000b004051bafcedfmr2539457wmq.24.1697747091206; 
 Thu, 19 Oct 2023 13:24:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a7bcbcf000000b004060f0a0fdbsm5204826wmi.41.2023.10.19.13.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 13:24:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64C741FFBB;
 Thu, 19 Oct 2023 21:24:50 +0100 (BST)
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
 <20231019101030.128431-7-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 6/6] plugins: Remove an extra parameter
Date: Thu, 19 Oct 2023 21:24:44 +0100
In-reply-to: <20231019101030.128431-7-akihiko.odaki@daynix.com>
Message-ID: <87cyxa8inh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> copy_call() has an unused parameter so remove it.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Queued to plugins/next, thanks.

> ---
>  accel/tcg/plugin-gen.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 39b3c9351f..78b331b251 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -327,8 +327,7 @@ static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
>      return op;
>  }
>=20=20
> -static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *empty_func,
> -                        void *func, int *cb_idx)
> +static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb=
_idx)
>  {
>      TCGOp *old_op;
>      int func_idx;
> @@ -372,8 +371,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugi=
n_dyn_cb *cb,
>      }
>=20=20
>      /* call */
> -    op =3D copy_call(&begin_op, op, HELPER(plugin_vcpu_udata_cb),
> -                   cb->f.vcpu_udata, cb_idx);
> +    op =3D copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
>=20=20
>      return op;
>  }
> @@ -420,8 +418,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_=
dyn_cb *cb,
>=20=20
>      if (type =3D=3D PLUGIN_GEN_CB_MEM) {
>          /* call */
> -        op =3D copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
> -                       cb->f.vcpu_udata, cb_idx);
> +        op =3D copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
>      }
>=20=20
>      return op;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

