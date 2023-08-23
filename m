Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C296B786183
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRd-0005Kd-IJ; Wed, 23 Aug 2023 16:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRY-000585-KC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRX-0006CV-1Y
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bec3a81c4so171784b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822425; x=1693427225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahCrP7F2MvJ32qfYW6+qoIFl/wcJc9b7HEfMWV5oPEg=;
 b=qj5IpEH1pErP5EWF+BI1fooJDeVbxRhhGtQ3TwMe1w8tfYwSHZ46aTTA9JhmCZTQ5y
 XqVBtmeeJIbvy2TuUmsWSu9zsTUk9tNQf2fbbsFiVHNAx1uVwjqX/sPycmz9MKLBmkgN
 +NxLkKlt2hZi7gw/+gBhgyC4vSOSX7KK2xjsx0uJN5iuvQUIapIbbqfqQU8gUPv+AAiZ
 yxv1/o0QV4zWPF2bpdrN1xLe7VUS4a/eVl4mCDeCsXIuqalXdJZfK9FhpqSjhE431xsk
 I13S+HzllAgQI5RGyk+XoPb+8uMyUcb0arSg0T5SVmmz/QI8RK6KKju1L34HZshFeHLN
 F7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822425; x=1693427225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahCrP7F2MvJ32qfYW6+qoIFl/wcJc9b7HEfMWV5oPEg=;
 b=M1W/8YfouO7k/R+hKNEiesx7/+G2qTz2A9taV+Mcr0aGr9sc37YJoisLKtrcvu8GZ+
 OMgwSd5Ze86tlCAq5XTmhjPCXe9+Ib5/d7ZV/rxY5ppdecpOfMqx8ZsYLL5bR4Cm7PKH
 alEMTZVbhyJLgIwGBwGCzxuIJE4kAn5oGGTTEGqZL8UYegIMbcoBr/LVybvjFmPKYcTv
 W70l5RejKoDZzzF6PvUmR98kjFGWP33Rmq7tdazspXH0nxpGn1kY4NKSPwBAyp55BsSR
 QlLSOYrgL/ezw+Yss13tM47qaxPercqjbZosJ3s/Zji8Ry7MmfhHuMXTp1y7kngPBbsZ
 +6IA==
X-Gm-Message-State: AOJu0YwzI3utzthr7zNspyhLqbJJM4XveVKcYNA5toj8kuxQon7Y6GhG
 Bqaa9AES9LjdaTzCZ/CO7tSTR/JHDwC7flKD9Qw=
X-Google-Smtp-Source: AGHT+IHCgHmF8y2lUPlRAjg3xR7GF1nehGND7SkAvL80DhKTL14FbiTOCXmRPG3LBH0nZzbnQhnb3A==
X-Received: by 2002:a05:6a00:17aa:b0:68b:a137:373d with SMTP id
 s42-20020a056a0017aa00b0068ba137373dmr7197957pfg.17.1692822425614; 
 Wed, 23 Aug 2023 13:27:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/48] tcg/tcg-op: Document bswap32_i32() byte pattern
Date: Wed, 23 Aug 2023 13:23:19 -0700
Message-Id: <20230823202326.1353645-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 88c7c60ffe..ed0ab218a1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1078,6 +1078,11 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i32: 32-bit byte swap on a 32-bit value.
+ *
+ * Byte pattern: abcd -> dcba
+ */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (TCG_TARGET_HAS_bswap32_i32) {
-- 
2.34.1


