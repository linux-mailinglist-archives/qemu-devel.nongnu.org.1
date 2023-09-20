Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F417A82FE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwzs-0000w1-W0; Wed, 20 Sep 2023 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiwzp-0000sT-Rz
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiwzl-0000kU-Tf
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695215516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waoWp/BMmkKagx5MucxvubDSaNkfMRlbYYNueHad5xo=;
 b=cyKpyFx4DqlVs3sGEPBFdj1NTbUxHA2MlkI5BKn5pvagAJubqdObbhJuWLZ9f0CQ66UsKL
 sutTzNx8VSYiDA4SerO6rqdlKJfp56QKwlL5ikfB38iGCOuncVZm0GCE0vGvclaRAXHK61
 DvgMYpgPHboQqeSbn8QD675tmEkwOgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-rVdIXJvFOMycGK80KOJuGA-1; Wed, 20 Sep 2023 09:11:55 -0400
X-MC-Unique: rVdIXJvFOMycGK80KOJuGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC29B811E92;
 Wed, 20 Sep 2023 13:11:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AD91140273C;
 Wed, 20 Sep 2023 13:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6A7421E6900; Wed, 20 Sep 2023 15:11:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com
Subject: Re: [PATCH 12/52] migration/rdma: Drop qemu_rdma_search_ram_block()
 error handling
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-13-armbru@redhat.com> <87a5tjz8o1.fsf@suse.de>
Date: Wed, 20 Sep 2023 15:11:53 +0200
In-Reply-To: <87a5tjz8o1.fsf@suse.de> (Fabiano Rosas's message of "Mon, 18 Sep
 2023 14:35:26 -0300")
Message-ID: <87jzslf0py.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> qemu_rdma_search_ram_block() can't fail.  Return void, and drop the
>> unreachable error handling.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/rdma.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 2b0f9d52d8..98520a42b4 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1234,12 +1234,12 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
>>   *
>>   * This search cannot fail or the migration will fail.
>>   */
>
> This comment can be removed as well.

Will do, thanks!

[...]


