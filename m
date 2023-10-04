Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712A7B7DFE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzrH-000083-0T; Wed, 04 Oct 2023 07:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzrE-0008UJ-Jj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzrC-0005ul-22
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696418155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ACnT4oFRRvCsrHxqy/mzsSYjOmhLN5KdLqEMl5P+nmk=;
 b=CEQ32HU5DKQJc6v0Kf/rrCvYytOig6AS/ypep7Bx7yh9cmxfkC3slxLDU+mwMveJDVAj8x
 BnqW2VFqIi144XKCRxbYnFOaPTQmTLRXmatGtlHAcza+KLBYIFBtMCI1hiJMyNTqTgnSFk
 MA0xdvZmZ0zXFHBoudOEWA2vyyspdIM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333--c7nJgCDN8-esz2T1kGX4g-1; Wed, 04 Oct 2023 07:15:52 -0400
X-MC-Unique: -c7nJgCDN8-esz2T1kGX4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A130F1C04B58;
 Wed,  4 Oct 2023 11:15:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ED4F111CD23;
 Wed,  4 Oct 2023 11:15:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B89221E6904; Wed,  4 Oct 2023 13:15:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 quintela@redhat.com,  peterx@redhat.com,  leobras@redhat.com,
 lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 52/53] migration/rdma: Use error_report() & friends
 instead of stderr
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-53-armbru@redhat.com> <87msx5yosr.fsf@suse.de>
Date: Wed, 04 Oct 2023 13:15:50 +0200
In-Reply-To: <87msx5yosr.fsf@suse.de> (Fabiano Rosas's message of "Fri, 29 Sep
 2023 12:36:20 -0300")
Message-ID: <87y1gihc49.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> error_report() obeys -msg, reports the current error location if any,
>> and reports to the current monitor if any.  Reporting to stderr
>> directly with fprintf() or perror() is wrong, because it loses all
>> this.
>>
>> Fix the offenders.  Bonus: resolves a FIXME about problematic use of
>> errno.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/rdma.c | 44 +++++++++++++++++++++-----------------------
>>  1 file changed, 21 insertions(+), 23 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 54b59d12b1..dba0802fca 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -877,12 +877,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>>  
>>          if (roce_found) {
>>              if (ib_found) {
>> -                fprintf(stderr, "WARN: migrations may fail:"
>> -                                " IPv6 over RoCE / iWARP in linux"
>> -                                " is broken. But since you appear to have a"
>> -                                " mixed RoCE / IB environment, be sure to only"
>> -                                " migrate over the IB fabric until the kernel "
>> -                                " fixes the bug.\n");
>> +                warn_report("WARN: migrations may fail:"
>> +                            " IPv6 over RoCE / iWARP in linux"
>> +                            " is broken. But since you appear to have a"
>> +                            " mixed RoCE / IB environment, be sure to only"
>> +                            " migrate over the IB fabric until the kernel "
>> +                            " fixes the bug.");
>
> Won't this become "warning: WARN:"?

It will.  I'll drop the "WARN: " prefix.

>>              } else {
>>                  error_setg(errp, "RDMA ERROR: "
>>                             "You only have RoCE / iWARP devices in your systems"
>> @@ -1418,12 +1418,8 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
>>          block->remote_keys[chunk] = 0;
>>  
>>          if (ret != 0) {
>> -            /*
>> -             * FIXME perror() is problematic, bcause ibv_dereg_mr() is
>> -             * not documented to set errno.  Will go away later in
>> -             * this series.
>> -             */
>> -            perror("unregistration chunk failed");
>> +            error_report("unregistration chunk failed: %s",
>> +                         strerror(ret));
>
> Doesn't seem to fix the issue, ret might still not be an errno. Am I
> missing something?

Yes :)

ibv_dereg_mr(3) section RETURN VALUE has:

       ibv_dereg_mr()  returns  0 on success, or the value of errno on failure
       (which indicates the failure reason).

Clearer now?

>>              return -1;
>>          }


