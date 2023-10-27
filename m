Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC807DA254
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 23:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwUEg-000319-DS; Fri, 27 Oct 2023 17:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUEe-0002zr-7X
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUEc-0002IO-KS
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698441553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5h51Xz+K6Fqn5GtAeyvnphPASqoY1AuyySlAEqLvY=;
 b=XFdqZp2N3ENVx4g38puwwBLyro6rMzSy1a3Gj/yEW1KcyepMvBP3gAqFVzhFzHKPd+8JC4
 wR1Qk4Uq8gveodzLOwg2MsJXkyIDOBKan5kuQ/gsy9JD5dj/1NsjtnE8OCFg/k1ngAB2Cl
 VcgEUHS+vqeU7QO9hEe2yuVZbz7l8TU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-14vWarDCPySCz-y-BKTlLg-1; Fri,
 27 Oct 2023 17:19:10 -0400
X-MC-Unique: 14vWarDCPySCz-y-BKTlLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C41138041DD;
 Fri, 27 Oct 2023 21:19:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 100251C060AE;
 Fri, 27 Oct 2023 21:19:08 +0000 (UTC)
Date: Fri, 27 Oct 2023 16:19:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/24] block: Mark bdrv_filter_child() and callers
 GRAPH_RDLOCK
Message-ID: <ha2z6ewnrexacwyarqxdlls6adftcgp6gk55xk2mqhkoysc6da@xwz5bshrx552>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-12-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-12-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Oct 27, 2023 at 05:53:20PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_filter_child() need to hold a reader lock for the graph because it
> accesses bs->file/backing.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-io.h | 4 ++--
>  block.c                      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Deceptively short compared to some of the others in this series.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


