Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2EAA975B2
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 21:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPO-00061X-Q5; Tue, 22 Apr 2025 15:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLf-0000fj-Ky
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLd-0006de-NT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2241053582dso78276595ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350320; x=1745955120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/LWI/F8VdrNv0zLmIvQDUtowepeiN+2e5bv51DEBF8=;
 b=F+3wQiHxGIC1kO2+3MBQ16NW/ggM9rc1SupvJLbw6EB1Yy7EAkYcpVLYqTn/wOPyJv
 6McwzRtzNk2unbbDh7MQAvfgbtA84oAfaW2pUZ2K3/Ng5HZFxYsdvMHN2ABAviluyMJy
 m/OwXa/Zu89kC9iG+dXLAdZp4c0GDo71NZnhAUe6WDZpIZvUCHcw1o2VfB+4d8M5S0p4
 4Cs+W3BnLvdANdQhTSa/D4km0cOYX2+jBIBCc44OYYwEipxiQ6e7iy6y6jSKAIJw5Dlj
 /2TvjkWKGY+JAA5RTdt/1tVNsD7S42D5Go0hrAJdyYQmPEhL3aCEhVyz787ljBZZobkL
 eZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350320; x=1745955120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/LWI/F8VdrNv0zLmIvQDUtowepeiN+2e5bv51DEBF8=;
 b=rSUAkt6RcHBpDDfIlZ50kgSQYvX+LrP6IFYkzXBexcX+dt2xdFsZobCOJNl2isc3GK
 3Sd5CZmWLu6zNT41XLofbmSqS7HL2F1ywUERiFKxTRUpL4OViYTdpT205BWmH6fDDCXq
 m/wbLOZUezOSCR7ZUdUy4I5vtp6a9MFEmLwskTYz8ub/EJH+X1fyuWBw3Ro44K8UFWqy
 89t/areSRlRphCKx7rzYf8xf1B8BuaelJhOp09zetdBca8Q0op+REeJcLrFl7vD0o+lm
 tgl52Y6T+jwDJaPI+a2XWQFH1fv7ABMEAp4iq4Mwfsvqzc6Q/wjr+oufBo3tymS2642Q
 g61A==
X-Gm-Message-State: AOJu0YzqU7GTf3CY/CqX41xCsNSY61NjTzf7Z/fBkRmhkXTxYokCXJ5w
 K4g4TWzCHgUDp8xoSErF1//+GIHohf7D7g0SFxUg7z7iPL2v0kF0rGydtoN2Y+9CMyeWhHiYVza
 f
X-Gm-Gg: ASbGncs2R1KoXjL4JI5xml1BsiVZrSI0lGJLBxJ126mbjKlMZPxu4jlyaL7RUP21t4A
 rrG5xOgXSDFAeXWu4yd2ZxC/wVTEOsIWhPuLiuIcO5SYcPBrE+DJEJdH3xRDTP2QcxTtNC4dIbY
 K4937BgavG+ollCH279hP41QyjJP9k7yG+WrunZJgmcMXwQ+mb0BmBnqQAPdE50+UbNGvlgiEW2
 9FNrqFHjbiNQXm7s7xwkB7aISSEuLxW/3W3ALB3Z+MJS6o538d1yywIF8A2Ma5WzonoGs/Nhvbw
 o65TiDCMEflKYxYZhAXMSyIv/yO4L9PuEMKH2J+KgwzrnneDjE+8yJq1Yr/ZRGjqIqYvoJ5k/im
 D/6dmfMs9sA==
X-Google-Smtp-Source: AGHT+IGJIgRF5vm0b8DMOQFMrPRxD+1jrTl1pVTjLQ/PntK9tXS9rWqrmN6akH0IEC/D6iW6wga7yA==
X-Received: by 2002:a17:903:2410:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22c536050f6mr274714465ad.38.1745350320207; 
 Tue, 22 Apr 2025 12:32:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 060/147] target/riscv: Remove ifndef CONFIG_USER_ONLY from
 cpu_cfg.h
Date: Tue, 22 Apr 2025 12:26:49 -0700
Message-ID: <20250422192819.302784-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

While RISCVCPUConfig.satp_mode is unused for user-only,
this header is used from disas/riscv.h, whose users are
only built once.  The savings of 4 bytes isn't worth it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_cfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..cfe371b829 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,9 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
-#ifndef CONFIG_USER_ONLY
     RISCVSATPMap satp_mode;
-#endif
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
-- 
2.43.0


