Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3F2AAC82F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 16:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJP9-0007dy-HH; Tue, 06 May 2025 10:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOs-0007VI-Ml
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOo-00015A-Oh
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so3039656f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542157; x=1747146957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvtl+DcgU0U8JmlXNUaemT/ydxF64Ur81pz9zOQo6Uo=;
 b=YAgNhgfNFrWhOhpc+hDXA2j9t4WA8flIKSRiJOtfihT8/Bx+7aKcL5eikszyJn71S/
 4YwSVhHdyOddz9S+lLec9mcnt/6visUmRfgT3LRkiyI3UblLT872TukyzKlawXNr+/v5
 abb+oi8xKUvqTVfFUWHAAmwBiNRYePwO9AMcp2cf09YplsGDFHclxI4Md2x86wk10zK+
 8V7GlHkzi5nx8CztqDhI6fBnRXLVIbYFT9uWclsEJjKq5LNDNeM3lR8RnVdZQdQUKMGE
 bMo7viJAoGWTcAUhndacZx9FATOrgIDfSigs7gVRK+OpQW0LzD58MdKC1LYngopHvtob
 pc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542157; x=1747146957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvtl+DcgU0U8JmlXNUaemT/ydxF64Ur81pz9zOQo6Uo=;
 b=XjL6iNeXqaRDBlCnB0Yso2ljlPCmfjNU+7kWj/ndEUbJ8mTsthknAHo8SOBfx5jk+5
 mBHyiszgkimz0BxtvG8hi0H5Rfo/RzIBc65OLBRic4U352NppwCzfn1lq8wBoQbrU9Yt
 3kIE4OLmJdcg+FuXNBzkPlbHUHqtTmWLasQJZg2J0WuEA7qUS9MMsL4d9Dg4AOwsot+/
 JLQTvdlOJ4Nh7bbFqffDuXkQjymPy1WwgyJcuQ/NzyEvfBivHN7XlhodmiHf2Qspp4SH
 +z9UoCxl/hzrafrds4Rhk8aYJct1NVW3YlUawosn2ovqoyblUajGgwkR2uhzozcVUiO6
 qX6Q==
X-Gm-Message-State: AOJu0YzE7hYAv6sTTR1qj6Qi8A5OoGUuFhGWSUAJKxycSvYgBe7TbhDB
 2B9oRbEndqVZnIOHqXtebuJI04OLMKAjIMYtF8HkPeKqxLph588I5uUSKFh01lVOBwKXnoBgszr
 w
X-Gm-Gg: ASbGncv8n3ozJ1zXyY734jqocW5gTcTNvH0JJNDUdSS39e6dvbjUcqlGhe/N8zu2FaB
 D3mC9OtI/feZ8DpTzci+WgZu4D7b7jK2vmxCZqlChkUngweI1jfs4vgU2KjWg/9OZDHSxsRbmCg
 CbnPExCs4LKVvJsvMQTg6c4Z+z/69j5+KgP25yxoSUeJEFAmBAw/AXVRcd2Lx0bveKkUfQwjuT2
 TzqwPvjiiWbkwtu7hVtQrkdxfu2XK0ejqCuUJW789AYvBJemOsOVlf4ha7MBTSqip8O3+mkP9KT
 Ai2CKfT8blpbPxucoCkGKj/yLR+biczUbPSOPwJbVMZVkuzQiNa6caZ3rAMMUpSTd7Pmj5Hwp/p
 n2GwXMw0Uk9fqe/VFHvdo
X-Google-Smtp-Source: AGHT+IHS79D9LkKh3v/hM2Bv1jJRZvMtGU4yeNt/xPanvA2Jbumuy/yCJ+lHOzTaYNSDnhYutjbq1g==
X-Received: by 2002:a5d:64cc:0:b0:3a0:6ae3:a1a with SMTP id
 ffacd0b85a97d-3a099ad6351mr11079967f8f.23.1746542156672; 
 Tue, 06 May 2025 07:35:56 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b25159c9sm1331614f8f.50.2025.05.06.07.35.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/22] hw/hyperv/hyperv.h: header cleanup
Date: Tue,  6 May 2025 16:34:58 +0200
Message-ID: <20250506143512.4315-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/hyperv/hyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index d717b4e13d4..63a8b65278f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -10,7 +10,8 @@
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
-#include "cpu-qom.h"
+#include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 #include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-- 
2.47.1


