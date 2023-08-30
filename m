Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B56B78D41D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGbh-0007KF-Qx; Wed, 30 Aug 2023 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGbf-0007Jz-Az
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGbd-0003uO-1w
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzlDG2ompQx6xlbiZ4bQ7msZUrJIOP2Br04dgYtf6Y0=;
 b=AsA67ZNv+tsD5/e7aPa2MLWqpAn1sG4270eZdqi48nmccP37yR+08m7ilPYnxt2n/SfENg
 W/T+KqUXq0QZEE/SW1rUzNQ5j/P5DK6BzjJIIm3sbQTSOmmLiROFo4iKgFENNijGvud4f6
 6xobJdkbXnxvAulsFsjo/EH37fBh06w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-LucVAf2JPOe3b8ZeM3z41w-1; Wed, 30 Aug 2023 04:31:14 -0400
X-MC-Unique: LucVAf2JPOe3b8ZeM3z41w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso58440771fa.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384273; x=1693989073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzlDG2ompQx6xlbiZ4bQ7msZUrJIOP2Br04dgYtf6Y0=;
 b=Kv73DWQ0cdyZBecYkFUpBi4lwnwfxLeUxeoYfzvnj+Pf6vflLWYFfVQCa0d8YK/ZSm
 beCmssWOO8o2hffT4+9+Leauhsuiw6sGoTDqDDoVUiWcPMKM8cYMFycg0yMpCAnODs9L
 f8xNp+YcaAonJIfUUdhSESyaI+8TFlp72PDwNkCBYD5ck96DH54rk0xbjhELAOc4ZZJM
 SMfW0ElmGvpZSEPpefwAF1f2pocdUeMnNhtMl68TXRfebBBaWj5YAgzTO83vBHpLtepG
 1uDisTSPXa2Y51LB1i+ujVi9NGiLdPl43TpFUzenIKdA4E6aTwCyRjltR9XwhslAB7pT
 8EFQ==
X-Gm-Message-State: AOJu0Yy+TzRT3KepCSwX+HEb89hPRVg8bRTbB0l08PikmnpqmmyRcdIF
 FwuYOhHPBr3jZ+oOONrbc3e56QU326O42NldxY0k1YdocPRimz+D93jDB561a0sgYwGobIt/AH4
 FM8qY+yoMnanHmPg=
X-Received: by 2002:a2e:8045:0:b0:2bc:de8d:4ab1 with SMTP id
 p5-20020a2e8045000000b002bcde8d4ab1mr1272357ljg.6.1693384272989; 
 Wed, 30 Aug 2023 01:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvFPHDYqoo5fiW6zlq/24W7BB/Itf0fF2XPf/lSjoQsKA9lpnrYTEQZpra24AXlWP/LukveQ==
X-Received: by 2002:a2e:8045:0:b0:2bc:de8d:4ab1 with SMTP id
 p5-20020a2e8045000000b002bcde8d4ab1mr1272344ljg.6.1693384272663; 
 Wed, 30 Aug 2023 01:31:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 rs25-20020a170907037900b0099bd1a78ef5sm6870247ejb.74.2023.08.30.01.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:31:11 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:31:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 3/7] vhost-user: factor out "vhost_user_write_msg"
Message-ID: <ddnrsg2yifpwtnso37ob5sw2o4ysi7ohgexq2xolgacubpytl4@2wxnq5knlbzs>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-4-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-4-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Sun, Aug 27, 2023 at 08:29:33PM +0200, Laszlo Ersek wrote:
>The tails of the "vhost_user_set_vring_addr" and "vhost_user_set_u64"
>functions are now byte-for-byte identical. Factor the common tail out to a
>new function called "vhost_user_write_msg".
>
>This is purely refactoring -- no observable change.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 66 +++++++++-----------
> 1 file changed, 28 insertions(+), 38 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 64eac317bfb2..36f99b66a644 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1320,10 +1320,35 @@ static int enforce_reply(struct vhost_dev *dev,
>     return vhost_user_get_features(dev, &dummy);
> }
>
>+/* Note: "msg->hdr.flags" may be modified. */
>+static int vhost_user_write_msg(struct vhost_dev *dev, VhostUserMsg *msg,
>+                                bool wait_for_reply)

The difference between vhost_user_write() and vhost_user_write_msg() is
not immediately obvious from the function name, so I would propose
something different, like vhost_user_write_sync() or
vhost_user_write_wait().

Anyway, I'm not good with names and don't have a strong opinion, so this 
version is fine with me as well :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


