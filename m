Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEC7B5557
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK5D-0004Bi-Hz; Mon, 02 Oct 2023 10:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK5A-000493-0D
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4y-0000Xl-6f
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so137110545e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696257562; x=1696862362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThqHVCoODVLmBGg+zWINkZtXAF1PafSxS7H+BvfEo28=;
 b=cI5nUXI/rJMlwKj9/JSxDJzBL2eUxECbF4yHQ/SUtgNWIN9vVpCLGxz2vEb5Se8Tzg
 yDmEevNvPx/slTW2XUi4hkCM78DZwlqdZet/+/OSIg1wSOpVgVnZz0Jprc3dyCL+aO3e
 LfBZVRy9jAnDl/ilOQLbgAFNai2rXiWUOJlVz3sU8QCMNNqKTv28hbtpE6ROjTiINcks
 p23QvBNGGSt/N7nTYKo08LobVr6P4k/GrdQvMlqzkYRQtKZv2sl/KUv9W4uk22mrVd3Q
 tPZCnFiskROFdu1ToLdGUdrjASoOJGknJ4RzqIlquhjMuL4jZ6jFZSRmBN1JgHuk6ZIe
 wXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257562; x=1696862362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThqHVCoODVLmBGg+zWINkZtXAF1PafSxS7H+BvfEo28=;
 b=cr/HHFeghrcBhpDyKsOsN+44socntDla1FrwyuiZvjx+USjTcC9M5cMkZG5jqMfEdV
 DDJ02LJ2X5SsU+P5GxS2YoUZY+2mLywwCxdDODmfmK8OJEDVpTeokner3XGMdQ4iYqg2
 ri/TTgI0St2N6hzNlsJKOLtfBSss5viPSzW6CMyueNUBO1TsUvFqCsaDfjSPKzUuho6K
 3VYYSfJhN8DM8D58mNMbE0jHpIPp9TCzMfjHPVMXuu5E0ZJ8Qns7TnKj3PMaDaSg961U
 KPid987CFHzCtV1z025ZhM7oPjWDJThmyP9UIknUlAxenozb0PrLvQ7PUQgjCTMKNFDE
 r5HA==
X-Gm-Message-State: AOJu0YzdInDO07rmZK7B3aGcmFOs5AQcOWpz5GDt4a1LBwaJRsf+FXu0
 Em8G/zNRZaw+V+O7bFziHqqjCzeRSS+R4rXJNdWwrg==
X-Google-Smtp-Source: AGHT+IEsJpL3vRkZUj+Vut3HSFliNV61LQ2sWC4XuINGwZClwK18oOLPInPUOFS4igKoEoRDvyv8Lw==
X-Received: by 2002:a05:600c:28c:b0:401:519:d2 with SMTP id
 12-20020a05600c028c00b00401051900d2mr9381438wmk.23.1696257562112; 
 Mon, 02 Oct 2023 07:39:22 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 n20-20020a1c7214000000b003fee567235bsm7416660wmc.1.2023.10.02.07.39.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/ppc/spapr: Rename 'softmmu' -> 'tcg'
Date: Mon,  2 Oct 2023 16:38:54 +0200
Message-ID: <20231002143855.50978-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002143855.50978-1-philmd@linaro.org>
References: <20231002143855.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

spapr_softmmu.c isn't related to having a soft MMU, but having
the TCG accelerator. Rename it using the 'tcg' suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/{spapr_softmmu.c => spapr_tcg.c} | 0
 hw/ppc/meson.build                      | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_tcg.c} (100%)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_tcg.c
similarity index 100%
rename from hw/ppc/spapr_softmmu.c
rename to hw/ppc/spapr_tcg.c
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..281100a58d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'pef.c',
 ))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
-  'spapr_softmmu.c',
+  'spapr_tcg.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
-- 
2.41.0


