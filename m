Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F2676FFF5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtZV-00027R-JO; Fri, 04 Aug 2023 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qRtZO-00027I-1g
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:06:14 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qRtZL-0002I3-SX
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:06:13 -0400
Received: from blackfin.pond.sub.org (p50902994.dip0.t-ipconnect.de
 [80.144.41.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 4F80C26316;
 Fri,  4 Aug 2023 14:06:04 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10EE521E692A; Fri,  4 Aug 2023 14:06:02 +0200 (CEST)
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
Date: Fri, 04 Aug 2023 14:06:02 +0200
Message-ID: <87h6pf9fmd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Hi, Markus,
>> >
>> > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
>> 
>> [...]
>> 
>> >> For better or worse, we duplicate full documentation between
>> >> MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
>> >> would be the first instance where we reference instead.  I'm not opposed
>> >> to use references, but if we do, I want them used consistently.
>> >
>> > We discussed this over the other "switchover" parameter, but that patchset
>> > just stranded..
>> >
>> > Perhaps I just provide a pre-requisite patch to remove all the comments in
>> > MigrateSetParameters and MigrationParameters, letting them all point to
>> > MigrationParameter?
>> 
>> Simplifies maintaining the doc commments.  But how does it affect the
>> documentation generated from it?  Better, neutral, or worse?
>
> Probably somewhere neutral.  There are definitely benefits, shorter
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

Yes, but we've been doing okay regardless.

The drawback of replacing duplicates by references is that readers need
to follow the references.

Less onerous when the references can be clicked.

If we de-duplicate, which copy do we keep, MigrationParameter,
MigrateSetParameters, or MigrationParameter?  Do we have an idea which
of these users are likely to read first?

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

The automatic generation of "Not documented" documentation is a
stop-gap.  Leaving a member undocumented should be a hard error.  It
isn't only because we have 511 instances to fix.

Perhaps a directive to ignore undocumented members could be useful.
I.e. to suppress the automatic "Not documented" documented now, the
error later.

We could write things out in longhand instead, like

    # @announce-initial: Same as MigrationParameter member
    #     @announce-initial.

> For developers, dedup the comment should always be a win, afaict.

No argument.

