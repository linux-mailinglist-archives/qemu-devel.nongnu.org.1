Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C467A712569
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VZ7-0002fE-Lp; Fri, 26 May 2023 07:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2VZ3-0002eq-DG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2VZ1-0002ce-UX
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMRzn41hmFsRuRGJF7xaafTgu50VEzev7NjBEnkfFR0=;
 b=FHGPRfWJUncTSMHz5mZzQdDih5es/zh72PbuGyCOI3hfO28hfBhxQD3E8FTbaTJlaFpGNx
 /JS5LecAqcb3KPmzSEesDXtPPFmpOSk+32VmPDcYx2hSdtApisoon2gy5zQF2sBfnYLePj
 EyP2Zh+/RggZXwWwpk0dPkoG8Zu+x9M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-QuD5YCsZNSy8wlIYg9XkPA-1; Fri, 26 May 2023 07:24:51 -0400
X-MC-Unique: QuD5YCsZNSy8wlIYg9XkPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 905601C08DAC;
 Fri, 26 May 2023 11:24:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F925202696C;
 Fri, 26 May 2023 11:24:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FB6B21E692E; Fri, 26 May 2023 13:24:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <quintela@redhat.com>,  <peterx@redhat.com>,
 <leobras@redhat.com>,  <eblake@redhat.com>
Subject: Re: [PATCH] qapi: better docs for calc-dirty-rate and friends
References: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
 <87sfbkpnho.fsf@pond.sub.org>
 <ZHB7CrcBsRDbHXdM@DESKTOP-0LHM7NF.china.huawei.com>
Date: Fri, 26 May 2023 13:24:50 +0200
In-Reply-To: <ZHB7CrcBsRDbHXdM@DESKTOP-0LHM7NF.china.huawei.com> (gudkov
 andrei's message of "Fri, 26 May 2023 12:25:30 +0300")
Message-ID: <87ttvzbail.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

<gudkov.andrei@huawei.com> writes:

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

>> > -# @sample-pages: page count per GB for sample dirty pages the default
>> > -#     value is 512 (since 6.1)
>> > +# @sample-pages: number of sampled pages per each GiB of guest
>> 
>> per GiB
>> 
>> > +#     memory.  Value is valid only in page-sampling mode (Since 6.1)
>> 
>> Suggest "Valid only in ..."

Outside this patch's scope, but here goes anway: I think we should have
made this member optional, and present only when it's actually valid.
Too late.

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

I'll change this to "is only an estimate of" if you don't mind.

[...]

>> This is *sooo* much better than before.  Thank you!
>> 
>> An R-by from a migration maintainer would be nice.

Got Peter's Acked-by now; all set.

>> If you agree with my suggestions, I can apply them in my tree, saving
>> you a respin.  Let me know.
>
> Yes, sure. Please include also suggestion about wr-protect from Peter. Thanks.

Done.

>> Acked-by: Markus Armbruster <armbru@redhat.com>

Queued.  Thanks!


