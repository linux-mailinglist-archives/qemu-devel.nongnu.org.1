Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E9776E26
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 04:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTvWs-00011B-4Q; Wed, 09 Aug 2023 22:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWl-0000vz-4l
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWj-0004xO-7W
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so370707b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691634952; x=1692239752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIUuncYK5LuF874bLlgv9Sndabs4GqkeEig1nWblAF4=;
 b=J14rMj2aacj5EX9ezHdfTZFOQTc/yhy+QR3vqDVS+RdKti+m6kXabo1mjwCdIYysEq
 USjXsFOrRhtjwnD6dpZV2zQ8PFEPdgA8g+WZa92hxeXeHrl1j1HLW6oBIJ69a9Y/CpHy
 H9YHx8OevAaKxQHWcaRLAIePumywdmXHd/bfP6XkM/NHlj3TDlQV3KhapA5KgNjpvNpW
 jD2fXlXoTXppb6dN94vlYjioEuClCbZI/0ChNZ8NMFWqo91GCR2uTzlmx2BQB/qZNr3D
 0x6qwhbS+PfxXzcSNkKAiQfal5ptWj+AUxQqlsg5ef+OSZrmNhWp6XPzMh0BQt3x4hs5
 7CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691634952; x=1692239752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIUuncYK5LuF874bLlgv9Sndabs4GqkeEig1nWblAF4=;
 b=UYPqNLRGn+b1qNLmFstjA5DScFFIaWH4msYvz9S2n/6aSK8zTyugN4J5xFp4Zq11u/
 CBskpTIJ8xonjStvInBfXz5wi0JcL5vUY2yde9nVmZd6Da14ArBvqwHILIVYYBjFadOA
 AIweePGKvsT47Iw8kWp8EyGUFR8rJMkKiW5xgBQY0EZqN5ccS45rIu7MGL2AMrHGBQNj
 tHuglpxcTbdPWGJoB6NLTwZYIQQNM6JFdPym7XMj6bcRoSOGSuWlyVA4ncyQF79SEd7j
 aD4QRSaUC0wCfzysoxgUMq/hDv+yffWgqMdfzUNsNv2s1fZdWYUtFF7H0eMG3NUXc+xA
 0/bw==
X-Gm-Message-State: AOJu0YxwedutejVBwnBBsInccleTXIGI19dGp4ojSGUIu/bkVTS0x7NJ
 fDHvFMu2mPTkmLoa18fhGpNqDiVHUUTUspa8PoY=
X-Google-Smtp-Source: AGHT+IGIwiJnrGfV4tq4dh488nE2vwFfUGXHuE6hk2R3xQPZLIq9xgtHLEWbrjlu7wbpZ2uh6dmpCw==
X-Received: by 2002:a05:6a00:14c8:b0:687:5c3f:d834 with SMTP id
 w8-20020a056a0014c800b006875c3fd834mr1585369pfu.11.1691634951983; 
 Wed, 09 Aug 2023 19:35:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 z7-20020aa791c7000000b0066ebaeb149dsm287283pfa.88.2023.08.09.19.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 19:35:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/5] target/arm: Reduce dcz_blocksize to uint8_t
Date: Wed,  9 Aug 2023 19:35:45 -0700
Message-Id: <20230810023548.412310-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810023548.412310-1-richard.henderson@linaro.org>
References: <20230810023548.412310-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This value is only 4 bits wide.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..7fedbb34ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,7 +1074,8 @@ struct ArchCPU {
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
-    uint32_t dcz_blocksize;
+    uint8_t dcz_blocksize;
+
     uint64_t rvbar_prop; /* Property/input signals.  */
 
     /* Configurable aspects of GIC cpu interface (which is part of the CPU) */
-- 
2.34.1


