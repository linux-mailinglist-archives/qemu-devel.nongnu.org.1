Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831B7C54EE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYYo-0006kk-NX; Wed, 11 Oct 2023 08:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYe-0006XH-VV
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYc-0003EB-4b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so62662125e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697028200; x=1697633000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Z09Y/GItrb7H2jZdZdkzhC3ro+JpWcdXOXIpSdTNVM=;
 b=CmeSpSxdi2RmpGz8icU5jf+A4ga8rvgj9E/+6nVVZIiN6Mr8Ow+NDXGxgOLST0IBye
 LppMzujWEtx3HFkVvUoUk2tXuOoCaApBD8vzIigVwmzvO8p8mCuQT0yHNQ01eKjgypuQ
 o3H8QCMmPXml8QgmgFFTq2L4pAuYBNpXX8bIww505PQJos2HaWRvik7x/2uViM07cNO7
 jpaRasedWEFNAAKBZHgks9S5nUfFOwZsgt4bJTH0rCeah67NJvFsZUSwwq9ShD+Q6ERa
 /VRniHJ5ThYp8rAZYaLbsd2rQAq0NtJReSqmAib098zhQ/s0KM4NjgCDd6EnbbtLlmN4
 U4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028200; x=1697633000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Z09Y/GItrb7H2jZdZdkzhC3ro+JpWcdXOXIpSdTNVM=;
 b=Bdsm+FnZwRe2Qcf8mLr2+HTgagsWQQDMCSZMYEgCukX2H7dU45bKi7L6fd6q/VH5Uj
 XBWu+eptLPBhLr/BkkW5WrxnTD+LML8Pcy6mMxXrz+DdJ9evjpFlrXnlTAA6Qzws8gBc
 2zyrCsW7Pe9ZEWrN0PktB0FG2mtBgT9hv2DwowCA0i8ejotOER+7aN6rZxoPzm+dxIjn
 JXS6sg9rh2Ir8BQi4uPKbnKGX1OZSGZZbbZKILUguABww5XLq3IOyasjgdNurv07R/6i
 fiUTIG2NdHOolCJwgr25sz/xpTBzhyMFgi1sqfcGKQvyjzhzvAteo7R663yb1rYaDmx1
 da4g==
X-Gm-Message-State: AOJu0YxQ+mRkF5iiYNDE10ZST2KNhnHckGBmO75eT1R8ZHfNk6gsdE/i
 tdeNhJFfnkuTtjBTQ5kbr6vysQyAYEitJ22lPJQ=
X-Google-Smtp-Source: AGHT+IHyTnE+WOPvji+WV9nu5spSZEShZWaJoCy6oYaRnb4nUeRtPSPyFhO1vNAr/ifF3L9qICFtCA==
X-Received: by 2002:a05:600c:1caa:b0:407:5b54:bb15 with SMTP id
 k42-20020a05600c1caa00b004075b54bb15mr2822159wms.36.1697028200565; 
 Wed, 11 Oct 2023 05:43:20 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c228a00b004065d72ab19sm19181749wmf.0.2023.10.11.05.43.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 05:43:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] MAINTAINERS: Cover hw/ppc/ppc440_uc.c with Sam460ex board
Date: Wed, 11 Oct 2023 14:43:11 +0200
Message-ID: <20231011124312.60476-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011124312.60476-1-philmd@linaro.org>
References: <20231011124312.60476-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

hw/ppc/ppc440_uc.c implements the TYPE_PPC460EX_PCIE_HOST
device, which is used by the aCube Sam460ex board.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e7dec4a58..8c07d07927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1482,6 +1482,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/sam460ex.c
+F: hw/ppc/ppc440_uc.c
 F: hw/ppc/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
-- 
2.41.0


