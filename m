Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3519736BA7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaCX-00073K-Qa; Tue, 20 Jun 2023 08:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBaCV-000737-Gl
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBaCR-0002NR-T4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687263067;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gqgwrtcJCe8OdJc7XKKsrM1TYQHhYh4C4wj6lwUDqMg=;
 b=De7ceZfOc0qhiKu15jgHacp3F3EnpVrYYWHfAKuGwVk2mxre4HSBFDEUxYiviMOxJbjWS3
 seu+m4B8GzlnY6x1gfNrqFGKqgKowJoKWxT1pdqte9Dt861xfucY5ITeAwtzz9NVqZlRy8
 t6HrKl3RM1cQRWcAifTlwiEH/shY/8c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-cvlOHUuPODyianvJ2qk9TA-1; Tue, 20 Jun 2023 08:11:04 -0400
X-MC-Unique: cvlOHUuPODyianvJ2qk9TA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF8D53810795;
 Tue, 20 Jun 2023 12:11:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C59E2166B26;
 Tue, 20 Jun 2023 12:10:57 +0000 (UTC)
Date: Tue, 20 Jun 2023 13:10:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJGXT4z95dMx0rd7@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y7sflqb.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 12, 2023 at 10:51:08PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
> >> Only "defer" is recommended.  After setting all migation parameters,
> >> start incoming migration with "migrate-incoming uri" command.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  docs/about/deprecated.rst | 7 +++++++
> >>  softmmu/vl.c              | 2 ++
> >>  2 files changed, 9 insertions(+)
> >> 
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 47e98dc95e..518672722d 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
> >>  ``blk`` functionality can be acchieved using
> >>  ``migrate_set_parameter block-incremental true``.
> >>  
> >> +``-incoming uri`` (since 8.1)
> >> +'''''''''''''''''''''''''''''
> >> +
> >> +Everything except ``-incoming defer`` are deprecated.  This allows to
> >> +setup parameters before launching the proper migration with
> >> +``migrate-incoming uri``.
> >> +
> >> diff --git a/softmmu/vl.c b/softmmu/vl.c
> >> index b0b96f67fa..7fe865ab59 100644
> >> --- a/softmmu/vl.c
> >> +++ b/softmmu/vl.c
> >> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
> >>      if (incoming) {
> >>          Error *local_err = NULL;
> >>          if (strcmp(incoming, "defer") != 0) {
> >> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
> >> +                        " set the uri with migrate-incoming.", incoming);
> >
> > I still use uri for all my scripts, alongside with "-global migration.xxx"
> > and it works.
> 
> You know what you are doing (TM).
> And remember that we don't support -gobal migration.x-foo.
> Yes, I know, we should drop the "x-" prefixes.
> 
> > Shall we just leave it there?  Or is deprecating it helps us in any form?
> 
> See the patches two weeks ago when people complained that lisen(.., num)
> was too low.  And there are other parameters that work the same way
> (that I convenientely had forgotten).  So the easiest way to get things
> right is to use "defer" always.  Using -incoming "uri" should only be
> for people that "know what they are doing", so we had to ways to do it:
> - review all migration options and see which ones work without defer
>   and document it
> - deprecate everything that is not defer.
> 
> Anything else is not going to be very user unfriendly.
> What do you think.

In some cases it is worth having a convenience option for user friendliness.

In this case, however, users are already needing to use QMP/HMP on the
source side to set migration parameters. I think it is reasonable to say
that doing *exactly* the same with QMP/HMP on the destination side is
actually more friendly than requiring use of -global on the dest side
which is different syntax.

We don't document the way to use -global with migration parameters so
when people see '-incoming' I think we are steering them into a trap,
making it look like -incoming is sufficient on its own. Hence that user's
mistake recently about not setting migration parameters.

Overall I agree with deprecating  '-incoming' != 'defer', as I think it
will better guide users to following the correct steps, as is not a
usability burden as they're already using QMP/HMP on the source side.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


