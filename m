Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D571EF5B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l4Y-0001gM-Po; Thu, 01 Jun 2023 12:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4l4W-0001gD-TD
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4l4U-0005UM-Mm
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxMKunyLIKsUnX86jRLnw1L+UCCM9fD4gyIuOYKeuR4=;
 b=VSjAPaJJMfCtAtqPWEUNmB6DjaqPnFs68KvOKaQrcMuHMJaR0tfcWreXm3AM/Jbb6l6YFK
 I8+qhaeG8q74EMDVYAqez7ajiYgSwC04BGVuiK7gdNG69wX5+2m1LLb0DEEGOqhaNFkXFu
 HJ+NyKsHSJL5y7cwIwZ1ajb0DiY+t20=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-SVdv-enLP7y5GVW8PV4ugg-1; Thu, 01 Jun 2023 12:22:39 -0400
X-MC-Unique: SVdv-enLP7y5GVW8PV4ugg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-19fa053d958so209204fac.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685636558; x=1688228558;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VxMKunyLIKsUnX86jRLnw1L+UCCM9fD4gyIuOYKeuR4=;
 b=g2Yh5IWWCo37AFzIGdqBM7bk//zD0//fXMI1T3NdPv1ZDa+OB96UXOHAkp5MlKoLmU
 RV1qWQLq/EsRmTJV6WXRyocm8o3IwsC6FQKwNaXP7CypMo24e5RUVtkkiZUF9tZ3ZMRL
 1SYvANo53AuCFLk4Um/CJgEzW6Oue6/sejOCL9chWxt6Ofw92k3h3zN0sf+akJozI9v3
 U6AdWpxcr5RCDdzSuLjoNoCWOtDHxqdaJzTf+k6XrptJWXc0ZCFs1ma6cVOzzG0KPMoC
 JreMH9zZCDmvJq2ulg42JaYgld8JGd5YFVN6wPUPZxx/M8EwLo8x96KgHtWBypyECSI7
 dTxA==
X-Gm-Message-State: AC+VfDxzm/gP+xfrDt6E4YuJ//qhti1KVS8mCnraVhSVoS9YIPC8p/Hw
 0Stm1hYDR3ycNHib5dkeaiL2zMrncT3KsPUukteQl1C4Yv7sQXuwO6o+tz5K92oYKR6lTE3699W
 45uxy5SddUppOgbUCcquMSp0=
X-Received: by 2002:aca:62c5:0:b0:394:25b9:db19 with SMTP id
 w188-20020aca62c5000000b0039425b9db19mr3540642oib.2.1685636558320; 
 Thu, 01 Jun 2023 09:22:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CGDqow8YnA48Y65zJIaf3AY7SxKFJNKQJEq+735f6DAShR525NfRfbzssE0p7NyYLCZq2BQ==
X-Received: by 2002:aca:62c5:0:b0:394:25b9:db19 with SMTP id
 w188-20020aca62c5000000b0039425b9db19mr3540628oib.2.1685636557923; 
 Thu, 01 Jun 2023 09:22:37 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 mz17-20020a0562142d1100b0061b7f6b5e15sm7472435qvb.140.2023.06.01.09.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 09:22:37 -0700 (PDT)
Date: Thu, 1 Jun 2023 12:22:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Message-ID: <ZHjFzH9zT34MIBEv@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
 <ZHi9OQz8PGuHMPpN@x1n> <ZHjBw2E+eJKNsniO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHjBw2E+eJKNsniO@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 05:05:23PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 11:46:01AM -0400, Peter Xu wrote:
> > On Wed, May 31, 2023 at 02:24:00PM +0100, Daniel P. Berrangé wrote:
> > > The migration test cases that actually exercise live migration want to
> > > ensure there is a minimum of two iterations of pre-copy, in order to
> > > exercise the dirty tracking code.
> > > 
> > > Historically we've queried the migration status, looking for the
> > > 'dirty-sync-count' value to increment to track iterations. This was
> > > not entirely reliable because often all the data would get transferred
> > > quickly enough that the migration would finish before we wanted it
> > > to. So we massively dropped the bandwidth and max downtime to
> > > guarantee non-convergance. This had the unfortunate side effect
> > > that every migration took at least 30 seconds to run (100 MB of
> > > dirty pages / 3 MB/sec).
> > > 
> > > This optimization takes a different approach to ensuring that a
> > > mimimum of two iterations. Rather than waiting for dirty-sync-count
> > > to increment, directly look for an indication that the source VM
> > > has dirtied RAM that has already been transferred.
> > > 
> > > On the source VM a magic marker is written just after the 3 MB
> > > offset. The destination VM is now montiored to detect when the
> > > magic marker is transferred. This gives a guarantee that the
> > > first 3 MB of memory have been transferred. Now the source VM
> > > memory is monitored at exactly the 3MB offset until we observe
> > > a flip in its value. This gives us a guaranteed that the guest
> > > workload has dirtied a byte that has already been transferred.
> > > 
> > > Since we're looking at a place that is only 3 MB from the start
> > > of memory, with the 3 MB/sec bandwidth, this test should complete
> > > in 1 second, instead of 30 seconds.
> > > 
> > > Once we've proved there is some dirty memory, migration can be
> > > set back to full speed for the remainder of the 1st iteration,
> > > and the entire of the second iteration at which point migration
> > > should be complete.
> > > 
> > > On a test machine this further reduces the migration test time
> > > from 8 minutes to 1 minute 40.
> > 
> > The outcome is definitely nice, but it does looks slightly hacky to me and
> > make the test slightly more complicated.
> > 
> > If it's all about making sure we finish the 1st iteration, can we simply
> > add a src qemu parameter "switchover-hold"?  If it's set, src never
> > switchover to dst but keeps the iterations.
> 
> For *most* of the tests, we want to ensure there are a minimum
> of 2 iterations. For the XBZRLE test we want to ensure there are
> a minimum of 3 iterations, so the cache gets  workout.
> 
> > Then migrate_ensure_non_converge() will be as simple as setting
> > switchover-hold to true.
> > 
> > I am even thinking whether there can even be real-life use case for that,
> > e.g., where a user might want to have a pre-heat of a migration of some VM,
> > and trigger it immediately when the admin really wants (the pre-heats moved
> > most of the pages and keep doing so).
> > 
> > It'll be also similar to what Avihai proposed here on switchover-ack, just
> > an ack mechanism on the src side:
> > 
> > https://lore.kernel.org/r/20230530144821.1557-3-avihaih@nvidia.com
> 
> In general I strongly wanted to avoid adding special logic to the
> migration code that makes it directly synchronize with the  test
> suite, because once we do that I don't think the test suite is a
> providing coverage of the real world usage scenario.

The problem is non-live is already not real world usage in most cases.  It
seems we all agreed that it's the code paths to cover not real world usages
in the tests, or maybe not?

> 
> IOW, if we add a switchover-ack feature, we should certainly have
> *a* test that uses it, but we should not modify other tests because
> we want to exercise the logic as it would run with apps that don't
> rely on switchover-ack.
> 
> Also, this slow migration test is incredibly painful for people right
> now, so I'd like to see us get a speed up committed to git quickly.
> I don't want to block it on a feature proposal that might yet take
> months to merge.

That'll be trivial, afaict.

I just worry that this patch will bring complexity to the test cases,
that's another burden we need to carry besides QEMU itself.

If you want, I can try to prepare such a patch before this weekend, and if
it's complicated enough and take more than next week to review feel free to
go ahead with this one.

I understand the migration test issue was there for a long time.  But still
to me it's important on which may be cleaner for the long term too.

-- 
Peter Xu


