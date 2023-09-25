Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD87AD0CD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:56:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkfV8-0008CU-LC; Mon, 25 Sep 2023 02:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfV7-0008C7-83
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfV5-0003xz-PJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695624923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0lpXRHEuqkAujVgnyi+CfV+7VUrZLjfn/pf5h+43Aaw=;
 b=Ixm494/EUkLo7tLGcgRs+F5b918Nzjo0NFirzDvQTHvJYoUtckdojRfixxQkSKQaSRyIEh
 t0WfrU2vGyBBXBFO+7lXuFb2UqQfiUsByx9UPZt2cAAccozOUHVvbRFUmL/Cbb8/U8eBWt
 f7zdPEOIQeoxoWXtiGU33JkiG0wl92c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-qu6XAqWdN66be1fcixjC_Q-1; Mon, 25 Sep 2023 02:55:21 -0400
X-MC-Unique: qu6XAqWdN66be1fcixjC_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7224101A529;
 Mon, 25 Sep 2023 06:55:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C44A540C6EA8;
 Mon, 25 Sep 2023 06:55:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA7E921E6900; Mon, 25 Sep 2023 08:55:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 23/52] migration/rdma: Clean up
 qemu_rdma_wait_comp_channel()'s error value
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-24-armbru@redhat.com>
 <ee5864ff-66d2-b22f-4a47-c6c164329ea9@fujitsu.com>
Date: Mon, 25 Sep 2023 08:55:19 +0200
In-Reply-To: <ee5864ff-66d2-b22f-4a47-c6c164329ea9@fujitsu.com> (Zhijian Li's
 message of "Mon, 25 Sep 2023 05:43:19 +0000")
Message-ID: <87il7yeo88.fsf@pond.sub.org>
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 18/09/2023 22:41, Markus Armbruster wrote:
>> qemu_rdma_wait_comp_channel() returns 0 on success, and either -1 or
>> rdma->error_state on failure.  Callers actually expect a negative
>> error value. 
>
> I don't see the only one callers expect a negative error code.
> migration/rdma.c:1654:        ret = qemu_rdma_wait_comp_channel(rdma, ch);
> migration/rdma.c-1655-        if (ret) {
> migration/rdma.c-1656-            goto err_block_for_wrid;

You're right.

I want the change anyway, to let me simplify the code some.  I'll adjust
the commit message.

>   I believe rdma->error_state can't be positive, but let's
>> make things more obvious by simply returning -1 on any failure.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   migration/rdma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 3421ae0796..efbb3c7754 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1588,7 +1588,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
>>       if (rdma->received_error) {
>>           return -EPIPE;
>>       }
>> -    return rdma->error_state;
>> +    return -!!rdma->error_state;
>
> And i rarely see such things, below would be more clear.
>
> return rdma->error_state ? -1 : 0:

Goes away in PATCH 26:

   @@ -1588,7 +1588,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
        if (rdma->received_error) {
            return -1;
        }
   -    return -!!rdma->error_state;
   +    return -rdma->errored;
    }

    static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)

>
>>   }
>>   
>>   static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)


