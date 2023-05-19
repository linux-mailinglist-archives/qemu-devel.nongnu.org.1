Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABB709E98
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04J9-0007Qx-EC; Fri, 19 May 2023 13:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04J7-0007QY-Gg
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04J6-0005Hj-20
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684518863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33o5hjQaEdvkmpCxUCSk/yN5FVLiyQWRI8/SHXQqshg=;
 b=Ennzcsz1lL4JnC2Lhsa0M3yv+5E16WpCM4YW2BhD/QDRLWKmIKBLl/Wd29mnKmj/wq6ZeF
 mFvnhM+WVNBy7Q78aGVXxG1yPzLK6xpfmfIjn3gqgWI8FYe7bnUppiCAFs54AL1gYYEmLP
 SesgXvQ5fsU15Z0T1V5NUEEyd5r4XWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-3hn6_CHGP1Ob94b2IMd-YQ-1; Fri, 19 May 2023 13:54:22 -0400
X-MC-Unique: 3hn6_CHGP1Ob94b2IMd-YQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0430811E86;
 Fri, 19 May 2023 17:54:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0834F2DE7;
 Fri, 19 May 2023 17:54:20 +0000 (UTC)
Date: Fri, 19 May 2023 12:54:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 11/19] test-cutils: Refactor qemu_strtosz tests for
 less boilerplate
Message-ID: <fzjeahymwhinmdv43qvu6qk4ax6a7rehbk7uaept3qzqsjsnwi@e6rzdep42bxr>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-12-eblake@redhat.com>
 <609ab33a-d0fe-d13b-274c-4c517ecd5428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609ab33a-d0fe-d13b-274c-4c517ecd5428@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 19, 2023 at 05:13:52PM +0200, Hanna Czenczek wrote:
> On 12.05.23 04:10, Eric Blake wrote:
> > No need to copy-and-paste lots of boilerplate per string tested, when
> > we can consolidate that behind helper functions.  Plus, this adds a
> > bit more coverage (we now test all strings both with and without
> > endptr, whereas before some tests skipped the NULL endptr case), which
> > exposed a SEGFAULT on qemu_strtosz(NULL, NULL, &val) that will be
> > parsed in an upcoming patch.

s/parsed/fixed/

> > 
> > Note that duplicating boilerplate has one advantage lost here - a
> > failed test tells you which line number failed; but a helper function
> > does not show the call stack that reached the failure.  Since we call
> > the helper more than once within many of the "unit tests", even the
> > unit test name doesn't point out which call is failing.  But that only
> > matters when tests fail (they normally pass); at which point I'm
> > debugging the failures under gdb anyways, so I'm not too worried about
> > it.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   tests/unit/test-cutils.c | 503 ++++++++-------------------------------
> >   1 file changed, 100 insertions(+), 403 deletions(-)
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

I'm debating about using similar boilerplate compression for the
strtol and strtod tests in v3 of the series.  I can definitively state
that debugging a failed test was harder (had to open up gdb instead of
just seeing the line number of the failure), but that overall I got to
focus a lot more on the tests rather than the boilerplate.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


