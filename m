Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF8825746
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:56:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmU7-0004vY-RM; Fri, 05 Jan 2024 10:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSm-0001n3-NF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSk-0001HA-L3
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso1485578f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469812; x=1705074612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJhN/WyzxWMOOPIeTap61yRQUoY0YL+ZGCT3kZkMZNQ=;
 b=kbhIsb5G5wAWcU8WA6XlQi/6lKGxmbGxrqPEcemqnUAJHAWx5hQHKlqoOe50A3ShTl
 1VjKZw6HJZXRVq0Qkdp3/7TWZnZqz/0Zm6Hvitg5mfr38q44rrsFhW4TCZ2kdOVEZF4w
 RiGv8yqiwQJ0qh9gznbkrTMAXZuJ0/qlbqeG7B/SxZKotvHVMF19VFSsRvVTp+rYcejd
 k17URYeJuZmVmQklH/D1WUAfYQu2xiYwuf7NAfsNDt0yHchKrtVurmB1PKsfNg0CYRV9
 zxWKlhmZVkFLu4szNRvLhGnHKIQL8emVwUpOXYMi0QeF9SBpw2psC7u0feUG1OcLX6jm
 hKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469812; x=1705074612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJhN/WyzxWMOOPIeTap61yRQUoY0YL+ZGCT3kZkMZNQ=;
 b=byKGFfuaUTi4bmbo3eacBYl0VcEabCYJY8r0suLDJhtAKWAHrWzHQDM1BTDHRcRPpZ
 QlRGY7Ryaq3np7RYIqWPZLvI73lBK4uSZZ015OHw4e6+2f4/lfJU7R51tC1Ab2eheI0Y
 Vl1X1R0adJ4WWDQMIigsk0oFIdB9G9Cr5bRtXcp9ZpECKHNdx2tPHnetbK57rXuJeaIY
 o+D5jPZc9hVlZRvDDZVAmtt5zHbu5WjBsUv4guRVPF5OYvw092Qs/AFO9/yhu7tWwY1h
 7CgEruM7qt3eeqU6tzsKKnvBJUjme2eGlyMcRnLTY5d4KClVg5wbLcJdLXuffB34Oonm
 Y4uA==
X-Gm-Message-State: AOJu0Yzv08YkC3tX/BsfZ0x5+Kk2FuPzpbtFkhnww/SePgAZObl+6+e9
 AhdarBEfHjQJ+GplK5Qso0PDlbAMnUvVV0v8jvinCQplXYk=
X-Google-Smtp-Source: AGHT+IFgZoIHxDMrAT6W2pvOHEZRM/nIAoxIFWwT/z/A34AmtOLLTFbNPuahflw3qXI8Zju35p8bsQ==
X-Received: by 2002:a5d:6d50:0:b0:336:808d:95e5 with SMTP id
 k16-20020a5d6d50000000b00336808d95e5mr1497119wri.67.1704469812164; 
 Fri, 05 Jan 2024 07:50:12 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 a22-20020a5d4576000000b0033671314440sm1629463wrc.3.2024.01.05.07.50.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:50:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Grant Ramsay <gramsay@enphaseenergy.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 70/71] hw/net/can/sja1000: fix bug for single acceptance filter
 and standard frame
Date: Fri,  5 Jan 2024 16:43:03 +0100
Message-ID: <20240105154307.21385-71-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

A CAN sja1000 standard frame filter mask has been computed and applied
incorrectly for standard frames when single Acceptance Filter Mode
(MOD_AFM = 1) has been selected. The problem has not been found
by Linux kernel testing because it uses dual filter mode (MOD_AFM = 0)
and leaves falters fully open.

The problem has been noticed by Grant Ramsay when testing with Zephyr
RTOS which uses single filter mode.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reported-by: Grant Ramsay <gramsay@enphaseenergy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2028
Fixes: 733210e754 ("hw/net/can: SJA1000 chip register level emulation")
Message-ID: <20240103231426.5685-1-pisa@fel.cvut.cz>
---
 hw/net/can/can_sja1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 1165d59824..6694d7bfd8 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -108,7 +108,7 @@ void can_sja_single_filter(struct qemu_can_filter *filter,
         }
 
         filter->can_mask = (uint32_t)amr[0] << 3;
-        filter->can_mask |= (uint32_t)amr[1] << 5;
+        filter->can_mask |= (uint32_t)amr[1] >> 5;
         filter->can_mask = ~filter->can_mask & QEMU_CAN_SFF_MASK;
         if (!(amr[1] & 0x10)) {
             filter->can_mask |= QEMU_CAN_RTR_FLAG;
-- 
2.41.0


