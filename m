Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657827C737E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyuL-0004xA-OJ; Thu, 12 Oct 2023 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuE-0004tp-VP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuC-0005cV-Gt
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697129483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyA5Mg0uBpkkeTCc7iQaDmXE+iZLniiMO0wCg8OVfUA=;
 b=Q0RH9GhmZo431hI0rq3sJkoKxS+ScaPqJnv5Gyz2eXN5ZcjyhNSmkNOfsVjqwCQPjvZX5t
 CUlSWuXO5A3bmd3/AJcfxuapqlWhwvklOJP1Xr+14ZMSh0EKawvu+/vsrbHH5D72Fcz+xp
 fSpLXzaxu4zQBsY+5RkM7rirk03htmU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-mqFi35MKNtiKI5xeUeHErA-1; Thu, 12 Oct 2023 12:51:19 -0400
X-MC-Unique: mqFi35MKNtiKI5xeUeHErA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E019B3822550;
 Thu, 12 Oct 2023 16:51:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76E8025C0;
 Thu, 12 Oct 2023 16:51:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/7] hw/misc/Kconfig: add switch for i2c-echo
Date: Thu, 12 Oct 2023 18:51:06 +0200
Message-ID: <20231012165108.913443-6-thuth@redhat.com>
In-Reply-To: <20231012165108.913443-1-thuth@redhat.com>
References: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/Kconfig     | 5 +++++
 hw/misc/meson.build | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 858277bb60..dba41afe67 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -34,6 +34,11 @@ config PCA9552
     bool
     depends on I2C
 
+config I2C_ECHO
+    bool
+    default y if TEST_DEVICES
+    depends on I2C
+
 config PL310
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 33659313b4..f60de33f9a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -138,7 +138,7 @@ system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
 
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
-system_ss.add(when: 'CONFIG_I2C', if_true: files('i2c-echo.c'))
+system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
-- 
2.41.0


