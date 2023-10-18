Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2E7CD4AF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0R6-0007tZ-Fn; Wed, 18 Oct 2023 02:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0R2-0007tA-54
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0R0-0004MB-7K
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697612016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQ01y2oQ7SZWUN+dWtlPVRHXxNMc3aWGZp/xM6OnkWk=;
 b=JVYuWJKnw77fDymYnAhVEQscd5KrPSKNyOjFlR57vtHTCVV4r38gv2PrBIUM26KqFXFbdm
 Iw27szTzl1S/fqCZRQYWxdk4FdTXkPnGTE+qnilK/kqJMvX7pzymOKLYcKQP1Wdx8FRvjI
 pIKm6eN6qoVclS3r3RJ6dDheIPWjSfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-iC06mbRqP6iyKIHgGnTfag-1; Wed, 18 Oct 2023 02:53:15 -0400
X-MC-Unique: iC06mbRqP6iyKIHgGnTfag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD2FF881F00;
 Wed, 18 Oct 2023 06:53:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C3C72166B26;
 Wed, 18 Oct 2023 06:53:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 843CF21E6A1F; Wed, 18 Oct 2023 08:53:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Chensheng Dong
 <chdong@redhat.com>,  Juan Quintela <quintela@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Eric Blake <eblake@redhat.com>,  Joao Martins
 <joao.m.martins@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v4] migration: Allow user to specify available
 switchover bandwidth
References: <20231010221922.40638-1-peterx@redhat.com>
 <87y1g149t3.fsf@pond.sub.org> <ZS6qJ0F1uRlKWe45@x1n>
Date: Wed, 18 Oct 2023 08:53:13 +0200
In-Reply-To: <ZS6qJ0F1uRlKWe45@x1n> (Peter Xu's message of "Tue, 17 Oct 2023
 11:37:11 -0400")
Message-ID: <87wmvkxvza.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Oct 17, 2023 at 04:12:40PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Migration bandwidth is a very important value to live migration.  It's
>> > because it's one of the major factors that we'll make decision on when to
>> > switchover to destination in a precopy process.
>> >
>> > This value is currently estimated by QEMU during the whole live migration
>> > process by monitoring how fast we were sending the data.  This can be the
>> > most accurate bandwidth if in the ideal world, where we're always feeding
>> > unlimited data to the migration channel, and then it'll be limited to the
>> > bandwidth that is available.
>> >
>> > However in reality it may be very different, e.g., over a 10Gbps network we
>> > can see query-migrate showing migration bandwidth of only a few tens of
>> > MB/s just because there are plenty of other things the migration thread
>> > might be doing.  For example, the migration thread can be busy scanning
>> > zero pages, or it can be fetching dirty bitmap from other external dirty
>> > sources (like vhost or KVM).  It means we may not be pushing data as much
>> > as possible to migration channel, so the bandwidth estimated from "how many
>> > data we sent in the channel" can be dramatically inaccurate sometimes.
>> 
>> how much data we've sent to the channel
>> 
>> >
>> > With that, the decision to switchover will be affected, by assuming that we
>> > may not be able to switchover at all with such a low bandwidth, but in
>> > reality we can.
>> >
>> > The migration may not even converge at all with the downtime specified,
>> > with that wrong estimation of bandwidth, keeping iterations forever with a
>> 
>> iterating forever
>> 
>> > low estimation of bandwidth.
>> >
>> > The issue is QEMU itself may not be able to avoid those uncertainties on
>> > measuing the real "available migration bandwidth".  At least not something
>> > I can think of so far.
>> >
>> > One way to fix this is when the user is fully aware of the available
>> > bandwidth, then we can allow the user to help providing an accurate value.
>> >
>> > For example, if the user has a dedicated channel of 10Gbps for migration
>> > for this specific VM, the user can specify this bandwidth so QEMU can
>> > always do the calculation based on this fact, trusting the user as long as
>> > specified.  It may not be the exact bandwidth when switching over (in which
>> > case qemu will push migration data as fast as possible), but much better
>> > than QEMU trying to wildly guess, especially when very wrong.
>> >
>> > A new parameter "avail-switchover-bandwidth" is introduced just for this.
>> > So when the user specified this parameter, instead of trusting the
>> > estimated value from QEMU itself (based on the QEMUFile send speed), it
>> > trusts the user more by using this value to decide when to switchover,
>> > assuming that we'll have such bandwidth available then.
>> >
>> > Note that specifying this value will not throttle the bandwidth for
>> > switchover yet, so QEMU will always use the full bandwidth possible for
>> > sending switchover data, assuming that should always be the most important
>> > way to use the network at that time.
>> >
>> > This can resolve issues like "unconvergence migration" which is caused by
>> > hilarious low "migration bandwidth" detected for whatever reason.
>> 
>> "unconvergence" isn't a word :)
>> 
>> Suggest "like migration not converging, because the automatically
>> detected migration bandwidth is hilariously low for whatever reason."
>> 
>> Appreciate the thorough explanation!
>
> Thanks for reviewing!
>
> The patch is already in today's migration pull, so unfortunately no planned
> repost for now.  I'll amend the commit message and collect the ACK if I'll
> need to redo it.

Didn't see the PR, and didn't expect it so soon.

>> > Reported-by: Zhiyi Guo <zhguo@redhat.com>
>> > Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> > v4:
>> > - Rebase to master, with duplicated documentations
>> > ---
>> >  qapi/migration.json            | 34 +++++++++++++++++++++++++++++++++-
>> >  migration/migration.h          |  2 +-
>> >  migration/options.h            |  1 +
>> >  migration/migration-hmp-cmds.c | 14 ++++++++++++++
>> >  migration/migration.c          | 24 +++++++++++++++++++++---
>> >  migration/options.c            | 28 ++++++++++++++++++++++++++++
>> >  migration/trace-events         |  2 +-
>> >  7 files changed, 99 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 8843e74b59..0c897a99b1 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -759,6 +759,16 @@
>> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>> >  #     in bytes per second.  (Since 2.8)
>> >  #
>> > +# @avail-switchover-bandwidth: to set the available bandwidth that
>> > +#     migration can use during switchover phase.  NOTE!  This does not
>> > +#     limit the bandwidth during switchover, but only for calculations when
>> > +#     making decisions to switchover.  By default, this value is zero,
>> > +#     which means QEMU will estimate the bandwidth automatically.  This can
>> > +#     be set when the estimated value is not accurate, while the user is
>> > +#     able to guarantee such bandwidth is available when switching over.
>> > +#     When specified correctly, this can make the switchover decision much
>> > +#     more accurate.  (Since 8.2)
>> 
>> We tend to eschew abbreviations in QAPI schema identifiers.
>> available-switchover-bandwidth is a mouthful, though.  What do you
>> think?
>
> The named changed in the past versions, and IIRC avail-switchover-bandwidth
> is something we came up with last.. assuming a trade-off between length and
> sane meanings.  I don't have anything better to come up.. :)
>
> Please shoot if you have better suggestions.  We still have three weeks to
> 8.2 soft freeze.

I just had a similar conversation with Vladimir for "[PATCH 2/4] qapi:
introduce device-sync-config".  Quoting myself:

    In the words of Captain Barbossa, it's "more what you'd call
    'guidelines' than actual rules."

    I didn't come up with the "avoid abbreviations" stylistic guideline.  I
    inherited it.

    I do like consistent style.  I don't like excessively long names.
    Sometimes these likes conflict, and we need to pick.

For what it's worth, there's precedence for "avail" in the schema.

Let's move on.


