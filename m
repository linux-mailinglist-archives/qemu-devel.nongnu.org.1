Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7C8143C0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 09:37:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE3gg-0006yq-C8; Fri, 15 Dec 2023 03:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE3ge-0006y4-E3
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 03:36:48 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE3gc-0006zV-TO
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 03:36:48 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-425c9cd7dd2so2724831cf.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702629405; x=1703234205; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB/aoezIYMAwWj2scTW4Zfw9R6nH2vO4b8CwbTSDeY0=;
 b=XzZlBNsMNMTWuryL8gu+wVeIbRxidMSQiSeHZZcLE18KHtnziFOGs8JxIdU8kzBtZa
 HWryjbblr1q/EBhbuVI/Yq8K9njcgBalugDUEkEa0OuKnE6Wkaqd2j7k1XFovWWhrz2M
 1ncB/rCGuIc+c+5JrP9v3gZALGBWhvGh5RX6QQ2fT5jPLf3it8EwyC4vckXIqxQK358a
 a3Cpx3mK/rYAwvmPH5ab4FDdBzyvcUlo2jR38w7PryJW+eFOXUJK5pXMgpWtBxgC4JWi
 bfv8nfHe9fe8Kp7+QqLa6KuNtOIYNAZFhlNB5l7AzSfoONZb0h+tBgKT65dBPCwlmTU+
 wd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702629405; x=1703234205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kB/aoezIYMAwWj2scTW4Zfw9R6nH2vO4b8CwbTSDeY0=;
 b=h8rfWnca+FCuwwD3DG72U2TOP9n+HoVx7SbfOluci06KiVx45B71UETOjnTpQq8ZbM
 Byd72bdHuqFY+BFSFgjOiXiSSHd+NO+kgV/6dxZvTDQqBsgjgayKkCKVnSo2/sQOIPPk
 bX+etVWxbowaqaKtgFOJY0kS3OKsAOoSmcsLHMypCHVYnpNJYU6dFeQ5ofaNoXo9Rv6U
 Dwgn8TjRpHmMpOyvP7nYw0uRWek9xYBzlPdkH9H8IJ/AokohtNZE+HQAieBiu+XW0Lid
 +iifG0L5ssv0ocCboM/+sCJQSJ7Rd6Epkccg9AWl64FVix4RSGpd1FcsV6Jw8X4H4eP5
 7M6Q==
X-Gm-Message-State: AOJu0YwYdTzkjgjD5hnJkDy+aINu3v7lR054LUsZ8RpJg1deYIsqV9wf
 xfiZAVuSjWCmYDw+KSKrdYkCe3xEK8TcROucAUGhSwdN
X-Google-Smtp-Source: AGHT+IFA8ybi0Bl8K4U0FGnieRhZnJtbIKbPPvGAmzGL0jTRCqK7lo6NxvcqFWtbLS3XjXAoSeXL1hR4EPqv6s6FJZ4=
X-Received: by 2002:a05:622a:1711:b0:425:4043:8d41 with SMTP id
 h17-20020a05622a171100b0042540438d41mr9731014qtk.92.1702629405277; Fri, 15
 Dec 2023 00:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <20231213202419.15459-2-dongwon.kim@intel.com>
In-Reply-To: <20231213202419.15459-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 12:36:34 +0400
Message-ID: <CAJ+F1C+GR7gEO2SktenXpRUHtFAvF-ZrW_QGe0-nSErZESbjtQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ui/gtk: unblock pipeline only if fence hasn't been
 signaled yet
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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
> It is needed to unblock the pipeline only if there is an active dmabuf
> to be rendered and the fence for it is not yet signaled.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index ea8d07833e..073c9eadb8 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -597,10 +597,16 @@ void gd_hw_gl_flushed(void *vcon)
>      VirtualConsole *vc =3D vcon;
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>
> -    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
> -    close(dmabuf->fence_fd);
> -    dmabuf->fence_fd =3D -1;
> -    graphic_hw_gl_block(vc->gfx.dcl.con, false);
> +    if (!dmabuf) {
> +        return;
> +    }

When is this function called with dmabuf =3D=3D NULL or fence_fd < 0?

> +
> +    if (dmabuf->fence_fd > 0) {

this should be >=3D 0

> +        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
> +        close(dmabuf->fence_fd);
> +        dmabuf->fence_fd =3D -1;
> +        graphic_hw_gl_block(vc->gfx.dcl.con, false);
> +    }
>  }
>
>  /** DisplayState Callbacks (opengl version) **/
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

