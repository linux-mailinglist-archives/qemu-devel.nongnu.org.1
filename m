Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA57CA47F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKEC-0000o4-B9; Mon, 16 Oct 2023 05:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsKE4-0000nI-3u
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsKE2-0004DA-Q1
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X0933dFTmbrGRTptfCDLL34scvp6vuokXl4Hzz7r8W8=;
 b=G4c3YcYYJygqEFplnJjFiQna2xpg+rqV6WPQGb8l3c60jthFIVpS+mIPzm1D06dshKEFtS
 P/qZP2+SbXE99Gdl3O5CNaAywGmObm5iSZrTEwONobVV4K5DQWa4Ws0i6a97E7R2tjdOkj
 1kmxPk2p3HTi1yVaj2ofC17GwEaOGN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-k68GJjoAP5aJcjuRHljpKw-1; Mon, 16 Oct 2023 05:49:20 -0400
X-MC-Unique: k68GJjoAP5aJcjuRHljpKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C235D85A5A8;
 Mon, 16 Oct 2023 09:49:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B083020296DB;
 Mon, 16 Oct 2023 09:49:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] scripts: Mark feature_to_c.py as non-executable to fix a
 build issue
Date: Mon, 16 Oct 2023 11:49:17 +0200
Message-ID: <20231016094917.19044-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Meson tries to run scripts via the shebang line if they files are
marked as executable. If "python3" is not in the $PATH, or if it
is a version that is too old, then the script execution fails.
We should make sure to run scripts via the python3 interpreter
that is used for Meson itself. For this, the files need to be marked
as non-executable, then meson will use the python3 binary that has
been used to run itself.

Fixes: 956af7daad ("gdbstub: Introduce GDBFeature structure")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/feature_to_c.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 scripts/feature_to_c.py

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
old mode 100755
new mode 100644
-- 
2.41.0


