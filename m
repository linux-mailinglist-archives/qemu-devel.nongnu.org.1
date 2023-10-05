Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74227B9ADD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGZr-0001pz-5S; Thu, 05 Oct 2023 01:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoGZp-0001pq-5m
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoGZn-0002gY-LK
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696482426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EDcoejOaglWegJvf5u6z5h7y3aDJfcOdLeQ6V0BaSM=;
 b=KMdXhvkQxzvMZZGzMUsfl3p/Sj5wNH0FyYg9Ys9rykc6xm7pgX7dzKamH1TF9uJReN5yRx
 +GfwTRZ/hwvxnOuNJM11Um6k8SOBK1y/yH6FQzgZLMiWLnY7/q1meDZk+RRqAIoyknKcLa
 z65DvmExgUhJLrPDixDRF53hZNpsgUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-svEcgklQPQyDx0zHRCBwEQ-1; Thu, 05 Oct 2023 01:07:02 -0400
X-MC-Unique: svEcgklQPQyDx0zHRCBwEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5D088039C8;
 Thu,  5 Oct 2023 05:07:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83EC040C2015;
 Thu,  5 Oct 2023 05:07:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F62E21E6904; Thu,  5 Oct 2023 07:07:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 00/53] migration/rdma: Error handling fixes
References: <20230928132019.2544702-1-armbru@redhat.com>
 <87fs2qs2b3.fsf@secure.mitica>
Date: Thu, 05 Oct 2023 07:07:00 +0200
In-Reply-To: <87fs2qs2b3.fsf@secure.mitica> (Juan Quintela's message of "Wed, 
 04 Oct 2023 19:52:16 +0200")
Message-ID: <87r0m9ac97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Oh dear, where to start.  There's so much wrong, and in pretty obvious
>> ways.  This code should never have passed review.  I'm refraining from
>> saying more; see the commit messages instead.
>>
>> Issues remaining after this series include:
>>
>> * Terrible error messages
>>
>> * Some error message cascades remain
>>
>> * There is no written contract for QEMUFileHooks, and the
>>   responsibility for reporting errors is unclear
>>
>> * There seem to be no tests whatsoever
>>
>> PATCH 29 is arguably a matter of taste.  I made my case for it during
>> review of v1.  If maintainers don't want it, I'll drop it.
>>
>> Related: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
>> polling error
>
> Hi Markus
>
> I integrated everything except:
>
>>   migration/rdma: Fix or document problematic uses of errno
>
> Most of them are dropped on following patches.

The hunks that are dropped in later patches are:

* Four FIXME comments about incorrect or problematic use of perror().

  If you drop the patch, you have to adjust the later patches that
  remove these hunks.  Resolving the conflicts is *not* enough; you also
  have to correct the commit messages.

The hunks that are not dropped are:

* Three comments about bugs (either library doc bug or incorrect use of
  @errno here).  I'd hate to lose them.

* One bug fix, in qemu_rdma_advise_prefetch_mr().  Losing this one would
  be foolish.

Please consider keeping the patch.

>>   migration/rdma: Use error_report() & friends instead of stderr
>
> You said you have to resend this one.

Can do, but since the change is trivial, perhaps you could make it in
your tree without a resend.  Change the line

                warn_report("WARN: migrations may fail:"

to

                warn_report("migrations may fail:"

> There were some conflicts, I was careful, but one never knows.  So you
> are wellcome to take a look when the PULL cames to the tree.
>
> Thanks, Juan.


