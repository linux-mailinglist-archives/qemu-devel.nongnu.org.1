Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B844770EB6
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCPl-0004mY-8v; Sat, 05 Aug 2023 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCPj-0004m9-LN
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCPi-0000jw-0M
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691223209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kuls/8mUCG4jj0C+zwiCM2D3HHvbu1e46o6yO1j7bao=;
 b=MB5rJMWU0BzkrLIm6d4pQcHb37XY0zFB/Fe1MRudV9tUsizdzY408GfBXzjlw8wAAlphmH
 Rp5R6riy1OVkMIgwfmiBYE6RRJGjttPeK65jE/tXRMDl1WiJrN17X3ZO+yN2DbpktL+x32
 RXoPKpjPZT8euazrx4Cd/EMrAFxCCy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-nGzNXTOVNSWZebSZ9mS9mw-1; Sat, 05 Aug 2023 04:13:27 -0400
X-MC-Unique: nGzNXTOVNSWZebSZ9mS9mw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FC88101132F;
 Sat,  5 Aug 2023 08:13:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D60B2492B02;
 Sat,  5 Aug 2023 08:13:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE28A21E692A; Sat,  5 Aug 2023 10:13:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>,  Eric Blake <eblake@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Chensheng Dong <chdong@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org> <ZME33z8vFL0fRGYV@x1n>
 <87h6pf9fmd.fsf@pond.sub.org> <ZMz9FJ09waiG4r9n@x1n>
Date: Sat, 05 Aug 2023 10:13:25 +0200
In-Reply-To: <ZMz9FJ09waiG4r9n@x1n> (Peter Xu's message of "Fri, 4 Aug 2023
 09:28:52 -0400")
Message-ID: <87wmy9x5y2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Aug 04, 2023 at 02:06:02PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > Hi, Markus,
>> >> >
>> >> > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
>> >> 
>> >> [...]
>> >> 
>> >> >> For better or worse, we duplicate full documentation between
>> >> >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
>> >> >> would be the first instance where we reference instead.  I'm not opposed
>> >> >> to use references, but if we do, I want them used consistently.
>> >> >
>> >> > We discussed this over the other "switchover" parameter, but that patchset
>> >> > just stranded..
>> >> >
>> >> > Perhaps I just provide a pre-requisite patch to remove all the comments in
>> >> > MigrateSetParameters and MigrationParameters, letting them all point to
>> >> > MigrationParameter?
>> >> 
>> >> Simplifies maintaining the doc commments.  But how does it affect the
>> >> documentation generated from it?  Better, neutral, or worse?
>> >
>> > Probably somewhere neutral.  There are definitely benefits, shorter
>> > man/html page in total, and avoid accidentally different docs over the same
>> > fields.  E.g., we sometimes have different wordings for different objects:
>> >
>> >        max-cpu-throttle
>> >               maximum cpu throttle percentage.  Defaults to 99.  (Since 3.1)
>> >
>> >        max-cpu-throttle: int (optional)
>> >               maximum cpu throttle percentage.  The default value is 99. (Since 3.1)
>> >
>> > This one is fine, but it's just very easy to leak in something that shows
>> > differently.  It's good to provide coherent documentation for the same
>> > fields over all three objects.
>> 
>> Yes, but we've been doing okay regardless.
>> 
>> The drawback of replacing duplicates by references is that readers need
>> to follow the references.
>> 
>> Less onerous when the references can be clicked.
>> 
>> If we de-duplicate, which copy do we keep, MigrationParameter,
>> MigrateSetParameters, or MigrationParameter?  Do we have an idea which
>> of these users are likely to read first?
>
> I chose MigrationParameter for no explicit reason, because I can't find
> good argument to differenciate them.  Please let me know if you have any
> suggestion.
>
>> 
>> > When looking at qemu-qmp-ref.7, it can be like this when we can invite the
>> > reader to read the other section (assuming we only keep MigrationParameter
>> > to keep the documentations):
>> >
>> >    MigrationParameters (Object)
>> >
>> >        The object structure to represent a list of migration parameters.
>> >        The optional members aren't actually optional.  For detailed
>> >        explanation for each of the field, please refer to the documentation
>> >        of MigrationParameter.
>> >
>> > But the problem is we always will generate the Members entry, where now
>> > it'll all filled up with "Not documented"..
>> >
>> >    Members
>> >        announce-initial: int (optional)
>> >               Not documented
>> >
>> >        announce-max: int (optional)
>> >               Not documented
>> >
>> >        announce-rounds: int (optional)
>> >               Not documented
>> >
>> >        [...]
>> >
>> > I think maybe it's better we just list the members without showing "Not
>> > documented" every time for the other two objects.  Not sure whether it's an
>> > easy way to fix it, or is it a major issue.
>> 
>> The automatic generation of "Not documented" documentation is a
>> stop-gap.  Leaving a member undocumented should be a hard error.  It
>> isn't only because we have 511 instances to fix.
>> 
>> Perhaps a directive to ignore undocumented members could be useful.
>> I.e. to suppress the automatic "Not documented" documented now, the
>> error later.
>> 
>> We could write things out in longhand instead, like
>> 
>>     # @announce-initial: Same as MigrationParameter member
>>     #     @announce-initial.
>
> Yes I can definitely do this.
>
> Since I don't really know whether the "put a link" will work at all (at
> least man page doesn't really have those, does it?), would this be the way
> you suggest us forward?

I don't remember offhand how the QAPI doc generation machinery adds
links.  I can look it up for you after my vacation (two weeks, starting
basically now).

> Note that I am also always happy to simply duplicate the three paragraphs
> just like before; that's not something I must do with solving the migration
> problem so far, we can decouple the two problems essentially.  But since
> we're at it, if you think worthwhile we may have a chance get rid of
> duplicated documents here (before code) I can try.
>
>> 
>> > For developers, dedup the comment should always be a win, afaict.
>> 
>> No argument.
>
> Let me explain a bit: I meant the patch author who will reduce writting
> duplicated documents, making sure everything match together.  And reviewers
> who will read the duplicated content, making sure that everything match
> together again.  The two efforts can be avoided.  That's all I meant here
> for when I was referring to as "developers" in this context..  Not everyone
> as a common sense of developer.

By "no argument", I mean we don't need to argue about this.  I actually
agree with you that de-duplication would be net positive for developers.


