Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0467B816A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2K4-0001AM-Hr; Wed, 04 Oct 2023 09:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qo2Jh-00014q-OF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qo2Jg-0002kS-4U
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M5h1/kZ/bfou2M6Bf2orQuTGwg/bl7LNzqxAiXkOYAU=;
 b=bRTdXs546nUPLE8rRl8LAbmuYXrR7QwcvkB6a8A2CNZe/WoCzgZleKrR5Bwqy4QHxIzmjH
 nqqGPvxHDoNXsB/POyuW4e3yMv86quhipeH5y5FYqwBztnrN0WNqRQp3Yi4jZjAcKjdnQi
 6X1yomSQYkrUUudDr9XpAHP0KKCdNqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-8bxdPBwaOseeYRPQt3hmZg-1; Wed, 04 Oct 2023 09:53:19 -0400
X-MC-Unique: 8bxdPBwaOseeYRPQt3hmZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4680C1C01E9C;
 Wed,  4 Oct 2023 13:53:19 +0000 (UTC)
Received: from localhost (unknown [10.39.194.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF79A440E3;
 Wed,  4 Oct 2023 13:53:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/1] Block patches
Date: Wed,  4 Oct 2023 09:53:16 -0400
Message-ID: <20231004135317.1254548-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-10-03 07:43:44 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9afa888ce0f816d0f2cfc95eebe4f49244c518af:

  osdep: set _FORTIFY_SOURCE=2 when optimization is enabled (2023-10-04 09:52:06 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Daniel P. Berrangé (1):
  osdep: set _FORTIFY_SOURCE=2 when optimization is enabled

 meson.build                  | 10 ----------
 include/qemu/osdep.h         |  4 ++++
 util/coroutine-sigaltstack.c |  4 ++--
 util/coroutine-ucontext.c    |  4 ++--
 4 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.41.0


