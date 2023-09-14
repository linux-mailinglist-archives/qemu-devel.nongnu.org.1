Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92897A03D7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglSV-00022F-DU; Thu, 14 Sep 2023 08:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qglSU-00021Y-5v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qglSS-0006tY-1h
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694694510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvgAjAoWCEdXVX+hfH6P2BpT50D34U2ytvSifhhQocg=;
 b=DnMhNiOjmP9YCvzO8QtiK4/Bjl9FjZefNvDOeIAa2AEAIm7c4ciCFas+u0gzB9oARvumVA
 zIUTAxHlDqbT95QAix4D0jL3XImUGTTU0UrDRqX7xzbB5p7LWm5jB1kJ7XCagxOLcEFBLK
 kl1OfyuRD3AUSQxPKIJgGHAK8VVsUEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-OoIt5ED-PIWS1IT94f_OLA-1; Thu, 14 Sep 2023 08:28:29 -0400
X-MC-Unique: OoIt5ED-PIWS1IT94f_OLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDC0185A79B;
 Thu, 14 Sep 2023 12:28:28 +0000 (UTC)
Received: from redhat.com (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82C7640C6EBF;
 Thu, 14 Sep 2023 12:28:27 +0000 (UTC)
Date: Thu, 14 Sep 2023 14:28:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Message-ID: <ZQL8avIMyJq4xvHz@redhat.com>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <ZQHZquVrpTFaU7kD@redhat.com>
 <4si43aghmpl4yxtlqhg63q2ivecnsxi5sm67ec5dhtezrhbijy@7zcuqmytr2qt>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4si43aghmpl4yxtlqhg63q2ivecnsxi5sm67ec5dhtezrhbijy@7zcuqmytr2qt>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 13.09.2023 um 18:31 hat Eric Blake geschrieben:
> On Wed, Sep 13, 2023 at 04:47:54PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Sep 06, 2023 at 04:09:17PM +0200, Denis V. Lunev wrote:
> > > Each particular testcase could skipped intentionally and accidentally.
> > > For example the test is not designed for a particular image format or
> > > is not run due to the missed library.
> > > 
> > > The latter case is unwanted in reality. Though the discussion has
> > > revealed that failing the test in such a case would be bad. Thus the
> > > patch tries to do different thing. It adds additional status for
> > > the test case - 'skipped' and bound intentinal cases to that state.
> > 
> > I'm not convinced this distinction makes sense and I fear it is
> > leading us down the same undesirable route as avocado with too
> > many distinct states leading to confusion:
> > 
> >   https://lore.kernel.org/qemu-devel/Yy1gB1KB3YSIUcoC@redhat.com/
> > 
> > If I looked at the output I can't tell you the difference between
> > "not run" and "skipped" - they both sound the same to me.
> > 
> > IMHO there's alot to be said for the simplicity of sticking with
> > nothing more than PASS/FAIL/SKIP as status names.  The descriptive
> > text associated with each SKIP would give more context as to the
> > reason in each case if needed.
> 
> I guess it boils down to whether there is an actionable response in
> that message.  If a test is skipped because it is the wrong format
> (for example, ./check -raw skipping a test that only works with
> qcow2), there's nothing for me to do.  If a test is skipped because my
> setup didn't permit running the test, but where I could enhance my
> environment (install more software, pick a different file system,
> ...), then having the skip message call that out is useful if I want
> to take action to get more test coverage.

I'm not sure if there is a clear line to define whether there is an
actionable response or not, because that completely depends on what the
user considers an acceptable response.

You have the relatively clear cases like the test being for another
format, though you could argue that the actionable response is running
./check -qcow2 if raw doesn't work - in fact, why don't we allow ./check
-raw -qcow2 to run both and count it as skipped only if it wasn't run at
all?

The relatively clear case on the other end of the spectrum is if a tool
is missing on the host that you could possibly install. Though maybe
your distro doesn't even package it, so is that still a reasonable
action to take?

What about cases where a block driver isn't compiled in or not
whitelisted? (We've seen this often enough with quorum.) That could be
an accident, but more likely it was a conscious decision and while just
enabling it might fix the test case, enabling additional features in
your product just to make tests happy might not be considered
acceptable. So should this be "not run" or "skipped"? [1]

You could find other unclear cases like tests depending on a different
target architecture, or testing different code paths on different target
architectures.

> Even if the message is present, we have so many tests intentionally
> skipped that it is hard to see the few tests where a skip could be
> turned into a pass by installing a prerequisite.
> 
> > > +++ b/tests/qemu-iotests/testrunner.py
> > > @@ -200,6 +200,8 @@ def test_print_one_line(self, test: str,
> > >                  col = '\033[1m\033[31m'
> > >              elif status == 'not run':
> > >                  col = '\033[33m'
> > > +            elif status == 'skipped':
> > > +                col = '\033[34m'
> > >              else:
> > >                  col = ''
> 
> It looks like for now, the only difference in the two designations is
> the output color, and even then, only if you are running the tests in
> an environment where color matters (CI systems may not be showing
> colors as intended).

Well, and the different status text, obviously.

CI will probably use the tap interface, which is not modified at all by
the patch, so no result would be recorded for "skipped" tests (while
"not run" tests will still return "ok ... # SKIP").

Kevin

[1] If you do answer this rhetorical question, please note that I
    already forgot which is which, so maybe also specify if you mean the
    bad skip or the harmless skip.


