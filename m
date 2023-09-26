Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E177AE629
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1lY-0004y0-E3; Tue, 26 Sep 2023 02:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1lW-0004xs-MN
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1lT-0000YJ-QZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695710507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvLeeabu8ZY6tpLT/FjqYOnLrwihI8bWLOPHDn18+r0=;
 b=hImLk9C8spc7ttNz83Wq8DMcp69YdgzIiQldrFX2rSEnUK4n7at7VtJbeSVlhhkvksAoZl
 5WBWOuKH4TLOvdFlo0uN0zsxDXr+/5ITdAHdnfER6z6w9328PGit3lEyZcLlWfbJtxfRI+
 FeN+J321+X2BOvlVagPH3t0cvy/Vt8I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-_jJFrdc5NPKrHS5kiNEXwg-1; Tue, 26 Sep 2023 02:41:45 -0400
X-MC-Unique: _jJFrdc5NPKrHS5kiNEXwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 393823800EA3;
 Tue, 26 Sep 2023 06:41:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DDDC154CB;
 Tue, 26 Sep 2023 06:41:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 193DE21E6900; Tue, 26 Sep 2023 08:41:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 43/52] migration/rdma: Convert qemu_rdma_alloc_pd_cq()
 to Error
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-44-armbru@redhat.com>
 <209dd727-9e55-42d0-aac7-98509a4789b0@fujitsu.com>
Date: Tue, 26 Sep 2023 08:41:44 +0200
In-Reply-To: <209dd727-9e55-42d0-aac7-98509a4789b0@fujitsu.com> (Zhijian Li's
 message of "Tue, 26 Sep 2023 05:43:39 +0000")
Message-ID: <87h6nhjv13.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
>> Functions that use an Error **errp parameter to return errors should
>> not also report them to the user, because reporting is the caller's
>> job.  When the caller does, the error is reported twice.  When it
>> doesn't (because it recovered from the error), there is no error to
>> report, i.e. the report is bogus.
>> 
>> qemu_rdma_source_init() violates this principle: it calls
>> error_report() via qemu_rdma_alloc_pd_cq().  I elected not to
>> investigate how callers handle the error, i.e. precise impact is not
>> known.
>> 
>> Clean this up by converting qemu_rdma_alloc_pd_cq() to Error.
>> 
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>> ---
>>   migration/rdma.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>
> [...]
>
>
>> @@ -2451,6 +2451,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>>   
>>   static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       int ret, idx;
>>   
>>       /*
>> @@ -2464,12 +2465,12 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
>>           goto err_rdma_source_init;
>>       }
>>   
>> -    ret = qemu_rdma_alloc_pd_cq(rdma);
>> +    ret = qemu_rdma_alloc_pd_cq(rdma, errp);
>>       if (ret < 0) {
>> -        error_setg(errp, "RDMA ERROR: "
>> -                   "rdma migration: error allocating pd and cq! Your mlock()"
>> -                   " limits may be too low. Please check $ ulimit -a # and "
>> -                   "search for 'ulimit -l' in the output");
>> +        error_append_hint(errp,
>> +                          "Your mlock() limits may be too low. "
>> +                          "Please check $ ulimit -a # and "
>> +                          "search for 'ulimit -l' in the output\n");
>
>
> I think we could freely remove this error message as well, it may neither a exact resolution
> nor some one will take care. Just report the error qemu_rdma_alloc_pd_cq() tell us.

Double-checking: you recommend to drop error_append_hint()?

> Anyway
>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>
>
>>           goto err_rdma_source_init;
>>       }

Thanks!


