Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022D7BD294
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qphyS-00062c-DP; Mon, 09 Oct 2023 00:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qphyP-00061t-0e
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:34:29 -0400
Received: from mail-oa1-x41.google.com ([2001:4860:4864:20::41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qphyK-0001C5-9E
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:34:28 -0400
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-1e113555a47so2872452fac.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826060; x=1697430860;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNWWpmHXK61TAvUuSaXJXuCXG6m+Usfd03efHMYbuXk=;
 b=UVja/1F8pnnZcr9TDX4hpj5m/Pc63XgRd/+3im79Tg/gCdCS/P2guBaQ9v1vaeYG1x
 wkbeV9EIzHXoub9zSG6E8aQT+E8Qd4n6jnWQVb7ERrthVrWJKtpZh7hh6C/a7wNuDMIb
 iLBVWwTbC9U51j5yvWnzlG5KGaBUbivD2OOMtPz1rKcSL2H9I26b8gEV8FjjhLDBmlaX
 srxGPzEirBcBPs1mxmYJD508YyhleXKO+6B9vi0h/fyXEf0sgXdEw3VA3sJsiqvLrndk
 IOlu9NIPeyumMKx1DUB36+2cWcxSS1oLSPOOX6oGdSArw1xCHJE3LmewEjZrt7KetWx8
 4GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826060; x=1697430860;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNWWpmHXK61TAvUuSaXJXuCXG6m+Usfd03efHMYbuXk=;
 b=pCHi5qFAczgIlkbfHPEMhI1gkWQVwvr31NCp3OftGoN/TBqwW7dTXwkSElRzcGCvi3
 NSqpX9XY4sywnvlX3Set/ej617QyNWsiOk+/G3SR1Q2n94AiJ7YuUUrnEglYFwIMtCKq
 WnLUmNyYt8Dnu6Z5DVGWKPEfejg5kZaW+hcdqWvVy7zaSghEA+2Rh8TPhrlSaiKfk09o
 VWuVFtJ0ZlNZecBSxH5YJgrsh/7yZpz7tI7Y/bO7hs50HMQxatAgYfo3EeXBdjZ5z6tM
 /z4OuuXGwkXkkaCZDvpMrbPN7HDgft5ezkU5mCq1O2FQwQYn0L4Qg+HrhM5hKIftSRiv
 fg/Q==
X-Gm-Message-State: AOJu0YwwuOr03nAwwZyT3wDWgRNR+glyYLwdAnzakUJnezTrsBZyTZtK
 Fh2qzPiVJFGXRlCkWzaTcw4g7A==
X-Google-Smtp-Source: AGHT+IFp5Ny8MNc60PPh2Cg0pYDOGjcY5MMwzeCCPm+R+faI/ob01Lv9PmouppShZne7WM5OvcKvSA==
X-Received: by 2002:a05:6870:f6a9:b0:1c8:c313:3e0d with SMTP id
 el41-20020a056870f6a900b001c8c3133e0dmr16648138oab.46.1696826059594; 
 Sun, 08 Oct 2023 21:34:19 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b00689f5940061sm5478871pfn.17.2023.10.08.21.34.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Oct 2023 21:34:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v7 3/5] vhost-user-scsi: support reconnect to backend
From: Li Feng <fengli@smartx.com>
In-Reply-To: <27ldj.4hqzhrkvm1st@linaro.org>
Date: Mon, 9 Oct 2023 12:34:02 +0800
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFC29B13-3ACC-493A-A5BB-5DCAD29D0E1C@smartx.com>
References: <20231008091220.870171-1-fengli@smartx.com>
 <20231008091220.870171-4-fengli@smartx.com> <27ldj.4hqzhrkvm1st@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
Received-SPF: none client-ip=2001:4860:4864:20::41;
 envelope-from=fengli@smartx.com; helo=mail-oa1-x41.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Thanks for your comments, I will submit the v8.

> On 8 Oct 2023, at 6:46=E2=80=AFPM, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> Hello Li, I have some trivial style comments you could possibly =
address in a next version:
>=20
> On Sun, 08 Oct 2023 12:12, Li Feng <fengli@smartx.com> wrote:
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index df6b66cc1a..5df24faff4 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -39,26 +39,56 @@ static const int user_feature_bits[] =3D {
>>    VHOST_INVALID_FEATURE_BIT
>> };
>> +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>> +{
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    int ret;
>> +
>> +    ret =3D vhost_scsi_common_start(vsc, errp);
>> +    s->started_vu =3D (ret < 0 ? false : true);
>=20
> -+    s->started_vu =3D (ret < 0 ? false : true);
> ++    s->started_vu =3D !(ret < 0);
>=20
>> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>=20
> -+    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
> ++    DeviceState *dev =3D DEVICE(vdev);
>=20
>> +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    int ret =3D 0;
>> +
>> +    if (s->connected) {
>> +        return 0;
>> +    }
>> +    s->connected =3D true;
>> +
>> +    vsc->dev.num_queues =3D vs->conf.num_queues;
>> +    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + =
vs->conf.num_queues;
>> +    vsc->dev.vqs =3D s->vhost_vqs;
>> +    vsc->dev.vq_index =3D 0;
>> +    vsc->dev.backend_features =3D 0;
>> +
>> +    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, =
VHOST_BACKEND_TYPE_USER, 0,
>> +                         errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    /* restore vhost state */
>> +    if (virtio_device_started(vdev, vdev->status)) {
>> +        ret =3D vhost_user_scsi_start(s, errp);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>=20
>=20
> -+    if (virtio_device_started(vdev, vdev->status)) {
> -+        ret =3D vhost_user_scsi_start(s, errp);
> -+        if (ret < 0) {
> -+            return ret;
> -+        }
> -+    }
> -+
> -+    return 0;
> -+}
> ++    if (virtio_device_started(vdev, vdev->status)) {
> ++        ret =3D vhost_user_scsi_start(s, errp);
> ++    }
> ++
> ++    return ret;
> ++}
>=20
> [skipping..]
>=20
>> +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error =
**errp)
>> +{
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>=20
>=20
> -+    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
> ++    DeviceState *dev =3D DEVICE(s);
>=20
>> diff --git a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h
>> index 521b08e559..b405ec952a 100644
>> --- a/include/hw/virtio/vhost-user-scsi.h
>> +++ b/include/hw/virtio/vhost-user-scsi.h
>> @@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, =
VHOST_USER_SCSI)
>> struct VHostUserSCSI {
>>    VHostSCSICommon parent_obj;
>>    VhostUserState vhost_user;
>> +    bool connected;
>> +    bool started_vu;
>> +
>> +    struct vhost_virtqueue *vhost_vqs;
>=20
> +    bool connected;
> +    bool started_vu;
> -+
> +    struct vhost_virtqueue *vhost_vqs;
>=20
> See =
https://www.qemu.org/docs/master/devel/style.html#qemu-object-model-declar=
ations
>=20
> The definition should look like:
>=20
> struct VHostUserSCSI {
>   VHostSCSICommon parent_obj;
>=20
>   /* Properties */
>   bool connected;
>   bool started_vu;
>=20
>   VhostUserState vhost_user;
>   struct vhost_virtqueue *vhost_vqs;
> }


