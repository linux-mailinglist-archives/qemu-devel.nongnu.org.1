Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1CB73903C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3el-0008E7-Qm; Wed, 21 Jun 2023 15:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3ei-0008C0-AL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3ef-0001TH-MV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687376292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Osf5QCa3YH+3m64oNaGXWADw81W107OyU1yHlQUihsc=;
 b=Se2O18QCJFwHX1hTELp1zeLRSElO90GqBchJZZLEOxfVudEqEdVbUgVohIg51lSa0NBm/K
 kQle9eDy5XWAP6Rl7R1o68R+CWvKzVYDlnmHllG8BVrSE6X+5wGONGTKeprfyxnWl9dLL5
 ZMEawVYjHknxqXhxBb2HRr7pMdqGquc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-7ikpUXc5P0GruOSyYn4sIA-1; Wed, 21 Jun 2023 15:38:11 -0400
X-MC-Unique: 7ikpUXc5P0GruOSyYn4sIA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b19cb170so19256405e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687376290; x=1689968290;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Osf5QCa3YH+3m64oNaGXWADw81W107OyU1yHlQUihsc=;
 b=Oa/UmzRRctEFLP0Fg78EXJ6To0vPqrZ3QZviE1+Mbtwf9tbs6LTkhi45HqOC2oLh0h
 ifXv9RsmxvTOslz3K3808VwM4j3nscELI7C1SlGAuFTOmVX1bP5CWfSup74C1iX566fu
 qnkhE4jK70CDHWEzt0RiLczJZCCElmsgUdtxzyG+IoH3hqmsPJPyUav7eCrQqYNo5nz6
 QdU0iPe3DoCn20f6dQQQyeW3xW81hHVpNWTdxkK9zjl3gUwhSRGhyUa0/Lcjw4uUpluQ
 aCzGOpfDtgJi/6nJjTb6AIje3abOFqLvGmWNgKmZrAvnF5Ae7lLsk9vgc4VH7Wudj5Ho
 GsJw==
X-Gm-Message-State: AC+VfDyIuOenf5fHMrkTs2Ibsc7rwizeu06MVjGow7BOKze3/ADDLIjy
 ICXCH7usaUiMWa5L7xaAMGNtu1Uq0ySGjywhaj5vAVf5iINHl7ajK1cITbgUp3PCz2X5Iau87IB
 /PG+Q7zf+VMkfnWw=
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id
 25-20020a05600c029900b003f90ba25d19mr8693296wmk.33.1687376290185; 
 Wed, 21 Jun 2023 12:38:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PseYh6RO6bqXazwVTUoa04NcuR9UVpzM0txg8z5GI1QYkURrVBOrv2Mw34jFwX0nEMbuxWg==
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id
 25-20020a05600c029900b003f90ba25d19mr8693283wmk.33.1687376289884; 
 Wed, 21 Jun 2023 12:38:09 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 i3-20020a05600c290300b003f8140763c7sm5833596wmd.30.2023.06.21.12.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:38:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Yury Kotov
 <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 12/42] migration-test: Enable back ignore-shared test
In-Reply-To: <ZJHFbgdyd7yj13rp@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 11:27:42 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-13-quintela@redhat.com> <ZJHFbgdyd7yj13rp@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 21:38:08 +0200
Message-ID: <87jzvwa9nj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
> On Fri, Jun 09, 2023 at 12:49:13AM +0200, Juan Quintela wrote:
>> It failed on aarch64 tcg, lets see if that is still the case.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> According to the history:
>
> https://lore.kernel.org/all/20190305180635.GA3803@work-vm/
>
> It's never enabled, and not sure whether Yury followed it up.  Juan: have
> you tried it out on aarch64 before enabling it again?  I assume we rely on
> the previous patch but that doesn't even sound like aarch64 specific.  I
> worry it'll just keep failing on aarch64.

Hi

I am resending this series.

I hard tested this time.  x86_64 host.
Two build directories:
- x86_64 (I just build qemu-system-x86_64, kvm)
- aarch64 (I just build qemu-system-aarch64, tcg)

Everything is run as:

while true; do $command || break; done

And run this:
- x86_64:
  * make check (nit: you can't run two make checks on the same
    directory)
  * 4 ./test/qtest/migration-test
  * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/cancel
  * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/ignore_shared

- aarch64:
  The same with s/x86_64/aarch64/

And left it running for 6 hours.  No errors.
Machine has enough RAM for running this (128GB) and 18 cores (intel
i9900K).
Load of the machine while running this tests is around 50 (I really hope
that our CI hosts have less load).

A run master with the same configuration.  In less than 10 minutes I get
the dreaded:

# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-3264370.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3264370.qmp,id=char0 -mon chardev=char0,mode=control -display none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-1A1461/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-1A1461/bootsect    -accel qtest
Broken pipe
../../../../../mnt/code/qemu/multifd/tests/qtest/libqtest.c:195: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)
$

On multifd+cancel.

I have no been able to ever get ignore_shared to fail on my machine.
But I didn't tested aarch64 TCG in the past so hard, and in x86_64 it
has always worked for me.

Later, Juan.




