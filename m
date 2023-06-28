Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D977415EF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXXH-0003eM-5f; Wed, 28 Jun 2023 11:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWU-0002ov-GS
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWO-0001rK-Mw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso390235e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967755; x=1690559755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS9p0CO5xuXT5CmTtX8By8EJcaMyoP638DTVL9KLDbs=;
 b=IOiHK7OjveeptVVVCASlvxA6zQi77wf/srMfTGPyknWY5WCoj3A5DxwWS9UjA6E6x1
 HwKGYR6viVhdvfWfnRsu1ZdF3T8zLdiz37EUAYb54pg5rREhUCEst2a//oHFHzzHM6E8
 iR2d/mO8x//fbfgEu8/SgzrVnpesXUiLKDTPI2MYvl4norwz8WpQhpXXVsLCVOe9Dxhl
 jfMohx5nI5W1KVJmmuWjJFpi9yAaTzAvKwcE6WAAKm+jPrdoB8Jv3xv2uUrrTNbY1+su
 23Ae7sPgeXMQWzdL7Kd3jYO8vRnOIrj7108wlAdtI+s0jpqk99DS46FZ/h5sXgz+6V7u
 0T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967755; x=1690559755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PS9p0CO5xuXT5CmTtX8By8EJcaMyoP638DTVL9KLDbs=;
 b=WKod1YRxCok32xj1IcIdNCclF/WaBrEjXRxW3y1Vv1owQwADv6AIXfy5cmKAWUdJyP
 j4PKTwGRSsxlZmLlYMA3GgSmwZwPtAX1tUxPzDW8lUGj+EHn1rW7g+AA0G8d2SYiBweQ
 u0H/SIhukH8D/pBzyQQ/ULQIiN/3ouW+bMr6Qo7pI7IucaIeL2/R8xDINcERAUoIrLCt
 aNl5uRKnUiEcLPijcTwp1AFXhWd1aT1rdpgyCTW1jmP0+5VJ19a0RyC5fiYSxBayUHyl
 y+eE+mlph02sJDcqBe9sbLEMV3q73HB5EFJss2+PPA1ov9FY1nvXXwMgO2/AjEjbWf3J
 SJVw==
X-Gm-Message-State: AC+VfDwjbDMazTudGnRNleg+Ag+ZoPCqHBUVBiaQXuwJ6Ee2cFMcbO1P
 ojP5iq8krpJaRVC2PIWngncB71CVPJcb2KVZeYY=
X-Google-Smtp-Source: ACHHUZ7y+fNuTAVetRl2osxgYvIdWZL5T8wxKPucEfuwtX+KZA80swCOAMOLVIZrcTm8oeo2TuimrQ==
X-Received: by 2002:a1c:7214:0:b0:3fa:8cd5:b64a with SMTP id
 n20-20020a1c7214000000b003fa8cd5b64amr6950703wmc.0.1687967754916; 
 Wed, 28 Jun 2023 08:55:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a7bc399000000b003fa96fe2bebsm9159019wmj.41.2023.06.28.08.55.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/30] target/i386/WHPX: Fix error message when fail to set
 ProcessorCount
Date: Wed, 28 Jun 2023 17:53:10 +0200
Message-Id: <20230628155313.71594-28-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Zhao Liu <zhao1.liu@intel.com>

003f230e37d7 ("machine: Tweak the order of topology members in struct
CpuTopology") changes the meaning of MachineState.smp.cores from "the
number of cores in one package" to "the number of cores in one die"
and doesn't fix other uses of MachineState.smp.cores. And because of
the introduction of cluster, now smp.cores just means "the number of
cores in one cluster". This clearly does not fit the semantics here.

And before this error message, WHvSetPartitionProperty() is called to
set prop.ProcessorCount.

So the error message should show the prop.ProcessorCount other than
"cores per cluster" or "cores per package".

Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
[PMD: Use '%u' format for ProcessorCount]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9ee04ee650..57580ca383 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2598,8 +2598,8 @@ static int whpx_accel_init(MachineState *ms)
         sizeof(WHV_PARTITION_PROPERTY));
 
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to set partition core count to %d,"
-                     " hr=%08lx", ms->smp.cores, hr);
+        error_report("WHPX: Failed to set partition processor count to %u,"
+                     " hr=%08lx", prop.ProcessorCount, hr);
         ret = -EINVAL;
         goto error;
     }
-- 
2.38.1


