Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D07B2EC6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Mn-0001qS-8y; Fri, 29 Sep 2023 05:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Mb-0001mc-E5
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MN-0008Bb-Nw
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4GjYDCb7xOJWXlG+vnKWW+7by992abrtrTUH3d+Z1Q=;
 b=QddJfZ4E/5BOSZMNk/ssMI56TmfYgUkZ2UR4kmIe7mUMGc3bC49pAnpnw7nMcpDOX6tgB5
 iKSpWurjg8sGtCklq5DKas3VjUu7KaVZjCqyw3VusCBTqae6PSr1en8jgC/aZhiAa5g/nP
 LiGsieMQnDoV1LVg6xvSSd+Qz9wI/Ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-cI-9u3zxNNyyh6XhV0cGvw-1; Fri, 29 Sep 2023 05:00:27 -0400
X-MC-Unique: cI-9u3zxNNyyh6XhV0cGvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9D5802D38;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C901176E4;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8BE621E689D; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 40/56] hw/misc/arm_sysctl.c: Avoid shadowing local variable
Date: Fri, 29 Sep 2023 10:50:37 +0200
Message-ID: <20230929085053.2789105-41-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Peter Maydell <peter.maydell@linaro.org>

Avoid shadowing a local variable in arm_sysctl_write():

../../hw/misc/arm_sysctl.c: In function ‘arm_sysctl_write’:
../../hw/misc/arm_sysctl.c:537:26: warning: declaration of ‘val’ shadows a parameter [-Wshadow=local]
  537 |                 uint32_t val;
      |                          ^~~
../../hw/misc/arm_sysctl.c:388:39: note: shadowed declaration is here
  388 |                              uint64_t val, unsigned size)
      |                              ~~~~~~~~~^~~

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20230922152944.3583438-3-peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/arm_sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 42d4693854..3e4f4b0524 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -534,12 +534,12 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
                     s->sys_cfgstat |= 2;        /* error */
                 }
             } else {
-                uint32_t val;
+                uint32_t data;
                 if (!vexpress_cfgctrl_read(s, dcc, function, site, position,
-                                           device, &val)) {
+                                           device, &data)) {
                     s->sys_cfgstat |= 2;        /* error */
                 } else {
-                    s->sys_cfgdata = val;
+                    s->sys_cfgdata = data;
                 }
             }
         }
-- 
2.41.0


