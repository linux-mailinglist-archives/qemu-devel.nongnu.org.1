Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F0827CC7
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 03:14:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN1cF-0004LI-Sk; Mon, 08 Jan 2024 21:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN1cB-0004L3-0q
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN1c8-0006oR-BX
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704766390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+iCHMZROQ7F+PUkk3h4ZuHCBJRm83jWjx3eNIijEBs=;
 b=g9KUmBZJKU9hkA3EqjaFGjuZdRTlzihgbzJlwhxodggpD/r85bBnJByzWwjLGOq73bOTZx
 kU9nieJ5kCBOrrTjltFwKCQkedgnTLRK1hR5w1JhfxaJ2IyZVxqYmPFkCkPQ3/dk6Lv+tM
 oq7fL8+3Uewpw2ZFpDuGNsLNTgDcthQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jMxl8VhINP6JnTczasC2mA-1; Mon, 08 Jan 2024 21:13:07 -0500
X-MC-Unique: jMxl8VhINP6JnTczasC2mA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28bd331cb57so1010749a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 18:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704766387; x=1705371187;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+iCHMZROQ7F+PUkk3h4ZuHCBJRm83jWjx3eNIijEBs=;
 b=l4E0yRCUJpFyGu3xng0Uh/YJ/GhLXjfo8HdDm5CA9l4hPq9dZUHKmXYnqzIpfBNJaT
 hKBMOu2pnNSzvzrWSDf3x63yXxh7uD6As2mx6YdsWu9uGjqsMvbp3dS78LTYsQN650zv
 E9+ffKCsWKZipmBRXKzM9FyZ5VS7Awt0OCwY7R7rfg/M2/gEwAxQGT0GszdlQt97CtYR
 7MD0NxLIFJkEcMUZ9CNcY7GwiKPWH218VnxeGb6/mhM1yAm+u4gWlB14Z9TEhuy7I0WF
 GKXtbceghSw/lD8VNP2GLDm5kbYa6iU7+RNtyT2BWmdvrTgQ3v+/VdJlMkyq6sxG7FnN
 zvQg==
X-Gm-Message-State: AOJu0YyK16wMHeXqgdVJWVCLZdHFblQZsDd9if0ppTsyu7Fp2CzKf6pJ
 S/mSNxk9HQJgcQ404IBlA7hv5Pi9NbTNgsqNis4TubSYeE0h4g/UwI7dJ8Zo7L7qzR7vkcTb0eg
 txum+FEPmHfARP7BPC2+jgEk=
X-Received: by 2002:a05:6a21:1c84:b0:199:d6b5:20bc with SMTP id
 sf4-20020a056a211c8400b00199d6b520bcmr1980600pzb.3.1704766386778; 
 Mon, 08 Jan 2024 18:13:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHs7UKf048UgtqXRXTpBcMfO8AiKvvslwo1sNEJkugc/b5VT6wIfKCUP6ggh0LqHSu8PiT70w==
X-Received: by 2002:a05:6a21:1c84:b0:199:d6b5:20bc with SMTP id
 sf4-20020a056a211c8400b00199d6b520bcmr1980585pzb.3.1704766386454; 
 Mon, 08 Jan 2024 18:13:06 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 q18-20020a170902dad200b001d472670a30sm553664plx.162.2024.01.08.18.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 18:13:05 -0800 (PST)
Date: Tue, 9 Jan 2024 10:12:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Message-ID: <ZZyrqnk3nJ3WIX8v@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de>
 <87ttvjoexo.fsf@secure.mitica> <ZZuZcCxxIS6j_jHD@x1n>
 <87frz73nr7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frz73nr7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 08, 2024 at 11:26:04AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jun 07, 2023 at 10:27:15AM +0200, Juan Quintela wrote:
> >> Fabiano Rosas <farosas@suse.de> wrote:
> >> > We've found the source of flakiness in this test, so re-enable it.
> >> >
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > ---
> >> >  tests/qtest/migration-test.c | 10 ++--------
> >> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> > index b0c355bbd9..800ad23b75 100644
> >> > --- a/tests/qtest/migration-test.c
> >> > +++ b/tests/qtest/migration-test.c
> >> > @@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
> >> >      }
> >> >      qtest_add_func("/migration/multifd/tcp/plain/none",
> >> >                     test_multifd_tcp_none);
> >> > -    /*
> >> > -     * This test is flaky and sometimes fails in CI and otherwise:
> >> > -     * don't run unless user opts in via environment variable.
> >> > -     */
> >> > -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> >> > -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
> >> > -                       test_multifd_tcp_cancel);
> >> > -    }
> >> > +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
> >> > +                   test_multifd_tcp_cancel);
> >> >      qtest_add_func("/migration/multifd/tcp/plain/zlib",
> >> >                     test_multifd_tcp_zlib);
> >> >  #ifdef CONFIG_ZSTD
> >> 
> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> 
> >> There was another failure with migration test that I will post during
> >> the rest of the day.  It needs both to get it right.
> >
> > This one didn't yet land upstream.  I'm not sure, but maybe Juan was saying
> > about this change:
> >
> >         commit d2026ee117147893f8d80f060cede6d872ecbd7f
> >         Author: Juan Quintela <quintela@trasno.org>
> >         Date:   Wed Apr 26 12:20:36 2023 +0200
> >
> >         multifd: Fix the number of channels ready
> 
> That's not it. It was something in the test itself around the fact that
> we use two sets of: from/to. There was supposed to be a situation where
> we'd start 'to2' while 'to' was still running and that would cause
> issues (possibly with sockets).
> 
> I think what might have happened is that someone merged a fix through
> another tree and Juan didn't notice. I think this is the one:
> 
>   commit f2d063e61ee2026700ab44bef967f663e976bec8
>   Author: Xuzhou Cheng <xuzhou.cheng@windriver.com>
>   Date:   Fri Oct 28 12:57:32 2022 +0800
>   
>       tests/qtest: migration-test: Make sure QEMU process "to" exited after migration is canceled
>       
>       Make sure QEMU process "to" exited before launching another target
>       for migration in the test_multifd_tcp_cancel case.
>       
>       Signed-off-by: Xuzhou Cheng <xuzhou.cheng@windriver.com>
>       Signed-off-by: Bin Meng <bin.meng@windriver.com>
>       Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>       Message-Id: <20221028045736.679903-8-bin.meng@windriver.com>
>       Signed-off-by: Thomas Huth <thuth@redhat.com>

Hmm, i see.

> 
> > Fabiano, did you try to reproduce multifd-cancel with current master?  I'm
> > wondering whether this test has already been completely fixed, then maybe
> > we can pick up this patch now.
> 
> Yes, let's merge it. I have kept it enabled during testing of all of the
> recent race conditions we've debugged and haven't seen it fail. Current
> master also looks fine.

It needs a trivial touchup, but then I queued it.

Thanks,

-- 
Peter Xu


