Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF277A8300
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qix1j-0002sm-0x; Wed, 20 Sep 2023 09:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qix1g-0002sQ-1V
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qix1e-0000zc-Bk
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695215633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mK9f8JLFXrIpjBHOOW4RiYLom0MYM9JEyj2FDzM639M=;
 b=WtpOyIByGnOSuUDmXwwXVUKfqbRKPd1LAGSplddhxsqMDy9L8hBEQgbz21F1mJPzMY1ok8
 Xky+Jg6lzEnnxzABBa7MLon3rexqDVooDqb+ZoEQAxF366sZN9o65clrjKaxPJ7lw+u24f
 W08gwT1Lc1Wcs5fJnWgo3xWR+9O2wEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-7XRHlt8zP-mEznN4LRKnLw-1; Wed, 20 Sep 2023 09:13:52 -0400
X-MC-Unique: 7XRHlt8zP-mEznN4LRKnLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D4685A5BD
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 13:13:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6895140273D
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 13:13:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02C0921E6900; Wed, 20 Sep 2023 15:13:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  quintela@redhat.com,  leobras@redhat.com
Subject: Re: [PATCH 20/52] migration/rdma: Drop dead qemu_rdma_data_init()
 code for !@host_port
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-21-armbru@redhat.com> <ZQnGCOlrmFUL7+aB@x1n>
Date: Wed, 20 Sep 2023 15:13:50 +0200
In-Reply-To: <ZQnGCOlrmFUL7+aB@x1n> (Peter Xu's message of "Tue, 19 Sep 2023
 12:02:16 -0400")
Message-ID: <87cyydf0mp.fsf@pond.sub.org>
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 18, 2023 at 04:41:34PM +0200, Markus Armbruster wrote:
>> qemu_rdma_data_init() neglects to set an Error when it fails because
>> @host_port is null.  Fortunately, no caller passes null, so this is
>
> Indeed they all seem to be non-null.
>
> Before this patch, qemu_rdma_data_init() can still tolerant NULL, not
> setting errp but still returning NULL showing an error.

Returning failure without setting an error is wrong :)

> After this patch, qemu_rdma_data_init() should crash at inet_parse() if
> it's null.

Yes.

> Would it be simpler and clearer if we just set ERROR() for !host_port?

I dislike impossible error paths, because they are untestable.

> Thanks,
>
>> merely a latent bug.  Drop the flawed code handling null argument.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>


