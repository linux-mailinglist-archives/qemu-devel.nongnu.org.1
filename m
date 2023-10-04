Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243507B7DE1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnznX-0000qV-CA; Wed, 04 Oct 2023 07:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnznT-0000pi-Os
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnznR-0004uj-U5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696417925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3naIuioo+PaO17QwTvZI64uG0HSvqOxEkNNyw/Nqxw4=;
 b=NmdGL2ySxTvsNW+4VwtBs+Bkpo7pJs+NW3Lvltw37Tc3uq4jw4QwfSVh768yT0b2iaguow
 hCbpGFCWcXSv6vJmvRCbYcZ+R9KphvmfR1gRC9y1oDjWrpWbc3+sJJpoTaeZ2fjbJ4+J7k
 vsnMvaMa03GXpLa3E8x4T4mtvwLNj+A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-GhJmxOKBMuecG9sqbDejUw-1; Wed, 04 Oct 2023 07:12:01 -0400
X-MC-Unique: GhJmxOKBMuecG9sqbDejUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 740131C05AA9;
 Wed,  4 Oct 2023 11:12:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47B7F40C6EA8;
 Wed,  4 Oct 2023 11:12:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37C2721E6904; Wed,  4 Oct 2023 13:12:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 16/53] migration/rdma: Fix or document problematic
 uses of errno
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-17-armbru@redhat.com> <87y1gpyq24.fsf@suse.de>
Date: Wed, 04 Oct 2023 13:12:00 +0200
In-Reply-To: <87y1gpyq24.fsf@suse.de> (Fabiano Rosas's message of "Fri, 29 Sep
 2023 12:09:07 -0300")
Message-ID: <875y3miqv3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
>> We use errno after calling Libibverbs functions that are not
>> documented to set errno (manual page does not mention errno), or where
>> the documentation is unclear ("returns [...] the value of errno on
>> failure").  While this could be read as "sets errno and returns it",
>> a glance at the source code[*] kills that hope:
>>
>>     static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
>>                                     struct ibv_send_wr **bad_wr)
>>     {
>>             return qp->context->ops.post_send(qp, wr, bad_wr);
>>     }
>>
>> The callback can be
>>
>>     static int mana_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr,
>>                               struct ibv_send_wr **bad)
>>     {
>>             /* This version of driver supports RAW QP only.
>>              * Posting WR is done directly in the application.
>>              */
>>             return EOPNOTSUPP;
>>     }
>>
>> Neither of them touches errno.
>>
>> One of these errno uses is easy to fix, so do that now.  Several more
>> will go away later in the series; add temporary FIXME commments.
>> Three will remain; add TODO comments.  TODO, not FIXME, because the
>> bug might be in Libibverbs documentation.
>>
>> [*] https://github.com/linux-rdma/rdma-core.git
>>     commit 55fa316b4b18f258d8ac1ceb4aa5a7a35b094dcf
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/rdma.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 28097ce604..bba8c99fa9 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -853,6 +853,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>>  
>>          for (x = 0; x < num_devices; x++) {
>>              verbs = ibv_open_device(dev_list[x]);
>> +            /*
>> +             * ibv_open_device() is not documented to set errno.  If
>> +             * it does, it's somebody else's doc bug.  If it doesn't,
>> +             * the use of errno below is wrong.
>> +             * TODO Find out whether ibv_open_device() sets errno.
>> +             */
>>              if (!verbs) {
>>                  if (errno == EPERM) {
>>                      continue;
>
> This function can call into glibc, so it's not unreasonable to expect
> errno to be set at some point. We're not relying on errno to be set,
> just taking an action if it happens to be.

errno may well be set on some failures.  But it needs to be set on *all*
failures to be reliable.  If it's not, then its value on such failures
comes from some unrelated, prior errno-setting failure.

> I don't think someone would just decide to handle EPERM at this point
> for no reason. Specially since the manual makes no mention to
> errno. This was probably introduced after someone got bit by it.
>
> ... indeed the commit 5b61d57521 ("rdma: Fix qemu crash when IPv6
> address is used for migration") introduced this to fix a crash.

I don't doubt the error recovery added there works in the case described
by the commit message.  I suspect it can break on unrelated failures.


