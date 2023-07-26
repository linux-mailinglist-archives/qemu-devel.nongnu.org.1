Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C168B762D7F
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYwn-00056G-63; Wed, 26 Jul 2023 03:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOYwb-00055K-AA
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOYwZ-0002qY-KS
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690356503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNe9UCANzuArez9z4jnAf89IVzirxR0uXihDJffyO68=;
 b=TWLb3qnSo7GlpbzAau3OATCjcZB5imKZawlR6rudoDuFi3jQjYmab3A+654R7jBnZCnRto
 niNNvOL+QSJv1Fkm1yRxa5qS1ZawlGwOygW5Jxu8+n3R2qYzj9KlFR5QzvoQfotRB3zRYx
 Yd6HRtshlnVWjFs8cd1OFf+8X6BwQvg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-BPyTAQyhM-e5nsRAWPAI8g-1; Wed, 26 Jul 2023 03:28:21 -0400
X-MC-Unique: BPyTAQyhM-e5nsRAWPAI8g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993831c639aso423794766b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690356500; x=1690961300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNe9UCANzuArez9z4jnAf89IVzirxR0uXihDJffyO68=;
 b=JSJP74533Atuh/VPZ68GdmPdbspgrGsyuDaReCjAew5WdoLltpa9BVedc8oGUILCrw
 J5AasnYvJDJqeKrYEv+lzhD3vMGEPvkt8fMf+ZCQDZkLkqmRKQmUyG2516Reco8JCPlB
 TYCMGFI32V08Y9zEtBszSejVQKffOD4MYygLbJwyHW7vf64TyzuGXn2yB05l1JBHMnlb
 KrE7DiSUSp/R6EG0VLJcrKmBWtp5PP+cxNZ6C/7ifl6L5D6RJmvs3j1qd425AG+cwhnG
 rvdyJtytytXbaVJXoKPnKCxQJhWlwoCGrncIBZ+WwZHM2XXU+RsLBWx/o6GHizsAfqXz
 vVOg==
X-Gm-Message-State: ABy/qLaTfYVCcTFTgFD8uU6SGcuelwAmfINAX4XIuYTOzF3rnOgpmj64
 cGoA+ORF2fNU6fMklowFB2Mo1D6pDXRIgm77eFWg7a3JKPn9KQRH5ojlEnPhhlr2ygBu8x8BfcY
 aaG8WtSuJVYicvbw=
X-Received: by 2002:a17:907:770d:b0:99b:499d:4635 with SMTP id
 kw13-20020a170907770d00b0099b499d4635mr907529ejc.75.1690356500449; 
 Wed, 26 Jul 2023 00:28:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlRhZ3K8TbMp6muRvZuXW9i8NCzb6giPqP3lixCqCYy+VOaTvBWN91Wu0zANa0DYAmmFGD0Q==
X-Received: by 2002:a17:907:770d:b0:99b:499d:4635 with SMTP id
 kw13-20020a170907770d00b0099b499d4635mr907512ejc.75.1690356500121; 
 Wed, 26 Jul 2023 00:28:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.111.137])
 by smtp.gmail.com with ESMTPSA id
 l24-20020a1709066b9800b009893f268b92sm9116489ejr.28.2023.07.26.00.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 00:28:19 -0700 (PDT)
Date: Wed, 26 Jul 2023 09:28:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] block/blkio: use blkio_set_int("fd") to check fd
 support
Message-ID: <oiiiyd53pcqc6vt6u2kn3vcysfs5ovqlsm4uxacdpw57dkwojp@x73gzawwkxut>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-3-sgarzare@redhat.com>
 <20230725200538.GC749269@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230725200538.GC749269@fedora>
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

On Tue, Jul 25, 2023 at 04:05:38PM -0400, Stefan Hajnoczi wrote:
>On Mon, Jul 24, 2023 at 05:46:11PM +0200, Stefano Garzarella wrote:
>> The way the virtio-blk driver is implemented in libblkio,
>> it's much easier to use blkio_set_int() instead of blkio_get_int()
>> and have it fail right away to see if `fd` is supported by the
>> transport. See https://gitlab.com/libblkio/libblkio/-/merge_requests/208
>
>The commit description is vague about what's going on here. My
>understanding is:
>
>  Setting the `fd` property fails with virtio-blk-* libblkio drivers
>  that do not support fd passing since
>  https://gitlab.com/libblkio/libblkio/-/merge_requests/208.
>
>  Getting the `fd` property, on the other hand, always succeeds for
>  virtio-blk-* libblkio drivers even when they don't support fd passing.
>
>  This patch switches to setting the `fd` property because it is a
>  better mechanism for probing fd passing support than getting the `fd`
>  property.
>
>Please update the commit description. Thanks!

Ack, I'll update it.

Thanks,
Stefano

>
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  block/blkio.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blkio.c b/block/blkio.c
>> index ca1149042a..719b19324b 100644
>> --- a/block/blkio.c
>> +++ b/block/blkio.c
>> @@ -665,7 +665,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
>>      const char *blkio_driver = bs->drv->protocol_name;
>>      BDRVBlkioState *s = bs->opaque;
>>      bool fd_supported = false;
>> -    int fd, ret;
>> +    int ret;
>>
>>      if (!path) {
>>          error_setg(errp, "missing 'path' option");
>> @@ -678,7 +678,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
>>      }
>>
>>      if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0 &&
>> -        blkio_get_int(s->blkio, "fd", &fd) == 0) {
>> +        blkio_set_int(s->blkio, "fd", -1) == 0) {
>>          fd_supported = true;
>>      }
>>
>> @@ -688,7 +688,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
>>       * layer through the "/dev/fdset/N" special path.
>>       */
>>      if (fd_supported) {
>> -        int open_flags;
>> +        int open_flags, fd;
>>
>>          if (flags & BDRV_O_RDWR) {
>>              open_flags = O_RDWR;
>> --
>> 2.41.0
>>



