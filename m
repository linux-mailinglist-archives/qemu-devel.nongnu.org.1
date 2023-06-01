Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679671EEDF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kPH-0003VZ-R0; Thu, 01 Jun 2023 11:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kPF-0003V8-P4
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kPD-0006LA-Kq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685634002;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYLXDoBiWowzoMIFoHjTuk0SVsemWSF69WtkA7++nYY=;
 b=YNtSI53BOWDmhiy6Ue8wpmflzVPqWwok5Tw+EyhRow9csPpGZiz3Usin446OU9o+bLfTYS
 E7Ewge3qabq7E6bQZwrvKYmEHPW7HQJ/r5SI2PKGfSA8pKSnZT8krj/AWcRfCyOTwexJ69
 UXE3+cyhh5XxIjOSXwPdLbO+GFchJJ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-o5l5HoBHPr6-7NCR5OxdNA-1; Thu, 01 Jun 2023 11:39:56 -0400
X-MC-Unique: o5l5HoBHPr6-7NCR5OxdNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03B7C29DD9B6
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 15:39:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37E4B40CFD45;
 Thu,  1 Jun 2023 15:39:51 +0000 (UTC)
Date: Thu, 1 Jun 2023 16:39:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHi7xLhUp0+5cay7@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <ZHi5gmd+5pQhDqBF@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHi5gmd+5pQhDqBF@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 11:30:10AM -0400, Peter Xu wrote:
> Thanks for looking into this.. definitely worthwhile.
> 
> On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrangé wrote:
> > There are 27 pre-copy live migration scenarios being tested. In all of
> > these we force non-convergance and run for one iteration, then let it
> > converge and wait for completion during the second (or following)
> > iterations. At 3 mbps bandwidth limit the first iteration takes a very
> > long time (~30 seconds).
> > 
> > While it is important to test the migration passes and convergance
> > logic, it is overkill to do this for all 27 pre-copy scenarios. The
> > TLS migration scenarios in particular are merely exercising different
> > code paths during connection establishment.
> > 
> > To optimize time taken, switch most of the test scenarios to run
> > non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> > a massive speed up for most of the test scenarios.
> > 
> > For test coverage the following scenarios are unchanged
> 
> Curious how are below chosen?  I assume..

Chosen based on whether they exercise code paths that are unique
and interesting during the RAM transfer phase.

Essentially the goal is that if we have N% code coverage before this
patch, then we should still have the same N% code coverage after this
patch.

The TLS tests exercise code paths that are unique during the migration
establishment phase. Once establishd they don't exercise anything
"interesting" during RAM transfer phase. Thus we don't loose code coverage
by runing TLS tests non-live.

> 
> > 
> >  * Precopy with UNIX sockets
> 
> this one verifies dirty log.
> 
> >  * Precopy with UNIX sockets and dirty ring tracking
> 
> ... dirty ring...
> 
> >  * Precopy with XBZRLE
> 
> ... xbzrle I think needs a diff on old/new, makes sense.
> 
> >  * Precopy with UNIX compress
> >  * Precopy with UNIX compress (nowait)
> >  * Precopy with multifd
> 
> What about the rest three?  Especially for two compression tests.

The compress thread logic is unique/interesting during RAM transfer
so benefits from running live. The wait vs non-wait scenario tests
a distinct codepath/logic.

multifd has been a massive source of bugs and has very different
codepaths from non-multifd, so is needed for codeage.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


