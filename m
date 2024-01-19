Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE54832922
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:44:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAv-0003ai-LZ; Fri, 19 Jan 2024 06:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAt-0003ZV-Ik
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAq-0002om-QM
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:39 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-337c5bcf79fso602782f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664194; x=1706268994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRUeXWyyJ392ZohYjYrcHzpfLxHyioAU0c9SeFp2B+4=;
 b=U8SlidXbM8Y2dQEorClOwMLGiJs+pXPpw6EGVS1qq8ORi+ImOMGHZamC+MRDYO+jGI
 N1sd7Ndd2QUt0jYauMwXKT1wt0ppuxLuwXvIQ+lQHkb9KLtQ8oIKKT7o9BTvZZ9oHu8U
 PLPUpZwqsJ4djhBgmW5vLoY1eq0tJ1l9P8/u0oAN65ga9HrLO7NnHU+esySc5FMyz8T4
 zpq22KCSjXEuIZqzyTXBmXDTJHyc32UfjHH96lbAym3pNJ6zBgv0qWxdH2i/R3gB2ucI
 VUeAz7yCSPu1GwjaM3JlmtrE7IYJp5VIjCmN3ElJ0xjEfzwjEkLKE/43O7DAaTQ25q46
 aUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664194; x=1706268994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRUeXWyyJ392ZohYjYrcHzpfLxHyioAU0c9SeFp2B+4=;
 b=IIoxR9Vlf10m5EC8XeegzjFB1+s/mALZG4J6511ZyJns8QuJqLoEMu9xBcNuY2v4qr
 sJGDdz6PFV6IJw/SpiFBrXM2/nc0JKgRL3BP9qS2o1uyVGokYcwAdZ6+u7Mi98RY3Rt3
 JxvnmBXVjOhZ3cB5rB4JUk7W4OJXDZldretoP4ok/HulOrzhLN+SGRjVjQFcPI51K8iR
 /pdMiGIvtZD3stCni7fZXLGNW8/ngnGbDlBQ7C/YlkeqfVfE5tq5xaInSFeEGOvKWfOE
 /0Q7j1rvogsBxuWNhfT+6txnsyUP0vPJWD6HQjsBqpltGC2Yc5ltGiDuW16E6K8uX1B6
 jSgw==
X-Gm-Message-State: AOJu0YxKyz1xideED9UMoEQhKukPKN7gWkmm5kbMax4GTqgCfgcILc0J
 Ose1jhBrJCKK0oyx618IGh6VDhUdE9Sew6Io+UhvkOk48sGegtahlrMIMuhUJsAn3VD/KyVkLxA
 jiPqAJg==
X-Google-Smtp-Source: AGHT+IGj75N26ZT3ZOq7omXVoZFMqbnYR23Hs+dWcYwTne9hE7wDiuiR0snF9EPNVkl2lhYt9iYgSQ==
X-Received: by 2002:a7b:c3d4:0:b0:40e:89a4:27dc with SMTP id
 t20-20020a7bc3d4000000b0040e89a427dcmr1430853wmj.106.1705664194508; 
 Fri, 19 Jan 2024 03:36:34 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040d8eca092esm32803585wmq.47.2024.01.19.03.36.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 19/36] hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
Date: Fri, 19 Jan 2024 12:34:48 +0100
Message-ID: <20240119113507.31951-20-philmd@linaro.org>
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

From: Gerd Hoffmann <kraxel@redhat.com>

Use the helper functions we have to read/write multi-byte values
in correct byte order.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240108160900.104835-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 63 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 67f1c9773a..8434a45cab 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -225,34 +225,10 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
     uint32_t ret;
 
     p = pfl->storage;
-    switch (width) {
-    case 1:
-        ret = p[offset];
-        break;
-    case 2:
-        if (be) {
-            ret = p[offset] << 8;
-            ret |= p[offset + 1];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            ret = p[offset] << 24;
-            ret |= p[offset + 1] << 16;
-            ret |= p[offset + 2] << 8;
-            ret |= p[offset + 3];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-            ret |= p[offset + 2] << 16;
-            ret |= p[offset + 3] << 24;
-        }
-        break;
-    default:
-        abort();
+    if (be) {
+        ret = ldn_be_p(p + offset, width);
+    } else {
+        ret = ldn_le_p(p + offset, width);
     }
     trace_pflash_data_read(pfl->name, offset, width, ret);
     return ret;
@@ -408,34 +384,11 @@ static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
     trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
     p = pfl->storage + offset;
 
-    switch (width) {
-    case 1:
-        p[0] = value;
-        break;
-    case 2:
-        if (be) {
-            p[0] = value >> 8;
-            p[1] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            p[0] = value >> 24;
-            p[1] = value >> 16;
-            p[2] = value >> 8;
-            p[3] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-            p[2] = value >> 16;
-            p[3] = value >> 24;
-        }
-        break;
+    if (be) {
+        stn_be_p(p, width, value);
+    } else {
+        stn_le_p(p, width, value);
     }
-
 }
 
 static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
-- 
2.41.0


