Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0579EDDC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSHY-0008So-3X; Wed, 13 Sep 2023 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSHW-0008SP-7M
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSHU-0005el-1W
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694620794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kShElbIDrPZclbLPq83wPTH1Z3jfy4V+YnjtZyTEbYI=;
 b=Aivr7jXYSmUfPI3Db2R6SqU0QwnQgxoWtJ9qFTT3DmxZ2rKka5BAVW9uJXWmOnNwlqUK/7
 j+hcQi3sdkq7JVh3RtgnNqn5WYx+vpfRmVOjZDjCklDlbcdnr5Yeri0py4Fnn0YJyHnS0L
 y7mkDeS/RamOfwep9dvoitxGyma7TJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-nVIOJ8WdPJewAjKZwK7Rjg-1; Wed, 13 Sep 2023 11:59:53 -0400
X-MC-Unique: nVIOJ8WdPJewAjKZwK7Rjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA9B8101FAA0;
 Wed, 13 Sep 2023 15:59:52 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE3C10EE6C9;
 Wed, 13 Sep 2023 15:59:49 +0000 (UTC)
Date: Wed, 13 Sep 2023 10:59:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 kwolf@redhat.com, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 1/5] block: remove AIOCBInfo->get_aio_context()
Message-ID: <ajfm74oskicgrxhvi3r46qh2s7qtqppspn7ju2zpbiiilgqdgk@tu7gbxpgzxdm>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Tue, Sep 12, 2023 at 07:10:33PM -0400, Stefan Hajnoczi wrote:
> The synchronous bdrv_aio_cancel() function needs the acb's AioContext so
> it can call aio_poll() to wait for cancellation.
> 
> It turns out that all users run under the BQL in the main AioContext, so
> this callback is not needed.
> 
> Remove the callback, mark bdrv_aio_cancel() GLOBAL_STATE_CODE just like
> its blk_aio_cancel() caller, and poll the main loop AioContext.
> 
> The purpose of this cleanup is to identify bdrv_aio_cancel() as an API
> that does not work with the multi-queue block layer.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


