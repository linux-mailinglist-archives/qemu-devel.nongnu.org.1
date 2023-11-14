Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9D7EAD3A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:45:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2py1-0003tQ-4D; Tue, 14 Nov 2023 04:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2pxy-0003sd-L7
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:44:18 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2pxv-0000Ha-TD
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:44:18 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4ac4cd60370so2491531e0c.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699955055; x=1700559855; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1aoTn7+6qkvPPYAJnrl/E6nR19Y5OREHlELWQ7qIGw=;
 b=H9ukncxcLf1yPz0Dxs9J7cdwWiDOFyrdAWbFk/F58eTGtuzeyKiYfWm8vxk6o70Iku
 /mMZxRB2UUgv7/Aiy88z3lvrPeqBiRex1VC+DiYo+QTm0Sl9q8myAC+BFqcv3fCmu8gA
 +my5w1KVypaUfKfLgZPRrPMdirTOaDWG3X+LoHfV0q3hWetCluTSoSrtvYELBApcMTWO
 VsczbwkfVWiatkX5U0Y9P66bI5zZCtwgIk739ww6N9l4U4IjOCwKUTb1iXg9+7kQfw/e
 G5eYgIfRO/hrWm4vWyTySwpSfDMQp0DmxosbeznHtQCEUNf/8+O5pX/Yn6pxCpn/E1NB
 yBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699955055; x=1700559855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1aoTn7+6qkvPPYAJnrl/E6nR19Y5OREHlELWQ7qIGw=;
 b=MrR00rzr7D+Q3Ly5CK/FzMXCSFCQJ9kNZQxanlTzHZb+vicM9nWL313tEvFRsRHlMh
 d4JvNd1h/O77JP67p0jzHeguOzwf9hUsYmGPMN6Sxikfh0lUoPionRKoDfZC4gO4sUQ8
 GQfX3vtlYXx/maLAooeLVnFutqYim62WNBLrEWb1y4FEt78OeNLHrDSGZIClvnmlHl/K
 nvyIXzaQWzS9rN1wpsyTsWH514rd4SyD6Dg2PsXQvKmVdo2DvoI1wQ1E7PKqclUzzk7R
 OiGo6rELPNV1YUMDhIOcIO4Q3ynDehaqk3/Eo3Oty7kuFyDYtb3LAbFr3V33Bs+839UT
 H64A==
X-Gm-Message-State: AOJu0YzyacZiWIkM4SGhUuehxtHA/E+rBAbJtHSGhoQYwp1oMeqfP3VO
 Ym3Qc1WFRTEu5pHwN1KB+RfI406oUa+d8KxFzT8=
X-Google-Smtp-Source: AGHT+IFsO1jZhnSrr3b9BewsMXd9MvuJAary1zWga0LWjA8ANu2F2MEXqZRRz87kXLmswL4ydeuviWLKJPGvbccYWck=
X-Received: by 2002:a05:6122:1d13:b0:49a:36e4:5565 with SMTP id
 gc19-20020a0561221d1300b0049a36e45565mr9739594vkb.16.1699955054781; Tue, 14
 Nov 2023 01:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20231113190211.92412-1-leo.yan@linaro.org>
 <20231113190211.92412-2-leo.yan@linaro.org>
In-Reply-To: <20231113190211.92412-2-leo.yan@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 13:44:03 +0400
Message-ID: <CAJ+F1CJMq4HdbJ6074Ni6M8csWHAW6CJzwEodytQ6VzZLxE+_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/virtio: Support set_config() callback in
 vhost-user-base
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vk1-xa36.google.com
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

On Mon, Nov 13, 2023 at 11:04=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> The Virtio input device invokes set_config() callback for retrieving
> the event configuration info, but the callback is not supported in
> vhost-user-base.
>
> This patch adds support set_config() callback in vhost-user-base.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/virtio/vhost-user-base.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 78cfa9a5bb..a83167191e 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -140,6 +140,22 @@ static void vub_get_config(VirtIODevice *vdev, uint8=
_t *config)
>      }
>  }
>
> +static void vub_set_config(VirtIODevice *vdev, const uint8_t *config_dat=
a)
> +{
> +    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> +    int ret;
> +
> +    g_assert(vub->config_size && vub->vhost_user.supports_config =3D=3D =
true);
> +
> +    ret =3D vhost_dev_set_config(&vub->vhost_dev, config_data,
> +                               0, vub->config_size,
> +                               VHOST_SET_CONFIG_TYPE_FRONTEND);
> +    if (ret) {
> +        error_report("vhost guest set device config space failed: %d", r=
et);
> +        return;
> +    }
> +}
> +
>  /*
>   * When the daemon signals an update to the config we just need to
>   * signal the guest as we re-read the config on demand above.
> @@ -337,6 +353,7 @@ static void vub_class_init(ObjectClass *klass, void *=
data)
>      vdc->unrealize =3D vub_device_unrealize;
>      vdc->get_features =3D vub_get_features;
>      vdc->get_config =3D vub_get_config;
> +    vdc->set_config =3D vub_set_config;
>      vdc->set_status =3D vub_set_status;
>  }
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

