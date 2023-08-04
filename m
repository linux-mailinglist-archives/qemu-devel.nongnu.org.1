Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4424770202
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRv1t-0002NQ-IJ; Fri, 04 Aug 2023 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRv1q-0002Mo-4V
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRv1i-0001v6-He
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691156362;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qFiwBAeM/ffqHiVVGuLOSQ7USRY7Ej9FOzAzPadXqus=;
 b=C3PJDGXAC7IvWFZ9d9GLvyj0kWcot8wobgHZ3hnmfmq9UmeEtb17OSYtAXbfIXWV534ZYx
 KFuJ0KroUIgEmbwCL28Tldkfv3qzK2U3wpyU7NFggBPOmUPYQwvCOkXbVRibvBfE24O5pJ
 NIMV0QGDwV+3xEtXPx67aFCPQnib764=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-jA2LgF7mPXS4Hi9eZNbGDw-1; Fri, 04 Aug 2023 09:39:21 -0400
X-MC-Unique: jA2LgF7mPXS4Hi9eZNbGDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6233883505A;
 Fri,  4 Aug 2023 13:39:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4C6E40C2078;
 Fri,  4 Aug 2023 13:39:17 +0000 (UTC)
Date: Fri, 4 Aug 2023 14:39:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZMz/g+qU7vzXx6aP@redhat.com>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org> <ZME33z8vFL0fRGYV@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZME33z8vFL0fRGYV@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Wed, Jul 26, 2023 at 11:12:31AM -0400, Peter Xu wrote:
> On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > Hi, Markus,
> > >
> > > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
> > 
> > [...]
> > 
> > >> For better or worse, we duplicate full documentation between
> > >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
> > >> would be the first instance where we reference instead.  I'm not opposed
> > >> to use references, but if we do, I want them used consistently.
> > >
> > > We discussed this over the other "switchover" parameter, but that patchset
> > > just stranded..
> > >
> > > Perhaps I just provide a pre-requisite patch to remove all the comments in
> > > MigrateSetParameters and MigrationParameters, letting them all point to
> > > MigrationParameter?
> > 
> > Simplifies maintaining the doc commments.  But how does it affect the
> > documentation generated from it?  Better, neutral, or worse?
> 
> Probably somewhere neutral.  There are definitely benefits, shorter
>
> man/html page in total, and avoid accidentally different docs over the same
> fields.  E.g., we sometimes have different wordings for different objects:
> 
>        max-cpu-throttle
>               maximum cpu throttle percentage.  Defaults to 99.  (Since 3.1)
> 
>        max-cpu-throttle: int (optional)
>               maximum cpu throttle percentage.  The default value is 99. (Since 3.1)
> 
> This one is fine, but it's just very easy to leak in something that shows
> differently.  It's good to provide coherent documentation for the same
> fields over all three objects.

Do we have any actual problems though where the difference in
docs is actively harmful ? I agree there's a possbility of the
duplication being problematic, but unless its actually the
case in reality, it is merely a theoretical downside.

IMHO for someone consuming the docs, this patch is worse, not neutral.

> 
> When looking at qemu-qmp-ref.7, it can be like this when we can invite the
> reader to read the other section (assuming we only keep MigrationParameter
> to keep the documentations):
> 
>    MigrationParameters (Object)
> 
>        The object structure to represent a list of migration parameters.
>        The optional members aren't actually optional.  For detailed
>        explanation for each of the field, please refer to the documentation
>        of MigrationParameter.
> 
> But the problem is we always will generate the Members entry, where now
> it'll all filled up with "Not documented"..
> 
>    Members
>        announce-initial: int (optional)
>               Not documented
> 
>        announce-max: int (optional)
>               Not documented
> 
>        announce-rounds: int (optional)
>               Not documented
> 
>        [...]
> 
> I think maybe it's better we just list the members without showing "Not
> documented" every time for the other two objects.  Not sure whether it's an
> easy way to fix it, or is it a major issue.
> 
> For developers, dedup the comment should always be a win, afaict.

IMHO that's optimizing for the wrong people and isn't a measurable
win anyway. Someone adding a new parameter can just cut+paste the
same docs string in the three places. It is a cost, but it is a
small one time cost, where having "not documented" is a ongoing
cost for consumers of our API.

I don't think the burden on QEMU maintainers adding new migration
parameters is significant enough to justify ripping out our existing
docs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


