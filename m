Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16E87BC43
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 12:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjeK-00073C-AQ; Thu, 14 Mar 2024 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkjeB-00070q-9v
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkje5-0002fk-Dz
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710417192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myNGf+CSdMNy8uDZly82xQ5nUEAzqpRNwgBz4DoBbKk=;
 b=cLDsQWRUd5Q+eI7c8tdr8H+QZD2f0LQY0PAzwcNsZ6enSrd68t8KYndzPKCrG1wqVw7BjP
 gGqAuQinUel2JJ1/gXBXa5KEt5Te4W0J9DEdqyRzWAo68nQV2S427vsbX/F5Hm/sX4TSzB
 SJJv1fwE+xG5Xm8ytlbg2hGqQ/DmpvE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-3InzF2bKNkKRD6CBdqCQXg-1; Thu,
 14 Mar 2024 07:53:09 -0400
X-MC-Unique: 3InzF2bKNkKRD6CBdqCQXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E531E1C006B1;
 Thu, 14 Mar 2024 11:53:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85EB02166AE5;
 Thu, 14 Mar 2024 11:53:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9487C18009DB; Thu, 14 Mar 2024 12:53:07 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/5] roms/efi: clean up edk2 build config
Date: Thu, 14 Mar 2024 12:52:59 +0100
Message-ID: <20240314115307.628118-2-kraxel@redhat.com>
In-Reply-To: <20240314115307.628118-1-kraxel@redhat.com>
References: <20240314115307.628118-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Needed to avoid stale toolchain configurations breaking firmware builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/roms/Makefile b/roms/Makefile
index 8e5d8d26a9a0..edc234a0e886 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -187,6 +187,7 @@ clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C ipxe/src veryclean
 	$(MAKE) -C edk2/BaseTools clean
+	rm -rf edk2/Conf/{.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
 	$(MAKE) -C SLOF clean
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
-- 
2.44.0


