Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7037B09E6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 18:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlXHQ-0001v1-RE; Wed, 27 Sep 2023 12:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlXHP-0001uj-3X
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlXHN-0000QA-Qk
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695831648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7ZFQ3rCycdu9JBpy7SgUwoPgIx4ilP7s9CG37EaCTo=;
 b=ahaN3nk2CPC3jAlOP+7J7NuOcGL3qo4cPQ8QrJGS17puF4sYjQv2np/2veIrgnxPbt+m7y
 fn/fmL7KJjiifBaU/PS2s8UCqTp0JDo9NRNPEiGODlalc9aekN8zprlARrVUEpGQ2edqAQ
 FyxWtKVXgJNlVm/Y32KVCMvwE9VkBaw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-7wckZrVcMuGtc-zJZ8uO1Q-1; Wed, 27 Sep 2023 12:20:47 -0400
X-MC-Unique: 7wckZrVcMuGtc-zJZ8uO1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3237A381170E
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 16:20:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07DEC40C6E7D;
 Wed, 27 Sep 2023 16:20:45 +0000 (UTC)
Date: Wed, 27 Sep 2023 11:20:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com
Subject: Re: [PATCH 10/52] migration/rdma: Eliminate error_propagate()
Message-ID: <ossygji7xnbuwdn5rohjy3jehooi7wqxkgtufc7pchavv42u7q@56czoc62ugyl>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-11-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918144206.560120-11-armbru@redhat.com>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 04:41:24PM +0200, Markus Armbruster wrote:
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  
>      ret = qemu_rdma_alloc_pd_cq(rdma);
>      if (ret) {
> -        ERROR(temp, "rdma migration: error allocating pd and cq! Your mlock()"
> +        ERROR(errp, "rdma migration: error allocating pd and cq! Your mlock()"
>                      " limits may be too low. Please check $ ulimit -a # and "
>                      "search for 'ulimit -l' in the output");

Not this patch's problem, but noticing it while here:

it would help if we had a consistent style on whether to break long
strings after the space instead of carrying the space to the next
line, rather than using both styles in the same concatenated string.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


