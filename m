Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D307583EE
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 19:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLovl-0000fC-60; Tue, 18 Jul 2023 13:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLovj-0000e3-4w
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLovh-0001GL-Po
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689702969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6+xNiflPLL3mDvHnzPmlZpwHAXgVGsS7JzepCT5178=;
 b=a9CuhzC1uX+fmBiouCyzH8YQPItnzu+jnym78Kxn5KvVUeZ9ivvKf1DHcK2mJF0tav8tMM
 Gs/futdOkKs9LVtKVt0Rnne8RgcFFbGbwSul5KiMi/uIW9WCevnm++dYPJPZjV8ZP3u0/m
 gGYN+FKPOOqonS2CrNrfIdfF96QzbD4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-KZlM2sN5OYS-iU9t3Tbb_w-1; Tue, 18 Jul 2023 13:53:56 -0400
X-MC-Unique: KZlM2sN5OYS-iU9t3Tbb_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45CB3800159;
 Tue, 18 Jul 2023 17:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 591D740C206F;
 Tue, 18 Jul 2023 17:53:55 +0000 (UTC)
Date: Tue, 18 Jul 2023 12:53:53 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 6/5] qemu-nbd: make verbose bool and local variable in
 main()
Message-ID: <7v3uxgjkpxrzgfos5u7saklqzhpurd7lzfo6j6rujmcq6qisxb@6hyzuyhv77ve>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717202520.236999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717202520.236999-1-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 17, 2023 at 10:25:20PM +0200, Denis V. Lunev wrote:
> Pass 'verbose' to nbd_client_thread() inside NbdClientOpts which looks
> a little bit cleaner and make it bool as it is used as bool actually.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'll queue the series through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


