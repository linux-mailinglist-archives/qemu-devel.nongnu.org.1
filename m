Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730577F0A9
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWhl-0001wd-Gg; Thu, 17 Aug 2023 02:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qWWhi-0001wS-IY
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:41:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qWWhf-0002pa-6f
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:41:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so425832b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692254390; x=1692859190;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9RIPbuoCQPgJGcObTmlNihMP6S2fVSSXI1W+Hu6eDo=;
 b=ePut72RWN9LTVydes0W0B73rTcj58jgUZDuDriGUeMrP8Oc2raI1Ab+yEShQ4VryQQ
 ic+hZDHBHcb2QAmYQtacDdvSofiQhx47W0JqnkeGQc7b1SGuv2iBnXiWQ8TAMhNsdWPT
 KTu9uwBjhWf0l4/GWpgA+zUfuHKxrSv3pouLqGHtWMHjGIVCPVhbFPZen2rIEOC4FJyd
 07XWbk1YPO1P96nyWh7d6uQrSLwJLdoty3SMaSxotLwn2ltuD+RQaHOKbEc4TMTfYXDu
 2d7x3z15JDCf4TgmntRU41yiUynIOVb1b/pNSRDzDg6gZIGfMuAzwZkCaXUW07SFs7+9
 TQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692254390; x=1692859190;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9RIPbuoCQPgJGcObTmlNihMP6S2fVSSXI1W+Hu6eDo=;
 b=gh99TV4hplwl6M7FIZsBWx5NaXEbCDPEJykM6brG0HD1gGj4p75YKQ7ncGL0p1i2Nw
 3WWELqL+KmqNAXUiLqymW6B3UdG5uCBpf1d9NbMtFUJoxHTle2JAdMeYA7Nb//b4n+/i
 64xxKECGSLNj9/pLOjUrcOC06QTVaDw51v/oKGcVB0rzUTpSqymHk0b4ZqFq6cxS4TYl
 2HGvyVsoKiJg3G8k6XYqcmjjHCTrmadFvY9AOovyzeW00WlrlqnT4T/vZ/ibQSRhFlnp
 wA4zHlGe7D+yK3G6lsecB/azZdh8x1pspeTIIxfNvQAC9Aan+/sxbl/d0iU4FAZu4Nv2
 1DjA==
X-Gm-Message-State: AOJu0YysRWehic1n/dhlV7UxMH9uww1U1GRjiOns2ICoGAWjlfhs96up
 +1nqT1c4woqPfvQnHqBBtRsIZA==
X-Google-Smtp-Source: AGHT+IHX8b9TL9znNXSW1Aqv2mE+KpK/xrCJrX8gj0A1BylXH4aGaR/b44XcbtbQQN7xjvsWYwZYuQ==
X-Received: by 2002:a05:6a20:2444:b0:123:152d:d46b with SMTP id
 t4-20020a056a20244400b00123152dd46bmr2229233pzc.26.1692254389252; 
 Wed, 16 Aug 2023 23:39:49 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 s24-20020aa78298000000b00666b3706be6sm12103098pfm.107.2023.08.16.23.39.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Aug 2023 23:39:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
From: Li Feng <fengli@smartx.com>
In-Reply-To: <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
Date: Thu, 17 Aug 2023 14:40:24 +0800
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
 <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


> 2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphae=
l Norwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Why can=E2=80=99t we rather fix this by adding a =E2=80=9Cevent_cb=E2=80=
=9D param to vhost_user_async_close and then call =
qemu_chr_fe_set_handlers in vhost_user_async_close_bh()?
>=20
> Even if calling vhost_dev_cleanup() twice is safe today I worry future =
changes may easily stumble over the reconnect case and introduce crashes =
or double frees.
>=20
I think add a new event_cb is not good enough. =
=E2=80=98qemu_chr_fe_set_handlers=E2=80=99 has been called in =
vhost_user_async_close, and will be called in event->cb, so why need add =
a
new event_cb?
=20
For avoiding to call the vhost_dev_cleanup() twice, add a =E2=80=98inited=E2=
=80=99 in struct vhost-dev to mark if it=E2=80=99s inited like this:

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..edc80c0231 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1502,6 +1502,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void =
*opaque,
         goto fail_busyloop;
     }

+    hdev->inited =3D true;
     return 0;

 fail_busyloop:
@@ -1520,6 +1521,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
 {
     int i;

+    if (!hdev->inited) {
+        return;
+    }
+    hdev->inited =3D false;
     trace_vhost_dev_cleanup(hdev);

     for (i =3D 0; i < hdev->nvqs; ++i) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index ca3131b1af..74b1aec960 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -123,6 +123,7 @@ struct vhost_dev {
     /* @started: is the vhost device started? */
     bool started;
     bool log_enabled;
+    bool inited;
     uint64_t log_size;
     Error *migration_blocker;
     const VhostOps *vhost_ops;

Thanks.

>=20
>> On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>> When the vhost-user is reconnecting to the backend, and if the =
vhost-user fails
>> at the get_features in vhost_dev_init(), then the reconnect will fail
>> and it will not be retriggered forever.
>>=20
>> The reason is:
>> When the vhost-user fail at get_features, the vhost_dev_cleanup will =
be called
>> immediately.
>>=20
>> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.
>>=20
>> The reconnect path is:
>> vhost_user_blk_event
>>  vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>>    qemu_chr_fe_set_handlers <----- clear the notifier callback
>>      schedule vhost_user_async_close_bh
>>=20
>> The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
>> called, then the event fd callback will not be reinstalled.
>>=20
>> With this patch, the vhost_user_blk_disconnect will call the
>> vhost_dev_cleanup() again, it's safe.
>>=20
>> All vhost-user devices have this issue, including =
vhost-user-blk/scsi.
>>=20
>> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/virtio/vhost-user.c | 10 +---------
>> 1 file changed, 1 insertion(+), 9 deletions(-)
>>=20
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 8dcf049d42..697b403fe2 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2648,16 +2648,8 @@ typedef struct {
>> static void vhost_user_async_close_bh(void *opaque)
>> {
>>    VhostAsyncCallback *data =3D opaque;
>> -    struct vhost_dev *vhost =3D data->vhost;
>>=20
>> -    /*
>> -     * If the vhost_dev has been cleared in the meantime there is
>> -     * nothing left to do as some other path has completed the
>> -     * cleanup.
>> -     */
>> -    if (vhost->vdev) {
>> -        data->cb(data->dev);
>> -    }
>> +    data->cb(data->dev);
>>=20
>>    g_free(data);
>> }
>> --=20
>> 2.41.0
>>=20
>=20


