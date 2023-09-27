Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95C7B0C5B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 21:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlZq5-0007SK-G9; Wed, 27 Sep 2023 15:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZpw-0007IU-Tw
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlZpt-0004N9-GT
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695841474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkmXF2CF2As+pYXPd1c1cQ9iXrj2gpaPDRyLKi+9LYQ=;
 b=Ue8HkKfXwgUYslKTEWiA01YlEI7M3ZexSQ1siVdQMIkJNcytwKLoyT6cqjhtPS2WL65B6h
 qsR1sktO0xHNDKypqC/6YRFn511D1+V1Ui0C6JL5GPV/UZM4ZwDaKDdamsi6Q64X7lrt1/
 Moy3owRraHXyqBXGhdzBfyk5j1C5Jr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-S6b7jmMZOK26djfi8JSUPg-1; Wed, 27 Sep 2023 15:04:32 -0400
X-MC-Unique: S6b7jmMZOK26djfi8JSUPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD79811E8D
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:04:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D04176C7
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 19:04:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D734921E6905; Wed, 27 Sep 2023 21:04:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com
Subject: Re: [PATCH 26/52] migration/rdma: Replace int error_state by bool
 errored
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-27-armbru@redhat.com>
 <lxid3tkawqyvy3upspi66zdnok3aqwhwi4ul4bzzo57wesqmst@fu3bofqg3r62>
Date: Wed, 27 Sep 2023 21:04:30 +0200
In-Reply-To: <lxid3tkawqyvy3upspi66zdnok3aqwhwi4ul4bzzo57wesqmst@fu3bofqg3r62>
 (Eric Blake's message of "Wed, 27 Sep 2023 12:38:39 -0500")
Message-ID: <87bkdna14x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Eric Blake <eblake@redhat.com> writes:

> On Mon, Sep 18, 2023 at 04:41:40PM +0200, Markus Armbruster wrote:
>> All we do with the value of RDMAContext member @error_state is test
>> whether it's zero.  Change to bool and rename to @errored.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/rdma.c | 66 ++++++++++++++++++++++++------------------------
>>  1 file changed, 33 insertions(+), 33 deletions(-)
>> 
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index ad314cc10a..85f6b274bf 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -352,7 +352,7 @@ typedef struct RDMAContext {
>>       * memory registration, then do not attempt any future work
>>       * and remember the error state.
>>       */
>> -    int error_state;
>> +    int errored;
>
> Commit message says 'change to bool', but this is still int.

Accident, will fix, thanks!


