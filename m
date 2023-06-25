Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C00173CFA4
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 11:13:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLnU-0001Fs-Ab; Sun, 25 Jun 2023 05:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDLnQ-0001Fb-Sj
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 05:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDLnP-0002s7-75
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 05:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687684353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YosYUU3gtLpa7sd8J7bYfBWTq50sROCUV3ftmVv4NZ8=;
 b=PSdevPmanJXB9da/KO7k9yFibF6Cf+L9i45IUL/MKVPQQHc77zhw+v5OMDUDLznk3pU3Af
 oD3c8twqDhIFFT1Semo5++9HLui576t7MHXQzdPX+LSIkT0WH9FGLFf41XmeX+dV7byk6d
 wZuAWCyN12X9PsshGP5hfdN/XuX7CC0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-rFs65jfJOgaI3KHA8PF_BA-1; Sun, 25 Jun 2023 05:12:31 -0400
X-MC-Unique: rFs65jfJOgaI3KHA8PF_BA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-c17812e30b4so1053815276.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 02:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687684351; x=1690276351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YosYUU3gtLpa7sd8J7bYfBWTq50sROCUV3ftmVv4NZ8=;
 b=O+RzW/NuF/x0CgqrJQIUbawW361Mpz+jfNO6FQb9Ya6of7ADDMoS2G30EZmKyX0gMI
 Y66BINNCbEnkxo+DDlrRDIwZMFycyOP3YkwIS2ruibjIUq1W4i/m+Xxun16r4bUY3Zp9
 HVxft5m5/adidcjcSHxVOmCPnQqPZs8Zk4HX69z3SdB9uHTJrKlCR8XL5Gxx2/cy48Yw
 RNh/LLz4iDUJao/bl629l0kq1OCqGHqcyCZLqIE4QaD72cXP2PVi3S9ErG7l5IntB7r6
 33tpz7cMKvLsUHcEpvv3w5djMcmkdtP9cmokh8HI7lwbk/eoSMCoX8Xy37U6xFx61hAj
 iSyg==
X-Gm-Message-State: AC+VfDxDJr5L0OUWMrgCFqRojuovEAQmNM90AESxFG3j5I8Ygz/VhsAI
 XxS01cscXpQra40FegROM86oTiS2LSzQ/d7f0zhcmddRvZJ6SSROJTk9p0ZptIakCN2QW9oIs9H
 JURVlMVdiXTY9vnJeeMjtUcavnrBrUN0=
X-Received: by 2002:a25:42c8:0:b0:bce:9515:b904 with SMTP id
 p191-20020a2542c8000000b00bce9515b904mr22683155yba.2.1687684351380; 
 Sun, 25 Jun 2023 02:12:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JAJ1x4drwSydaW8cXLGpqJhrw7/1FSbneG0ea+C94iF034Sj2V0BTFdSKUEO6vsIp6bIMi40Y4MaTkXYK02k=
X-Received: by 2002:a25:42c8:0:b0:bce:9515:b904 with SMTP id
 p191-20020a2542c8000000b00bce9515b904mr22683132yba.2.1687684351067; Sun, 25
 Jun 2023 02:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153143.470745-1-eperezma@redhat.com>
 <CAFEAcA_7C7jD5x+eT6XbheMYAESVy-VNn2RXxg4pBW9c7PN=tA@mail.gmail.com>
In-Reply-To: <CAFEAcA_7C7jD5x+eT6XbheMYAESVy-VNn2RXxg4pBW9c7PN=tA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 11:11:55 +0200
Message-ID: <CAJaqyWcG7pf1Qg=-vDQwiqk9N0nBfpvtxLQuwmC0wJPCDL7=kA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Move ASID test to vhost-vdpa net initialization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com, 
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, 
 Cindy Lu <lulu@redhat.com>, Lei Yang <leiyang@redhat.com>, 
 Harpreet Singh Anand <hanand@xilinx.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Jason Wang <jasowang@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, alvaro.karsz@solid-run.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 23, 2023 at 3:06=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 26 May 2023 at 16:32, Eugenio P=C3=A9rez <eperezma@redhat.com> wr=
ote:
> >
> > QEMU v8.0 is able to switch dynamically between vhost-vdpa passthrough
> > and SVQ mode as long as the net device does not have CVQ.  The net devi=
ce
> > state followed (and migrated) by CVQ requires special care.
> >
> > A pre-requisite to add CVQ to that framework is to determine if devices=
 with
> > CVQ are migratable or not at initialization time.  The solution to it i=
s to
> > always shadow only CVQ, and vq groups and ASID are used for that.
> >
> > However, current qemu version only checks ASID at device start (as "dri=
ver set
> > DRIVER_OK status bit"), not at device initialization.  A check at
> > initialization time is required.  Otherwise, the guest would be able to=
 set
> > and remove migration blockers at will [1].
> >
> > This series is a requisite for migration of vhost-vdpa net devices with=
 CVQ.
> > However it already makes sense by its own, as it reduces the number of =
ioctls
> > at migration time, decreasing the error paths there.
>
> Hi -- since you're working on the net_init_vhost_vdpa() code,
> would you mind having a look at Coverity CID 1490785 ?
> This is about a leak of the vdpa_device_fd. We fixed one
> instance of that leak in commit aed5da45daf734ddc54 but
> it looks like there's still a different leak:
>
>     for (i =3D 0; i < queue_pairs; i++) {
>         ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                      vdpa_device_fd, i, 2, true, opts->x_=
svq,
>                                      iova_range, features);
>         if (!ncs[i])
>             goto err;
>     }
>
>     if (has_cvq) {
>         nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                  vdpa_device_fd, i, 1, false,
>                                  opts->x_svq, iova_range, features);
>         if (!nc)
>             goto err;
>     }
>
>     return 0;
>
> In this code, if queue_pairs is non-zero we will use
> vdpa_device_fd because we pass it to net_vhost_vdpa_init().
> Similarly, if has_cvq is true then we'll also use the fd.
> But if queue_pairs is zero and has_cvq is false then we
> will not do anything with the fd, and will return 0,
> leaking the file descriptor.
>
> Maybe this combination is not supposed to happen, but
> I can't see anything in vhost_vdpa_get_max_queue_pairs()
> or in this function which guards against it. If it's
> an invalid setup we should detect it and return an
> error, I think.
>

Yes, a device that returns 0 max_vq_pairs would be invalid. I will
introduce a guard for that.

Thanks for the heads up!

> thanks
> -- PMM
>


