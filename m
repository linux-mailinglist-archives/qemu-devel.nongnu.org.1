Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3A739071
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3tn-0006MX-NG; Wed, 21 Jun 2023 15:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC3tj-0006MH-QL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC3ti-0005aC-1S
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687377225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5aVkECsFf0NMHkTszWX7n1xUdV7uCAZeey46/HVhik=;
 b=ZlkAHGejZoatuDK6dXh7i+ncioGOirmkHcO1XlpANQqhQf+SWip6u3qPop7XLcCgjhWwqs
 cMS7M8qYGEw9NRQNcaPtMZAKHuw+CQx9rfWO+VO2dMhkf3acBht5hc1BUhCnONhoAV7aak
 zl9XbjPphYqMRmqS4ZQ9tXpuMcd5I/w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-7XT5xcI2P2eqaikXaGi51w-1; Wed, 21 Jun 2023 15:53:44 -0400
X-MC-Unique: 7XT5xcI2P2eqaikXaGi51w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3ff1fec3500so7487421cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687377223; x=1689969223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5aVkECsFf0NMHkTszWX7n1xUdV7uCAZeey46/HVhik=;
 b=cPkU9hC/Aes/nBrWCFeiMRQJkOOScs9k1oOgUwSY171APAOWilDBCTZ/JbDUf6MdrM
 BjrDlfWUjAw7tFofk15icPjaAkckof8g7BJwPnWZrFGK+B7iNaaDPRMzZG7+L+TzcBy7
 kpMLzp0q/58a6XyYc095uhIZTzIbYUqWQmnQ0dbvezINUztVMOg/Kw9HwJp9NI8+HLh5
 h0Mmn+CeJXQmvaZf7rz8aXQbyyLUo8TDhx3J8WJ4iP6q0sycWepCjZ0GkH+hlnYPViX9
 vif3I03Bwlg++pBjHNdV9a/fghaFYOzLWHEvlJNsLmGnK/H89NkjCWCZXa5F63dh/bYv
 nMLw==
X-Gm-Message-State: AC+VfDxJigf4yBOAkArEMJCO/D1+GdVOU53PD+78H3u/DDtJZ/sLdtYp
 SmCvb77T1rG+oEDKISR+U0cLYsPJNb17oWGpv7Rt/byDKnGXoW+yOk8kqXMRy/yvDsFZlxEThR9
 TylUpSAsMzzeDV+Q=
X-Received: by 2002:a05:622a:18a9:b0:3ff:2adf:5c28 with SMTP id
 v41-20020a05622a18a900b003ff2adf5c28mr7709540qtc.1.1687377223378; 
 Wed, 21 Jun 2023 12:53:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42gcNqZo0MrgmFjarOJu2p/sBJcF4pSnSgdCPNFVr7M8/jhVqW5GbuzDkTz587iCYTgWiuPg==
X-Received: by 2002:a05:622a:18a9:b0:3ff:2adf:5c28 with SMTP id
 v41-20020a05622a18a900b003ff2adf5c28mr7709527qtc.1.1687377223103; 
 Wed, 21 Jun 2023 12:53:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bz24-20020a05622a1e9800b003ff268d90aesm2732913qtb.56.2023.06.21.12.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:53:42 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:53:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 12/42] migration-test: Enable back ignore-shared test
Message-ID: <ZJNVRQfPRxhbLpfZ@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-13-quintela@redhat.com> <ZJHFbgdyd7yj13rp@x1n>
 <87jzvwa9nj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzvwa9nj.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 21, 2023 at 09:38:08PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Jun 09, 2023 at 12:49:13AM +0200, Juan Quintela wrote:
> >> It failed on aarch64 tcg, lets see if that is still the case.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> > According to the history:
> >
> > https://lore.kernel.org/all/20190305180635.GA3803@work-vm/
> >
> > It's never enabled, and not sure whether Yury followed it up.  Juan: have
> > you tried it out on aarch64 before enabling it again?  I assume we rely on
> > the previous patch but that doesn't even sound like aarch64 specific.  I
> > worry it'll just keep failing on aarch64.
> 
> Hi
> 
> I am resending this series.
> 
> I hard tested this time.  x86_64 host.
> Two build directories:
> - x86_64 (I just build qemu-system-x86_64, kvm)
> - aarch64 (I just build qemu-system-aarch64, tcg)
> 
> Everything is run as:
> 
> while true; do $command || break; done
> 
> And run this:
> - x86_64:
>   * make check (nit: you can't run two make checks on the same
>     directory)
>   * 4 ./test/qtest/migration-test
>   * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/cancel
>   * 2 ./test/qtest/migration-test -p ./tests/qtest/migration-test -p /x86_64/migration/ignore_shared
> 
> - aarch64:
>   The same with s/x86_64/aarch64/
> 
> And left it running for 6 hours.  No errors.
> Machine has enough RAM for running this (128GB) and 18 cores (intel
> i9900K).
> Load of the machine while running this tests is around 50 (I really hope
> that our CI hosts have less load).
> 
> A run master with the same configuration.  In less than 10 minutes I get
> the dreaded:
> 
> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-3264370.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3264370.qmp,id=char0 -mon chardev=char0,mode=control -display none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-1A1461/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-1A1461/bootsect    -accel qtest
> Broken pipe
> ../../../../../mnt/code/qemu/multifd/tests/qtest/libqtest.c:195: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
> $
> 
> On multifd+cancel.
> 
> I have no been able to ever get ignore_shared to fail on my machine.
> But I didn't tested aarch64 TCG in the past so hard, and in x86_64 it
> has always worked for me.

Thanks a lot, Juan.

Do you mean master is broken with QEMU_TEST_FLAKY_TESTS=1?  And after the
whole series applied we cannot trigger issue in the few hours test even
with it?

Shall we wait for another 1-2 days to see whether Yury would comment
(before you repost)?  Otherwise I agree if it survives your few-hours test
we should give it a try - at least according to Dave's comment before it
was failing easily, but it is not now on the test bed.

Maybe it's still just hidden, but in that case I also agree enabling it in
the repo is the simplest way to reproduce the failure again, if we still
ever want to enable it one day..

-- 
Peter Xu


