Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6670A114
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 22:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q078A-00069C-Dh; Fri, 19 May 2023 16:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q0787-00068r-Md
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q0785-0003C6-Ph
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684529712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mFwB6eZzHSG0g8cmauuuVKfcZRCgSLwiS2W/l4TP7og=;
 b=CB93oQ9HnNczNgTVaSTVpr9jveNCONytrzv89E4Ug/pg82ntajMyKeTQOfTBn6tk/GInxq
 1Mt5u5Hgr44i59P8vNzc8FmF2dc/hLIPo5ZirpI/mrED4vR+fMlViun7og9KP5AH2qCfEe
 bUKH/eu4oUKSDbYAK1kJ9M6PN3BCsy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-GGI-Q9Q0OwaDYr-rSMoNRA-1; Fri, 19 May 2023 16:55:11 -0400
X-MC-Unique: GGI-Q9Q0OwaDYr-rSMoNRA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-306489b7585so1414537f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684529708; x=1687121708;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFwB6eZzHSG0g8cmauuuVKfcZRCgSLwiS2W/l4TP7og=;
 b=GWZTK/iXVU7WOqBdjmyRc3IJB857fA7iPFQ93WWk0Ny+hEkkJW+F5K/54H+vTHKh6p
 5CBlM5QCug66gzTzcRmALVQqeNAE0gtSStZeqq8eAHEEvau9Bgh5/o1ZK5feWfVulqHE
 1tu8aSUWJc1dXb0adr+J7ZmhAQ7apCbf2dFrVrmF0CBjJabB//307/mros8g5aMW1PqY
 pVzLqDn9RjVLrdiTD4sbIRGjbgSiYHXSX3lZmZZcRIwRGYOp+AnTvBX1LUs9pOG5b9im
 zNXnwhptNHymHg29hLn178debo7y+Ymn3i9Lfe9KlT4ne5c38zhQtOSOK8Ze28XglJ4i
 VBYQ==
X-Gm-Message-State: AC+VfDxWIihW6dJ/w/3ikcbWHUMjnlMZQ45hrvb0aYiCC6jyA3ePP70Z
 4WopYDp6gn6sqq6abFMMz0olZF5f+4yBix3K0TI0Ttj/BYk64Io1zpoR4J9fjU7gqxkFiDd1pmP
 dHHSppbMLeHy59ms=
X-Received: by 2002:adf:e750:0:b0:307:9b67:d14f with SMTP id
 c16-20020adfe750000000b003079b67d14fmr2564285wrn.9.1684529708486; 
 Fri, 19 May 2023 13:55:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TpeHK6DvQErjnlO5UrzUCgWZvPnUYCgkN7NVEif/h6cn34FZCkegQ/q+xkLAyisSOJbSQ5g==
X-Received: by 2002:adf:e750:0:b0:307:9b67:d14f with SMTP id
 c16-20020adfe750000000b003079b67d14fmr2564270wrn.9.1684529707932; 
 Fri, 19 May 2023 13:55:07 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f15-20020a0560001b0f00b00307acec258esm30707wrz.3.2023.05.19.13.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 13:55:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/21] Block layer patches
In-Reply-To: <ZGfLrJ5H+H6dnJjA@redhat.com> (Kevin Wolf's message of "Fri, 19
 May 2023 21:19:08 +0200")
References: <20230519171806.435109-1-kwolf@redhat.com>
 <c74f18d7-47a4-5251-85c2-a9981e9603bf@linaro.org>
 <ZGfLrJ5H+H6dnJjA@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 19 May 2023 22:55:05 +0200
Message-ID: <878rdkavo6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Kevin Wolf <kwolf@redhat.com> wrote:
> Am 19.05.2023 um 20:48 hat Richard Henderson geschrieben:
>> On 5/19/23 10:18, Kevin Wolf wrote:
>> > The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:

[ Adding Peter Xu, he has worked on postcopy lately]

>> > 
>> >    Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
>> > 
>> > are available in the Git repository at:
>> > 
>> >    https://repo.or.cz/qemu/kevin.git tags/for-upstream
>> > 
>> > for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
>> > 
>> >    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
>> > 
>> > ----------------------------------------------------------------
>> > Block layer patches
>> > 
>> > - qcow2 spec: Rename "zlib" compression to "deflate"
>> > - Honour graph read lock even in the main thread + prerequisite fixes
>> > - aio-posix: do not nest poll handlers (fixes infinite recursion)
>> > - Refactor QMP blockdev transactions
>> > - graph-lock: Disable locking for now
>> > - iotests/245: Check if 'compress' driver is available
>> > 
>> > ----------------------------------------------------------------
>> > Akihiro Suda (1):
>> >        docs/interop/qcow2.txt: fix description about "zlib" clusters
>> > 
>> > Kevin Wolf (12):
>> >        block: Call .bdrv_co_create(_opts) unlocked
>> >        block/export: Fix null pointer dereference in error path
>> >        qcow2: Unlock the graph in qcow2_do_open() where necessary
>> >        qemu-img: Take graph lock more selectively
>> >        test-bdrv-drain: Take graph lock more selectively
>> >        test-bdrv-drain: Call bdrv_co_unref() in coroutine context
>> >        blockjob: Adhere to rate limit even when reentered early
>> >        graph-lock: Honour read locks even in the main thread
>> >        iotests/245: Check if 'compress' driver is available
>> >        graph-lock: Disable locking for now
>> >        nbd/server: Fix drained_poll to wake coroutine in right AioContext
>> >        iotests: Test commit with iothreads and ongoing I/O
>> > 
>> > Stefan Hajnoczi (2):
>> >        aio-posix: do not nest poll handlers
>> >        tested: add test for nested aio_poll() in poll handlers
>> > 
>> > Vladimir Sementsov-Ogievskiy (6):
>> >        blockdev: refactor transaction to use Transaction API
>> >        blockdev: transactions: rename some things
>> >        blockdev: qmp_transaction: refactor loop to classic for
>> >        blockdev: transaction: refactor handling transaction properties
>> >        blockdev: use state.bitmap in block-dirty-bitmap-add action
>> >        blockdev: qmp_transaction: drop extra generic layer
>> 
>> Test failure:
>> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/4317480370#L3347
>> 
>> 194              fail       [18:42:03] [18:42:05]   1.2s
>> output mismatch (see /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad)
>> --- /builds/qemu-project/qemu/tests/qemu-iotests/194.out
>> +++ /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad
>> @@ -14,7 +14,6 @@
>>  {"return": {}}
>>  {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp":
>> {"microseconds": "USECS", "seconds": "SECS"}}
>>  {"data": {"status": "active"}, "event": "MIGRATION", "timestamp":
>> {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp":
>> {"microseconds": "USECS", "seconds": "SECS"}}
>>  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp":
>> {"microseconds": "USECS", "seconds": "SECS"}}
>>  Gracefully ending the `drive-mirror` job on source...
>
> You got the same failure on mst's pull request, so this seems to be
> unrelated to the pull request at least.
>
> Maybe it is related to us using different test runners now and the test
> isn't working right there?
>
> I tried to reproduce locally with the same options as the disable-tcg CI
> job uses, but it always passes. Juan, do you have an idea what it could
> mean if on some CI system the "postcopy-active" event is missing?

The only thing that I can think by memory is that the machine go so fast
that we end migration on precopy and don't wait until postcopy.  But
that is a wild guess, will try to take a look at the failure later.

> Kevin

Regards, Juan.


