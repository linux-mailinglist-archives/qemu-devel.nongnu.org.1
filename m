Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F4A78BAE6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakVB-0007Kz-94; Mon, 28 Aug 2023 18:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakV9-0007Em-C0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakV5-0004J7-GE
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so3132730f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260862; x=1693865662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a91SKJtvPXvgB5sy2pGCK9ijSQdaH2tTol0tKP9ptIs=;
 b=aWL7EvO5AjFIcN/KluUWftfP2Y5cehU+y6pv6zHIeNA4NCFZ9b7eZDLUqTnUwg02oq
 3G+EKJGqiHujXTv0J9idbIAxmK7q6g0iI8A4KX+B9Gr3sP44XOfAOvxsnTF1oSyf2FGc
 GZJhqhcwkl4aFeNkDHm81ImANZXykIn/v5pEX+swH8/BTkySm14kCYCmInZ6STUODuos
 fBx+PYqozxpraIE6VUcASYlu4U+m3XX+wK8Upf6Aq5P/jfgSB631z1JIpPPqVJXR+hLO
 OQ45Lor6dQVNvQEW5OIiV17rPpdsCgyMi90m6cW8OxEP3BkYn+W1tzpr/MPgZt8mRZcm
 uxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260862; x=1693865662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a91SKJtvPXvgB5sy2pGCK9ijSQdaH2tTol0tKP9ptIs=;
 b=Fqjz18vr/RoRHPUgD1+xqszrLHiW/MVA3g7UqrNjcNbXdYorG4BcvfnuJpjyhvK0mB
 +nsupYk3/CfLRbrlza2Gb+g23xSSxjXfYED+i6B1x32tLMoYxeezphqHNhIJibHdhdHx
 JZuxBRlibrRr5U8+mPtTJop7wgpX8guGZHWSwMPXlAbu8LDmh6qzkjxeDJSlsq1GFTuW
 t4hMW/tjOcfa3ITbboFMchNT27ZgsAwu9Ibjnrof6CrKXa9lgOsWGIOBgdCA3QOtJCFa
 xbSWverhAX0xnc7eyOjYi1dE+sW0hQMuyYoc5IR/F8RzJaNG9K6qxwwk6SLAVU8Romfa
 soMw==
X-Gm-Message-State: AOJu0YxRnglS1LGUz1pGjq/ZmL8wL1NZgczAHBQKBs+vuh3AjHZnzq/T
 NP6NZy8s1bwvyiQhWwv61nanPRcWmd2+hVYQpAI=
X-Google-Smtp-Source: AGHT+IHMfOn9go+PUQ2Vy8ki68yioo9KVeOTCzFSAbG2+4k+J2TTRSkKP011hH+3IoWp1wU3ZH3y0g==
X-Received: by 2002:adf:ec11:0:b0:313:f4e2:901d with SMTP id
 x17-20020adfec11000000b00313f4e2901dmr20467448wrn.22.1693260862015; 
 Mon, 28 Aug 2023 15:14:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 f17-20020adfdb51000000b0031912c0ffebsm11673969wrj.23.2023.08.28.15.14.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:14:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/11] qemu/processor: Remove unused 'qemu/atomic.h' header
Date: Tue, 29 Aug 2023 00:13:13 +0200
Message-ID: <20230828221314.18435-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/qemu/processor.h b/include/qemu/processor.h
index 8e16c9277d..9f0dcdf28f 100644
--- a/include/qemu/processor.h
+++ b/include/qemu/processor.h
@@ -7,8 +7,6 @@
 #ifndef QEMU_PROCESSOR_H
 #define QEMU_PROCESSOR_H
 
-#include "qemu/atomic.h"
-
 #if defined(__i386__) || defined(__x86_64__)
 # define cpu_relax() asm volatile("rep; nop" ::: "memory")
 
-- 
2.41.0


