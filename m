Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C457B8574
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4sm-00009X-S0; Wed, 04 Oct 2023 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo4si-00008J-Mx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo4sc-0002iY-K9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fz1dga711r5xm336buv7guDNPzZ6c5/xwh/u37H8trI=;
 b=KEdniRtzJyXkP8FennfNvaCKqpZC4HzK5Gem4WPzmkPVMM/dj7qjw6i7/JwnIuxdCA0lNK
 OdCYjRClCEKpdShxSAkvDbtHXUYhGZTos0Ok4NljhKCh88g/7vTmZmbsGGtr3QUcvg2O3L
 SeweTBeOw2UwWuZd+P7WQ/leeOm1eEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-ZaOdZC2BNhO-6RbfttvcTQ-1; Wed, 04 Oct 2023 12:37:43 -0400
X-MC-Unique: ZaOdZC2BNhO-6RbfttvcTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AFC21875053;
 Wed,  4 Oct 2023 16:37:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6274A140E950;
 Wed,  4 Oct 2023 16:37:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D81D21E6904; Wed,  4 Oct 2023 18:37:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 23/53] migration/rdma: Fix QEMUFileHooks method
 return values
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-24-armbru@redhat.com>
 <87a5sywe6p.fsf@secure.mitica>
Date: Wed, 04 Oct 2023 18:37:42 +0200
In-Reply-To: <87a5sywe6p.fsf@secure.mitica> (Juan Quintela's message of "Wed, 
 04 Oct 2023 18:22:06 +0200")
Message-ID: <87jzs2bay1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> The QEMUFileHooks methods don't come with a written contract.  Digging
>> through the code calling them, we find:
>>
>> * save_page():
>>
>>   Negative values RAM_SAVE_CONTROL_DELAYED and
>>   RAM_SAVE_CONTROL_NOT_SUPP are special.  Any other negative value is
>>   an unspecified error.
>>
>>   qemu_rdma_save_page() returns -EIO or rdma->error_state on error.  I
>>   believe the latter is always negative.  Nothing stops either of them
>>   to clash with the special values, though.  Feels unlikely, but fix
>>   it anyway to return only the special values and -1.
>>
>> * before_ram_iterate(), after_ram_iterate():
>>
>>   Negative value means error.  qemu_rdma_registration_start() and
>>   qemu_rdma_registration_stop() comply as far as I can tell.  Make
>>   them comply *obviously*, by returning -1 on error.
>>
>> * hook_ram_load:
>>
>>   Negative value means error.  rdma_load_hook() already returns -1 on
>>   error.  Leave it alone.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Changed idea.  Will include this and rebase mines on top.

Thanks!


