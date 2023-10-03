Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FA7B6219
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZT5-0001ZX-07; Tue, 03 Oct 2023 03:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZT2-0001Yh-7W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:05:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSm-0008Sm-Oz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:05:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso616234f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316699; x=1696921499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dGNWXL4bt/YZVly7d1oK3PqrthsZjp41Sj7J9uNPxE=;
 b=fdnvxRmhb4A2CQCjmKssDKnkUYSnnGsMegiRMQbnuXhjQaUXo5kb4GESYSc/PR/+oS
 bwr9uag2cuEHBf0/bQWIaaC+SHt0fzlpN15z7L17kE+PVdU3oT3BBdWFwen/Sixg5Brl
 GX5cgJq6ALjrQBKQnuQmUtnshukN4t18hHShThu+j5m4G1YMDEq57ZwGy3yalLxTPCVQ
 P8EwR1BtL8DRPFKRsB4pR6u/PTxpoxxLmMI2o+YMpMFB3fT6gUYQkC0zTz6j+JDFJzpQ
 C8n8U/szhxQQCqyBWlu1/ro7jbG5+7m+mLYGPVskHmnCpf6Y8VJGji51/3YsoF8bmh2h
 kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316699; x=1696921499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dGNWXL4bt/YZVly7d1oK3PqrthsZjp41Sj7J9uNPxE=;
 b=sdrzbR19x9pnBqOZF24Rk8cZnq7nK2EJ5vJ2D3Oy4lGqb/GMGO2bXSONd4wQaDg3qx
 iAMr6alrRXZrvWiJV1MWeHEgu3F4DQpDKhBCZXHqjhIA+/50I5OiPctYbzwtp1X91DNQ
 Wvh3hh3nSR94Gdox9N8th7f+51kN2m5jdDCgs38qKTD3c1izwRhestOp0y8bb/gSV98S
 bP4QOCC9tAZlrfhxiSnUVLVwDRIuYrYnop+c5bPpunUQSlRZK1/3qtvSbYITsFidvdJZ
 nFKwWb05EYJtmlOLYubobfYslNrVk63CqvThokVqGQRJqokrnG7B4WHia6roRtPas/ld
 9Ktg==
X-Gm-Message-State: AOJu0Yycvu9oZewsnBQIjDaQzxh/34uPraVpJzM2jIxVXonfKEq8IArO
 FFqQDLcwbyBwYmDATfl+eLAAFoWX9BLUnt0blEYiuQ==
X-Google-Smtp-Source: AGHT+IEtMLpY0vDY8IiNQlnwRAuBYlQaQaB3YsnFQvO7ycOaQmgl/yRWmUy1V6VmkwiBs0q8c2c4lw==
X-Received: by 2002:a5d:58c2:0:b0:321:f74d:ade6 with SMTP id
 o2-20020a5d58c2000000b00321f74dade6mr11933643wrf.40.1696316699144; 
 Tue, 03 Oct 2023 00:04:59 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a056000115200b00326c952716esm818614wrx.61.2023.10.03.00.04.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 00:04:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] target/ppc: Prohibit target specific KVM prototypes on
 user emulation
Date: Tue,  3 Oct 2023 09:04:26 +0200
Message-ID: <20231003070427.69621-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003070427.69621-1-philmd@linaro.org>
References: <20231003070427.69621-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

None of these target-specific prototypes should be used
by user emulation. Remove their declaration there, so we
get a compile failure if ever used (instead of having to
deal with linker and its possible optimizations, such
dead code removal).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/kvm_ppc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6a4dd9c560..1975fb5ee6 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -13,6 +13,10 @@
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include kvm_ppc.h from user emulation
+#endif
+
 #ifdef CONFIG_KVM
 
 uint32_t kvmppc_get_tbfreq(void);
-- 
2.41.0


