Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E27DC202
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZy2-0004er-3D; Mon, 30 Oct 2023 17:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZxe-0004YN-IF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZxY-0001o5-RN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698701882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XeRjszol/1t+00ejALfArrZY4Q2ar3HjlZvqNyiUzdI=;
 b=UqRZ5bUR1wbhg0tQdiBue/ZfkWf/ZmzPMNM7UEQ/5CMIjssEYMUvEQWAXUPFTMfDYeM5Z4
 XZey+Zm/CRDt70Gr7jouNCwQGFm7Cze7SHbXesIQJzjYBGLWNMdrvQdT4ZY5/u0Ecw54/R
 E6m1tZymt7tUJwBzUYmen4Xukoy3mLU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-Hv4aJSU5NeGHkzPkyGC0ug-1; Mon,
 30 Oct 2023 17:37:57 -0400
X-MC-Unique: Hv4aJSU5NeGHkzPkyGC0ug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D5A71C18CC0;
 Mon, 30 Oct 2023 21:37:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EAB9492BE0;
 Mon, 30 Oct 2023 21:37:56 +0000 (UTC)
Date: Mon, 30 Oct 2023 16:37:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 24/24] block: Protect bs->file with graph_lock
Message-ID: <udc7v4ty532le4ijdwjr7ja3lu6bnnlp5to6hurebc2gbsqvwu@omhkwiwpc6hc>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-25-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-25-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 05:53:33PM +0200, Kevin Wolf wrote:
> Almost all functions that access bs->file already take the graph
> lock now. Add locking to the remaining users and finally annotate the
> struct field itself as protected by the graph lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/parallels.h                |  5 +++--
>  block/qed.h                      |  2 +-
>  include/block/block_int-common.h |  2 +-
>  block.c                          | 11 ++++++++---
>  block/blkreplay.c                |  8 +++++++-
>  block/copy-before-write.c        |  2 +-
>  block/crypto.c                   |  6 ++++++
>  block/dmg.c                      | 16 ++++++++++------
>  block/parallels-ext.c            | 21 ++++++++++-----------
>  block/parallels.c                |  6 ++++--
>  block/preallocate.c              | 19 ++++++++++++++-----
>  block/qed.c                      | 12 ++++++++++--
>  block/raw-format.c               |  9 ++++++---
>  block/replication.c              |  5 ++++-
>  block/vmdk.c                     | 14 ++++++++++++--
>  15 files changed, 97 insertions(+), 41 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


