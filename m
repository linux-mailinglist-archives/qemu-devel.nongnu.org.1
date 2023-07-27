Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3176593A
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:52:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3c0-0000jd-Hl; Thu, 27 Jul 2023 12:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3bs-0000io-0V
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3bm-0004Xs-KN
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlnDrTrIvhODiuOM+cMqf2P7Fzb2MVgkh/RImtgjjTw=;
 b=K756/t/Tr8aHgb2cSkXytIk7cw6zZFd9YYGKE7KXxCmcxnRsybrvEvUHYHDleFKrZxzvVJ
 Hc62vot98/H7ItMdYGRjBBARtI0hGBPT0Vs49wXXFlTgrb5pKRfGTHCtpAannD/QCH6gMc
 9TYdmbLCmylptJAgijRicXyycDdHSTs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Ws-2VLhhO8GUGOA8axbxtg-1; Thu, 27 Jul 2023 12:12:56 -0400
X-MC-Unique: Ws-2VLhhO8GUGOA8axbxtg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fbcdca8f29so1099106e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474375; x=1691079175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XlnDrTrIvhODiuOM+cMqf2P7Fzb2MVgkh/RImtgjjTw=;
 b=WWVST5o6MMAuPe/bxScGCEVMRcmgCNZiGV/t7KYPJJrs/Gs2keKtq4Oa0Rt39zP7Zw
 NPsv9xkB/uMWUPgRVlKJ4e0kHmbZ9OVwgVsdCw/TgVCofKdhr4Tc9C1lsJgPY6ho3IiJ
 5AUwJedq1zQ9F1h4L1GI6t65ME0CTYOwEmbEww9AI6Ef5Dgy9z2Xh6JVBugzu8+eLRQy
 0t8gU0mccdjTlkvrBKsYofdnlM34O5I/g6heIqEDIb1sGsV1LhlmQ9dcImSmZlnsvg9q
 OpIUzMugBdMhnb1Su/DN3ZsoCGSQUh4xVhZ8jLJ7cPAV3kwpwYxWsr9M2PwAQRNbSmXP
 eBZQ==
X-Gm-Message-State: ABy/qLZ445ZetCCkriXFImvdOUhyPMo1wdUSq0pYJAB6k4P8YG9dL+ZJ
 u2O9YqtJgnlufGpWzVMutHE5x6m6QIptHCvV/OEqUOR1nwcQiKpuOBowjSHkTwQXNxITzKm4Ikf
 FSqXkKSuvrfalVfQ=
X-Received: by 2002:a05:6512:3b0a:b0:4f6:3ab6:3d9e with SMTP id
 f10-20020a0565123b0a00b004f63ab63d9emr2810231lfv.59.1690474375268; 
 Thu, 27 Jul 2023 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1hrGetPEZ+xvOb4RWoQ9CvJQ3Z/Lo3ugY56kPQnf9loS93r3cCcnbNRV1HP5JoXBvtBmJSQ==
X-Received: by 2002:a05:6512:3b0a:b0:4f6:3ab6:3d9e with SMTP id
 f10-20020a0565123b0a00b004f63ab63d9emr2810214lfv.59.1690474374934; 
 Thu, 27 Jul 2023 09:12:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a056402139500b005227e53cec2sm781772edv.50.2023.07.27.09.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:12:54 -0700 (PDT)
Message-ID: <3e164b63-9a9b-9139-2371-4421e2460ef1@redhat.com>
Date: Thu, 27 Jul 2023 18:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 9/9] block/throttle-groups: Use ThrottleDirection
 instread of bool is_write
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
 <20230724100939.1022984-10-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724100939.1022984-10-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24.07.23 12:09, zhenwei pi wrote:
> 'bool is_write' style is obsolete from throttle framework, adapt
> block throttle groups to the new style.
>
> Use a simple python script to test the new style:
>   #!/usr/bin/python3
> import subprocess
> import random
> import time
>
> commands = ['virsh blkdeviotune jammy vda --write-bytes-sec ', \
>              'virsh blkdeviotune jammy vda --write-iops-sec ', \
>              'virsh blkdeviotune jammy vda --read-bytes-sec ', \
>              'virsh blkdeviotune jammy vda --read-iops-sec ']
>
> for loop in range(1, 1000):
>      time.sleep(random.randrange(3, 5))
>      command = commands[random.randrange(0, 3)] + str(random.randrange(0, 1000000))
>      subprocess.run(command, shell=True, check=True)
>
> This works fine.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   block/throttle-groups.c         | 105 ++++++++++++++++----------------
>   block/throttle.c                |   8 +--
>   include/block/throttle-groups.h |   6 +-
>   3 files changed, 60 insertions(+), 59 deletions(-)
>
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 3847d27801..c7c700fdb6 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c

Thanks a lot!  The changes done look good, and I think they’re nice.

There are some functions left untouched, though, which I think should 
use ThrottleDirection, too:

throttle_group_register_tgm() should use THROTTLE_READ/THROTTLE_WRITE to 
index tgm->throttled_reqs[] (instead of 0/1).  It also has a `for (i = 
0; i < 2; i++)` loop over tg->tokens[], which probably should use 
THROTTLE_MAX as the upper limit, or iterate over a ThrottleDirection 
variable altogether (as you’ve done it in patch 3 e.g. for 
throttle_timers_attach_aio_context()).

throttle_group_unregister_tgm() has such a loop, too (over 
tgm->pending_reqs[], tgm->throttled_reqs[], 
tgm->throttle_timers.timers[], and tg->tokens[], all of which are arrays 
over ThrottleDirection).

throttle_group_detach_aio_context() also has both the indexing “problem” 
(integers instead of THROTTLE_* for tgm->pending_reqs[] and 
tgm->throttled_reqs[]) and such a loop.  There, the loop probably really 
should be over a ThrottleDirection variable, because it passes that 
variable to schedule_next_request().

throttle_group_restart_tgm() also has such a loop, it uses that variable 
to index tgm->throttle_timers.timers[], and passes it to both timer_cb() 
and throttle_group_restart_queue().

read_timer_cb() and write_timer_cb() should call timer_cb() with 
THROTTLE_READ/THROTTLE_WRITE instead of false/true.

> diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> index ff282fc0f8..2355e8d9de 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h

[...]

> @@ -78,7 +78,7 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
>   
>   void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
>                                                           int64_t bytes,
> -                                                        bool is_write);
> +                                                        ThrottleDirection direction);

block/block-backend.c calls this function in 
blk_co_do_p{read,write}v_part(), those calls need to be adjusted, too.

>   void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>                                          AioContext *new_context);
>   void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);


