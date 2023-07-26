Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC15762D59
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYvK-0004MI-QC; Wed, 26 Jul 2023 03:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOYv9-0004M4-Dg
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOYv7-0002R0-St
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690356412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwtGQKyzasT4BagATqnb1msP6Otumuz4N/5SexwFmRc=;
 b=T5q0mLrkXkW7NcGtIt2YLnW44uDl28xQe3Y+zjF6vQmYX5OpopwG93mt00xxNuYaHCQM/e
 pGPuaFeEOlNxAq1aRQRni53DhBQuKEJVqVJ9kOcb9DuDqekpgIV1eePCfTMt93QvM2tmXN
 kbDRM3sTYf+pk5/xR+d5o3lf2t95rsg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-zJuF-uQRO7uPv98Uvrgiqg-1; Wed, 26 Jul 2023 03:26:50 -0400
X-MC-Unique: zJuF-uQRO7uPv98Uvrgiqg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso3393966b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690356409; x=1690961209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwtGQKyzasT4BagATqnb1msP6Otumuz4N/5SexwFmRc=;
 b=N/53JUA6x27WdeE5PMr7ndhmLgmjwZMGyh5NYZj4kyE2uLxoe6dpf6okO0sfEouBKO
 ABV3n75c6eBUTpaAOeKKF1E8JX8Db8CpxmGVig9B8pQr29ek5/uNKB8BW2tMJfZNppCb
 23ekkYAXSUFy86GLdAxCAwJtk7RSXYQ4aC6jU71a1J6uLUDeQgNlXkk9iacX3eKYDvw3
 xiF6NLTMmrNznjJHJ6Pw+e4fybmciLE/poe6CXJiL+/Kg/p5K3fCKiWsrCQFcmQnDzB4
 hfoPmF2Lo/eSrdNw8/LfSnqBNqXnhqR+mXGcBcURqYb/r+3bb6eNWOgDSLd48ul9uiiF
 weOQ==
X-Gm-Message-State: ABy/qLbtGishiebNiB2tPR7+J9QaiVnU+NsES5X3QkPOfU2AFC8XjDvY
 5kwmnH8P+Iveat+qYMIo/n20seHec4ToBlbuqoz+xrCO38cZXuw4dQq5m4FrTWxAd+mHFD4/Z2+
 oPmTI40TjIAyNmAc=
X-Received: by 2002:a17:907:7883:b0:993:eddd:6df4 with SMTP id
 ku3-20020a170907788300b00993eddd6df4mr1057041ejc.10.1690356408944; 
 Wed, 26 Jul 2023 00:26:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHuVmZFk3ajVlNOSxsWnguMBuAScgsV284eoVEAd7zeUcaYcgBBC0rEaLGkpFLrpX8nOuQglg==
X-Received: by 2002:a17:907:7883:b0:993:eddd:6df4 with SMTP id
 ku3-20020a170907788300b00993eddd6df4mr1057024ejc.10.1690356408570; 
 Wed, 26 Jul 2023 00:26:48 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.111.137])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a1709065f8600b0098ec690e6d7sm9236392eju.73.2023.07.26.00.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 00:26:48 -0700 (PDT)
Date: Wed, 26 Jul 2023 09:26:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH 1/2] block/blkio: fix opening virtio-blk drivers
Message-ID: <zba7q3vye5fwm33wkmmoajiya6mq3oesn3isqtf4qb24vdbn6u@ru7fzcovwmow>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-2-sgarzare@redhat.com>
 <20230725200038.GB749269@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230725200038.GB749269@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 25, 2023 at 04:00:38PM -0400, Stefan Hajnoczi wrote:
>On Mon, Jul 24, 2023 at 05:46:10PM +0200, Stefano Garzarella wrote:
>> libblkio 1.3.0 added support of "fd" property for virtio-blk-vhost-vdpa
>> driver. In QEMU, starting from commit cad2ccc395 ("block/blkio: use
>> qemu_open() to support fd passing for virtio-blk") we are using
>> `blkio_get_int(..., "fd")` to check if the "fd" property is supported
>> for all the virtio-blk-* driver.
>>
>> Unfortunately that property is also available for those driver that do
>> not support it, such as virtio-blk-vhost-user. Indeed now QEMU is
>> failing if used with virtio-blk-vhost-user in this way:
>>
>>    -blockdev node-name=drive0,driver=virtio-blk-vhost-user,path=vhost-user-blk.sock,cache.direct=on: Could not open 'vhost-user-blk.sock': No such device or address
>>
>> So, `blkio_get_int()` is not enough to check whether the driver supports
>> the `fd` property or not. This is because the virito-blk common libblkio
>> driver only checks whether or not `fd` is set during `blkio_connect()`
>> and fails for those transports that do not support it (all except
>> vhost-vdpa for now).
>>
>> So for now let's also check that the driver is virtio-blk-vhost-vdpa,
>> since that's the only one that supports it.
>
>What happens when more virtio-blk-* libblkio drivers gain support for
>`fd`? I think we'll be back to the same problem because QEMU will be
>unable to distinguish between old and new libraries.

If we release a v1.3.1 version of libblkio with
https://gitlab.com/libblkio/libblkio/-/merge_requests/208
we can set a minimum requirement in QEMU and use blkio_set_fd() here.

>
>How about retrying with `path` if opening with `fd` fails?

IIUC the only way is to check if blkio_connect() will fail with -EINVAL,
that can also be generated by other issues, then retry forcing `path`.

Do you see other ways?

The code wouldn't be great, but we could do it for now and then when
we release a new version of libblkio, do the revert and use
blkio_set_int(fd) to see if it's supported or not.

I don't know if it is worth it, or if it is better to merge this,
release libblkio v1.3.1 and force the minimum requirement.

WDYT?

Thanks,
Stefano


