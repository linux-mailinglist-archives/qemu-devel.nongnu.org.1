Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1127BAB4A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoUhX-0002xa-8p; Thu, 05 Oct 2023 16:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUhV-0002wU-HG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoUhU-0005qv-5s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696536719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hj5pYc+JIAiqag2IySpi1vpNeZw2ANPAEn7lShFWfFo=;
 b=FZpwWo7dhcc8aoS1j2oChRmBZ/6xpqjbf5o5MfUjTxZvhC27L0fQwKQHTrcRPFKCWUNVo6
 K59XvyBvYYX5HPv3KwARUTpeDitho2XZwXVUQKIUnY/teapERJVVHKe9uQMgEs893bn/GK
 2Ux7+9OdV6G20YeocYgetLODoDbZEEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-Q06IRFxkPpCJ9PN_XwnUsw-1; Thu, 05 Oct 2023 16:11:41 -0400
X-MC-Unique: Q06IRFxkPpCJ9PN_XwnUsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EDA98007A4;
 Thu,  5 Oct 2023 20:11:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DFFB40C6EA8;
 Thu,  5 Oct 2023 20:11:40 +0000 (UTC)
Date: Thu, 5 Oct 2023 15:11:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v6 11/14] iotests: drop some extra ** in qmp() call
Message-ID: <elrbxzvcvzgc6tlihuu2iqrfjvrtpmcpyq34h5f2evtjaqpzcy@b72xpddr6rpk>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
 <20231005135550.331657-12-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005135550.331657-12-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Oct 05, 2023 at 04:55:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> qmp() method supports passing dict (if it doesn't need substituting
> '_' to '-' in keys). So, drop some extra '**' operators.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qemu-iotests/040                        |  4 +-
>  tests/qemu-iotests/041                        | 14 +++---
>  tests/qemu-iotests/129                        |  2 +-
>  tests/qemu-iotests/147                        |  2 +-
>  tests/qemu-iotests/155                        |  2 +-
>  tests/qemu-iotests/264                        | 12 ++---
>  tests/qemu-iotests/295                        |  5 +-
>  tests/qemu-iotests/296                        | 15 +++---
>  tests/qemu-iotests/tests/migrate-bitmaps-test |  4 +-
>  .../tests/mirror-ready-cancel-error           | 50 +++++++++----------
>  10 files changed, 54 insertions(+), 56 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


