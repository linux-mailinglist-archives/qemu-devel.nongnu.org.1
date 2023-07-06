Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C29749F27
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQ6Y-0002I4-Kd; Thu, 06 Jul 2023 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHQ6W-0002HE-Ai
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHQ6U-0001VC-Ik
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688654225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JulRSscV85NHMP3waIMTzCBOTHDxHIFUbW3bERmstcQ=;
 b=hprZ50VvlCABQ48hlXcUgicBrtJCCAx1YsH/z3UP9BZvMK5wpB94Ebx+E/ugTG53cPslK6
 ul5aLdIbE0HVjT4lVMNMtDYxzyABjZh3fjJSWIbTijR81+cBGTRhUhMr7uyu60HZNHOMUb
 JBWP3ItZpmOqy5CGV4L8l6YZK209hrw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-GxhqQ43aNDCmrJZ0W57GVA-1; Thu, 06 Jul 2023 10:36:58 -0400
X-MC-Unique: GxhqQ43aNDCmrJZ0W57GVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28D2688D7F7;
 Thu,  6 Jul 2023 14:36:45 +0000 (UTC)
Received: from [10.39.194.17] (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 285BB40C2063;
 Thu,  6 Jul 2023 14:36:44 +0000 (UTC)
Message-ID: <8f579ca4-b51c-db7c-b76e-0de2d083af68@redhat.com>
Date: Thu, 6 Jul 2023 16:36:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] migration: factor out "resume_requested" in
 qmp_migrate()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-2-lersek@redhat.com>
 <33088999-cc41-7dd6-b522-84af01913172@tls.msk.ru>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <33088999-cc41-7dd6-b522-84af01913172@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/6/23 15:28, Michael Tokarev wrote:
> 06.07.2023 13:29, Laszlo Ersek пишет:
>> It cuts back on those awkward, duplicated !(has_resume && resume)
>> expressions.
>>
>> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
>> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
>> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
>> Cc: qemu-trivial@nongnu.org
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>   migration/migration.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 096e8191d15c..a60a5acee533 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1637,6 +1637,7 @@ void qmp_migrate(const char *uri, bool has_blk,
>> bool blk,
>>                    bool has_inc, bool inc, bool has_detach, bool detach,
>>                    bool has_resume, bool resume, Error **errp)
>>   {
>> +    bool resume_requested;
>>       Error *local_err = NULL;
>>       MigrationState *s = migrate_get_current();
>>       const char *p = NULL;
>> @@ -1646,13 +1647,14 @@ void qmp_migrate(const char *uri, bool
>> has_blk, bool blk,
>>           return;
>>       }
>>   +    resume_requested = has_resume && resume;
> 
> Dunno if it's worth it or cleaner, but it can be reduced to
> 
>       if (!has_resume)  resume = false;
> 
> and checking for only resume below this point.
> In other words, there's no need for an additional local var.

I vehemently disagree with overwriting (input) parameters. One situation
where that practice is a disaster is single-stepping through the
function in an interactive debugger. You won't see the actual argument
the function was originally called with.

I know it's sometimes comfortable to just reuse a "count" input
paramater as a loop index that runs to zero -- I resist that too, it's a
trap (for the same reason), IMO.

> 
> All other params (has_inc & inc, has_detach_detach etc) are like this
> too.
> 
> Anyway,
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks!
Laszlo


