Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AA81909D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX6-000217-TG; Tue, 19 Dec 2023 14:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001za-2a
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWr-0001oh-2P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:31 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3363aa2bbfbso5259615f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013199; x=1703617999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tjJ6DjjrNF4YS1GYLScIKt9PiPvca+RdqzW7lzNYdLU=;
 b=OIjeD+r8jmF9L7fbhsJ/zED7werStbAuMnbBmWyPe6Kz+DYfuqQuL1bMGxSl3C2hwf
 HhpnHiZO/myejB7hUvxsr4tiILsd+Cd21fjq6LMtILCqKwl3erp+i+psjney5M3bIYTE
 QLlezaoyz7RTFaVVBR6+4cr/fjKd0+8ax+eDIuYCkQqGimhZDrIL3rzmFBHhko7gRk1q
 EdAxSO381ZkJ5KGLs/tUEyr3YiPwgBHGPlosoW6wcqO42NM3vpniz3buGs2Jn7q8w9kH
 4LcfEfatEBzSpf2ytQuBjDzmHe1eR8sKUTPTcn/QaJthn2Czh2XojrtyU3LbKUxwLRiX
 zWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013199; x=1703617999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjJ6DjjrNF4YS1GYLScIKt9PiPvca+RdqzW7lzNYdLU=;
 b=Y0L4lrr994AELemAJqvttTMrpj46UcFClc58al9lnuBTi7PyAEtGHcZ2sOTNT5BlTC
 cfQ16obrp3sKTog8PiWvnNGxu5UOGEksi2W4rgiB3Fq/ODZRHtXU0t7pxk5r4DzCCmpL
 GOpygImZxR0b9tiJEi7nvTjEchwp357EGQLdElgw31hxIUA7hkxL4lsqaxDuo++1vH/D
 M9uvjDFLRPhdIg5/k2o95EpEu8hL7wm23cpnf0+qu+XKqcA8ZefwOSS9c+e4wUtbhEWu
 oaNVTxbecxeDHW4ydVIz66OGs8zY6Tdgak71PxRy2mkK2hB/mmYG8rWpzZCmveAEfQ1r
 A5Og==
X-Gm-Message-State: AOJu0YycNsLsdcv02SE+lIX9v6c7rZaKUZ1EFXse3VaWyP2dX+VS8dZ7
 6cZY0EJn0JkgJyBx+yNFUe9YosDqE7UjkRXyfMs=
X-Google-Smtp-Source: AGHT+IHMOLTAVif2uLukeNHAaXtLrW7Z8wG1OP/Ky4tO20K3BerZ3YZw48sqSzIo0ds3FIbncwLIBg==
X-Received: by 2002:a5d:5551:0:b0:336:7142:8c30 with SMTP id
 g17-20020a5d5551000000b0033671428c30mr941263wrw.123.1703013199593; 
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] hw/intc/arm_gicv3: Include missing 'qemu/error-report.h'
 header
Date: Tue, 19 Dec 2023 19:12:46 +0000
Message-Id: <20231219191307.2895919-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

kvm_arm_its_reset_hold() calls warn_report(), itself declared
in "qemu/error-report.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index f7df602cfff..3befc960db2 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/runstate.h"
-- 
2.34.1


