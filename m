Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0E7A94D2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJkL-0004kj-3Z; Thu, 21 Sep 2023 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJkJ-0004j5-70
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJkH-0006mq-Ip
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtsqDNoLCYRhxLX0y1mI7bF6xiiwSEq/0luqxitKGs8=;
 b=QXZ0hvcoooYFKQE0Wcht1T7Z87U+ZWHuVTqLl6lm4Hq/qfFG5fkffFIvQVVn1b4vxHa9QS
 iwycDj+lX1kDYwUIsEu8bHtqyMyLFU0jpzDjX6+gqd+Iqx6n6UxPui20h2Sq09083cnxdH
 e9HW7SfYPwktBAJJCyDUC3NxxRTCoG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-UAHJ7O3QNAKzdJkhXrq55A-1; Thu, 21 Sep 2023 07:15:04 -0400
X-MC-Unique: UAHJ7O3QNAKzdJkhXrq55A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C8A52932493;
 Thu, 21 Sep 2023 11:15:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B17C2156A27;
 Thu, 21 Sep 2023 11:15:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04D1121E6900; Thu, 21 Sep 2023 13:15:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error handling
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-12-armbru@redhat.com>
 <94601877-3170-8d7d-d161-3b72041d9551@fujitsu.com>
Date: Thu, 21 Sep 2023 13:15:03 +0200
In-Reply-To: <94601877-3170-8d7d-d161-3b72041d9551@fujitsu.com> (Zhijian Li's
 message of "Thu, 21 Sep 2023 09:39:51 +0000")
Message-ID: <874jjn7p6w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> rdma_add_block() can't fail.  Return void, and drop the unreachable
>> error handling.
>> 
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>> ---
>>   migration/rdma.c | 30 +++++++++---------------------
>>   1 file changed, 9 insertions(+), 21 deletions(-)
>> 
>
> [...]
>
>>    * during dynamic page registration.
>>    */
>> -static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
>> +static void qemu_rdma_init_ram_blocks(RDMAContext *rdma)
>>   {
>>       RDMALocalBlocks *local = &rdma->local_ram_blocks;
>>       int ret;
>> @@ -646,14 +645,11 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
>>       assert(rdma->blockmap == NULL);
>>       memset(local, 0, sizeof *local);
>>       ret = foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>> -    if (ret) {
>> -        return ret;
>> -    }
>> +    assert(!ret);
>
> Why we still need a new assert(), can we remove the ret together.
>
>      foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>      trace_qemu_rdma_init_ram_blocks(local->nb_blocks);

The "the callback doesn't fail" is a non-local argument.  The assertion
checks it.  I'd be fine with dropping it, since the argument is
straightforward enough.  Thoughts?


