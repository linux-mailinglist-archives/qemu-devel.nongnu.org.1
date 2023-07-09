Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0974C70B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAh-0008Qp-D9; Sun, 09 Jul 2023 14:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAc-0008Ol-1W
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAX-0000JC-AU
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso43742245e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927400; x=1691519400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=RqvWPhZswLWUrpEQGmY7oJWN9eiH5da86YPgh1OZXD4H6go/r+/GGnofRVrrE0jHlz
 tYq42UkMFZ9qWTybgSr2PO+8aySdpQNBwaHQZNlKkC/zWJtXvHai85xCVXuqKseh18yp
 T8VYVmF4GbkFruL4+5qcna8QsiUeJqfV72JkocjSbjnC2nUJDx+gPNWY2rqS31l6vFqP
 WvsoQ3C8Qciwlp1DvNPwTNn+z1Ekn1yBlVvpf6mJ+hQjUFVHAX//K3AivhOW1D1AOMBV
 vdHovHt0Jvu8uqAlgNRO4mQsX8FpWXupUmakU3/hPaDf/qbLndWIUmSQdixYhLzuhNP3
 RiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927400; x=1691519400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=D/XdSSdOoWsHepmKn/gI5FiYswavKlLdf7sTW1Ze2k6MI8dQkKxX6NoZxKENL3RmSS
 jMVnNug7e6IhrAmMkFhefOeBMezihnb0N5vm3YrzP5pFE8oKiJ1yB+YRrXJJnMKTXMkq
 Ib0OhAHca3zxkPlPnJyQ1qCCg0Yy8vvwoywngP9G+l8DxNfXSYndSkuHoH9yZkIn75Hb
 cnDpkr4q0EIxHqWAsTiWSjPthNQm9ixnJlefhRn3slaZy/UYdNNXlOvHn9O+yBq1FTly
 M3JRGRzDgjuGd8qugxlCmUtW8dynbjag1KFLiJadkD2YOKpkoztE+cMEJp8Mtv6Ey+Ik
 6EBA==
X-Gm-Message-State: ABy/qLYr166DLkPOEIwnOayuFVRXLQBfaDCL7rtXIwIPpAnviqp1pmHJ
 PlpWWDAYUwB+EBghtEJDrrcDZ/ZVJ77j2lrKDeCEPg==
X-Google-Smtp-Source: APBJJlEuShfZlLevnT+ST3DTQuaL+ait8buR+3rq5JRbCmjeEWFiQvhEJ0XkPpqAuwCzALsGqLUWXA==
X-Received: by 2002:a05:600c:29a:b0:3f9:b8df:26ae with SMTP id
 26-20020a05600c029a00b003f9b8df26aemr9850639wmk.34.1688927400052; 
 Sun, 09 Jul 2023 11:30:00 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 14/45] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 microblaze
Date: Sun,  9 Jul 2023 19:28:40 +0100
Message-Id: <20230709182934.309468-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Based on gcc's microblaze.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 743b8bb9ea..beba0a48c7 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,7 +15,9 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
-#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
+#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
+    || defined(TARGET_SH4) \
+    || defined(TARGET_MICROBLAZE)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


