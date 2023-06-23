Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEAB73B3D2
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdHP-0003Jv-IW; Fri, 23 Jun 2023 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCdHN-0003JR-BP
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCdHL-0002iG-OI
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687513230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4ovUS9/J+ziHEQXfL3GwBRkIZ+c95y6weUBghvO3lzc=;
 b=Q8Vu0c/TgbmQ6722Pi6rvVJsQxORenMdf5p8fJ8QD8KmTwf8CKGlVcPk+cDNOhD4IVntSm
 VOVkzC7JVXiREZZ3W2OjFvhZ4KpkLVlrFEWpyqlJGPZkpyJVOBdk3nQdj2wwxCKnAQOTTX
 AoTTy+Smq3DWqZhcgHHuTaCWdb6RSWE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-Z7UipHkvOd2FN3wNB_XZSQ-1; Fri, 23 Jun 2023 05:40:27 -0400
X-MC-Unique: Z7UipHkvOd2FN3wNB_XZSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55EA53C13932
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 09:40:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B07F3C1ED97;
 Fri, 23 Jun 2023 09:40:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Miroslav Rezanina <mrezanin@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] keymaps: use 'ara' X11 keyboard map instead of 'ar'
Date: Fri, 23 Jun 2023 10:40:25 +0100
Message-Id: <20230623094025.72295-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The keyboard mapping name 'ar' was a legacy name only available from
xkeyboard-config via a (15 year old) backcompat mapping. This mapping
was finally removed in the latest upstream release 2.39:

  https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 pc-bios/keymaps/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index bff3083313..0bd8ce0077 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -1,5 +1,5 @@
 keymaps = {
-  'ar': '-l ar',
+  'ar': '-l ara',
   'bepo': '-l fr -v dvorak',
   'cz': '-l cz',
   'da': '-l dk',
-- 
2.40.1


