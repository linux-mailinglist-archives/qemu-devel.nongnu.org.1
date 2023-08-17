Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C777F6D8
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcVe-0003tl-2F; Thu, 17 Aug 2023 08:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWcU1-0001Vi-Js
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:52:16 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWcTy-00031d-FQ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:52:12 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-40ffb4476d8so44820051cf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692276728; x=1692881528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgwD8SKREsYOwnSw6MD7pezSYgOqztVgqZYcNgKT/hI=;
 b=doYKPZGuXKai+rVzAIx97Tt3e+Fl0DCqCEy4kpHLKDi+s/UGeRf9ehiypz1nkejNYF
 +qlUrjNo0PfJkG7yZjsh5bFZl7eTB4kCX4l3UtX+DMGrVgIQu6a/p42Br3EcYDkyuLpF
 HGvf5hszV8hnJw/ZgD2JHcLLbVZ2C7fmYd9sGv5iQrehDdkHNgdG/44S8pVQUvLLbwzN
 bRJnoCSDptAx+CfzzJsrfWcozTXxiCHf7A8/bqew2S91qSxAjSA45M7YXHln4Is0uX3X
 dKwC6WAea9FXlGK/nh74kZeZHhgcba+Ceq7KzvzzbcOd9iMXftcWIC+LkoNMo2SQSLgn
 hsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692276728; x=1692881528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgwD8SKREsYOwnSw6MD7pezSYgOqztVgqZYcNgKT/hI=;
 b=PGmqh6u9GiZhDtj6DrASE9ManPUAAQ8qaFxs3MznYn2veYbx1mCLBO+eUQwjzvlRhU
 rFVyMtax2VDLh3h0wltEDl1nNMnYrderw5wdhuic2Qxf9HRtNm44/JpgovNzkTDL7lR8
 NhzC2+EfEfT4kkrG7XQY9jJRyML3KBf7Re9A08ePDs1Sk0L7cOY9wyoP3avOa2gn5wlr
 a278IFVDNE6F2gMFp1I198TMGQzniv04EqajpJvt50CdAYgDEOOg5R96RcGbbpk7xc8W
 YNfF6biWW3PH4pJXbRXj1gDWdJiBjdygWMiN79OiwpzsKIK53VtUd3y5SdTpF/Wm7J7i
 as5g==
X-Gm-Message-State: AOJu0YweKCDWJXqBFRl6IMcuAybT59DyipMTpW6VIHFrx1zTdAYEs3P9
 a+FhjwN8gX6OMzP+9WsAMlXLrriqlg2CGMnGzP0=
X-Google-Smtp-Source: AGHT+IEQaCeOFKUI2c5rd9wCpvM8ClxobFDyPf/TXP/H390WuwkJUJqAqdzHR8hTqA6Xqb/3+azODz+2yiLoAGQl3II=
X-Received: by 2002:a05:622a:11d1:b0:403:f60d:49e5 with SMTP id
 n17-20020a05622a11d100b00403f60d49e5mr6037173qtk.33.1692276728585; Thu, 17
 Aug 2023 05:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692268800.git.tugy@chinatelecom.cn>
 <febb712a419d37d2e2b244794f28efdf8aa5177c.1692268800.git.tugy@chinatelecom.cn>
In-Reply-To: <febb712a419d37d2e2b244794f28efdf8aa5177c.1692268800.git.tugy@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2023 16:51:57 +0400
Message-ID: <CAJ+F1CJ7MCtV8ZtV3WE4_gyYRQHHOvqZVcKLHfmtxeH0=0Yg-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ui/vdagent: Unregister input handler of mouse during
 finalization
To: tugy@chinatelecom.cn
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

On Thu, Aug 17, 2023 at 3:33=E2=80=AFPM <tugy@chinatelecom.cn> wrote:
>
> From: Guoyi Tu <tugy@chinatelecom.cn>
>
> Input handler resource should be released when
> VDAgentChardev object finalize
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vdagent.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 386dc5abe0..4c9b3b7ba8 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -924,6 +924,9 @@ static void vdagent_chr_fini(Object *obj)
>  {
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
>
> +    if (vd->mouse_hs) {
> +        qemu_input_handler_unregister(vd->mouse_hs);
> +    }
>      migrate_del_blocker(vd->migration_blocker);
>      buffer_free(&vd->outbuf);
>      error_free(vd->migration_blocker);
> --
> 2.27.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

