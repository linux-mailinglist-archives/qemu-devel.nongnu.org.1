Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CB7A070D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgn8G-0005hE-Uf; Thu, 14 Sep 2023 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgn8A-0005ec-Ia
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgn88-00043r-Bg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=utjZRj1rg1Jlk8Apku+ftk3YVVsBUNZGao4CABt4bnk=;
 b=UFD9+5WFJh0z6KjfKwFw3GBwYw3cXAcvte1yPwjGFnEARLs8p3tyd2y8CwUhS423NBjMU9
 17BT7cpM4HQj17tLNvH6BLPnw8vZZZxgFUTp7EkZNP3Bv6eYC0oyMZrw7cb9Fk/xo8nJ/g
 3clHvb8rRRGWhFc1y+DqzKArgWrN41A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-G0I9LcO4Oxa5JwWBGARyxg-1; Thu, 14 Sep 2023 10:15:34 -0400
X-MC-Unique: G0I9LcO4Oxa5JwWBGARyxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65EF481DC15
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 14:15:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B66962026D4B;
 Thu, 14 Sep 2023 14:15:33 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:15:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi: fix example of query-rocker-of-dpa-flows
 command
Message-ID: <ZQMVg7LD4KDvwlwq@redhat.com>
References: <20230911104017.65397-1-victortoso@redhat.com>
 <20230911104017.65397-8-victortoso@redhat.com>
 <87ttrwn9sw.fsf@pond.sub.org>
 <rfoxcr5ki2g7p42mny2ycw4fo6is6n262c7byujqw7gauqketa@zsiljvb3akc3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rfoxcr5ki2g7p42mny2ycw4fo6is6n262c7byujqw7gauqketa@zsiljvb3akc3>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 14, 2023 at 04:01:55PM +0200, Victor Toso wrote:
> Hi,
> 
> On Thu, Sep 14, 2023 at 03:50:23PM +0200, Markus Armbruster wrote:
> > Victor Toso <victortoso@redhat.com> writes:
> > 
> > > Example output has a comment embedded in the array. Remove it.
> > > The end result is a list of size 1.
> > >
> > > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > > ---
> > >  qapi/rocker.json | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/qapi/rocker.json b/qapi/rocker.json
> > > index 31ce0b36f6..858e4f4a45 100644
> > > --- a/qapi/rocker.json
> > > +++ b/qapi/rocker.json
> > > @@ -249,8 +249,7 @@
> > >  #                   "cookie": 0,
> > >  #                   "action": {"goto-tbl": 10},
> > >  #                   "mask": {"in-pport": 4294901760}
> > > -#                  },
> > > -#                  {...more...},
> > > +#                  }
> > >  #    ]}
> > >  ##
> > >  { 'command': 'query-rocker-of-dpa-flows',
> > 
> > The schema patches in this series fix typos, except for this patch and
> > the next one, which drop "more of the same omitted for brevity" text.  I
> > believe you drop the text because it doesn't parse as JSON.
> 
> That's correct.
> 
> > Fine if the example still make sense afterwards.  Do they?
> 
> It depends what you mean by making sense. I did not setup rocker
> to do this query and copied a real example. I think the real
> example would have a list of size more than one.
> 
> So, if you think about real examples, it might not make sense. If
> we talk about clarifying they API, I think it is reasonable.
>  
> > Shortening examples is a reasonable thing to do.  Perhaps we
> > should adopt a conventional way to do it, and teach the
> > proposed generator to cope with it.  What do you think?
> 
> Yep, I like it. In reality, I did not do this change in v1 but it
> was suggested by Daniel that the end result of introducing this
> generator would be to have it run without errors, so I shortened
> as a simple way to fix it.
> 
> So, should we instead move forward with another convention for
> comments inside the examples? This way we could still have a list
> size 1 with this patch but it would be clear that the expectation
> is a bigger list.

Personally I'd say if a field is a list, then the example should
contain 2 elements, just to make it a little more obvious at a
glance, as opposed to relying on spottnig the []. But that's not
a massively strong argument.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


