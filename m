Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3EA7D4E11
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEn2-0002Av-QZ; Tue, 24 Oct 2023 06:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvEmq-0002Ai-7H
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvEml-0006We-3d
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698143838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0W9SC7zLulE00xImu3yY1ham0zMrWduM2JwP5hX+uY=;
 b=K7n9+OScPQjg0EasXomBLMYZVnQOFFa2pe6pW5X12yNWSedLUEAG5hUP+BaylFAu8SabSh
 i2ZusQUfqCnMLaEuD6qMR842iSsL1o92u363sJYVrr8CydLB5sTHK7F0iPw2azt7PJYaZj
 L6ufPozzpTbJVyRt6qLnZemh5HQkMp4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Dg9EZsW9MD6eC0aLRoX7Bg-1; Tue,
 24 Oct 2023 06:37:15 -0400
X-MC-Unique: Dg9EZsW9MD6eC0aLRoX7Bg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17A8C2824762;
 Tue, 24 Oct 2023 10:37:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA7AA8C0A;
 Tue, 24 Oct 2023 10:37:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3B4221E6A1F; Tue, 24 Oct 2023 12:37:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v2] block/snapshot: Fix compiler warning with
 -Wshadow=local
References: <20231023175038.111607-1-thuth@redhat.com>
 <87zg08vcwd.fsf@pond.sub.org>
Date: Tue, 24 Oct 2023 12:37:13 +0200
In-Reply-To: <87zg08vcwd.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 24 Oct 2023 06:54:10 +0200")
Message-ID: <875y2ws3vq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

Markus Armbruster <armbru@redhat.com> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> No need to declare a new variable in the the inner code block
>> here, we can re-use the "ret" variable that has been declared
>> at the beginning of the function. With this change, the code
>> can now be successfully compiled with -Wshadow=local again.
>>
>> Fixes: a32e781838 ("Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Assign "ret" only in one spot
>>
>>  block/snapshot.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index 6e16eb803a..55974273ae 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -629,7 +629,6 @@ int bdrv_all_goto_snapshot(const char *name,
>>      while (iterbdrvs) {
>>          BlockDriverState *bs = iterbdrvs->data;
>>          AioContext *ctx = bdrv_get_aio_context(bs);
>> -        int ret = 0;
>>          bool all_snapshots_includes_bs;
>>  
>>          aio_context_acquire(ctx);
>> @@ -637,9 +636,8 @@ int bdrv_all_goto_snapshot(const char *name,
>>          all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
>>          bdrv_graph_rdunlock_main_loop();
>>  
>> -        if (devices || all_snapshots_includes_bs) {
>> -            ret = bdrv_snapshot_goto(bs, name, errp);
>> -        }
>> +        ret = (devices || all_snapshots_includes_bs) ?
>> +              bdrv_snapshot_goto(bs, name, errp) : 0;
>>          aio_context_release(ctx);
>>          if (ret < 0) {
>>              bdrv_graph_rdlock_main_loop();
>
> Better.  Unconditional assignment to @ret right before it's checked is
> how we should use @ret.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> And queued.  Thanks!

Mind if I drop the Fixes: tag?  Nothing broken until we enable
-Wshadow=local...


