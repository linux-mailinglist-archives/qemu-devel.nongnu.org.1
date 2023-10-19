Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3147D040A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:29:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRr-0000vP-Ah; Thu, 19 Oct 2023 17:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRp-0000uL-8X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRm-0005do-TQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083cd39188so939375e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750449; x=1698355249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kG3m+UrB+1tXa81IHczK7QBkGPM1a1yV1vD8kixZHhU=;
 b=zxWNbtDBgcvI2l+R/7m3HyIXyXO79WWJGiO70Tyg+MJ+nj4ReWReEiuTC1eqjddfMj
 HsUdd//q6a7Wmo5tQ3GALNuYLw6lIJ0nhGcQAuvcsFVFz4oXBmDLkylxG+KrQcXNByI/
 iUPFyXjV3JlcqYqIsHA8/1Up6YX0p4dtQqxgnIQ3/XHlt0/NdoV1Vrdu+oFSPFQrZpXg
 rK7st6hyZZciHqj02XZ10a+1OIuBIXcZNNl1cZTLY27kZJBG/QKiXjsXkCTCG399dUtD
 sO8sgTGnH+N+W5B6brwukB+0RlOk0A3WgYpeYx+vxz2tmc9+3PX+cv6ZUSts9wead9l8
 HE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750449; x=1698355249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kG3m+UrB+1tXa81IHczK7QBkGPM1a1yV1vD8kixZHhU=;
 b=QznS8Y9Ta1bJDUTHQ74l8TGPauekRjpF1mm5xpz3j6OQcMWUrG7eLiHt1UR2wpG3B4
 RkqhFGfCahxr8TvEworBpO5V9A6bairbk3Y66BW5a9VKYSO4iMlm+5xfg/cfwxyYU8bs
 2xHGo8LytrXXRM/PZiSKyCUQSwoxoM5GCBvXoh7yfkDYJAz6gWPfxKGIctJ1dD6NocZA
 dWQExMhEpymeNDodSSw1vRfb1A0PpsB2xTkHHANBV7Z68cXHa37XP3YgjGAHkUQjUIdO
 vJrgLsnNnnlLe0W4PC+S+/YhSKtmmvndTOt8DdS8gJLKEkfRiUM2kQM4rUrTt3LWmnpk
 bb6Q==
X-Gm-Message-State: AOJu0YyOBcNLCAM2pjYHhSxcD5w5Wj3RRjDM/b+hpNMXxTKBAZAMmcoM
 m4dTrRfBYJpoojYcG+1F92n296XH9FsWnUxAvM3PPA==
X-Google-Smtp-Source: AGHT+IH7Chkm57EbayQ+rA08dWmaUxzQAq1pAUtC21KE7tNcrWX5XkoI450jvyx16/2SVy3fCzPfYQ==
X-Received: by 2002:a05:600c:1d25:b0:408:3eaa:aea6 with SMTP id
 l37-20020a05600c1d2500b004083eaaaea6mr69227wms.7.1697750449130; 
 Thu, 19 Oct 2023 14:20:49 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c450600b0040535648639sm515316wmo.36.2023.10.19.14.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 23/46] hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before
 accessing it
Date: Thu, 19 Oct 2023 23:17:48 +0200
Message-ID: <20231019211814.30576-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qbus_new() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231019131647.19690-2-philmd@linaro.org>
---
 hw/ppc/spapr_vio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 9d4fec2c04..f8ef2b6fa8 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -574,13 +574,14 @@ SpaprVioBus *spapr_vio_bus_init(void)
 
     /* Create bridge device */
     dev = qdev_new(TYPE_SPAPR_VIO_BRIDGE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     qbus = qbus_new(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
     bus = SPAPR_VIO_BUS(qbus);
     bus->next_reg = SPAPR_VIO_REG_BASE;
 
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     /* hcall-vio */
     spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
 
-- 
2.41.0


