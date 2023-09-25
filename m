Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 688DB7AD049
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkfCf-0005DG-FP; Mon, 25 Sep 2023 02:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfCd-0005BE-EC
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkfCb-00085P-Sx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695623776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+0UlrylBrBbU9DW2IHVf9s2aNE0PBOFK8jkv7JnN7w=;
 b=NT+GoldH42+TxmSY6m4jMiW6xpmtzzcwDeUhz83aBozrW4gTXB4P8JRVF0ztFmEfLv81OO
 MhB61JxlW8BXsWq0X+21qoYfSP13mzNfQtY7Cpv5qBvjnDEhTiQQb8YSsMqWqsUYXy0NML
 vygqEEfAPlcOCsGCqi8RpYCRIv4bbJ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Kat19XFVPxCvUyd1CFRCKQ-1; Mon, 25 Sep 2023 02:36:14 -0400
X-MC-Unique: Kat19XFVPxCvUyd1CFRCKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BBB529AB3E8;
 Mon, 25 Sep 2023 06:36:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5BF3140E953;
 Mon, 25 Sep 2023 06:36:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D97AC21E6900; Mon, 25 Sep 2023 08:36:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "quintela@redhat.com" <quintela@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,  "leobras@redhat.com"
 <leobras@redhat.com>
Subject: Re: [PATCH 21/52] migration/rdma: Fix QEMUFileHooks method return
 values
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-22-armbru@redhat.com>
 <742d57f9-7660-b40c-10fd-c81365b161b8@fujitsu.com>
Date: Mon, 25 Sep 2023 08:36:12 +0200
In-Reply-To: <742d57f9-7660-b40c-10fd-c81365b161b8@fujitsu.com> (Zhijian Li's
 message of "Mon, 25 Sep 2023 04:08:37 +0000")
Message-ID: <87edimg3oj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> The QEMUFileHooks methods don't come with a written contract.  Digging
>> through the code calling them, we find:
>> 
>> * save_page():
>
> I'm fine with this
>
>> 
>>    Negative values RAM_SAVE_CONTROL_DELAYED and
>>    RAM_SAVE_CONTROL_NOT_SUPP are special.  Any other negative value is
>>    an unspecified error.
>> 
>>    qemu_rdma_save_page() returns -EIO or rdma->error_state on error.  I
>>    believe the latter is always negative.  Nothing stops either of them
>>    to clash with the special values, though.  Feels unlikely, but fix
>>    it anyway to return only the special values and -1.
>> 
>> * before_ram_iterate(), before_ram_iterate():
>
> error code returned by before_ram_iterate() and before_ram_iterate() will be
> assigned to QEMUFile for upper layer.
> But it seems that no callers take care about the error ?  Shouldn't let the callers
> to check the error instead ?

The error values returned by qemu_rdma_registration_start() and
qemu_rdma_registration_stop() carry no additional information a caller
could check.

Both return either -EIO or rdma->error_state on error.  The latter is
*not* a negative errno code.  Evidence: qio_channel_rdma_shutdown()
assigns -1, qemu_rdma_block_for_wrid() assigns the error value of
qemu_rdma_poll(), which can be the error value of ibv_poll_cq(), which
is an unspecified negative value, ...

I decided not to investigate what qemu-file.c does with the error values
after one quick glance at the code.  It's confusing, and quite possibly
confused.  But I'm already at 50+ patches, and am neither inclined nor
able to take on more migration cleanup at this time.

>>    Negative value means error.  qemu_rdma_registration_start() and
>>    qemu_rdma_registration_stop() comply as far as I can tell.  Make
>>    them comply *obviously*, by returning -1 on error.
>> 
>> * hook_ram_load:
>> 
>>    Negative value means error.  rdma_load_hook() already returns -1 on
>>    error.  Leave it alone.
>
> see inline reply below,
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   migration/rdma.c | 79 +++++++++++++++++++++++-------------------------
>>   1 file changed, 37 insertions(+), 42 deletions(-)
>> 
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index cc59155a50..46b5859268 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -3219,12 +3219,11 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
>>       rdma = qatomic_rcu_read(&rioc->rdmaout);
>>   
>>       if (!rdma) {
>> -        return -EIO;
>> +        return -1;
>>       }
>>   
>> -    ret = check_error_state(rdma);
>> -    if (ret) {
>> -        return ret;
>> +    if (check_error_state(rdma)) {
>> +        return -1;
>>       }
>>   
>>       qemu_fflush(f);
>> @@ -3290,9 +3289,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
>>       }
>>   
>>       return RAM_SAVE_CONTROL_DELAYED;
>> +
>>   err:
>>       rdma->error_state = ret;
>> -    return ret;
>> +    return -1;
>>   }
>>   
>>   static void rdma_accept_incoming_migration(void *opaque);
>> @@ -3538,12 +3538,11 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
>>       rdma = qatomic_rcu_read(&rioc->rdmain);
>>   
>>       if (!rdma) {
>> -        return -EIO;
>> +        return -1;
>
> that's because EIO is not accurate here ?

It's because the function does not return a negative errno code, and
returning -EIO is misleading readers into assuming it does.

>>       }
>>   
>> -    ret = check_error_state(rdma);
>> -    if (ret) {
>> -        return ret;
>
> Ditto

Likewise.

[...]


