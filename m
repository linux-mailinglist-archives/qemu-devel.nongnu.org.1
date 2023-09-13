Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342879EE49
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSmE-0000ry-0a; Wed, 13 Sep 2023 12:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSm9-0000r9-7M
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSm6-0005wQ-4M
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694622693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSSxsNYIlpsRuxP4Cp3DLuGL4u+kATOjn6ibis7QV0A=;
 b=F58i0xP6Y/QBMBo/LT1kAj38Jz0duhhoOjaP2u/mH4OuGXaETRSrJgW04/cEmeBy0QKEjf
 rit1u6QQhf6mXbOYCvl0S49AHfMqo75rml8zW2fUCuYP7kRf8TWYoq0iJZjVFT/KyvEBRM
 vd1nshxgFv3/+YXqcpZTT7/MJYqrx4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-FJmeDHx4Np2IvwCeycoLbA-1; Wed, 13 Sep 2023 12:31:29 -0400
X-MC-Unique: FJmeDHx4Np2IvwCeycoLbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF71805B3E;
 Wed, 13 Sep 2023 16:31:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AF6540C6EC0;
 Wed, 13 Sep 2023 16:31:27 +0000 (UTC)
Date: Wed, 13 Sep 2023 11:31:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Message-ID: <4si43aghmpl4yxtlqhg63q2ivecnsxi5sm67ec5dhtezrhbijy@7zcuqmytr2qt>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <ZQHZquVrpTFaU7kD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQHZquVrpTFaU7kD@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 13, 2023 at 04:47:54PM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 06, 2023 at 04:09:17PM +0200, Denis V. Lunev wrote:
> > Each particular testcase could skipped intentionally and accidentally.
> > For example the test is not designed for a particular image format or
> > is not run due to the missed library.
> > 
> > The latter case is unwanted in reality. Though the discussion has
> > revealed that failing the test in such a case would be bad. Thus the
> > patch tries to do different thing. It adds additional status for
> > the test case - 'skipped' and bound intentinal cases to that state.
> 
> I'm not convinced this distinction makes sense and I fear it is
> leading us down the same undesirable route as avocado with too
> many distinct states leading to confusion:
> 
>   https://lore.kernel.org/qemu-devel/Yy1gB1KB3YSIUcoC@redhat.com/
> 
> If I looked at the output I can't tell you the difference between
> "not run" and "skipped" - they both sound the same to me.
> 
> IMHO there's alot to be said for the simplicity of sticking with
> nothing more than PASS/FAIL/SKIP as status names.  The descriptive
> text associated with each SKIP would give more context as to the
> reason in each case if needed.

I guess it boils down to whether there is an actionable response in
that message.  If a test is skipped because it is the wrong format
(for example, ./check -raw skipping a test that only works with
qcow2), there's nothing for me to do.  If a test is skipped because my
setup didn't permit running the test, but where I could enhance my
environment (install more software, pick a different file system,
...), then having the skip message call that out is useful if I want
to take action to get more test coverage.  Even if the message is
present, we have so many tests intentionally skipped that it is hard
to see the few tests where a skip could be turned into a pass by
installing a prerequisite.

> > +++ b/tests/qemu-iotests/testrunner.py
> > @@ -200,6 +200,8 @@ def test_print_one_line(self, test: str,
> >                  col = '\033[1m\033[31m'
> >              elif status == 'not run':
> >                  col = '\033[33m'
> > +            elif status == 'skipped':
> > +                col = '\033[34m'
> >              else:
> >                  col = ''

It looks like for now, the only difference in the two designations is
the output color, and even then, only if you are running the tests in
an environment where color matters (CI systems may not be showing
colors as intended).

I'll hold off queuing the patch while conversation continues.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


