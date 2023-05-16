Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E40704BA2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQG-0002tY-67; Tue, 16 May 2023 07:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPI-0001bi-MO
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP7-00089s-J5
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rw+P8uHeSMURxVOwYqGlxgsOL1z8Zr5ZjIA/UkRecQ4=;
 b=WfGCwPUnkgx08WZ8+yQrAsuVX0jEysHlKvjg+K+u2i7BGY59vdlz6jimFR12Gty+HV816N
 XUQF0vzTniqOODxKD9Na9psa894WOlsiViAvZbHY5mRkSDwKx9Z6hC/Q9LV8BboJdOaAH7
 lNgqFrxBXasx+YlD4wgx1DniCaHC8dw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-0mX6rwj1PUmiRgIaV80wyw-1; Tue, 16 May 2023 06:59:39 -0400
X-MC-Unique: 0mX6rwj1PUmiRgIaV80wyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE575185A79C;
 Tue, 16 May 2023 10:59:38 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF0AB492B00;
 Tue, 16 May 2023 10:59:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 19/27] qemu.git: drop meson git submodule
Date: Tue, 16 May 2023 12:59:00 +0200
Message-Id: <20230516105908.527838-19-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Now that meson is installed from a vendored wheel, we don't need the git
submodule anymore. Drop it.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-19-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules | 3 ---
 meson       | 1 -
 2 files changed, 4 deletions(-)
 delete mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index 6ce5bf49c588..2a3a12033c4b 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -49,9 +49,6 @@
 [submodule "roms/qboot"]
 	path = roms/qboot
 	url = https://gitlab.com/qemu-project/qboot.git
-[submodule "meson"]
-	path = meson
-	url = https://gitlab.com/qemu-project/meson.git
 [submodule "roms/vbootrom"]
 	path = roms/vbootrom
 	url = https://gitlab.com/qemu-project/vbootrom.git
diff --git a/meson b/meson
deleted file mode 160000
index 3a9b285a55b9..000000000000
--- a/meson
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 3a9b285a55b91b53b2acda987192274352ecb5be
-- 
2.40.1



