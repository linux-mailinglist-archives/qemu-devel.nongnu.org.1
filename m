Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A37371EF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBePT-0003bt-Lb; Tue, 20 Jun 2023 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePQ-0003b6-3p
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:48 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePO-0002FK-3d
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:47 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-988883b0d8fso425602166b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279244; x=1689871244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=GNi65gj3w+SRZytRPU7VtzNHGTOvuVdXN9gT6YJwwhiuFmLt1IypZEKcQ9Jf5gW8/W
 YPExz1HbyPXU0zUr2L3x0+NsZSkOWb1DhQPhAGDGTgriqV2JMSrFBkFvL+eKcEnubzCs
 owlNx9m4l5/0C+lrvfl+eK0x8Js5eKqi6Hzdsldf17PWQed3ORbHVKMLa8X5htt2N69T
 /FN8HbgqHhHiXdpuKGEQ4Fwg+tAjLknkuTsvvf10bkoD8MCCxxFllKIFIyQ/ZylEhOix
 xm8akhf0tyVQ7p7tEXV8f3Um8FltkRkqQDPGGaNuO6bCSjdw/BvegJyNm5pEm15i7/5N
 5D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279244; x=1689871244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=g/6wTm1xRpwupHvWWaL9ucfWS8RChRJYnMTzyrxCJAFe6U2NhAf2Htxqfa74mST584
 f/GS0RV0KHKUG1aGFk1NG/EUO9JiPuXpU1mDTQkjhILJBsKRGVdMty6nzuIFp0Doxf+S
 j+IMJ1h/eXVunMOLt8c/qDfZM/25/mL/y3XVs0IzTTOSUYBX45Tu04iqpvR022sBuAm/
 b/Qbr/BDtvEalVuKarac8ddo6zSpX259Rytrpy4Q1HXaiJFj2GhR10f24FBuksh8votV
 HWHnBCzLQYlgzvcNGfNu95oKCtQyAhOPZPub0YmBwPHPcVYiTnATRwRoA73c23bHqJop
 7ZUA==
X-Gm-Message-State: AC+VfDze5kqg2yxp/dnE/vyI6jxTfb8kshHI+q/e+clF0/bQ2vH+Hcz8
 IyUDhxIY7lBnD2Avn427O9Q1ZVbYH1+K8E9NwuFkTcYX
X-Google-Smtp-Source: ACHHUZ7IblhLpMF1Yp4ubZcM6cuV/6lKj4ML6IJxTYuzNtGVF4vv10UTqRflo2v9JiQcHuWgi1oFLA==
X-Received: by 2002:a17:907:3f18:b0:97d:ee91:df83 with SMTP id
 hq24-20020a1709073f1800b0097dee91df83mr14140775ejc.61.1687279244572; 
 Tue, 20 Jun 2023 09:40:44 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm1685589ejb.126.2023.06.20.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 09:40:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 2/2] configs: Enable MTTCG for sparc, sparc64
Date: Tue, 20 Jun 2023 18:40:40 +0200
Message-Id: <20230620164040.912490-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620164040.912490-1-richard.henderson@linaro.org>
References: <20230620164040.912490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

This will be of small comfort to sparc64, because both
sun4u and sun4v board models force max_cpus = 1.
But it does enable actual smp for sparc32 sun4m.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/sparc-softmmu.mak   | 1 +
 configs/targets/sparc64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 454eb35499..a5d9200382 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d3f8a3b710..36ca64ec41 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
-- 
2.34.1


