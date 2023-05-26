Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01A712565
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VXR-0001s6-Tj; Fri, 26 May 2023 07:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2VXQ-0001rk-4I
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2VXO-0002Oa-7K
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMYPsJSqZ8C12vyMyc+PIwYySMzEMjij51o8V8vZTEc=;
 b=eOl9RTh/Mn1MowO6Uz3h6EOmuX7CmqPKNZgyBpVcOZArVlL9qqr1Q8QWGpmxtU+r2dyZpF
 ikJcAJ/NuzWBkIITl+x4WZbKOIxN6I/x4oei00MP+uKZrRDMXkIXa9ZaggF2Qmeob3AQ05
 /7k4emg7Gi5/dc/hJy4aMaM6FX+arsk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-bKWEKg2lPaC2pnp7V51byQ-1; Fri, 26 May 2023 07:23:09 -0400
X-MC-Unique: bKWEKg2lPaC2pnp7V51byQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BFEC2999B33;
 Fri, 26 May 2023 11:23:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AB33400E118;
 Fri, 26 May 2023 11:23:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDF6421E692E; Fri, 26 May 2023 13:23:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,  qemu-devel@nongnu.org,
 quintela@redhat.com,  leobras@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH] qapi: better docs for calc-dirty-rate and friends
References: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
 <87sfbkpnho.fsf@pond.sub.org> <ZG9i20k6x8n+ydTq@x1n>
Date: Fri, 26 May 2023 13:23:07 +0200
In-Reply-To: <ZG9i20k6x8n+ydTq@x1n> (Peter Xu's message of "Thu, 25 May 2023
 09:30:03 -0400")
Message-ID: <87y1lbbalg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 25, 2023 at 03:08:35PM +0200, Markus Armbruster wrote:
>> Andrei Gudkov <gudkov.andrei@huawei.com> writes:
>> 
>> > Rewrote calc-dirty-rate documentation. Briefly described
>> > different modes of dirty page rate measurement. Added some
>> > examples. Fixed obvious grammar errors.
>> >
>> > Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
>> > ---
>> >  qapi/migration.json | 107 +++++++++++++++++++++++++++++++-------------
>> >  1 file changed, 77 insertions(+), 30 deletions(-)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 179af0c4d8..19b51444b5 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json

[...]

>> > +# Dirty page rate is the number of pages changed in a given time
>> > +# period expressed in MiB/s.  The following methods of calculation
>> > +# are available:
>> > +#
>> > +# 1. In page sampling mode, a random subset of pages are selected
>> > +#    and hashed twice: once in the beginning of measurement time
>> 
>> Suggest "once at the beginning"
>> 
>> > +#    period, another one -- in the end.  If two hashes for some page
>> 
>> Suggest ", and once again at the end".
>> 
>> > +#    are different, the page is counted as changed.  Since this
>> > +#    method relies on sampling and hashing, calculated dirty page
>> > +#    rate is only the estimation of its true value.  Setting
>> > +#    @sample-pages to higher value improves estimation quality but
>> 
>> Suggest "Increasing @sample-pages improves estimation quality at the
>> cost ..."
>> 
>> > +#    at the cost of higher computational overhead.
>> > +#
>> > +# 2. Dirty bitmap mode captures writes to memory by temporarily
>> > +#    revoking write access to all pages and counting page faults.
>
> Just to mention that wr-protection is only one way to do this, IIUC that
> depends on both arch (e.g. s390 impl KVM_GET_DIRTY_LOG totally differently
> from x86) and also hardware capabilities (e.g. even on x86, PML enabled
> hosts use dirty bits and PML-full vm exits rather than page faults).

Good point.

> But I think wr-protect may still be a good detailed showcase of it so
> keeping it there looks very nice, perhaps just add "... writes to memory,
> for example, by temporarily revoking ..."?

Going with

      # 2. Dirty bitmap mode captures writes to memory (for example by
      #    temporarily revoking write access to all pages) and counting page
      #    faults.  Information about modified pages is collected into a
      #    bitmap, where each bit corresponds to one guest page.  This mode
      #    requires that KVM accelerator property "dirty-ring-size" is *not*
      #    set.

if you don't mind.

[...]

>> This is *sooo* much better than before.  Thank you!
>
> I also agree. :)
>
>> 
>> An R-by from a migration maintainer would be nice.
>
> Only one migration maintainer now, but we have two reviewers.
>
> Here's one from the reviewers' list:
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

[...]


