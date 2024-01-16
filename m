Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C982F12E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:15:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7N-0006ha-55; Tue, 16 Jan 2024 10:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7K-0006g1-7d
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7G-0005rv-TS
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e86a9fbd9so3524555e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417957; x=1706022757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=klstX9rwm3US7BwgKsjrY2dDzwCKawA+SeWa7QsXZAk=;
 b=cahlQxQFxC1k6+elzFEia58H+e91jBEjWwhwwq/qScCK3LOTGnxWFjDKLSwj1U+0Wk
 /+23TFo0MN0/fb14WO+TP+LvIcMrgHjt50qCuEQRTZaOA7yvkW/XjvtCGHWWJzia3a8u
 JRb9WJJaj7SDrGq6xa1fF+rL1NwwyxMDk0tz+Ufu7q+r2MkaJ7QnrPO8Z0/QzycFwXo8
 JdQbnjDFcqcE7qriQc0RmVovswcHoJksMybN6Iw9LGkXKMmKzynCf3bsMIoUwb22lLr9
 3ex+LGvM6sYVrLZ/Pnz7uJPiJfKP1ixtJYSS+0+kg4taxDzQXAUq1IA3Hfg/4AFnLZ9j
 ApKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417957; x=1706022757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klstX9rwm3US7BwgKsjrY2dDzwCKawA+SeWa7QsXZAk=;
 b=UFNziL7IU83L3DACgTHQg/8PKlxyyZX4SUlQgTVPvDWMIwbT/hqnaByAbUJC0LGSqM
 VKdmgRPs1b1q1SlC8t0OKYhgMM6Wfsp3GWVog8BmbW2z/w9Z+9WmJRazLKQ7fIpXqsOq
 GgaXCosl4W3HYsYqcH4THlszvFVt1tFW327zL281WyjmPAxwLeWsrByz6dTP1duUQNsr
 aVaSp+99r6eeA0Vj8FmuLcC45yUiDNJHHbt/0IVwcJbfhZ/i1rwrjJt1lRUkmbA1lfH3
 mmOo4QEte9dDldTzssHqQBK+82ALKVW170vTy2zcvOdOwBpJ/LVxevDg6BB0w0owGdVD
 uzdQ==
X-Gm-Message-State: AOJu0YyqvJemIvhBDv5NiUeR8Mdrc1ZTjkB0CWnQLj5HJxer6ixPPKex
 bSz7OoBqt7ZaFhQFZqJSlnQ/aE2bmTfk/A48JwW1Hri/XqI=
X-Google-Smtp-Source: AGHT+IGr2ITE6pvGXWMPd7CNQT7qliqNHGLWBmdSCNlMxG81Qx5ZpunjyY0VRrzh5lVuKobSBIKoNQ==
X-Received: by 2002:a05:600c:1396:b0:40e:3d82:2394 with SMTP id
 u22-20020a05600c139600b0040e3d822394mr3513432wmf.19.1705417957388; 
 Tue, 16 Jan 2024 07:12:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] hw/timer: fix systick trace message
Date: Tue, 16 Jan 2024 15:12:26 +0000
Message-Id: <20240116151228.2430754-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Samuel Tardieu <sam@rfc1149.net>

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20240109184508.3189599-1-sam@rfc1149.net
Fixes: ff68dacbc786 ("armv7m: Split systick out from NVIC")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 3eccef83858..8145e18e3da 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -35,7 +35,7 @@ aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From 0x%" PRI
 
 # armv7m_systick.c
 systick_reload(void) "systick reload"
-systick_timer_tick(void) "systick reload"
+systick_timer_tick(void) "systick tick"
 systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 
-- 
2.34.1


