Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6067A6119
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYpL-0007nH-Ot; Tue, 19 Sep 2023 07:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYpF-0007jT-Ax
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYpD-0007sz-62
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695122606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeTafZtAzJaxwE1Nx2tUtUpcJxkavkXA3byQi9MNlRM=;
 b=DbJ+F1cXgIGvJEry+Pbft7O3YMQmAsgZZy1TPLiXfskCplvifLv+v/Pw8UPDQ2DzULs9ms
 h7qze/G4C/DgQdN+8d/+9OBhOg7jOOwBbrqOCppphwhCMstQPa/YZmwgtHq9lz6DMKpkcf
 H++JpyudPD3gZ2hirM1PccidGFlVw3s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-irYyx1BSO0K_IaBcZXGtzA-1; Tue, 19 Sep 2023 07:23:24 -0400
X-MC-Unique: irYyx1BSO0K_IaBcZXGtzA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5310e629933so1526636a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695122603; x=1695727403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GeTafZtAzJaxwE1Nx2tUtUpcJxkavkXA3byQi9MNlRM=;
 b=gxk/gtVI7ZPdPBENzePrs3FKXVGkjOhwWfihz3ylrr65AqAFZoQxUDvYxSCnJ8RhwW
 DWyJwLybD9WEifJKqc1bY15WAGZHCRdVNVP+BWnJPFt/VhG6jXcjqjOWBn9HdZXVERSx
 8CM+ijABPajmIV9GXmKcq8DCINv8NXBqyzswS9JlL25lLCqcy2lRf05IC5WOoGf6zAhh
 TRHftBK9MDUbqKPoXc6EuUSTyvbj0C5/eogViZoSn+duqN8TtTcW+RNezy3RZJSPkB+h
 Er4NV7c4DK7h9LDoVxJST86jScE8E+ZGOgglweTHxvVbh4JVWhechuO+UQ98PHCM72fB
 quew==
X-Gm-Message-State: AOJu0Yz2bXkwuWyTekQs93Y+GK9UAOwY+VB6ajPJdk1GY0+NXL1UmtnA
 8YheFOSrq/wuQkCSM3GbZ4ThbyLPcsqQfbSDc70ZOPcr+sptPpCXCTc41E9B4xnzq9K0o0PX9Ld
 HMWXXM76t3fFb+Bg=
X-Received: by 2002:a05:6402:50cf:b0:532:b974:671e with SMTP id
 h15-20020a05640250cf00b00532b974671emr1650569edb.41.1695122603161; 
 Tue, 19 Sep 2023 04:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPzjZEs6KVQVL6UUQK5UNPdDTF21/4MT+KQ7uGJVorwsPlwd9mtMU1RKkffTgfD3pbcqybxQ==
X-Received: by 2002:a05:6402:50cf:b0:532:b974:671e with SMTP id
 h15-20020a05640250cf00b00532b974671emr1650545edb.41.1695122602857; 
 Tue, 19 Sep 2023 04:23:22 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a056402021200b0052fdfd8870bsm7287631edv.89.2023.09.19.04.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 04:23:22 -0700 (PDT)
Message-ID: <ddea0946-4cd9-a259-5208-1f180de56b90@redhat.com>
Date: Tue, 19 Sep 2023 13:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Deadlock with SATA CD I/O and eject
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, John Levon <levon@movementarian.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <ZQiIxERjYmZb0v4l@movementarian.org> <ZQl+A0nys2v7UzeN@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <ZQl+A0nys2v7UzeN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19.09.23 12:54, Kevin Wolf wrote:
> Am 18.09.2023 um 19:28 hat John Levon geschrieben:
>> Observed with base of qemu 6.2.0, but from code inspection it looks to me like
>> it's still current in upstream master. Apologies if I have missed a fix in this
>> area.
>>
>> Symptom: run a UEFI-booted SATA CD Windows installer. When it hits "Loading
>> files.." screen, run an eject e.g.
>>
>> virsh qemu-monitor-command 64c6e190-ea7f-49e2-b2d5-6ba1814b00ae '{"execute":"eject", "arguments": { "id": "sata0-0-0" } }'
>>
>> qemu will get stuck like so:
>>
>> gdb) bt
>> #0  0x00007f8ba4b16036 in ppoll () from /lib64/libc.so.6
>> #1  0x0000561813c48ed5 in ppoll (__ss=0x0, __timeout=0x7ffcbd981a70, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:62
>> #2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=999896128) at ../util/qemu-timer.c:348
>> #3  0x0000561813c29be9 in fdmon_poll_wait (ctx=0x56181516e070, ready_list=0x7ffcbd981af0, timeout=999896128) at ../util/fdmon-poll.c:80
>> #4  0x0000561813c297e1 in aio_poll (ctx=ctx@entry=0x56181516e070, blocking=blocking@entry=true) at ../util/aio-posix.c:607
>> #5  0x0000561813ae2fad in bdrv_do_drained_begin (poll=true, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x56181533fcc0) at ../block/io.c:483
>> #6  bdrv_do_drained_begin (bs=0x56181533fcc0, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at ../block/io.c:446
>> #7  0x0000561813ad9982 in blk_drain (blk=0x5618161c1f10) at ../block/block-backend.c:1741
>> #8  0x0000561813ad9b8c in blk_remove_bs (blk=blk@entry=0x5618161c1f10) at ../block/block-backend.c:852
>> #9  0x000056181382b8ab in blockdev_remove_medium (has_device=<optimized out>, device=<optimized out>, has_id=<optimized out>, id=<optimized out>, errp=0x7ffcbd981c78) at ../block/qapi-sysemu.c:232
>> #10 0x000056181382bfb1 in qmp_eject (has_device=<optimized out>, device=0x0, has_id=<optimized out>, id=0x561815e6efe0 "sata0-0-0", has_force=<optimized out>, force=<optimized out>, errp=0x7ffcbd981c78) at ../block/qapi-sysemu.c:45
>>
>> We are stuck forever here:
>>
>>   351 static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
>>   352                                   bool poll)
>> ...
>>   380     if (poll) {
>>   381         BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
>>   382     }
>>
>> Because the blk root's ->in_flight is 1, as tested by the condition
>> blk_root_drained_poll().
>>
>>
>> Our blk->in_flight user is stuck here:
>>
>> 1298 static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
>> ...
>> 1310         blk_dec_in_flight(blk);
>> 1311         qemu_co_queue_wait(&blk->queued_requests, &blk->queued_requests_lock);
>> 1312         blk_inc_in_flight(blk);
>>
>> Note that before entering this stanza, blk->in_flight was 2. This turns out to
>> be due to the ide atapi code. In particular, the guest VM is generating lots of
>> read I/O. The "first IO" arrives into blk via:
>>
>> cd_read_sector()->ide_buffered_readv()->blk_aio_preadv()
>>
>> This initial IO completes:
>>
>> blk_aio_read_entry()->blk_aio_complete()
>>
>> 1560 static void blk_aio_complete(BlkAioEmAIOCB *acb)
>> 1561 {
>> 1562     if (acb->has_returned) {
>> 1563         acb->common.cb(acb->common.opaque, acb->rwco.ret);
>> 1564         blk_dec_in_flight(acb->rwco.blk);
>> 1565         qemu_aio_unref(acb);
>> 1566     }
>> 1567 }
>>
>> Line 1564 is what we need to move blk->in_flight down to zero, but that is never
>> reached! This is because of what happens at :1563
>>
>> acm->common.cb()->cd_read_sector_cb()->ide_atapi_cmd_reply_end()->cd_read_sector_sync()->blk_pread()
>>
>> That is, the IO callback in the atapi code itself triggers more - synchronous - IO.
>>
>> In the meantime, we start processing the blk_drain() code, so by the time this
>> blk_pread() actually gets handled, quiesce is set, and we get stuck in the
>> blk_wait_while_drained().
>>
>> I don't know the qemu block stack well enough to propose an actual fix.
>>
>> Experimentally, waiting for ->in_flight to drop to zero *before* we quiesce in
>> blk_remove_bs() via an AIO_WAIT_WHILE() avoids the symptom, but I'm pretty sure
>> that's just a band-aid instead of fixing the deadlock.
>>
>> Any suggestions/clues/thoughts?
> Related discussion: https://lists.gnu.org/archive/html/qemu-block/2023-03/msg00284.html
>
> Actually, it seems we never fixed that problem either?

We didn’t, from my POV mainly because everyone had different suggestions 
and none of them looked nice enough that it was clear which one to pursue.

I.e., there are also 
https://lists.gnu.org/archive/html/qemu-block/2023-03/msg00709.html and 
https://lists.gnu.org/archive/html/qemu-block/2023-04/msg00118.html .

> Back then I suggested that blk_drain*() should disable request queuing
> because its callers don't want to quiesce the BlockBackend, but rather
> get their own requests completed. I think this approach would solve this
> one as well.
>
> Your experiment with moving the queuing later is basically what Paolo
> suggested, though I'd still argue it's not the right thing to do because
> while it seems to mostly work with both use cases of drain (give me
> exclusive access vs. wait for my requests to complete), it's not optimal
> for either one.
>
> Kevin
>


