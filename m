Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF908C7595
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 14:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Zq5-00057z-Lo; Thu, 16 May 2024 08:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpx-0004oz-13
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpu-0002My-UA
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIqjM5EDB0EDQN5EIqgrch9ZOwxGoOCxQd9vryEWZrA=;
 b=cUBCR5mI2QVdcIwN+08++saGOm8pjkFnqIHNPhpscM4kozl6bk7t82PVAbCdTnObFSR4xU
 B+vQCZuOwWLvajRAlYvLksE602RXxwn8kVfhjJRnCEGuFTbvfA3qRS7u3e60LZM1Dq9FuC
 zmgW3az/eh7vHlQZWZOuOyp1SnanRqg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-8cmQVVvRPr2O_aN8UOKdMA-1; Thu,
 16 May 2024 08:03:48 -0400
X-MC-Unique: 8cmQVVvRPr2O_aN8UOKdMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5AF53800090
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:03:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6601C00A8E;
 Thu, 16 May 2024 12:03:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E026B1801001; Thu, 16 May 2024 14:03:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/4] MAINTAINERS: drop usb maintainership
Date: Thu, 16 May 2024 14:03:39 +0200
Message-ID: <20240516120344.531521-3-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-1-kraxel@redhat.com>
References: <20240516120344.531521-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

Remove myself from usb entries.
Flip status to "Orphan" for entries which have nobody else listed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f52e2912fc3..d81376f84746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2140,8 +2140,7 @@ F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 
 USB
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: hw/usb/*
 F: stubs/usb-dev-stub.c
 F: tests/qtest/usb-*-test.c
@@ -2150,7 +2149,6 @@ F: include/hw/usb.h
 F: include/hw/usb/
 
 USB (serial adapter)
-R: Gerd Hoffmann <kraxel@redhat.com>
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: hw/usb/dev-serial.c
-- 
2.45.0


