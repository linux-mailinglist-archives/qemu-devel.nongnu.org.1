Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C472197873B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 19:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spASX-0001HY-4F; Fri, 13 Sep 2024 13:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1spASV-0001Gy-BK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1spAST-0000Ey-SH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726249907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sRBJhryyEAjyrPlxrcuKiHVsMV+0HJ5LGOgEBM1ZoSw=;
 b=XpL09JiXIMJruiAH+rJbI++UzlVYDFsBYlJMg86dAqbPT91NCHV8/WI9VjucAenPpBMgtu
 hREYEsjjnIS1wL/v+rDkSeU2vuwGNyWMX7EOPRyWBPDQ3iJL3UCUCg+Z2/Mo21wCEwg/70
 dnm9WXOvSYHVQtGbJCVKHyvOGoCGLRo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-A6js5quMN7CpqDi7M3P5IQ-1; Fri,
 13 Sep 2024 13:51:45 -0400
X-MC-Unique: A6js5quMN7CpqDi7M3P5IQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C1F21956077; Fri, 13 Sep 2024 17:51:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4654319560B0; Fri, 13 Sep 2024 17:51:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] tests/functional: Move the mips64el fuloong2e test into the
 thorough category
Date: Fri, 13 Sep 2024 19:51:40 +0200
Message-ID: <20240913175140.3329083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
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

Commit d2fce37597c2 added a test that downloads an asset from the
internet, so this test should not be run by default anymore and be
put into the thorough category instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 975e609073..8d5520349d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -86,11 +86,8 @@ tests_mipsel_system_thorough = [
   'mipsel_malta',
 ]
 
-tests_mips64el_system_quick = [
-  'mips64el_fuloong2e',
-]
-
 tests_mips64el_system_thorough = [
+  'mips64el_fuloong2e',
   'mips64el_loongson3v',
   'mips64el_malta',
 ]
-- 
2.46.0


