Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AE7E0195
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:34:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyrV0-0000Rz-Tr; Fri, 03 Nov 2023 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyrUy-0000QQ-LU
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyrUx-0007Yy-85
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699007634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TsgKRewZGs4aanBMwlJEMdPPaILnwhE10pJLaCBa+g=;
 b=jWq9DRWGqgEuJXsBypriVM9weIbw5YwUXyoYAYt8eCRV1de0T/459ihyjLhPEcDi+xtYQi
 e0Z1w2X8xNBXocADeBICnqIfAXRWXARiubgU0dBIj9q6c44U1zN113iWJpZ45froKKubYR
 K0IwczEsrmMwg5RgXOoEMB5Df871fzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-rghfUa3JOA2bFhp3YhkwiA-1; Fri, 03 Nov 2023 06:33:49 -0400
X-MC-Unique: rghfUa3JOA2bFhp3YhkwiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A07B385A59D;
 Fri,  3 Nov 2023 10:33:49 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85946492BE0;
 Fri,  3 Nov 2023 10:33:48 +0000 (UTC)
Date: Fri, 3 Nov 2023 11:33:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 19/24] block: Introduce bdrv_co_change_backing_file()
Message-ID: <ZUTMi/AIqPeqQXN6@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-20-kwolf@redhat.com>
 <s5jvuqejqapizbe7oyxonoocabd2rnfbhfejcerdn32ddrgtzr@6m6a2yij2zuu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5jvuqejqapizbe7oyxonoocabd2rnfbhfejcerdn32ddrgtzr@6m6a2yij2zuu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 30.10.2023 um 14:57 hat Eric Blake geschrieben:
> On Fri, Oct 27, 2023 at 05:53:28PM +0200, Kevin Wolf wrote:
> > bdrv_change_backing_file() is called both inside and outside coroutine
> > context. This makes it difficult for it to take the graph lock
> > internally. It also means that driver implementations need to be able to
> > run outside of coroutines, too. Switch it to the usual model with a
> > coroutine based implementation and a co_wrapper instead. The new
> > function is marked GRAPH_RDLOCK.
> > 
> > As the co_wrapper now runs the function in the AioContext of the node
> > (as it should always have done), this is not GLOBAL_STATE_CODE() any
> > more.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block-global-state.h |  3 +-
> >  include/block/block-io.h           |  8 ++++
> >  include/block/block_int-common.h   |  5 ++-
> >  block.c                            | 11 ++---
> >  block/qcow2.c                      | 18 +++++----
> >  block/qed.c                        | 64 +++++++++++++++---------------
> >  tests/unit/test-bdrv-drain.c       |  8 ++--
> >  7 files changed, 65 insertions(+), 52 deletions(-)
> > 
> > +++ b/block/qcow2.c
> > @@ -6155,9 +6159,9 @@ BlockDriver bdrv_qcow2 = {
> >      .bdrv_co_save_vmstate   = qcow2_co_save_vmstate,
> >      .bdrv_co_load_vmstate   = qcow2_co_load_vmstate,
> >  
> > -    .is_format                  = true,
> > -    .supports_backing           = true,
> > -    .bdrv_change_backing_file   = qcow2_change_backing_file,
> > +    .is_format                      = true,
> > +    .supports_backing               = true,
> > +    .bdrv_co_change_backing_file    = qcow2_co_change_backing_file,
> >  
> >      .bdrv_refresh_limits        = qcow2_refresh_limits,
> >      .bdrv_co_invalidate_cache   = qcow2_co_invalidate_cache,
> 
> Here, you only realigned = on a portion of the initializer...
> 
> > diff --git a/block/qed.c b/block/qed.c
> > index 686ad711f7..996aa384fe 100644
> > --- a/block/qed.c
> > +++ b/block/qed.c
> >  static BlockDriver bdrv_qed = {
> > -    .format_name              = "qed",
> > -    .instance_size            = sizeof(BDRVQEDState),
> > -    .create_opts              = &qed_create_opts,
> > -    .is_format                = true,
> > -    .supports_backing         = true,
> > -
> > -    .bdrv_probe               = bdrv_qed_probe,
> 
> ...while here, you are doing it on the entire block.  This shows why I
> personally dislike aligning =, but I tolerate it when it is already
> prevailing style.  Still, it feels weird to be inconsistent within the
> same patch.

It's because qcow2 already had multiple different indentations, but qed
had everything aligned to the same column. I can update qcow2.

Kevin


