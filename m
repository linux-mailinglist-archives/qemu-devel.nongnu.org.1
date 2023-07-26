Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53938763C00
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgiK-0006kz-Kw; Wed, 26 Jul 2023 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOghV-00068H-Tl
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOghS-0008Ca-Ty
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690386318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjLOSgXH+hDlx4S+24ByIvJQpEavm7lVF2V8VIQ/Xjs=;
 b=biaHLKITi5y296x3XwNlby2UPLlPlauSMChDiZ16OSY67A3NmQHGgqbHlN7k09R86xn0hi
 eEbOLgD4VDkQ/SYvn0ZkKxaWYqM5GTmO+49BBoTGFA5P5QEPEo/gRic5g1upd2IGst0XYa
 tA7x2lblZHjtPOP9v4oI0voeM+7w2dY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-327rCg29PISMQwakb5LmVQ-1; Wed, 26 Jul 2023 11:45:16 -0400
X-MC-Unique: 327rCg29PISMQwakb5LmVQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fb416d7731so34677265e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690386313; x=1690991113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjLOSgXH+hDlx4S+24ByIvJQpEavm7lVF2V8VIQ/Xjs=;
 b=bJ9VIh4YJCLve1hSXC/3CHUajVwe8WwIHYsuYvAAZCce/uTo9mt6bJHoU+35F46VjA
 JNUDvazmmJjLQhoRD7IPY6+XlFfcp4OShM7S3snpZiIMVB9QaYxQv+LMTXDyB8O+L/dv
 Ohuoh7oVfG9KN1RaPa1XwVFAdiEaanK3fshY49XsfuCbwSxXDs+OZILfw+FcZryFXWBN
 YOb6IywJBNv6LBUI6qAMcfN0xFsTk5XetNJXUNtvv4G4yMXg1UuljCK/Pig2w9ZGe6Mb
 UkSmHOUwPndRE8Wcq7K5xILZoRIotUQr+LxgE5qX1P07TW7JMNz7ue7/DQqdGD3IJMW+
 pVAw==
X-Gm-Message-State: ABy/qLa9PEjfqTAzFKE3r4m/xxlzMPgJtGc4llXV6O92p+8AElgSKsRN
 CLoOX5BoAwhJhj6KZhCdNq3/VEg0pOITnOtP4yLoJJ1ud5YH/s6rf6y/ue3HmQ+A5Nhy5MbCvP3
 Ftqpc9mcHhAS4C4U=
X-Received: by 2002:a7b:c419:0:b0:3fb:fda1:710c with SMTP id
 k25-20020a7bc419000000b003fbfda1710cmr1548461wmi.2.1690386313202; 
 Wed, 26 Jul 2023 08:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEidlm/EsJ2/gdWhJnf36JjPNFbrUY/Jo5Om1Cf/uyKa7QNv9W2as8d3IiC5vzJUHX9DDsumw==
X-Received: by 2002:a7b:c419:0:b0:3fb:fda1:710c with SMTP id
 k25-20020a7bc419000000b003fbfda1710cmr1548447wmi.2.1690386312802; 
 Wed, 26 Jul 2023 08:45:12 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.111.137])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a5d65d2000000b00314172ba213sm20135068wrw.108.2023.07.26.08.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 08:45:12 -0700 (PDT)
Date: Wed, 26 Jul 2023 17:45:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH 1/2] block/blkio: fix opening virtio-blk drivers
Message-ID: <hm5av25cfbgptthzawmi7n3xguckzzmwpgnvtqfnwo33hwkoh3@waeosl26nmyh>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-2-sgarzare@redhat.com>
 <20230725200038.GB749269@fedora>
 <zba7q3vye5fwm33wkmmoajiya6mq3oesn3isqtf4qb24vdbn6u@ru7fzcovwmow>
 <20230726153210.GD809650@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726153210.GD809650@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 26, 2023 at 11:32:10AM -0400, Stefan Hajnoczi wrote:
>On Wed, Jul 26, 2023 at 09:26:45AM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 25, 2023 at 04:00:38PM -0400, Stefan Hajnoczi wrote:
>> > On Mon, Jul 24, 2023 at 05:46:10PM +0200, Stefano Garzarella wrote:
>> > > libblkio 1.3.0 added support of "fd" property for virtio-blk-vhost-vdpa
>> > > driver. In QEMU, starting from commit cad2ccc395 ("block/blkio: use
>> > > qemu_open() to support fd passing for virtio-blk") we are using
>> > > `blkio_get_int(..., "fd")` to check if the "fd" property is supported
>> > > for all the virtio-blk-* driver.
>> > >
>> > > Unfortunately that property is also available for those driver that do
>> > > not support it, such as virtio-blk-vhost-user. Indeed now QEMU is
>> > > failing if used with virtio-blk-vhost-user in this way:
>> > >
>> > >    -blockdev node-name=drive0,driver=virtio-blk-vhost-user,path=vhost-user-blk.sock,cache.direct=on: Could not open 'vhost-user-blk.sock': No such device or address
>> > >
>> > > So, `blkio_get_int()` is not enough to check whether the driver supports
>> > > the `fd` property or not. This is because the virito-blk common libblkio
>> > > driver only checks whether or not `fd` is set during `blkio_connect()`
>> > > and fails for those transports that do not support it (all except
>> > > vhost-vdpa for now).
>> > >
>> > > So for now let's also check that the driver is virtio-blk-vhost-vdpa,
>> > > since that's the only one that supports it.
>> >
>> > What happens when more virtio-blk-* libblkio drivers gain support for
>> > `fd`? I think we'll be back to the same problem because QEMU will be
>> > unable to distinguish between old and new libraries.
>>
>> If we release a v1.3.1 version of libblkio with
>> https://gitlab.com/libblkio/libblkio/-/merge_requests/208
>> we can set a minimum requirement in QEMU and use blkio_set_fd() here.
>>
>> >
>> > How about retrying with `path` if opening with `fd` fails?
>>
>> IIUC the only way is to check if blkio_connect() will fail with -EINVAL,
>> that can also be generated by other issues, then retry forcing `path`.
>>
>> Do you see other ways?
>
>No. Checking for -EINVAL and then retrying with `path` is what I had in
>mind.
>
>> The code wouldn't be great, but we could do it for now and then when
>> we release a new version of libblkio, do the revert and use
>> blkio_set_int(fd) to see if it's supported or not.
>>
>> I don't know if it is worth it, or if it is better to merge this,
>> release libblkio v1.3.1 and force the minimum requirement.
>>
>> WDYT?
>
>I prefer retrying on -EINVAL because even if libblkio 1.3.1 is released
>today, we don't have control over when it becomes available in distros.

Fair point!

I'll send v2 using that approach!

Thanks,
Stefano


