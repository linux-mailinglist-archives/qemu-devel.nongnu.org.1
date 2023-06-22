Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E573A789
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOKc-00047g-Nt; Thu, 22 Jun 2023 13:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qCOKb-00047X-0M
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qCOKZ-0003OH-Di
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687455770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ldsiV1mDTKJ+DZyLuTCQRNH+UkgTYtRm0s6N1O41IM=;
 b=GqDOZMEErDkzIA/B2bnmwJl1i8oEGZLa7IxqDboDvMhYb3bpo+UUN4h2Wtcbx1W/H6FF3z
 RQBSUedgAK23IEfUPmLIcPEpqdZDobEE90FJ80ediQDT9aOVHHEr8nxDphdx9c2nkDs2rI
 e5CfbId3pC1M4bIoELvyzX5Ev1h9LUY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-2tGWBZjnOvuy-2t2NrDJfg-1; Thu, 22 Jun 2023 13:42:47 -0400
X-MC-Unique: 2tGWBZjnOvuy-2t2NrDJfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DA5338008C2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 17:42:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E3EB492C13
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 17:42:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 107C621E677D; Thu, 22 Jun 2023 19:42:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] migration.json: Don't use space before colon
References: <20230612191604.2219-1-quintela@redhat.com>
 <87352jbpo5.fsf@pond.sub.org> <87edm3fn1j.fsf@secure.mitica>
Date: Thu, 22 Jun 2023 19:42:44 +0200
In-Reply-To: <87edm3fn1j.fsf@secure.mitica> (Juan Quintela's message of "Thu, 
 22 Jun 2023 19:02:16 +0200")
Message-ID: <87bkh78kbv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> So all the file is consistent.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> Queued.  thanks!
>
> My deprecated series depend on this, so I will got it through the
> migration tree if you don't care.

Go right ahead.


