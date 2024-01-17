Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F283044B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:12:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3pU-0005pY-RR; Wed, 17 Jan 2024 06:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rQ3pS-0005pQ-Pv
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rQ3pQ-0001Gi-Um
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705489887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULLYsnr0YwZcFCMK9ypbkOfWZ97tfohJHzqMQ6E2fZY=;
 b=Kc5vs7SC8GTbzF6ShQRfYhd40+XZnvH05Sc9ogiBKKUyj5cknHyR4cZeZNiVCPxnjf4d91
 K9evhyq0jCnTRvXoFln3cglcEvaV3t38Cj2RqrOeNEOSoemGRearNFV9KYtqETdUoU0Yi5
 PYheyMKOyImyRmYESKXuU6FJIK/ab+M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-eSjxGEPtOlSm5qDgHzxmhw-1; Wed, 17 Jan 2024 06:11:25 -0500
X-MC-Unique: eSjxGEPtOlSm5qDgHzxmhw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50edc80b859so4715517e87.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 03:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705489884; x=1706094684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULLYsnr0YwZcFCMK9ypbkOfWZ97tfohJHzqMQ6E2fZY=;
 b=ba5IcT3zt8L30QEb0cWkGZBtuUm/6MAgd7Hbdma++MLkGPSvDYcopcOJ6YTOshC/fe
 1FhALL3BeAUP2DxRwdEKjOHe6EroS13St3LznnIsHnGwk0JQf858fg2YpQtBaz1zk1cR
 lFfQYlMW2lqd3lTOL2tBRvPnuTwk/yNljsFk47zybN0Ie9nVPkUJK2tV2Io4LZQ1px4r
 BwCwISWxgG7BOvioxj0Gf1jqdV5eXy/vBNZtsfOD4GkI46bfrn2bf4QvgrV7X86JWUPY
 Tr5xme+fNtvP+d7xA6+x9yayMtFrO5x2hfZq4LxZClHugyXMCG6ZL8cCD2DNRYaeIHUe
 p5NA==
X-Gm-Message-State: AOJu0YwOU8gjfrhn/KYb7NsFoN7LNE32dWb86q5VTn3N1fbQNMRBiViv
 j6ENo49/EC/Mny1MaTw4YyYcYVnLKZauLw3gbmx+AXjjDnJAZQrT48r49liiS2k32wZ/mIXu4zt
 7eOc5kHyk0QUUGJTyWyysc87qNYsZXZF7JF9zq+xNyk87ToU1/g==
X-Received: by 2002:a05:6512:74:b0:50e:79a5:545a with SMTP id
 i20-20020a056512007400b0050e79a5545amr3812637lfo.23.1705489883867; 
 Wed, 17 Jan 2024 03:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMt0vZLCJo0ltM7MeoaXFhIBIhVCSrNTeP4GoQwmGXFK9hG7PVSwxuB5Tli/aiq4kDlrFaQYD7Feru1T6rJDE=
X-Received: by 2002:a05:6512:74:b0:50e:79a5:545a with SMTP id
 i20-20020a056512007400b0050e79a5545amr3812625lfo.23.1705489883524; Wed, 17
 Jan 2024 03:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20240117110109.287430-1-f.ebner@proxmox.com>
In-Reply-To: <20240117110109.287430-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jan 2024 15:11:11 +0400
Message-ID: <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
Subject: Re: [PATCH v2] ui/clipboard: ensure data is available or request
 callback is set upon update
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Wed, Jan 17, 2024 at 3:01=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
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
> Another code path leading to the same issue in
> qemu_clipboard_request() is via vdagent_chr_write() and
> vdagent_clipboard_recv_request() after a non-extended
> VNC_MSG_CLIENT_CUT_TEXT messages with len=3D0 was sent.
>
> In particular, this can happen when using the KRDC (22.12.3) VNC
> client on X11.
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
> the VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it
> passes), that clipboard info is passed to qemu_clipboard_request() and
> the original segfault still happens.
>
> Fix the issue by disallowing clipboard update if both, data is missing
> and the clipboard owner's 'request' callback is not set.
>
> Add an assert that the clipboard owner's 'request' callback is set in
> qemu_clipboard_request() to have a clean error/abort should a similar
> issue appear in the future.
>
> Fixes: CVE-2023-6683
> Reported-by: Markus Frank <m.frank@proxmox.com>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> Changes in v2:
>     * Different approach as suggested by Marc-Andr=C3=A9:
>       Instead of quietly returning in qemu_clipboard_request() when no
>       request callback is set, prevent clipboard update if there is
>       both, no data and no request callback.
>
>  ui/clipboard.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index 3d14bffaf8..d1bb7c77f2 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -65,12 +65,28 @@ bool qemu_clipboard_check_serial(QemuClipboardInfo *i=
nfo, bool client)
>
>  void qemu_clipboard_update(QemuClipboardInfo *info)
>  {
> +    uint32_t type;
> +    bool missing_data =3D false;
>      QemuClipboardNotify notify =3D {
>          .type =3D QEMU_CLIPBOARD_UPDATE_INFO,
>          .info =3D info,
>      };
>      assert(info->selection < QEMU_CLIPBOARD_SELECTION__COUNT);
>
> +    for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_data;=
 type++) {
> +        if (!info->types[type].data) {
> +            missing_data =3D true;
> +        }
> +    }
> +    /*
> +     * If data is missing, the clipboard owner's 'request' callback need=
s to be
> +     * set. Otherwise, there is no way to get the clipboard data and
> +     * qemu_clipboard_request() cannot be called.
> +     */
> +    if (missing_data && info->owner && !info->owner->request) {
> +        return;
> +    }

It needs to check whether the type is "available". If not data is
provided, owner should be set as well, it should assert() that.

That should do the job:

for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
    /*
     * If data is missing, the clipboard owner's 'request' callback needs t=
o
     * be set. Otherwise, there is no way to get the clipboard data and
     * qemu_clipboard_request() cannot be called.
     */
    if (info->types[type].available && !info->types[type].data) {
        assert(info->owner && info->owner->request);
    }
}

> +
>      notifier_list_notify(&clipboard_notifiers, &notify);
>
>      if (cbinfo[info->selection] !=3D info) {
> @@ -132,6 +148,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
>          !info->owner)
>          return;
>
> +    assert(info->owner->request);
> +
>      info->types[type].requested =3D true;
>      info->owner->request(info, type);
>  }
> --
> 2.39.2
>
>


