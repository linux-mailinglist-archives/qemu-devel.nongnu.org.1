Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A43557EB28A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZN-0003be-BF; Tue, 14 Nov 2023 09:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZL-0003ZB-AD
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:11 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZI-0007pk-GY
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:11 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d2e7726d5bso856318066b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972747; x=1700577547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oo2mmHUNt8cswMDm2G2tk7NYG50Leech1RMDbe0XTgw=;
 b=zVMaj7I1L8G7J7EGcjNGtskc7ZlTuwUP8UlN3WDOeA98on4dzg9QaqOOpd1tleuASs
 9mPpAxKq6DJnCzYyOyKFFfgwJ8EJZ+ozm3TxVfl0czN6dRBq78Yq0GSNmchOKIM/zPQ7
 wFf5LGJAXnEWBhf3Wt4CFMVy0bafDLvhC6/nRY9AXuKWm27yMlvJyJU1+0beXBKkgWoR
 tHF1UBxYezyffRtafzpiLlwKWUK+HyOe/ZQ9+AGECfygO+DdTlfmzF+BGkOmEKlBznC5
 JK2NcutWe7fVfGTivOtWyKh9THbuyJwbE4zUPoPmvwYXV8jk6W93YleXkvgc4P5KYt+H
 n6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972747; x=1700577547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oo2mmHUNt8cswMDm2G2tk7NYG50Leech1RMDbe0XTgw=;
 b=EOucd0b0eSMd5yYey4XhG1I5I4Ta0yk6Ow938VFPOCE9gWbZAn7gRtdqtkbg3NYI5X
 uuiMFyDnHXD2Lp18AdV+B0IKqhsz8YdM0UmvjAE7rSQEhtjO5V4cgvxP36yWMbOjnhyM
 sD+fYOHJBISD3KtbrKYQV08YikvZiUg1Dtku6C6YBs2+DtDiFPRCxk7gwuBixISE4GtD
 yHq3TsGUM+Od8IjIrg7zRadBl/yOccPfH2m7ZX7PHOO9FnU3VMriVj8bsG27ZL/9JatI
 5aQkpLLyS84jIVcYYVdqJ5cQ3mtjre2wLQ1IlWsIOOLZYOs7INp4zK8RxykF4+6VdskG
 Eimg==
X-Gm-Message-State: AOJu0YzjpaHeS+3aLOsA+fpiGvDz+sySQE0pgT82j9J6hJ/ufQkduRqj
 jyyopB9euSJKrXmq+02lzMqDnw==
X-Google-Smtp-Source: AGHT+IFJHEre72B5jboKAaroDeSDmy2A+msHyepV3IUCtazYitevtMIyD1yfonucyI3qP3HjOGn0kg==
X-Received: by 2002:a17:906:45a:b0:9c7:56ee:b6e5 with SMTP id
 e26-20020a170906045a00b009c756eeb6e5mr6778901eja.40.1699972747032; 
 Tue, 14 Nov 2023 06:39:07 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 m13-20020a170906234d00b00997e00e78e6sm5591697eja.112.2023.11.14.06.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 07/19] hw/xen: Remove unnecessary
 xen_hvm_inject_msi() stub
Date: Tue, 14 Nov 2023 15:38:03 +0100
Message-ID: <20231114143816.71079-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since commit 04b0de0ee8 ("xen: factor out common functions")
xen_hvm_inject_msi() stub is not required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/xen-hw-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 7d7ffe83a9..6cf0e9a4c1 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -24,10 +24,6 @@ int xen_set_pci_link_route(uint8_t link, uint8_t irq)
     return -1;
 }
 
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-}
-
 int xen_is_pirq_msi(uint32_t msi_data)
 {
     return 0;
-- 
2.41.0


