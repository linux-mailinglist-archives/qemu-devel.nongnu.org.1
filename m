Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA58D6EA1
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jun 2024 09:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoR-00048t-Vf; Sat, 01 Jun 2024 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoP-00048W-Pq
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoO-00005T-DL
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPCYxa1h7nFEQqPN2p+USukWjIGoBJSGFRYq761CB1s=;
 b=iNvaR3j4TCr6Mcxp9B5Y1vztx/VDTYVV3rY5pbhQDY1cHG9c/Do4g6AENGn9F58yAZvPgm
 xtkD+Psw+LvPzHYwtkvViXjFI2S4J5zectI8OlEOSHyJDMWf2mrwKVJikSmCLfHnYgl+19
 iyvg+bGRj/J19qoceDeNk1AH20Nr/Cw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-Eip4vvlXO92oBNpltjk-cg-1; Sat,
 01 Jun 2024 03:05:50 -0400
X-MC-Unique: Eip4vvlXO92oBNpltjk-cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 144483C025AD;
 Sat,  1 Jun 2024 07:05:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0666D200A35C;
 Sat,  1 Jun 2024 07:05:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/5] tests/lcitool: Install mingw-w64-tools for the Windows
 cross-builds
Date: Sat,  1 Jun 2024 09:05:42 +0200
Message-ID: <20240601070543.37786-5-thuth@redhat.com>
In-Reply-To: <20240601070543.37786-1-thuth@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Beside g++ we also need the mingw-w64-tools for properly building
the code in qga/vss-win32/ , so let's install that package now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu-win-installer.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/lcitool/projects/qemu-win-installer.yml b/tests/lcitool/projects/qemu-win-installer.yml
index 86aa22297c..f3663ba030 100644
--- a/tests/lcitool/projects/qemu-win-installer.yml
+++ b/tests/lcitool/projects/qemu-win-installer.yml
@@ -2,3 +2,4 @@
 ---
 packages:
  - g++
+ - mingw-w64-tools
-- 
2.45.1


