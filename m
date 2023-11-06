Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1E7E2730
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:41:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jn-0006YN-DK; Mon, 06 Nov 2023 09:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jl-0006Uk-Qg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:57 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jj-00010D-WD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTs6gBLz4xkS;
 Tue,  7 Nov 2023 01:37:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTq3F5Zz4xkM;
 Tue,  7 Nov 2023 01:37:51 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 16/22] util/uuid: Remove UUID_FMT_LEN
Date: Mon,  6 Nov 2023 15:36:47 +0100
Message-ID: <20231106143653.302391-17-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Dangerous and now unused.

Cc: Fam Zheng <fam@euphon.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Denis V. Lunev" <den@openvz.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qemu/uuid.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 4e7afaf1d5bd5d382fefbd6f6275d69cf25e7483..356efe7b5797911640ed347fc08f4ef5ebbd0476 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -78,8 +78,7 @@ typedef struct {
                  "%02hhx%02hhx-" \
                  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
-#define UUID_FMT_LEN 36
-#define UUID_STR_LEN (UUID_FMT_LEN + 1)
+#define UUID_STR_LEN (36 + 1)
 
 #define UUID_NONE "00000000-0000-0000-0000-000000000000"
 
-- 
2.41.0


