Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D48143B3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 09:35:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE3dl-0004vV-4r; Fri, 15 Dec 2023 03:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE3di-0004tz-1I
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 03:33:46 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE3dg-0004ln-HE
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 03:33:45 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77f44cd99c6so31683285a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702629223; x=1703234023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmusgUkB+qbEBQ60rgdWn4+2k1/GbudE5xV6vfZGh5Q=;
 b=l6QGzzzrQCy2u32fMS6g8ul95Da0bdMgrYwbfgpt550tU6SH35tvNwZM1oyqlqgGPm
 1p523SThWQVx5lD5Tn14QXfsLMeIBubGQs5+Yc+uypH5WrSoQTrFv6mh6QHsyZxr36Ah
 T7Oov5DrQBfHQXeXOpL7u0k9dLm0KJ6oSWp9ZgRgHLZLVwaZdwdzhNopClHqq+tNCD2Y
 ww2ehzuMju0vipnkf2iTnsJELsxYspWT7jOXjDWSs/xPHMI5L2iK8h3M4Gxb4qDR1hjQ
 YUWkz8nWmaZDWEAw0M7bTEjdBxXEww13LKYklR+8W6DNesvLMbbFcscr6x689qDUh3Jr
 jLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702629223; x=1703234023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmusgUkB+qbEBQ60rgdWn4+2k1/GbudE5xV6vfZGh5Q=;
 b=QrzXw3b28S+IyU/snu+wK/qTzb2ypMi/O/P8eUfYOoCacJthLyqqLhDvGGG4OAtrWP
 Xj2br3LjkhjfJTx1V4vHaXzIpXFqWYchCqP69n/XoQlMphtMJ/kOn3c9SQumKW5kfcP/
 vO4FdiTFskCo3/K0/oMAkIgg+CWcOONCtvn6WMqY3syo/RDGhviYCuFqSpobo5QdRcWH
 HZ39NpRCXnYD1K4YsJT48CNxlLPlfCJgNPQ/LOsxF1vSKklyWB9iTXsIu4YOgV7Sinq8
 I3fU2cXVBSlKj26j+oxNxa2GovCOZXhrrtPomJ3xdkqq6Ylgf9ralazXMzepAA2R52ud
 es1A==
X-Gm-Message-State: AOJu0YzlLp1Xa9fqemVBfkugqz130AG6f2UJ0hBgxjLbGuvAYYmRT/lL
 NN5jmREerlJYMLcjNr+dY2xKffvNAhAQZTiYO9Q=
X-Google-Smtp-Source: AGHT+IF83jlRbuSCCR0g6Qs2RlvngreMqPZbeF65dxxyl8A/SL2jfJ5as+s8gpE5NOUrcWgU2YqCCNjDD8JgT//RPh8=
X-Received: by 2002:a05:620a:4515:b0:77f:65c3:9881 with SMTP id
 t21-20020a05620a451500b0077f65c39881mr15238425qkp.55.1702629223021; Fri, 15
 Dec 2023 00:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
In-Reply-To: <20231213202419.15459-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 12:33:31 +0400
Message-ID: <CAJ+F1C+-v7ZG5fFxrbcSEVOSrFEYx6dYYV02FraCOvfcG9sC+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72f.google.com
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

On Thu, Dec 14, 2023 at 8:26=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:
>
> If the guest state is paused before it gets a response for the current
> scanout frame submission (resource-flush), it won't flush new frames
> after being restored as it still waits for the old response, which is
> accepted as a scanout render done signal. So it's needed to unblock
> the current scanout render pipeline before the run state is changed
> to make sure the guest receives the response for the current frame
> submission.
>
> v2: Giving some time for the fence to be signaled before flushing
>     the pipeline
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..ea8d07833e 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -678,6 +678,25 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
>  static void gd_change_runstate(void *opaque, bool running, RunState stat=
e)
>  {
>      GtkDisplayState *s =3D opaque;
> +    int i;
> +
> +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            VirtualConsole *vc =3D &s->vc[i];
> +
> +            if (vc->gfx.guest_fb.dmabuf &&
> +                vc->gfx.guest_fb.dmabuf->fence_fd >=3D 0) {
> +                eglClientWaitSync(qemu_egl_display,
> +                                  vc->gfx.guest_fb.dmabuf->sync,
> +                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
> +                                  100000000);

This won't work. dmabuf->sync is NULL after egl_dmabuf_create_sync.

I will let Vivek, who wrote the sync code, comment.

thanks



--=20
Marc-Andr=C3=A9 Lureau

