Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57AD7AB324
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgcV-0002r8-JM; Fri, 22 Sep 2023 09:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjgcT-0002qT-2H
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjgcQ-0004gD-Lu
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695390894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALAbXdEx2Tvf92hxHdWqx0ajT7YAbZJH8GA8oJxTWVk=;
 b=D5iFsdJmJcTohF5oujICUIFgQXfj5jpkYd1yAizCCkGvbf5vu8sVUwJeB/0WQb8g41AoTz
 UCRrFDFXyYMWDGy/UskirGOuwHBWfz5wfMqfK3CvP34QVBI4sjXCgQPVq5Sip/s+hFxplP
 U0r1Rc9ALSQ4qRDOeB709RSLMM1YiNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-KCClApS5PQab_l3fgCDPvg-1; Fri, 22 Sep 2023 09:54:50 -0400
X-MC-Unique: KCClApS5PQab_l3fgCDPvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A2A685A5A8;
 Fri, 22 Sep 2023 13:54:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6481005B96;
 Fri, 22 Sep 2023 13:54:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/1] configure: support passthrough of -Dxxx args to meson
Date: Fri, 22 Sep 2023 14:54:45 +0100
Message-ID: <20230922135445.241520-2-berrange@redhat.com>
In-Reply-To: <20230922135445.241520-1-berrange@redhat.com>
References: <20230922135445.241520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This can be useful for setting some meson global options, such as the
optimization level or debug state, which don't have an analogous
option explicitly defined in QEMU's configure wrapper script.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index e08127045d..cbd7e03e9f 100755
--- a/configure
+++ b/configure
@@ -931,6 +931,8 @@ cat << EOF
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
 
+  -Dmesonoptname=val      passthrough option to meson unmodified
+
 NOTE: The object files are built at the place where configure is launched
 EOF
 exit 0
-- 
2.41.0


