Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E67A331A8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 22:37:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKN4-0003u6-LA; Wed, 12 Feb 2025 16:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMu-0003kf-1E
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMs-0000YC-E1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f22fe8762so71242f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396040; x=1740000840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGz7ndjNtFhvcqsdb3cBe+6raTEmZAEhsP/1+wNKBtU=;
 b=zM4mqLMk2RzXVtrvZXcEi4UDQF5PXyH+YTJzFcIS0cErE66Y5Gz9pdKnBwHyqoM7KB
 +P9JajUirNFKTDmG071Aw/s4NCHeNaMhRAUC3YNbMSo8Mc6qg/ASMfPRkIlEzgVFFjGH
 8UTlAKBAUHZhjQ6iA9jf1SvYTt16xAhvyFU2GTffkYcIHF6a/2vfyP2aZQjq9Iem5C6C
 d0woltJT8f+FEWZjlpF6S6yEz1TxxoFd2yOMbCTVcQx2OwOvVSV1j6scp8it9wtn5FWR
 JWNUjIiyEzK+nsFg3gQhtSNMpaLFARvbKYNYC+BKNkPEZlzU31Sy1KtSesmGt1qsp7oB
 b07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396040; x=1740000840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGz7ndjNtFhvcqsdb3cBe+6raTEmZAEhsP/1+wNKBtU=;
 b=UOZo2AeWjWsC+X727+4M5ZgYX1nQZsY/2DRv9k88s0q/QOjmhpobQ9Wpkr0oO80lB8
 yZYAdPjNpjcxW5hLvrjfti06YPcsN2NG8K+ecwmq4o5Rit+g1u1bantOHzb03wTpmSSf
 4Gmt/zG5kEZT0ceUscLrtAP3UnILwNO6lJA0w63iG0gtgQZVyJgk3W/TuqkrTPYBNLbm
 W5m0KZin1Kxblb6UnLUggytXlMwgXQAyWB8I0YLVLdd9rZXVGfDp1Ep3uPkfyxG+jMl6
 0kKXTvybXNP5VHHbprmUNb1YNPTkkUbJ8hjie0Twzgc4Ru4SsExznXtlO686U4kp28Gv
 nnCw==
X-Gm-Message-State: AOJu0Yywp06oVtu1LhIeyRLNi49DHo5KUs0cUl8+b5hF5p8CX+mHkETf
 gG3AferWEDY6aZbKilWO7znjDFmiN6fquqp/T95vJ4KlcFuybKmCcLsrL4NEq1qDNdmYRm2CQlt
 EEBA=
X-Gm-Gg: ASbGncuFNJrYZaf3aWEnOPBR1UItPX9Oot8XDePCZC62H5ZRHCCEJOBLNVHgUdGfVXy
 ehaqAeEMmgqWGbMLpCZrMH2TZ+i8lBIrbPebEDS6KhcJv8sHPhu6IZ6HGC2EAn4het9qGXd8c6u
 hXbSPOeoWdt9bUuCa+4uDhqtAKNlmKauxsWlAltUQFn6UMrrQr1XLeXeg3bWSgz38umfiOkZdOZ
 XFaI7nlkImmc5+JZ9SGIWYk+jtCwpDWUNWt8jNEILUUqoNOLPHns0x/uFPFPJmtGJUWnhyRzoAY
 k9jHhupSi8LOp5WlRNtDI5WIg6IMs5aX+bBflBlKT0vpiizr+xd5/f7uhM9JklFirA==
X-Google-Smtp-Source: AGHT+IGrlqe4ceJGm+2bzwi8vlAOGqHM3iBT8ZOCyRqRvxWveUUtITBxDWg+lqD/zpa/hKW2PMZ6gw==
X-Received: by 2002:a5d:598d:0:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-38dea3c30d5mr4651328f8f.3.1739396040467; 
 Wed, 12 Feb 2025 13:34:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5ee2sm23054f8f.80.2025.02.12.13.33.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/19] hw/virtio/virtio-pci: Assert before registering QOM
 types
Date: Wed, 12 Feb 2025 22:32:43 +0100
Message-ID: <20250212213249.45574-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 15383570c91..ad1d164421d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2496,6 +2496,9 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         },
     };
 
+    assert(t->base_name || !t->non_transitional_name);
+    assert(t->base_name || !t->transitional_name);
+
     if (!base_type_info.name) {
         base_type_info.name = base_name;
         base_type_info.class_init = virtio_pci_generic_class_init;
@@ -2503,9 +2506,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         generic_type_info.parent = base_name;
         generic_type_info.class_init = virtio_pci_base_class_init;
         generic_type_info.class_data = t;
-
-        assert(!t->non_transitional_name);
-        assert(!t->transitional_name);
     } else {
         base_type_info.class_init = virtio_pci_base_class_init;
         base_type_info.class_data = t;
-- 
2.47.1


