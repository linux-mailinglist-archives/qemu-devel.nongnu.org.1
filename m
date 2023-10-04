Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE67B7B3F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxqT-0000Fs-AQ; Wed, 04 Oct 2023 05:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqG-00005X-Au
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:06:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxq7-0007JQ-9R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:06:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so1817430f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410398; x=1697015198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vq400Z/hRo2TzTvAVidPJS+emom/nhiL5bExw++dGXQ=;
 b=UeVimI+1VpoiK1h0uLcdMkNNDyQ9joSOI8LdSZyYdH4iXrgMFc3nwoVCwQJWDIXDbw
 5ZRyVnr3ShOzEMN6mL17mPhE2ybWdZQZQx8ff30MNV4Lk0G9Y0oB7Lw1/xdmP1pj3oYk
 PccqLFdioKIllcQoC/Mj2dkHphPzRALFhgC642EUcSLgedS08HqgqbxxzpiikJB52sk5
 AI6skg5eBdbO0CYlCAza5Nio1YP4qTMqfp5Q2r9Z2sNWvJJ8hoN8h3/NwyLHJE3p0hqv
 cGsuLt9HBx7bhAsOF5hMiKXnnz36wTMewt2rloY7DJqs4xPzIGcaQNQsQ1lM+1LlLgUa
 Thrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410398; x=1697015198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq400Z/hRo2TzTvAVidPJS+emom/nhiL5bExw++dGXQ=;
 b=sd0RYkij201ha6sGX9hCWaiIHcoLGxOmd1o04pDMfhOQ/EXFqWGajhKeBqhnnPgD+4
 Dte0PHzx0kEBnU3ixJ4OFcJJyXlIrAbvSwk7bycfRG+VpUFPBEEQpBPna7OGoPE+m4/f
 sY2X3ToD5Gp1iAcwSJ/86YRtc1kS0WrsXKIGF+uD1VrevFfQ9kUewmkvH3iE534w1jYB
 t8suC3p9CLlNS5NYID5UOJ546x0bZSBciJwFwb/Szw7dNWoZklkCt14seG8HlTqOCTER
 CybqIqYOP4jaFb0JHFu4Y7rsdmX3OIQGsV2n5Lu5ANYL1AuWN84NESS2f/DSgmfoG3xN
 NN3w==
X-Gm-Message-State: AOJu0YxR8V1JnS+qHIHKr92FoEkSxiit5FxA6jVG0h1YieQZI8M3d15o
 ayVkr1OlQxSlbncUFSY4dpZaQbKq4VgZ2Czh6JI=
X-Google-Smtp-Source: AGHT+IHycCeab5oMDXM1XeeaxEgiovNyEXd4G5yJrPGXhRY9V3ZqcRfvXbSSXsEUG7+VuOe6HtspjA==
X-Received: by 2002:adf:fdc7:0:b0:31f:f982:5395 with SMTP id
 i7-20020adffdc7000000b0031ff9825395mr1573683wrs.35.1696410397897; 
 Wed, 04 Oct 2023 02:06:37 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 i15-20020a5d438f000000b003250aec5e97sm3517480wrq.4.2023.10.04.02.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:06:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/13] softmmu/trace-events: Fix a typo
Date: Wed,  4 Oct 2023 11:06:16 +0200
Message-ID: <20231004090629.37473-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit 8af3f5c6d6 ("softmmu: add trace point when bdrv_flush_all
fails") added calls to trace_vm_stop_flush_all() in 'cpus.c'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 softmmu/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/trace-events b/softmmu/trace-events
index 22606dc27b..69c9044151 100644
--- a/softmmu/trace-events
+++ b/softmmu/trace-events
@@ -21,7 +21,7 @@ flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 
-# softmmu.c
+# cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
 # vl.c
-- 
2.41.0


