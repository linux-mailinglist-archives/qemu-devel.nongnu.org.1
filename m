Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A294993C962
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jul 2024 22:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4p6-0006uq-L8; Thu, 25 Jul 2024 16:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4p4-0006qi-7B
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4p0-00068L-CN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721938336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wG786PrgBMS4wOVH/IkMp5sFpW2umMy+tKqaIMcZb1Q=;
 b=et2IhsfAc46gcOemcMqcfcrTDxwgH5xZ/oJ6dcmvIObhNCU+lYlWuay4XC7HhFhUXyR9ED
 8OgxgAwvOQ09K5jrGnwul0PbKmZjZgBR5SCjXxHl/YzzM1ArZtL/nrOTGGCHtPT5xV8FMP
 mP5TM6iZ3qGgsfZJlmTd2JvSlk857pE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-0zqDnD06Obecdb461SnixA-1; Thu,
 25 Jul 2024 16:12:15 -0400
X-MC-Unique: 0zqDnD06Obecdb461SnixA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C39ED1955D5B; Thu, 25 Jul 2024 20:12:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E7441955F40; Thu, 25 Jul 2024 20:12:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: [PULL 0/1] Block patches
Date: Thu, 25 Jul 2024 16:12:10 -0400
Message-ID: <20240725201211.460318-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

The following changes since commit 029e13a8a56a2931e7c24c0db52ae7256b932cb0:

  Merge tag 'bsd-user-for-9.1-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-07-25 09:53:57 +1000)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 851495571d14fe2226c52b9d423f88a4f5460836:

  util/async.c: Forbid negative min/max in aio_context_set_thread_pool_params() (2024-07-25 15:57:38 -0400)

----------------------------------------------------------------
Pull request

Peter's AioContext thread_pool_min/max fix

----------------------------------------------------------------

Peter Maydell (1):
  util/async.c: Forbid negative min/max in
    aio_context_set_thread_pool_params()

 util/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


