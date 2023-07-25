Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53437614B5
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOG5y-0005MT-Rc; Tue, 25 Jul 2023 07:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOG5j-0005KH-JD
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOG5i-00049L-0r
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690284032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1w2A4cOOSzcsTU9VuEXRaec7AF2BaJL4AaL5kMAXAg=;
 b=UBJmsSmMZbTFzKOtfzRYuvY/6gawqKSpuoVQ2n+NMcP7DKg/iC+87SNS38F05M30hKNuxf
 bf6tvz1dNDpSUoPGkDaRg1Pxx91uMRsgedNKD2xw1Xb/GuSyWWdI4KLHljoUW2MGOc5Swn
 o99juwKdykEoIrIUmSbFhzj+4fbcGgU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-tFqa5A-lP1S7UX8S8GBIXg-1; Tue, 25 Jul 2023 07:20:31 -0400
X-MC-Unique: tFqa5A-lP1S7UX8S8GBIXg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315998d6e7fso2551637f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690284030; x=1690888830;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1w2A4cOOSzcsTU9VuEXRaec7AF2BaJL4AaL5kMAXAg=;
 b=ciZG9SYl4q4e7ehtmCITT52HHV/y/GQo+RL6+51ZMHs6uWBnqEQpJhntupt0XjF+ml
 0kn3W5CbTL+j9SZWNayVJv7q5IZReiARBj91/3qAHKt+NX11XdlleVuvYiVCDLD3kLih
 CXOVrgeJYxe+m+RQbpzQTmuzH3Wt8TKWEJTBuKVB3IrAUvXCkrObj5yjkpGYPEtCCr8C
 1BzoyHFVPQn9GPN8lAzPQ3ONLN23acIJgqKcoUtJipz8FViDFvuv+YecaXxvt7e6FQLG
 bsks7YwkrasUKNycOUT3bg5jdKOUBPeX1ChX/LZXPmYt1RoUfBk5Yi3yMfErDKJehO6D
 4/JQ==
X-Gm-Message-State: ABy/qLb8t5XVat7TSZO7IlEnp9etZVzD0IRCu8b46zhXHXi5xgj/eSpG
 qtRRph9bBiIFnsMLf4jzMW0yTU+YOJpKVCtUtt9tC4+CbSSQ6mhg4YoAmGGDJgwzGex75ByUaat
 1J9AbQ6SeiVWOUhk=
X-Received: by 2002:a5d:664b:0:b0:315:adf3:67db with SMTP id
 f11-20020a5d664b000000b00315adf367dbmr8132949wrw.59.1690284030521; 
 Tue, 25 Jul 2023 04:20:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHr2/mcGDEjZG7S67WvQc9SZLXDSguwerWL9E/Rwuj5XNpdPS8W8r2UBtsbNldXXbJBRSxzYg==
X-Received: by 2002:a5d:664b:0:b0:315:adf3:67db with SMTP id
 f11-20020a5d664b000000b00315adf367dbmr8132931wrw.59.1690284030128; 
 Tue, 25 Jul 2023 04:20:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.123])
 by smtp.gmail.com with ESMTPSA id
 o15-20020adfeacf000000b00313de682eb3sm16083216wrn.65.2023.07.25.04.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 04:20:29 -0700 (PDT)
Date: Tue, 25 Jul 2023 13:20:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH] block/blkio: do not use open flags in qemu_open()
Message-ID: <xdiqu4hjyf4mibnbfaauentm4ftsplenkpcdm74dlpb4nrrdlm@nyra5uejnwap>
References: <20230725111155.85426-1-sgarzare@redhat.com>
 <ZL+u3J8nAuyvgYzs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZL+u3J8nAuyvgYzs@redhat.com>
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

On Tue, Jul 25, 2023 at 12:15:40PM +0100, Daniel P. Berrangé wrote:
>On Tue, Jul 25, 2023 at 01:11:55PM +0200, Stefano Garzarella wrote:
>> qemu_open() in blkio_virtio_blk_common_open() is used to open the
>> character device (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or in
>> the future eventually the unix socket.
>>
>> In all these cases we cannot open the path in read-only mode,
>> when the `read-only` option of blockdev is on, because the exchange
>> of IOCTL commands for example will fail.
>>
>> In order to open the device read-only, we have to use the `read-only`
>> property of the libblkio driver as we already do in blkio_file_open().
>>
>> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
>> Reported-by: Qing Wang <qinwang@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  block/blkio.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/block/blkio.c b/block/blkio.c
>> index 1798648134..fe9bf8ea5f 100644
>> --- a/block/blkio.c
>> +++ b/block/blkio.c
>> @@ -686,15 +686,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
>>       * layer through the "/dev/fdset/N" special path.
>>       */
>>      if (fd_supported) {
>> -        int open_flags;
>> -
>> -        if (flags & BDRV_O_RDWR) {
>> -            open_flags = O_RDWR;
>> -        } else {
>> -            open_flags = O_RDONLY;
>> -        }
>> -
>> -        fd = qemu_open(path, open_flags, errp);
>
>I'd suggest taking the paragraph from the commit message explaining why
>it is correct to hardcode O_RDWR and putting it into a comment here.

Ack, I'd also add:

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2225439

in the commit message.

I'll fix in v2.

Thanks,
Stefano

>
>> +        fd = qemu_open(path, O_RDWR, errp);
>>          if (fd < 0) {
>>              return -EINVAL;
>>          }
>> --
>> 2.41.0
>>
>>
>
>With regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>


