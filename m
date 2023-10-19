Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291787CFAA5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSr5-0000Hp-9o; Thu, 19 Oct 2023 09:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSpz-0007GG-LB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:23 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSpx-0002SR-8K
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:19 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so100502601fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721195; x=1698325995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v7QjsFI/UQ66aMELorogiH5Qo/GKGcFOriZN36zvBM=;
 b=nRu+Gnd/gciYPITH+dTK5fS+368XivaJf6t7hGwXTq+NBfbzy+hFDVfHZx2v8CMdFf
 fNezw5ed0lZqiY8F8pIV7iwb9XGbqI+fiBNm4ubokNys44ffExuRnfAYE9l8q6TsQYog
 FsQYR1Eq3byBDDwzdZFYaIbnCo31YdmjIn/ZoE9xkxad4in2P7Q+ZQRNKM+HwpOIsYU/
 eyIqYqZVyuUPIQbsEamfzG8Lp6N8Y158Yyf9YWOdpfvPwY1/4LeRa7FcnBjCx4yp1daH
 sex32oWkijOhlJe+WbRrd4gxT63ff27JhR1ihluaTwXuSqjNb98+qjFyzZhRzl/W3fYS
 55Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721195; x=1698325995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8v7QjsFI/UQ66aMELorogiH5Qo/GKGcFOriZN36zvBM=;
 b=pqa/iQv7bhlDacvq4YpVOT9Efv4WNINy0MnZ63KrwA6z669Jd0AcokGN5uk+0cwGjx
 iXQIm5t+MzQNnIbGLZ/eF11zbJrS+Hf79155ULjVSoLRMRbmmO9ZzfBqcA7Ft7kAIZmL
 UfK6iMcL2zD4PptzrMUra6MIhdiyR9iyECbSDSSLUbHV35ECSei4la3lHn2/Y1N4/XGj
 6vVME3QnAthLVH6/x4IH7+P+4XSbbQu9j5JaUAGUIy17pVWZouZQIE+rzrZw4F6SHtvy
 0l8ydeys/TwpVdXoq3yb6HS/kdD51cWGvDZ1BzDCAJOpzDtBgva4VG56VfdYuWxSqoTM
 gdIA==
X-Gm-Message-State: AOJu0YyIn84KuWILsIBOt/kPD0inT+giLfiZW8HzU2lutk9B+HJVEGL4
 RYSctSyz7eCJBvw7jX5FVhtiemVbvlXjN9C87TpAQA==
X-Google-Smtp-Source: AGHT+IFQcUojotVsITG3itR50XEFMK3MdBByNnXjQ2UtV/GN+El1hYU+5HLsAxqlQwO/RjEg3ish0Q==
X-Received: by 2002:a2e:9b0a:0:b0:2c4:feef:852 with SMTP id
 u10-20020a2e9b0a000000b002c4feef0852mr1254865lji.32.1697721194948; 
 Thu, 19 Oct 2023 06:13:14 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b00405d9a950a2sm4335932wml.28.2023.10.19.06.13.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device
 before accessing it
Date: Thu, 19 Oct 2023 15:12:59 +0200
Message-ID: <20231019131305.19157-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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


