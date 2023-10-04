Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E77B7D7C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzMr-00015b-GE; Wed, 04 Oct 2023 06:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzMg-00012e-Fp
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzMd-0001ah-VO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696416262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvoR9a1Vl0iCq+mDQkWoWTD9UW9RXt13PsHyN3NUyYU=;
 b=fPodAmv27yv21X7gaCx3W/fk6qb1/9Zd4gZ6OrqI72ZIuzy42IK8ieH0S42HYrl/70J4qv
 v27L1jYG4FNb2lqBjIpFaaTycypOOk8751hdTJj015ngpfiYiWiT8Dhke2bFHP+EnIQ5xp
 g0p5ZQXVawMrb/KFcrKovDN/gDjJbgs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ED_9k5a4N2GzCtRqZbGbSw-1; Wed, 04 Oct 2023 06:44:16 -0400
X-MC-Unique: ED_9k5a4N2GzCtRqZbGbSw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso174340266b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696416255; x=1697021055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvoR9a1Vl0iCq+mDQkWoWTD9UW9RXt13PsHyN3NUyYU=;
 b=xH6BXsM/TNfTBJZfF1sxCZeFEpNqeHPxR0rNo1MEZajf8r6Oci9xbHny9lDHo7Ep3L
 CXpiInUyvjhSMJIJYqRUmwEPG8RxB9nWFkT1nVUpybacKhIgMNn5a8QEmAUktxWsbb+F
 Y7BFECJH9wn/cpuGpP2zdXvSOSYRYXlE9R2IR6jPHU1yzZhpa6PgPLm5SG46jrQwoXPh
 jyAXEIoDSMM84aKjFST+OgdNZ7lc/pMxpJEYtr9XHMM8QgwwaL4nv6FmE1lQ6sP4P+t3
 KjaQ9dRbo7pTwU6UBwYAqJ7mek2qWRMA9KImdCs/7LIwe2rW8wfoT6hOtiu1uFq97TTq
 Ii/A==
X-Gm-Message-State: AOJu0YzqEQWjV9CCH9Wd5WlXRJzorJxjJDyoW6FyqhKUxcb6Jh107sy/
 ljS7M0/a6chXB4BvzQacDJCrdc7uNbtk8w/0QjSDCjvb+DprU+0ohhBkz8S7jcY5xzhJe4ZAGN2
 S2Udzk1S2TwLR9Ws=
X-Received: by 2002:a17:906:5193:b0:9ae:5848:3f8e with SMTP id
 y19-20020a170906519300b009ae58483f8emr1717315ejk.49.1696416255230; 
 Wed, 04 Oct 2023 03:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKhaxuYkQ6lZ/9Er/zDarCccZUDfhzj1F2fNZyds64x4TIdwJqlTeAiUO18U1pOFDA32dlZQ==
X-Received: by 2002:a17:906:5193:b0:9ae:5848:3f8e with SMTP id
 y19-20020a170906519300b009ae58483f8emr1717298ejk.49.1696416254862; 
 Wed, 04 Oct 2023 03:44:14 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709063c4c00b0099275c59bc9sm2625903ejg.33.2023.10.04.03.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 03:44:14 -0700 (PDT)
Message-ID: <346cfde5-82af-724e-cc02-8f55d06e67ee@redhat.com>
Date: Wed, 4 Oct 2023 12:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] vhost-user: do not send RESET_OWNER on device reset
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, eperezma@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
 <20231004014532.1228637-2-stefanha@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231004014532.1228637-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.10.23 03:45, Stefan Hajnoczi wrote:
> The VHOST_USER_RESET_OWNER message is deprecated in the spec:
>
>     This is no longer used. Used to be sent to request disabling all
>     rings, but some back-ends interpreted it to also discard connection
>     state (this interpretation would lead to bugs).  It is recommended
>     that back-ends either ignore this message, or use it to disable all
>     rings.

According to the spec, it is then indeed better to not call it in 
vhost_user_reset_device, because it seems like it would be interpreted 
as something completely different.

However, between the three back-end implementations of vhost-user I know 
of (libvhost-user, DPDK, the vhost crates; four if you count RSD), none 
implement RESET_DEVICE.  libvhost-user and DPDK do implement 
RESET_OWNER, though, and they both do it by resetting the device, not by 
disabling any vring.  The vhost crate also implements RESET_OWNER, but 
it doesn’t do anything but forward it as such to the actual device 
implementation (virtiofsd doesn’t implement this function, so ignores 
it).  It does document that it would disable all vrings, but does so in 
the past and has marked it deprecated (ever since the method was 
introduced in the fourth commit to the repository, making it extremely 
unlikely that anyone would implement it).

So I would like to know why the spec says that it would disable all 
vrings, when none of the implementations (qemu, libvhost-user, DPDK) 
agree on that.  Let me look it up:

Before commit c61f09ed855, it did say “stopping” instead of 
“disabling”.  The commit doesn’t explain why it changed this. Commit 
a586e65bbd0 (just a week prior) deprecated the command, changing it from 
“connection is about to be closed, [front-end] will no longer own this 
connection” to “deprecated, used to be sent to request stopping all 
vrings”.  To me, the front-end closing the connection sounds like a good 
point to reset, which would indeed stop all vrings, but not just that.  
Notably, qemu agrees, because RESET_OWNER is used only in the 
vhost_user_reset_device() function. a586e65bbd0^ removed that function’s 
use, though, specifically because it would cause a reset, when the 
intention was just to stop.

So it sounds to me like “used to be sent to request stopping all vrings” 
is rather what vhost_net wanted, but specifically not what the message 
did, which was anything between nothing and a reset, I presume (because 
it never specified what the back-end was supposed to do, though 
apparently libvhost-user and DPDK both took it to mean reset).  Why it 
was then changed to “disabling”, I absolutely cannot say.

Now, the code change here is indeed effectively a no-op, as you deduce 
below, but in the context of the whole series the situation is a bit 
different: As far as I understand, the point is to have guest-initiated 
resets be forwarded to back-ends.  But by removing the RESET_OWNER 
fallback, no back-end will actually do a reset still.

I understand that as per the specification, using RESET_OWNER for 
resetting is wrong.  But all implementations that implemented it before 
it was deprecated do interpret it as a reset, so I don’t think using it 
as a fallback is actually wrong.

Hanna

> The only caller of vhost_user_reset_device() is vhost_user_scsi_reset().
> It checks that F_RESET_DEVICE was negotiated before calling it:
>
>    static void vhost_user_scsi_reset(VirtIODevice *vdev)
>    {
>        VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
>        struct vhost_dev *dev = &vsc->dev;
>
>        /*
>         * Historically, reset was not implemented so only reset devices
>         * that are expecting it.
>         */
>        if (!virtio_has_feature(dev->protocol_features,
>                                VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
>            return;
>        }
>
>        if (dev->vhost_ops->vhost_reset_device) {
>            dev->vhost_ops->vhost_reset_device(dev);
>        }
>    }
>
> Therefore VHOST_USER_RESET_OWNER is actually never sent by
> vhost_user_reset_device(). Remove the dead code. This effectively moves
> the vhost-user protocol specific code from vhost-user-scsi.c into
> vhost-user.c where it belongs.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/scsi/vhost-user-scsi.c |  9 ---------
>   hw/virtio/vhost-user.c    | 13 +++++++++----
>   2 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index ee99b19e7a..8582b2e8ab 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -71,15 +71,6 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
>       VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
>       struct vhost_dev *dev = &vsc->dev;
>   
> -    /*
> -     * Historically, reset was not implemented so only reset devices
> -     * that are expecting it.
> -     */
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> -        return;
> -    }
> -
>       if (dev->vhost_ops->vhost_reset_device) {
>           dev->vhost_ops->vhost_reset_device(dev);
>       }
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..7bed9ad7d5 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1492,12 +1492,17 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
>   {
>       VhostUserMsg msg = {
>           .hdr.flags = VHOST_USER_VERSION,
> +        .hdr.request = VHOST_USER_RESET_DEVICE,
>       };
>   
> -    msg.hdr.request = virtio_has_feature(dev->protocol_features,
> -                                         VHOST_USER_PROTOCOL_F_RESET_DEVICE)
> -        ? VHOST_USER_RESET_DEVICE
> -        : VHOST_USER_RESET_OWNER;
> +    /*
> +     * Historically, reset was not implemented so only reset devices
> +     * that are expecting it.
> +     */
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> +        return -ENOSYS;
> +    }
>   
>       return vhost_user_write(dev, &msg, NULL, 0);
>   }


