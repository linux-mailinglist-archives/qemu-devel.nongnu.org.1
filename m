Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB17DC1E4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:26:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZlk-0008Qa-By; Mon, 30 Oct 2023 17:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZlh-0008LL-UG
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZlg-0007fq-Ds
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698701151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRRxTVoZjttyISvifkVJyqWj27CnkjBAzlCkyFDDRoE=;
 b=izYiSKGwe7rwOGkDKBpqSwgv8RIAMxY+TIduxItFGvn1qu6JiTOu2ub2d/GPBSUcmwRizv
 k7TR1VuIbHTOXTXRleOQwOqTaA7EQZKOG1w5xg+uSxEHcyT4ldGmm4M+lGDcPOQCbdrZzu
 +ZwT4f+TdyuwFZKI9XH10pUDVujEjvo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-21CsfZBLPc6iRfRwHQrjow-1; Mon,
 30 Oct 2023 17:25:23 -0400
X-MC-Unique: 21CsfZBLPc6iRfRwHQrjow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ECD72803024;
 Mon, 30 Oct 2023 21:25:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2238EC1596C;
 Mon, 30 Oct 2023 21:25:20 +0000 (UTC)
Date: Mon, 30 Oct 2023 16:25:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 21/24] qcow2: Take locks for accessing bs->file
Message-ID: <4dlvkpafbcyghymqmwirpftsmseiomday2oegjjro2b3m2b5rs@32puclvwwl5v>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-22-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-22-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 27, 2023 at 05:53:30PM +0200, Kevin Wolf wrote:
> This updates the qcow2 code to add GRAPH_RDLOCK annotations for all
> places that read bs->file.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.h         | 48 ++++++++++++++++++++++++++-----------------
>  block/qcow2-bitmap.c  | 14 +++++++------
>  block/qcow2-cluster.c | 25 +++++++++++-----------
>  block/qcow2.c         | 13 ++++++++----
>  4 files changed, 59 insertions(+), 41 deletions(-)
> 

> @@ -834,9 +834,9 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
>                                       int refcount_order, bool generous_increase,
>                                       uint64_t *refblock_count);
>  
> -int qcow2_mark_dirty(BlockDriverState *bs);
> -int qcow2_mark_corrupt(BlockDriverState *bs);
> -int qcow2_update_header(BlockDriverState *bs);
> +int GRAPH_RDLOCK qcow2_mark_dirty(BlockDriverState *bs);
> +int GRAPH_RDLOCK qcow2_mark_corrupt(BlockDriverState *bs);
> +int GRAPH_RDLOCK qcow2_update_header(BlockDriverState *bs);
>

My first thought was "why is this a read lock when these functions are
modifying the qcow2 headers?  Isn't that a write operation?"  But in
thinking further - they are reading the graph structure, not modifing
it (bs->file is not being changed; we may be modifying the contents to
be stored in bs->file, but whether or not that change is done now or
queued for the next flush, we still keep the same bs->file), so it
looks right after all - these really are operations where we don't
want the graph changed out from underneath us while we are modifying
the qcow2 header.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


