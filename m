Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638F0781155
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31n-0008G5-63; Fri, 18 Aug 2023 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31l-0008FE-0P
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31i-00082U-UU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso8783225ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378765; x=1692983565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPyTBROSdONEOHmOwoKlD5YWMd2vd+yZCLBm/BBj1es=;
 b=opMjJ9niRwLnvknf2vtrfjkO4b69llRXHvsFi8eORMeRtB44tZ21JWH+GrCeL8onSr
 WzYdpTZTKnX0bA2UxLX8HQoY18ZhYKeGW1GTPMgul/WbyKGh4HIIxePlMW2S6+yUQdi2
 zYdeFzUhZVmNJRGkSICSuZ2G7/og0aHB45BtCa4zq/VmWsbvNKjQVnfXgyEp+ItdPO0m
 hHGdd3IuATE9yRtsfUFqysLjDb6Si1xncL8wAh1vY6pt+mJXPThuXLZDRuNxGbFzpJ5K
 eFW5SXQdwiQ+oE2DQBZsIwN+4R9wsDf5lWyrXk27L11hTWDM44HX3zxJ+05wtTmh80An
 uNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378765; x=1692983565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPyTBROSdONEOHmOwoKlD5YWMd2vd+yZCLBm/BBj1es=;
 b=CwL2l8BpNxBWmYNYzBa9DSbFC6nVI+0jfBKO0vm61jLFm+RkvpERr4jFQsEe+XiMnT
 oeYo9r5wUFLbLtP5K+/gSzJzU+slQw54+/7wN3MIl0JFFWWFH3g7BOzR/mRKdNTIYirT
 FG+T7mb0/umNW3fU01c6BRC7GTtkntYNoG+Wig44VGTgLpVgWljKIFHWLgPofJt5mrI1
 pKDKuoldpg+NjoPGmkPFO9KI2OKl67ZunsX0ez/7JFlmOdEjr4JG6mb4YvXtUvq7Fu/f
 MAsYxVgENVDMk2BygAmJpcvcRNuRCYpTWnfzhxM4opCPl3MthqHaLdUW5LYxcIyoRKpk
 u+Iw==
X-Gm-Message-State: AOJu0Yye/ZPoOeyPX7HRb/JVdGiC4paRr6/iWBRNpkbsRac0gQY6JinS
 yDaXcC3raOXPfsRZrF2P2+OzKUTKw5mQBc+b5P4=
X-Google-Smtp-Source: AGHT+IEyQPBreIJ30c5HaYFIYnGV//b1jpePjLKtqWJTeUMvpN+MzFteG7pTBpcMjP+mTXk2FDr9/Q==
X-Received: by 2002:a17:903:124b:b0:1bb:c87d:7573 with SMTP id
 u11-20020a170903124b00b001bbc87d7573mr3510483plh.46.1692378765355; 
 Fri, 18 Aug 2023 10:12:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/33] softmmu/physmem: Remove qemu_host_page_size
Date: Fri, 18 Aug 2023 10:12:07 -0700
Message-Id: <20230818171227.141728-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..6881b2d8f8 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3448,7 +3448,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
-- 
2.34.1


