Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9781BFD6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQBm-0001ii-A2; Thu, 21 Dec 2023 16:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQBk-0001iY-Mi
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQBf-0001Ht-Q6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703192554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5LUIkvZ9TeKyY/k5axAn88KBZNVgPVIG51mzst7Lgk=;
 b=WIAexTUbZRwX+e9uSQKjlI4dN0REm10hifOgdKaMfC804qkumFJLnXqZ6K024dO4zLNMrm
 OiUES039t0bifhcnjGvxxXtXzud9RkVUF3IshOBxdTiwHIoSV4M8nVq0U2R+q+JNfFYVz+
 tikgGv0Gk/RwTTRxbAtd9KG1We2rwvI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-zZotT_JLPeKbOftxPjPzCQ-1; Thu,
 21 Dec 2023 16:02:30 -0500
X-MC-Unique: zZotT_JLPeKbOftxPjPzCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26DA9380662C;
 Thu, 21 Dec 2023 21:02:27 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBCE22166B31;
 Thu, 21 Dec 2023 21:02:22 +0000 (UTC)
Date: Thu, 21 Dec 2023 22:02:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 pbonzini@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 0/6] qemu-iotests fixes for Kevin's block tree
Message-ID: <ZYSn3EoLhaxKEbdB@redhat.com>
References: <20231221192452.1785567-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221192452.1785567-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 21.12.2023 um 20:24 hat Stefan Hajnoczi geschrieben:
> v3:
> - Add aio_wait_kick() into nbd_read_eof() to avoid race with nbd_drained_poll()
>   [Kevin]
> 
> v2:
> - Drop useless if (client->quiesing) check [Kevin]
> - run qio_channel_read_wake() in export AioContext to avoid race [Kevin]
> - Introduce nbd_client_put_nonzero() optimization [Paolo]
> - Reach goto label disconnect with client->lock taken [Paolo]
> - Add doc comment explaining nbd_co_receive_request() loop in nbd_trip() [Kevin]
> 
> Kevin merged several of my outstanding multi-queue block layer patch series and
> found that qemu-iotests -qcow2 was broken. This patch series fixes the block branch.
> 
> Most of the fixes are easy but the NBD server required deeper debugging and
> thread-safety fixes. The NBD server patches can be inserted before "aio: make
> aio_context_acquire()/aio_context_release() a no-op" to preserve bisectability.
> The other patches are fixups that can be squashed into the original patches.

Thanks, applied to the block branch.

Kevin


