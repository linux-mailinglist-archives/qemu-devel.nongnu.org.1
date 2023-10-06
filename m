Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8117BBFE1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqsX-0002Yd-NX; Fri, 06 Oct 2023 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsU-0002Xr-Si
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsT-0007jH-B4
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696621966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59Yb08j1vwXHm7g0r4RjBX9wyft1gjvIcrItrlXBZ8o=;
 b=XhyBh6FWFGppNhtLaIdrIEZYpDwLeb3ALhK50c88tA44XWBEz6SEnJEM05ZtxFWnmn1XlX
 1E6sarYYt3sH2ovBwXOQeGVaHvt6czulEQ2v87ARHga/6+4QzmdKywAkx/ogAlshwmR/p7
 VFFdoohr0p26Ey5owTUoWwx7lzjzN8U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-F0aG6HobNjK9rv0SrjhZUw-1; Fri, 06 Oct 2023 15:52:45 -0400
X-MC-Unique: F0aG6HobNjK9rv0SrjhZUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1403E3C108E3;
 Fri,  6 Oct 2023 19:52:45 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84F0B492B05;
 Fri,  6 Oct 2023 19:52:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] Python/iotests: Add type hint for nbd module
Date: Fri,  6 Oct 2023 15:52:40 -0400
Message-ID: <20231006195243.3131140-2-jsnow@redhat.com>
In-Reply-To: <20231006195243.3131140-1-jsnow@redhat.com>
References: <20231006195243.3131140-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

The test bails gracefully if this module isn't installed, but linters
need a little help understanding that. It's enough to just declare the
type in this case.

(Fixes pylint complaining about use of an uninitialized variable because
it isn't wise enough to understand the notrun call is noreturn.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/nbd-multiconn | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/nbd-multiconn b/tests/qemu-iotests/tests/nbd-multiconn
index 478a1eaba2..7e686a786e 100755
--- a/tests/qemu-iotests/tests/nbd-multiconn
+++ b/tests/qemu-iotests/tests/nbd-multiconn
@@ -20,6 +20,8 @@
 
 import os
 from contextlib import contextmanager
+from types import ModuleType
+
 import iotests
 from iotests import qemu_img_create, qemu_io
 
@@ -28,7 +30,7 @@ disk = os.path.join(iotests.test_dir, 'disk')
 size = '4M'
 nbd_sock = os.path.join(iotests.sock_dir, 'nbd_sock')
 nbd_uri = 'nbd+unix:///{}?socket=' + nbd_sock
-
+nbd: ModuleType
 
 @contextmanager
 def open_nbd(export_name):
-- 
2.41.0


