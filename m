Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FAE832904
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBz-0007fo-Tu; Fri, 19 Jan 2024 06:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBx-0007dM-V0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBv-00039Y-LN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:45 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-339208f5105so415971f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664262; x=1706269062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/Q3pfm39hWlzYJ6LfMyGawyaAzdsP1AW7mdF4S9bfM=;
 b=tgU6DI2R7DAufztizGNRFOpv2bR9xY1LfcIVKjlQwgkykRVT7kz3H13UIoi0IUev6o
 jqiFwliRmxSOu6OOQNuckiwda+IJGaGYy8tNcHHXLuCVqRM499NjZW4hz8a/ms4OUea0
 Qo5CwBN26PGbff4MtchTwFcqogmOHl1pDp7OVTV+Xg4Vf1K9kk95AfYbBgeYezsTiWR2
 +D6e79dfdJmzT7e0F2LShd2xMystgWAHM3rYsc4+zvjNJQ5QZ6zZdonSuHWr1CstML9j
 g8WNsx/UoYr4JY3YjJDflYKLmoMSHskHQCOOstbYdqLBHv2Y50whhdFgRanXcBeM6Lgn
 BcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664262; x=1706269062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/Q3pfm39hWlzYJ6LfMyGawyaAzdsP1AW7mdF4S9bfM=;
 b=VaEug4Zcm/xCi1nl6JiXZDrX2J7UkxKitH1g5J69sXBahuv59XEtYgrRXbO1Fwkiqp
 aBltUkPvWiUrTsy4USLtsW0YKsVcq/E5CMfBbJYbIIzgxWLx76jlNKpooZel65NVBqO1
 lUAxpdCEWVD+BQUBugaJwZYzNiNBbD6+nyx3GmdJCdGEsbx8sc7evI7XPZUXt7y3JF8D
 sQRozGAP33dHg9Il71VodFNWFEp3d0FV5NOV+LKhgZmDmagL2S2g1o9ys16zqFAn7B0c
 KC9jpjRTWseInLUurdkjQtjRDkLsBReil8LKfKlOWEc3AoG4hF686Z9neYGSGmCtAOQV
 vcGQ==
X-Gm-Message-State: AOJu0YwcCY/UbVL96gLF2OZnkxmSxxkWT/BpVARPCTHVU8/VHTi5xrgk
 WpQKFSsiJaBNSrnkAQAtO2YLcrBrY6HIiYau/RwqdzLgRam8Fv8yyZBOHZN2zUM+qEBzEhcy5U5
 RSPeyWw==
X-Google-Smtp-Source: AGHT+IEEDqWvYX1nqTzLbVpL34nk3+pfkofKdechFHai8eCCDyydj5pmMYWLBGlQpbML93VJ0YF90Q==
X-Received: by 2002:adf:b319:0:b0:337:61eb:2880 with SMTP id
 j25-20020adfb319000000b0033761eb2880mr884157wrd.88.1705664261827; 
 Fri, 19 Jan 2024 03:37:41 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 n7-20020adff087000000b00337bb0f370dsm6313156wro.40.2024.01.19.03.37.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/36] MAINTAINERS: Update Raphael Norwitz email
Date: Fri, 19 Jan 2024 12:35:03 +0100
Message-ID: <20240119113507.31951-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

I will be leaving Nutanix so updating my email in MAINTAINERS to my
personal email for now.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240111192846.111699-1-raphael.norwitz@nutanix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8ca270c4..760acdea66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2555,7 +2555,7 @@ F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
 
 vhost-user-blk
-M: Raphael Norwitz <raphael.norwitz@nutanix.com>
+M: Raphael Norwitz <raphael.s.norwitz@gmail.com>
 S: Maintained
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
-- 
2.41.0


