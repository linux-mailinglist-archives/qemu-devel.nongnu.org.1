Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A47391CF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 23:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC5lw-0004K1-0T; Wed, 21 Jun 2023 17:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC5ls-0004HX-Qz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC5lr-0004UI-1Q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687384425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HcYMFlo4oqR2Ss6s1D6c2ifUMAUNu4bDgALEmbM4Mwg=;
 b=Sc41YPGM4jPxxs8gsNhqwXGFzMmai96cSaGOAB2nmYP8gF6L1mv9bBfFqboeANj+PK/Sbr
 FHDV/27JinIM+3SNEh0ZXTeOqQsdRiajlwavlpf6VTFJvU0J5/UR4A5JyMKPN5cQ6Bp9d2
 wY3K1/GejBXMItlo6Mg6mwF2ahjNf7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-bTnU0r4YPyecNFJvo2yPdw-1; Wed, 21 Jun 2023 17:53:44 -0400
X-MC-Unique: bTnU0r4YPyecNFJvo2yPdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9d7ff4b6aso2106495e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 14:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687384423; x=1689976423;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcYMFlo4oqR2Ss6s1D6c2ifUMAUNu4bDgALEmbM4Mwg=;
 b=FU15LYX4RR7IFDt5V17u3RomBWjLz+tiXfUn0WxZ9hOikK2M+JEVKICUyOUuqQNIB+
 CBmMdgR5Tp82lCTPerWAIQp1jOq3Kkh6+8RWDaTgT6IbTEKF/NdmWpJYiGIme+zpQEfk
 IKvlrV338NiPBf/NAQEwomHXos9z6lokWwqWwLpwvJaST8MIgN88U/Ewx5cLLJ8Z/O6I
 RTEocxiAfU4oHxK0+FGVFrIowyMCIqmoeYyExkISZeRKvlQb7nn+KC3AaJGYxLR6Ks++
 adVYOGXySC95wX3h4KNgLDwEwzdDVN5zT+eFrXVVtBIUTMY/5WPCa+vOG9jHHQRt+KY7
 KVLA==
X-Gm-Message-State: AC+VfDyD371SjfAu0iu7psniF3FgX4EBgV8ITJSCDAE16vBAjD+3Stb5
 px92MnMcXwmpF9J7umqIcVkIQwFhMeE1V54TB8k+z6hAkPueX38iMncgK+x/wtDFlMFxJbx/Io5
 UMd5u9eLER9siL24=
X-Received: by 2002:adf:e6c4:0:b0:30e:3d28:ba75 with SMTP id
 y4-20020adfe6c4000000b0030e3d28ba75mr12672721wrm.28.1687384423063; 
 Wed, 21 Jun 2023 14:53:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ792rpxXRFIKd5ukCgHqHjiXRyGju/kvZaApexWD/1t+nNpDOMUwAWaF7zz7AW0sjTU/wjeWA==
X-Received: by 2002:adf:e6c4:0:b0:30e:3d28:ba75 with SMTP id
 y4-20020adfe6c4000000b0030e3d28ba75mr12672705wrm.28.1687384422751; 
 Wed, 21 Jun 2023 14:53:42 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b00307acec258esm5476474wro.3.2023.06.21.14.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 14:53:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Yury Kotov
 <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 12/42] migration-test: Enable back ignore-shared test
In-Reply-To: <ZJNVRQfPRxhbLpfZ@x1n> (Peter Xu's message of "Wed, 21 Jun 2023
 15:53:41 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-13-quintela@redhat.com> <ZJHFbgdyd7yj13rp@x1n>
 <87jzvwa9nj.fsf@secure.mitica> <ZJNVRQfPRxhbLpfZ@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 23:53:41 +0200
Message-ID: <87legc8ot6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jun 21, 2023 at 09:38:08PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Fri, Jun 09, 2023 at 12:49:13AM +0200, Juan Quintela wrote:
>> >> It failed on aarch64 tcg, lets see if that is still the case.
>> >> 
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >
>> > According to the history:
>> >
>> > https://lore.kernel.org/all/20190305180635.GA3803@work-vm/
>> >
>> > It's never enabled, and not sure whether Yury followed it up.  Juan: have
>> > you tried it out on aarch64 before enabling it again?  I assume we rely on
>> > the previous patch but that doesn't even sound like aarch64 specific.  I
>> > worry it'll just keep failing on aarch64.
>> 
>> Hi
>> 
>> I am resending this series.
>> 
>> I hard tested this time.  x86_64 host.
>> Two build directories:
>> - x86_64 (I just build qemu-system-x86_64, kvm)
>> - aarch64 (I just build qemu-system-aarch64, tcg)
>> 
>> Everything is run as:
>> 
>> while true; do $command || break; done
>> 
>> And run this:
>> - x86_64:
>>   * make check (nit: you can't run two make checks on the same
>>     directory)
>>   * 4 ./test/qtest/migration-test
>>   * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/cancel
>>   * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/ignore_shared
>> 
>> - aarch64:
>>   The same with s/x86_64/aarch64/
>> 
>> And left it running for 6 hours.  No errors.
>> Machine has enough RAM for running this (128GB) and 18 cores (intel
>> i9900K).
>> Load of the machine while running this tests is around 50 (I really hope
>> that our CI hosts have less load).
>> 
>> A run master with the same configuration.  In less than 10 minutes I get
>> the dreaded:
>> 
>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-3264370.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3264370.qmp,id=char0 -mon chardev=char0,mode=control -display none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-1A1461/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-1A1461/bootsect    -accel qtest
>> Broken pipe
>> ../../../../../mnt/code/qemu/multifd/tests/qtest/libqtest.c:195: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>> Aborted (core dumped)
>> $
>> 
>> On multifd+cancel.
>> 
>> I have no been able to ever get ignore_shared to fail on my machine.
>> But I didn't tested aarch64 TCG in the past so hard, and in x86_64 it
>> has always worked for me.
>
> Thanks a lot, Juan.
>
> Do you mean master is broken with QEMU_TEST_FLAKY_TESTS=1?

Yeap.  I mean multifd+cancel.  That is the reason why we put the FLAKY
part.

> And after the
> whole series applied we cannot trigger issue in the few hours test even
> with it?

Yeap.

> Shall we wait for another 1-2 days to see whether Yury would comment
> (before you repost)?  Otherwise I agree if it survives your few-hours test
> we should give it a try - at least according to Dave's comment before it
> was failing easily, but it is not now on the test bed.

From the v2 series that I am about to post:

    migration-test: Re-enable multifd_cancel test

    Why?
    - migration/multifd: Protect accesses to migration_threads
      this patch fixed the problem about memory corruption
    - migration-test: Move serial to GuestState
      now we are using guest name as serial file name
      In the past there was a conflict between vm "to" and "to2" that used
      the same file name.
    - migration-test: Wait for first target to finish
      Now we wait from vm "to" to finish before launching "to2".  So we
      avoid similar problems in the future.

    Signed-off-by: Juan Quintela <quintela@redhat.com>


> Maybe it's still just hidden, but in that case I also agree enabling it in
> the repo is the simplest way to reproduce the failure again, if we still
> ever want to enable it one day..

We want.  If it still fails, we want to know why and fix it.

Later, Juan.


