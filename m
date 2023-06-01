Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79071A347
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kcF-00007B-5E; Thu, 01 Jun 2023 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kc7-00005s-Ov
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kc6-0008VI-6N
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685634801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkWVJt2j4Xx7b3pcIZtl9+XvUpnGshXgv7Tqy3l+jm8=;
 b=YKThJ608/FPMoFQsASj20paVc2oV6tmguvrg7RYlcEXfki/9Gp+8OMav/30gTpZ60NSMUq
 q6wRvx1MnoxWhO147FA+2I18MMU/465NHitFqYL9KytKSNxBCFzsrDfvRvwVhiyHbzNGDS
 qqypkAg6bonoEoYJp+VoM/uIJOWdOE8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-KJ78syHHMte9977yl8vi8A-1; Thu, 01 Jun 2023 11:53:20 -0400
X-MC-Unique: KJ78syHHMte9977yl8vi8A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62829b2aa10so2270556d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685634800; x=1688226800;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkWVJt2j4Xx7b3pcIZtl9+XvUpnGshXgv7Tqy3l+jm8=;
 b=B5TIlBgnVO9v4LVceQ4DNInMnrtlIRo5bO3ZDNDSO9+Z8UIeKDKDO8f9fldPqxu3YO
 Vi6qek0vKbNMHK7TTrPLkmw+eavkdgH9ZnYbqkVchSH+0Xg+4YjfUraFwnCKZdnbtVXh
 WvnZwJnCyoR4VF/P1jiFpQO3lO6CFH3YzUUfOgdx7QTXj1JFMkfAa5NLT3qojmgjJ3dl
 Fh/ap6/SNaJKk6LIeh1+HacSVzdPhUwGm4CWJEanuP8Ur45KRZYif4SozA8ePVSYtsZf
 H9WGcMrCHtgANxY6IdnS0iwmh+b08MTqroaUszkeMEB5E15WYZYYCHvW/m7mhuk8YZtZ
 cJUw==
X-Gm-Message-State: AC+VfDyiCwD0g7Wq5dkIEI0GorWvbUIyfC3sfr5FiAk1mue8M71POtiP
 Ch2WHm+xzqIkCFaCoL9Z0IK+i+bJN/GFvKZIP4nUdCs7Eh8xHcJwEvXArhnRr71BfvStmawnZ65
 u8YfU9HwFUEBNkNk=
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id
 ge9-20020a05621427c900b00624dcc5819fmr10411086qvb.1.1685634799731; 
 Thu, 01 Jun 2023 08:53:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/4wxYE26n1USjuQnmjzqKU0HMD0QokCix8Bm/VwRXpzC2nRrO0y4vh3IG727oBAbf+wKIKA==
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id
 ge9-20020a05621427c900b00624dcc5819fmr10411068qvb.1.1685634799487; 
 Thu, 01 Jun 2023 08:53:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 y10-20020a0cff4a000000b005ef5f8dc89esm7590638qvt.88.2023.06.01.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 08:53:18 -0700 (PDT)
Date: Thu, 1 Jun 2023 11:53:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHi+7bgcHPUisc8d@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <ZHi5gmd+5pQhDqBF@x1n> <ZHi7xLhUp0+5cay7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHi7xLhUp0+5cay7@redhat.com>
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

On Thu, Jun 01, 2023 at 04:39:48PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 11:30:10AM -0400, Peter Xu wrote:
> > Thanks for looking into this.. definitely worthwhile.
> > 
> > On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrangé wrote:
> > > There are 27 pre-copy live migration scenarios being tested. In all of
> > > these we force non-convergance and run for one iteration, then let it
> > > converge and wait for completion during the second (or following)
> > > iterations. At 3 mbps bandwidth limit the first iteration takes a very
> > > long time (~30 seconds).
> > > 
> > > While it is important to test the migration passes and convergance
> > > logic, it is overkill to do this for all 27 pre-copy scenarios. The
> > > TLS migration scenarios in particular are merely exercising different
> > > code paths during connection establishment.
> > > 
> > > To optimize time taken, switch most of the test scenarios to run
> > > non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> > > a massive speed up for most of the test scenarios.
> > > 
> > > For test coverage the following scenarios are unchanged
> > 
> > Curious how are below chosen?  I assume..
> 
> Chosen based on whether they exercise code paths that are unique
> and interesting during the RAM transfer phase.
> 
> Essentially the goal is that if we have N% code coverage before this
> patch, then we should still have the same N% code coverage after this
> patch.
> 
> The TLS tests exercise code paths that are unique during the migration
> establishment phase. Once establishd they don't exercise anything
> "interesting" during RAM transfer phase. Thus we don't loose code coverage
> by runing TLS tests non-live.
> 
> > 
> > > 
> > >  * Precopy with UNIX sockets
> > 
> > this one verifies dirty log.
> > 
> > >  * Precopy with UNIX sockets and dirty ring tracking
> > 
> > ... dirty ring...
> > 
> > >  * Precopy with XBZRLE
> > 
> > ... xbzrle I think needs a diff on old/new, makes sense.
> > 
> > >  * Precopy with UNIX compress
> > >  * Precopy with UNIX compress (nowait)
> > >  * Precopy with multifd
> > 
> > What about the rest three?  Especially for two compression tests.
> 
> The compress thread logic is unique/interesting during RAM transfer
> so benefits from running live. The wait vs non-wait scenario tests
> a distinct codepath/logic.

I assume you mean e.g. when compressing with guest page being modified and
we should survive that rather than crashing the compressor?

Okay to me.

> 
> multifd has been a massive source of bugs and has very different
> codepaths from non-multifd, so is needed for codeage.

:(

I think it makes sense to keep multifd in that, especially if we want to
some day make it more or less default.

Would you mind add some comment into each of .live=true case right above?
Then it'll be fairly clear that's not the default and any new test case
should justify them to be live=true.

Feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu


