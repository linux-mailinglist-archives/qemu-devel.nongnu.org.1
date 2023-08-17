Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E140077F6BE
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcS8-000786-Lf; Thu, 17 Aug 2023 08:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWcS6-00077F-4P
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:50:14 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWcS3-0002Nb-KC
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:50:13 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-76d764128d2so81009685a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692276610; x=1692881410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw+SaOq2RgRWk3EZr224tBFBrfsa68/TqZg87L9vqOw=;
 b=a7XVm3sa/9vcoRG+ENdNTAI7g026/fHMgBaLxd+jHTl0hCL+UwY/LyyMZGiTzwN1jh
 TFBnWtTR4BiNQRualV9DNb6eGO5wFXUVOsPuw0pJSHdXIkvFUrA/Kra3duF27NT1xhxb
 diXgKhEGrSozTCAvdgya7cxoqZgW3m/UFPsCEpl3q/3PiRwA1pVeIjFSkJAtwbfpxt/i
 VEn2393HV7RMr9nch3ed2Gj9cQX5FTO0XwhMKfhMiGq0SGwhcvk68n3TlGOrfiFqenqc
 zAjC7rL+7yP+u1z3ukJNZmOw3wXTuXH6xCUlJfeTRFBZVySSjiKodiq/DDE952UbkMmT
 sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692276610; x=1692881410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zw+SaOq2RgRWk3EZr224tBFBrfsa68/TqZg87L9vqOw=;
 b=GhIdGFrx03ADBqB2BeDlwMepFtUwyQtXIiPe5L4RYbUkkjUC8XsprQZmFz+AXqx4G/
 sA8GlZrfz54KNLS8Rp1LJPVFJbmHogKtRQvCmdxnXUv7Ca+Hgo9gDuyw79UKWNTSN21I
 U84JOG6vtYB5oWYL5fGtnFZaqFJBKHffbpo07Qs4QwJjALDXzkvTAiEawmbPi+bGusIR
 ySpCn1nm2IDOEbPH3tzyCwNlFNaycGMyE0TRixrhmTBvleCZPjIb0J9WtSHdc49CCbGG
 Hupidv4Sx2UNWDtporZIx/2m1/LZT5pn3vw3KnychUEAY1ibj2sBJPXbBnGQqrzA0Dx4
 PUeg==
X-Gm-Message-State: AOJu0YzKrwO4fzRUVzvGgY9QW3g7yy1JESabwmhQFrvQxT4fJCi0gHwr
 ywVbEd20LcgOBcApO24H5KszjI6gtcZUmYSi5pg=
X-Google-Smtp-Source: AGHT+IGIVn7cgLxCcx1n/xN5jnioHEPqoLvVJUvbppq/z9D+ODG31uzaRNDhBKBdg3n308HA2aXFva+kL3qC2FKhOP0=
X-Received: by 2002:a05:620a:bc8:b0:76c:de57:7b61 with SMTP id
 s8-20020a05620a0bc800b0076cde577b61mr5462084qki.25.1692276609970; Thu, 17 Aug
 2023 05:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692268800.git.tugy@chinatelecom.cn>
 <d285e8729552a6206ffa1cd4520fc8f9c6be5957.1692268800.git.tugy@chinatelecom.cn>
In-Reply-To: <d285e8729552a6206ffa1cd4520fc8f9c6be5957.1692268800.git.tugy@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2023 16:49:58 +0400
Message-ID: <CAJ+F1C+_fGHq3odW6=2krDMhSkOX0krNTUjPnLAuiXHb62naAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/vdagent: call vdagent_disconnect() when agent
 connection is lost
To: tugy@chinatelecom.cn
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x729.google.com
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

On Thu, Aug 17, 2023 at 3:32=E2=80=AFPM <tugy@chinatelecom.cn> wrote:
>
> From: Guoyi Tu <tugy@chinatelecom.cn>
>
> when the agent connection is lost, the input handler of the mouse
> doesn't deactivate, which results in unresponsive mouse events in
> VNC windows.
>
> To fix this issue, call vdagent_disconnect() to reset the state
> each time the frontend disconncect
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
> ---
>  ui/vdagent.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 8a651492f0..386dc5abe0 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -870,8 +870,11 @@ static void vdagent_disconnect(VDAgentChardev *vd)
>
>  static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
>  {
> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);
> +
>      if (!fe_open) {
>          trace_vdagent_close();
> +        vdagent_disconnect(vd);
>          /* To reset_serial, we CLOSED our side. Make sure the other end =
knows we
>           * are ready again. */
>          qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> @@ -922,7 +925,6 @@ static void vdagent_chr_fini(Object *obj)
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
>
>      migrate_del_blocker(vd->migration_blocker);
> -    vdagent_disconnect(vd);

why remove this cleanup ? (the function seems safe to call multiple
times, if it is the case during finalize)

>      buffer_free(&vd->outbuf);
>      error_free(vd->migration_blocker);
>  }
> --
> 2.27.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

