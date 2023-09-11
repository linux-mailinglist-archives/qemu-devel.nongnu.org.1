Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37F79A3A9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeS-0000D2-C3; Mon, 11 Sep 2023 02:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeR-0000Cs-9D
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:03 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeP-0004Rw-82
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:03 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bf58009a8dso2890271a34.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414640; x=1695019440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJk34toFNyidTQI3XnnaKroUPxNRe6WC7SlLZ/NA1WQ=;
 b=LCDbqOaaEe/b5xs2y0XNNBiDLlO+oMv9THFjngFeJMyHbMBT6usgluCZISKH2G6Wbb
 9w4J72IJ6CisPS9ugpy4bbp56MkeQ7JlD9Si7GfPlBn/dikmkOvosxGDTWrvYKziyS/a
 Cejk/DFVN9epTlhbfkXSmVC52QuXNpMbbJ35lD0vpnUwdRDQJvGveMe1zAgE58MVKulK
 bLE9thJrLLri8RgR7UyxBKNNrXNjSTitdCduD8R+RT+qyamirfNJ4YgO0ZyDrO5Ha5D2
 A8n0tuSjp0LNJOzBdeeJd3LhLD5Mxbyds9SEY9APQSOkqTsPB7/AUqE3ltiJQhl64Yo9
 3SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414640; x=1695019440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJk34toFNyidTQI3XnnaKroUPxNRe6WC7SlLZ/NA1WQ=;
 b=FZoB2TFS6j8bU/mxNH+os8J3NItbNZIgFN0Gtww810DccuT1R4pKRvMOmaTj3jpLkq
 J/z/xg4g/xvK9owcWBPmt1Kt25jiEArxAlW3UIRozUQxv4KTVJwurT59PAo4SGMEfEE+
 iQQpNbtNkWiUjiC8yULJUlgtvL4wKMmDwnWMydKqpRBot3Gu1SQ1mRGc1GWurUmnrVpS
 FlcfZJlkR02B1CeiKn9laR/tyNsWjNPQGjqxfJvp2dpLhAxbeG65hSstpcuoI+flIpM+
 z31wKPTkC65wojxeFA1ZHD62GAzGEEh7gEDR5B4WywOi9q/dc1bj5hfKZHuHGqcCRvj4
 9KHQ==
X-Gm-Message-State: AOJu0YxiW7O/3rIwZ/mTgkaBaVDrePGtNI8U7OJ7vRDNzjJXYZz01N3p
 ChAOmacNVcfm4AY9pwKCw8fyeP2X4UkO4A==
X-Google-Smtp-Source: AGHT+IH9RB2zLKdLYHjpIs5CYv+SYjtllCKTR2ZYE91scVk1Yo0AUA06WIGPMABn2QX+jDxdDQfBaw==
X-Received: by 2002:a05:6830:18e7:b0:6b9:b1b1:135 with SMTP id
 d7-20020a05683018e700b006b9b1b10135mr9084411otf.13.1694414639824; 
 Sun, 10 Sep 2023 23:43:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/45] target/riscv: Fix page_check_range use in
 fault-only-first
Date: Mon, 11 Sep 2023 16:42:41 +1000
Message-ID: <20230911064320.939791-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Commit bef6f008b98(accel/tcg: Return bool from page_check_range) converts
integer return value to bool type. However, it wrongly converted the use
of the API in riscv fault-only-first, where page_check_range < = 0, should
be converted to !page_check_range.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230729031618.821-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bc9e151aa9..379f03df06 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -584,7 +584,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, offset, PAGE_READ)) {
+                    if (!page_check_range(addr, offset, PAGE_READ)) {
                         vl = i;
                         goto ProbeSuccess;
                     }
-- 
2.41.0


