Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76157F8CCA
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 18:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6wU5-0000A0-LV; Sat, 25 Nov 2023 12:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wU3-00009D-FE
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wU0-0004OB-1I
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700933419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kifpr+xjr2cuRkMlo97p5m12+kzFdyyH25lPhQ6/ObI=;
 b=HGb4M4QUG+Kxe4EY+QQp0YXRg6oU2qiT1+LRBWeXfuJF6/ppnWkasoVdwypX0UD+7RbRMC
 B2Ht53aIVPneOcZjlmHHRxv7ymVW55rq+rkfkGwA34sHhmn8DsxGfRQ5dZjOxDtJ3+ZXn0
 0zE7qNeoS8boq68IE5Kv3lpdfSU3QHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Jfr63TzvPN61TBbwzv4eZQ-1; Sat, 25 Nov 2023 12:30:15 -0500
X-MC-Unique: Jfr63TzvPN61TBbwzv4eZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB9785A58A;
 Sat, 25 Nov 2023 17:30:14 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED79492BE7;
 Sat, 25 Nov 2023 17:30:14 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] build-sys: fix meson project version usage
Date: Sat, 25 Nov 2023 19:30:11 +0200
Message-ID: <20231125173011.374840-2-kkostiuk@redhat.com>
In-Reply-To: <20231125173011.374840-1-kkostiuk@redhat.com>
References: <20231125173011.374840-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Program wixl found: YES (/usr/bin/wixl)

../qga/meson.build:149:16: ERROR: Unknown variable "project".

Fixes: e20d68aa0b9 ("configure, meson: use command line options to configure qemu-ga")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 940a51d55d..ff7a8496e4 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -146,7 +146,7 @@ if targetos == 'windows'
       libpcre = 'libpcre2'
     endif
     qga_msi_version = get_option('qemu_ga_version') == '' \
-      ? project.version() \
+      ? meson.project_version() \
       : get_option('qemu_ga_version')
     qga_msi = custom_target('QGA MSI',
                             input: files('installer/qemu-ga.wxs'),
-- 
2.42.0


