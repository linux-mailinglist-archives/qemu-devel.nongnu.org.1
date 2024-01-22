Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A5836591
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:36:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvOt-0006Oe-Tc; Mon, 22 Jan 2024 09:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOq-0006Jz-Ik
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOo-0003Zx-7p
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so32334255e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705934139; x=1706538939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HadLfbJuSKfaEASuWIUz+ZfyQlTV96EslnoD7jrTY6E=;
 b=HxsqXuKweKsYaHaDAz4XkvvA2zPQGsjvqKOQZDLEOQ0cWKIgx90VpFsRxQPoH6L2Qy
 b1GwXvm6tZH2e4Fgq0gUKHejFeJ9kM7SrjPYHV1grBEZW0g/fIa4mFLaCzew/FwDbjwT
 vmxFpVQYRb7IdEgIIe5F7ADoZdMNx3QAxhh7cRiw8juxpsLHzRVCChCZKPWh+RPNA0d2
 OFXPeMbQUgRt2go61vy+s5EJ2SDVyHw3SLXHY1F0kDmklyaR3zp6SFyUfEN1x/rQ64ol
 Kkt/nKBtf292c3G9Pm8uN0zjEFXdpdQWD1Ftxp57vSzA70ODU05sB/jSsXDQqID4WGDM
 knlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934139; x=1706538939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HadLfbJuSKfaEASuWIUz+ZfyQlTV96EslnoD7jrTY6E=;
 b=mTAJG9lDnGbZv66MylrKSuup29QdWD155jgiV5eHD/ZNKbyOp6NE897I7xjFTWaS/b
 qD71xyotajinbMpt3ftvNpRWHHsR83hcnX0R8SsCRorPsHBueRbXOoH8kkZN4dHktZmQ
 bRcKqGjtG8moDxBxHeBoEjkFjBfcYgRrXvheR6wzO+NCeNyAenwuKpY+u64V8CyXZaEO
 BFLnUVgIImqDCCvQXO4wJldBJeFzuiENYkcmQt0CH4yxmqF6tIbbAM2A6/uvG6oIMjBk
 ecqpPfSVOn0fq7qnXsbQVKzmP3rQiM9Fa8dYYHfxgbxOiCa/SiRx9+vlpwJDU1nQ0cWp
 mIMw==
X-Gm-Message-State: AOJu0YybwBFHAB1O7f3vyVG3xVYRpGj7Q3ekmrDV4zvtWNlKGbY5tEXr
 jgdaEOrdCipSD95XuqdvCsrMJNwpO/ysW7/9p071RBS41b8Z0+0euMoG7TVbnoF9uHXaeWaztjA
 C
X-Google-Smtp-Source: AGHT+IHyEIEgFSAyQSiCzE3hTE9HCyOiWhtY3InBSDQA652Ml2bO7jLXj9LHN9FzBVN9k9v2VEGEFQ==
X-Received: by 2002:a05:600c:138a:b0:40e:5933:e2c2 with SMTP id
 u10-20020a05600c138a00b0040e5933e2c2mr2818825wmf.19.1705934139433; 
 Mon, 22 Jan 2024 06:35:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm39559584wmb.41.2024.01.22.06.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:35:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 1/3] tests/qtest/bios-tables-test: Allow changes to virt
 GTDT
Date: Mon, 22 Jan 2024 14:35:35 +0000
Message-Id: <20240122143537.233498-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122143537.233498-1-peter.maydell@linaro.org>
References: <20240122143537.233498-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Allow changes to the virt GTDT -- we are going to add the IRQ
entry for a new timer to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..7a6d4f80214 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/FACP",
+"tests/data/acpi/virt/GTDT",
-- 
2.34.1


