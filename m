Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F156E802C9B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:04:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3vT-0007F3-Gd; Mon, 04 Dec 2023 03:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3vP-0007DL-MB
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:03:32 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rA3vO-0004rk-4s
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:03:31 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4254223c150so13868061cf.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701677009; x=1702281809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhjXuYb+qQp64L7K5iW8hJchRMFquLq08fAE0tTx1Kc=;
 b=H6OgtVxbV8M3RKKHdUzOcq2UJ+ZO6Tqa74cCwXglfKjcDwJb8N7H19fCY2EjLkI+RC
 u/QYPH+obe/BWz4s2FzCDU9IRd+HRCLPpl9neKMN8WS6PWUmvMc1QKhyw8Oc992VAPMM
 x7A4PKKO0ewTKhToUTJw4BzUueU4l9hV6NFqG8hW18CWyTKeVCtFaeC9+LuNWEFsmueP
 NwjXTI2GkZQ/MUuec1aFjOr5FEWwxhQvFtnNvHcwNvpxCpf5eR1vMHtTT+Aud1AaHxcB
 EgsBafaX3+RihiPQJEO+UUq0t1JwJ/NYPL9xqhcX7DLMSRGMgv9rB0K1uTDygg1RdFcI
 lPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701677009; x=1702281809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhjXuYb+qQp64L7K5iW8hJchRMFquLq08fAE0tTx1Kc=;
 b=Ekuxkd+u2MsTPHtyy4UeUgqmeJrDYOtnsnOPChbZHj4pOCCJaQOgNGeTkNGBn5DNlN
 m93pa9SapZkPXT/FTSAnikyvpU9gsqugueXK6zDKKC3L1v+nMSyZ8rIvddczkL23eobI
 FHmgFxGlChxprK3B2J7+zZ24tXggw8lyGDwbYtKOerwOw0WfSQ409GZv9X7cE5JS78RL
 zYbvDTU3Sk5bdwOgBHMtyGdgmtFZA+tKEZsSJeOEwAne81qE334nwYG4Y+HdlzsMEoxi
 cgJPTyioLOa61gh7t5nNlf+6ghmCTzwPkmrP7en1bffVEkSTkjVhZXE+s4UsJyvI/lEx
 vSkw==
X-Gm-Message-State: AOJu0Yzy42J2VG+/vwNqAREB9Zv6szJQKcV5c8zc3ToJHvVU+ELkbcgu
 uQzr19ybgkbOZx25mF2BMzENApQMvnCx5Uhq2ZU=
X-Google-Smtp-Source: AGHT+IHmWZ/i+/yUwd6e0W3AYFkmpbvXMAa0ndVjrad84vAKb6druYAmbDHLeq0FCDswTEdP/k0GJpxqXXd9CPlLkJc=
X-Received: by 2002:a05:622a:354:b0:421:b909:de9e with SMTP id
 r20-20020a05622a035400b00421b909de9emr5483113qtw.2.1701677009239; Mon, 04 Dec
 2023 00:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20231204072837.6058-1-vr_qemu@t-online.de>
In-Reply-To: <20231204072837.6058-1-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 12:03:18 +0400
Message-ID: <CAJ+F1CJxPKMNd-vtwJCWsUDMJa0Nr7oe6Vd0bt3iaTUarBH_3Q@mail.gmail.com>
Subject: Re: [PATCH for 8.2] hw/audio/virtio-sound: mark the device as
 unmigratable
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

On Mon, Dec 4, 2023 at 11:30=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> The virtio-sound device is currently not migratable. QEMU crashes
> on the source machine at some point during the migration with a
> segmentation fault.
>
> Even with this bug fixed, the virtio-sound device doesn't migrate
> the state of the audio streams. For example, running streams leave
> the device on the destination machine in a broken condition.
>
> Mark the device as unmigratable until these issues have been fixed.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I'll queue this.

> ---
>  hw/audio/virtio-snd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 2fe966e311..b10fad1228 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -68,6 +68,7 @@ static const VMStateDescription vmstate_virtio_snd_devi=
ce =3D {
>
>  static const VMStateDescription vmstate_virtio_snd =3D {
>      .name =3D TYPE_VIRTIO_SND,
> +    .unmigratable =3D 1,
>      .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
>      .version_id =3D VIRTIO_SOUND_VM_VERSION,
>      .fields =3D (VMStateField[]) {
> --
> 2.35.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

