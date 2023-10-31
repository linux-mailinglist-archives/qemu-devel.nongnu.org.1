Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2337DD12C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:07:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrFS-00036Y-TA; Tue, 31 Oct 2023 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxrFN-00035n-Tg
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxrFL-00005f-QA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698768338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXhAPBjlS50dq8v+TBsuXWNEN1TwnS7HaTR1XFdqDIw=;
 b=Z0zpf6oljZZNQ0NF1ZSgZ8rIq3TiPe2Q6UuZ8S9TwPzhqHbKHc4IwKpCJBolsKdGmMNVO1
 I3aw6jwRtMS+o9KgQdS5LA/hMqPEXwVXXyBI0B/Ls6TW14jU8krc2ZrN6Jfv6jfoVcLogK
 UuzUeJ0ADfbhHZnEDAx2a1rHbGDm4GY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-FTDBeiovOYeYj303xZjSQA-1; Tue,
 31 Oct 2023 12:05:24 -0400
X-MC-Unique: FTDBeiovOYeYj303xZjSQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60F4A3C16DCC;
 Tue, 31 Oct 2023 16:05:24 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFC4010F4C;
 Tue, 31 Oct 2023 16:05:22 +0000 (UTC)
Date: Tue, 31 Oct 2023 11:05:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, 
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, 
 den@virtuozzo.com, t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v4 01/10] blockjob: introduce block-job-change QMP command
Message-ID: <okhs3xcnfd3aajdasdkz3yqcirvd6bftdk76l4xpkt62mwrttl@tb52nh3wc2le>
References: <20231031135431.393137-1-f.ebner@proxmox.com>
 <20231031135431.393137-2-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135431.393137-2-f.ebner@proxmox.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Tue, Oct 31, 2023 at 02:54:22PM +0100, Fiona Ebner wrote:
> which will allow changing job-type-specific options after job
> creation.
> 
> In the JobVerbTable, the same allow bits as for set-speed are used,
> because set-speed can be considered an existing change command.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Changes in v4:
>     * Add note that change callback can be invoked before job coroutine
>       is running.
> 
>  blockdev.c                   | 14 ++++++++++++++
>  blockjob.c                   | 20 ++++++++++++++++++++
>  include/block/blockjob.h     | 11 +++++++++++
>  include/block/blockjob_int.h |  7 +++++++
>  job.c                        |  1 +
>  qapi/block-core.json         | 26 ++++++++++++++++++++++++++
>  qapi/job.json                |  4 +++-
>  7 files changed, 82 insertions(+), 1 deletion(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


