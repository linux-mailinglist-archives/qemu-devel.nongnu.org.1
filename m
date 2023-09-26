Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF97AE625
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1kU-0004Eg-Od; Tue, 26 Sep 2023 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1kS-0004EV-SD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1kR-0000Lw-GG
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695710441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByJRsBn8XbGG0cGf4u9sYL3TLsmAPtjBg6w3AFpStA=;
 b=DRKNz2KSJ7BFIZu/m1blJYaL1ZcNrTVaEwIPA/yEwN1i5WC5nYiB7IUA+MaHJmwYNbkaUJ
 iSwD52opHNbI30MxOhXaPJ+XkXrsh6skubtAqNvynOr6cFFzAScISmv4zVE/4Mo3sj2vAw
 LlxfhCM7telwpp485/2nY0xtJtII7e4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-1Nji_cTrPtuc97ktqYXVAQ-1; Tue, 26 Sep 2023 02:40:39 -0400
X-MC-Unique: 1Nji_cTrPtuc97ktqYXVAQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59A4A8039C1;
 Tue, 26 Sep 2023 06:40:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36BF2492C37;
 Tue, 26 Sep 2023 06:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EAA021E6900; Tue, 26 Sep 2023 08:40:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
Date: Tue, 26 Sep 2023 08:40:38 +0200
In-Reply-To: <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com> (Zhijian Li's
 message of "Tue, 26 Sep 2023 05:50:28 +0000")
Message-ID: <87lectjv2x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> Functions that use an Error **errp parameter to return errors should
>> not also report them to the user, because reporting is the caller's
>> job.  When the caller does, the error is reported twice.  When it
>> doesn't (because it recovered from the error), there is no error to
>> report, i.e. the report is bogus.
>> 
>> qemu_rdma_write_flush() violates this principle: it calls
>> error_report() via qemu_rdma_write_one().  I elected not to
>> investigate how callers handle the error, i.e. precise impact is not
>> known.
>> 
>> Clean this up by converting qemu_rdma_write_one() to Error.
>> 
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>> ---
>>   migration/rdma.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>> 
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index c3c33fe242..9b8cbadfcd 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2019,9 +2019,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
>>    */
>>   static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
>>                                  int current_index, uint64_t current_addr,
>> -                               uint64_t length)
>> +                               uint64_t length, Error **errp)
>>   {
>> -    Error *err = NULL;
>>       struct ibv_sge sge;
>>       struct ibv_send_wr send_wr = { 0 };
>>       struct ibv_send_wr *bad_wr;
>
> [...]
>
>>           }
>> @@ -2219,7 +2216,7 @@ retry:
>>           goto retry;
>>   
>>       } else if (ret > 0) {
>> -        perror("rdma migration: post rdma write failed");
>> +        error_setg(errp, "rdma migration: post rdma write failed");
>
> It reminds that do you miss to use error_setg_errno() instead.

Indeed!

I'll adjust the commit message as well.

>>           return -1;
>>       }


