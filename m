Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE77A4537
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiA2r-0008QL-0M; Mon, 18 Sep 2023 04:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA2o-0008Q3-14
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA2m-0000L8-E5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695027347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRBttWJR8kg+UWtc0152bHgjroSY63pHUmNDkTYRMIA=;
 b=PWY8Uam+4F1dVya4nLHFYk/WCkRvv/Secs02WQ7py6Csq3HVxkUp9+C3FXDod8Tk4vjQMy
 6F1aeX21dujCOt1H/SPyCQlh+do3T/Iqddjp6GWGf2o83C97kVrrA3gTgxleJEr6W5MTxv
 2IsQT4P2O9gHJUSnW12rqfetT+7HTZI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-5164mDU-MX-9Btr8o47yxA-1; Mon, 18 Sep 2023 04:55:45 -0400
X-MC-Unique: 5164mDU-MX-9Btr8o47yxA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c001029f99so11460531fa.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695027343; x=1695632143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRBttWJR8kg+UWtc0152bHgjroSY63pHUmNDkTYRMIA=;
 b=GTg78dA0NCpGtU2kdGu+wltSnkOVbXYc5BdtRtWAc9K1pREEvvATov5F7Wm883palB
 +iZ2MNIiQrNcD490tZqPiPvzPdQjxjiKj+nrfsZOwO8WlD1HaQiWdDKY9mS4UoHWxtFu
 Zo/+J0zDU/l1O3fx6GYV2gPiZhARN6Q0IydfHLZOlLeFTh1rEbEa8/kPL2YnwaC8hvjV
 4Hhk7jJJR2EjeHcVc9qibKdReA1e3yhUvRdpxqeRTQmTXN56ODBweZNQ/6MR5p6Ex7Fp
 yvejDbqNpP+HnVXYwjMBUEpfKrggEJWeIi04b/ii4pQFj+cRTRg46ggxoBMGqrpxC3U2
 tLPA==
X-Gm-Message-State: AOJu0YytEJr+QQgdMGTsD9Nsz9uNp2bFIb+n71daG0EUJ1edwy9xeUTm
 ciTDQHqEpDbq7Q8YblmJWcFzPLPXbMZm8J1faRGx84WfHy9WANBRcWpDOYNvfdGCWlKxbtj3qI9
 PQUFaCttiSErBLDxSklP5X0Fe4t+oVHc=
X-Received: by 2002:a05:6512:3a90:b0:501:ba04:f34b with SMTP id
 q16-20020a0565123a9000b00501ba04f34bmr8268291lfu.44.1695027343472; 
 Mon, 18 Sep 2023 01:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0aJ06SuZfSG4c1gvCldjUvXize+Q/AmgM4GrlrsLUgUtk2bMH0K+RtRbFcd1Y9HK5bmVxlitA0uMaIcJBJG4=
X-Received: by 2002:a05:6512:3a90:b0:501:ba04:f34b with SMTP id
 q16-20020a0565123a9000b00501ba04f34bmr8268286lfu.44.1695027343192; Mon, 18
 Sep 2023 01:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170322.3076956-1-eperezma@redhat.com>
 <20230915170322.3076956-3-eperezma@redhat.com>
In-Reply-To: <20230915170322.3076956-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:55:32 +0800
Message-ID: <CACGkMEuhebdSkyq0OnNRr_x_d_bT9iUMi6ab=+QjPWX-KQ3KUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa net: stop probing if cannot set features
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 16, 2023 at 1:03=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Otherwise it continues the CVQ isolation probing.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9845e2db9c..51d8144070 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1289,6 +1289,7 @@ static int vhost_vdpa_probe_cvq_isolation(int devic=
e_fd, uint64_t features,
>      r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
>      if (unlikely(r)) {
>          error_setg_errno(errp, errno, "Cannot set features");
> +        goto out;
>      }
>
>      r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> --
> 2.39.3
>


