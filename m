Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1B8251D8
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNl-0007nw-CA; Fri, 05 Jan 2024 05:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNj-0007nG-3Y
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNh-0004ND-LR
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0c4dso14407035e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450287; x=1705055087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETwtqX8xX2jjy7kY2kGndiyjXuP9S4VMULkepuavFeo=;
 b=WOtI+5mY+eiTlbGqZ522QHD24P/JsL/X8wO4nH0ArdeiIgiKGMtTFsKx1S2JRDWq+q
 Ob7kgzgVKYlU7ualxPFKo5n4vfj+lud1wSmTLlhwga9tPrcyxqwYMgMm++SmJAnbbGpS
 GT1SUHRtONhrP30OfRG65/lOKt7RIadZ5BxYdZQIiQGIwM2e7B40HpA93xAgkT7MYPE6
 dELluO3+ZDQAYxPMaIl+dC2uMmwZF98K+pMN5saDfv4MuADfJd0rzJ5heg5RRrdCUrHW
 caOyCKr8jLajlitHbBnemLwxWr/G7P3rIdbpFrlWwV0RFzcYlJpaDCg/lCkuE00Kh1zr
 55TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450287; x=1705055087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETwtqX8xX2jjy7kY2kGndiyjXuP9S4VMULkepuavFeo=;
 b=FWpfgoUUBDWBFFlMJwADS9iNl+YT+g2zNgUY0WNUOuEB7nX260vurqCLfAbMMGuk9G
 G/wyNDKRu0foSaEoD+v8VspuNecW/SOpTl/XseyUDr6abtMR4KXjFzpswmE2TsD4HWxX
 09qV+Q3JQolyGLa7VwbOF1QmG/XqCzUkWzgsrqziotFLzwwP7464an30yGawXrg/I1e6
 BjBje/umJQxHdnHElDr3/hMkY+MlR4VHOwc6er/T7qs/OnfV6EgTlEcG+OH8yeY4A0GV
 XE5uy8zSjp3wYKEMsv/8vXVlIZrbbUli518pSogQxqVqO+R5TSlgJkiU9y7m3UDQFhsr
 EK0w==
X-Gm-Message-State: AOJu0Yz3sbKfzCDRDIZMwWYMDn+s5T56YU64x4e5sndZmj/3lXGF3Kzx
 5kFce8bz5kb09IWGvK5qtz6bH3lE3saU7wevCknjm6k7eQ==
X-Google-Smtp-Source: AGHT+IGzDgN7CMWCWTOmAOjpI3xWG7OPOx4FYUNOntWa/Yu3u6xjC6JPIxzbvkhxVjz8CmeeEzNusg==
X-Received: by 2002:a05:600c:331a:b0:40d:5c44:a9d with SMTP id
 q26-20020a05600c331a00b0040d5c440a9dmr1146481wmp.161.1704450287762; 
 Fri, 05 Jan 2024 02:24:47 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:47 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Fabien Chouteau <chouteau@adaocore.com>
Subject: [PATCH 9/9] MAINTAINERS: replace Fabien by myself as Leon3 maintainer
Date: Fri,  5 Jan 2024 11:24:21 +0100
Message-Id: <20240105102421.163554-10-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32c.google.com
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

CC: Fabien Chouteau <chouteau@adaocore.com>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 395f26ba86..a065e0b21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1694,7 +1694,7 @@ F: hw/rtc/sun4v-rtc.c
 F: include/hw/rtc/sun4v-rtc.h
 
 Leon3
-M: Fabien Chouteau <chouteau@adacore.com>
+M: Clément Chigot <chigot@adacore.com>
 M: Frederic Konrad <konrad.frederic@yahoo.fr>
 S: Maintained
 F: hw/sparc/leon3.c
-- 
2.25.1


