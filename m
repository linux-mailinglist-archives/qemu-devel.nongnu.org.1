Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B982D0CA
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 14:52:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP0u2-0002zd-O3; Sun, 14 Jan 2024 08:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rP0tx-0002zH-HB; Sun, 14 Jan 2024 08:51:49 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rP0tu-0003VW-GU; Sun, 14 Jan 2024 08:51:49 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4298e866cd6so48721021cf.0; 
 Sun, 14 Jan 2024 05:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705240301; x=1705845101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uXcncOfwnttSbHXQux5GnPqloDOlGt2n/TBvgyw6NM=;
 b=Tt4GK4xnWgqRDxypx4XvojsD08USjqE2Hzbg9+TFdY+qYz8UEE2aVjWgA1JxVtoXlf
 8ZHv0J+zEEIqjd3Fd2ZhT9vw7OC8w2BVvEvPi64LGsIk6KwCcYB9pXEGm9mNq1FIodcK
 VAfXOS1lX5h+78p3K1ow8TwbWChP500za2NUnC467v4jK3j7pDc4cQl2F4wcxnHCNgoA
 b7tPPugdWTrTYzQ7ruf7oWe45E5RS1D5s1vRjpDpUnMB3w50eqebfij1MTC6h+QMqaQi
 AAWpCu9LL5WXeOgQoNYKxmC45SDYA5iQKNjjyrMqAfqiPKCxXyZRq4KOf3ACE+Pg9CZn
 eOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705240301; x=1705845101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uXcncOfwnttSbHXQux5GnPqloDOlGt2n/TBvgyw6NM=;
 b=qm8ByENNNRByV38H2esT2d2dtQIKD+y23gbRhwY6hdijSI3VrAYkYy91KT25Ve008W
 RUeWG8K5DIDI3sS8LiRZbVGqm9TDgYFAt3YubsIiOm+vsAYnkz/EimL4yENK2vIvrign
 8ogrnGdkhL0O9OHUioVQUiSwpwz5pgv5jgd3aMkZIkIB/7I0jVa2SV7TyzSGLplP7nP1
 Ee2Zfkb8kfhrR+s8Xb1eP3BBJymIK7MDI5wYzJOK3WzmGluiaS3ymugtZnUauItm8XZP
 pPWM1WSXQdO5r2GY3kFSHLpO3y59e0HECBkLg9MGrb4lOjo11TZ5cvUkNI3bh3vstwg2
 Nxow==
X-Gm-Message-State: AOJu0YznaOZbYjFwoQijCqwc6gtrajJ7qdo3kILalxwp17UXobsehqX1
 zAl0z2JFzdBBhRNJNrAfM2GOxrksXPu3rwQKx2c=
X-Google-Smtp-Source: AGHT+IHvuN92BtcjRxjK6P/ZFVC55DOc9+AChZ6q670F/LsUein2xGT1LRFfMtP6VXCRgghoeA7UvNQzIBtGMcup3zE=
X-Received: by 2002:a05:622a:1b8d:b0:429:af93:4e7f with SMTP id
 bp13-20020a05622a1b8d00b00429af934e7fmr6193357qtb.64.1705240300986; Sun, 14
 Jan 2024 05:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20240112135527.57212-1-f.ebner@proxmox.com>
In-Reply-To: <20240112135527.57212-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 14 Jan 2024 17:51:29 +0400
Message-ID: <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Fri, Jan 12, 2024 at 5:57=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> With VNC, it can be that a client sends a VNC_MSG_CLIENT_CUT_TEXT
> message before sending a VNC_MSG_CLIENT_SET_ENCODINGS message with
> VNC_ENCODING_CLIPBOARD_EXT for configuring the clipboard extension.
>
> This means that qemu_clipboard_request() can be reached (via
> vnc_client_cut_text_ext()) before vnc_server_cut_text_caps() was
> called and had the chance to initialize the clipboard peer. In that
> case, info->owner->request is NULL instead of a function and so
> attempting to call it in qemu_clipboard_request() results in a
> segfault.
>
> In particular, this can happen when using the KRDC (22.12.3) VNC
> client on Wayland.
>
> It is not enough to check in ui/vnc.c's protocol_client_msg() if the
> VNC_FEATURE_CLIPBOARD_EXT feature is enabled before handling an
> extended clipboard message with vnc_client_cut_text_ext(), because of
> the following scenario with two clients (say noVNC and KRDC):
>
> The noVNC client sets the extension VNC_FEATURE_CLIPBOARD_EXT and
> initializes its cbpeer.
>
> The KRDC client does not, but triggers a vnc_client_cut_text() (note
> it's not the _ext variant)). There, a new clipboard info with it as
> the 'owner' is created and via qemu_clipboard_set_data() is called,
> which in turn calls qemu_clipboard_update() with that info.
>
> In qemu_clipboard_update(), the notifier for the noVNC client will be
> called, i.e. vnc_clipboard_notify() and also set vs->cbinfo for the
> noVNC client. The 'owner' in that clipboard info is the clipboard peer
> for the KRDC client, which did not initialize the 'request' function.
> That sounds correct to me, it is the owner of that clipboard info.
>
> Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
> the feature correctly, so the check added by your patch passes), that
> clipboard info is passed to qemu_clipboard_request() and the original
> segfault still happens.
>
> Fixes: CVE-2023-6683
> Reported-by: Markus Frank <m.frank@proxmox.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Markus Frank <m.frank@proxmox.com>
> ---
>
> This is just a minimal fix. Happy to add some warning/error to not
> hide the issue with the missing initialization completely and/or go
> for a different approach with a check somewhere in the VNC code.
>
>  ui/clipboard.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index 3d14bffaf8..c13b54d2e9 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
>      if (info->types[type].data ||
>          info->types[type].requested ||
>          !info->types[type].available ||
> -        !info->owner)
> +        !info->owner ||
> +        !info->owner->request)
>          return;

While that fixes the crash, I think we should handle the situation
earlier. A clipboard peer shouldn't be allowed to hold the clipboard
if it doesn't have the data available or a "request" callback set.

Iow, we should have an assert(info->owner->request !=3D NULL) here instead.

>      info->types[type].requested =3D true;
> --
> 2.39.2
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

