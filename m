Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35F770BBD
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rO-00053q-5m; Fri, 04 Aug 2023 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qm-0004au-Az
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qk-0001so-PQ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-56433b18551so1550829a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186444; x=1691791244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=BtOVCALbvnLFOrhOUcbGsyqY/H8Km9l7kikFPwfKscT6KRGcMwHGAaPyX6fRKeWWWx
 z5GTufoNJ7zlc5LTfwPevun1faUnAZBM9ef9hXZPeGJk29YmNHi/C+iZ/Qsw9SNDqqN5
 BzhMcR4/cXmVN27YD8jhvXc0gJiX/5JeSTo1+iwyUC75TX0L0d5HlkrRT8i0DApkE30P
 qFnLxRj7Mo3Tq2wh2lAPlmoKd87Mw/gnNKTTPE+QIT5irlaCM0rgb/BYV14uzXtzpSS1
 sUvRjF3f2c6uVajtbCvAUGzJ9k/VBg16QItjNOUX4J5bDzTeqxNU8dzM7h7LMlVlnpG4
 4xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186444; x=1691791244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=S/fbKjLw0psBGjrTREI6OGlzAir4IkxoK5ni4yFKxodrW80Qxt830IOCoykuEAMS+k
 t8G/gh+MISw6HyevQE5htMheqKmDQksoAI/kCMOSLB7YJZb9k1qjx8n8bBzEkDEqVW13
 gukHa2FGUFwFuCMRVOq4IYZd7Q4wigN3VxewTFepvFhd1RJqusVcL0CJ09ZP4ILJfMGm
 ogY5Wph5mujZiW0igzHVERYAKMJ3JND7JcfX6ki/ZTdhf7V7O4vBoz5GG6iksJphL8te
 3nSHYTG05O63uaAUYEWm+pDHnxuXgBkGYSUVKNAzB+9sqMJhnTMDBB+owoQ7I1D+pARV
 +Hsg==
X-Gm-Message-State: AOJu0Ywe2c1nL3ATNg89wC4VY4v4tQ0PITEw2XKgnUMXhWRciqvqvK11
 Q4gdCaAvMRlT7QFw3+TFR9kfaFcexV8cYajmnlA=
X-Google-Smtp-Source: AGHT+IH17YjlFAFfIU3JiSQtdJODOEPaT9Qd8yM/QONZOLg0m9+f1zeyTcxvim2xtst0w6TqtR+BNQ==
X-Received: by 2002:a17:90a:4e84:b0:268:3b8b:140d with SMTP id
 o4-20020a17090a4e8400b002683b8b140dmr2234232pjh.35.1691186444121; 
 Fri, 04 Aug 2023 15:00:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/24] bsd-user: Remove last_brk
Date: Fri,  4 Aug 2023 15:00:20 -0700
Message-Id: <20230804220032.295411-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

This variable is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h | 1 -
 bsd-user/mmap.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index edf9602f9b..8f2d6a3c78 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -232,7 +232,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index b62a69bd07..8e148a2ea3 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -214,8 +214,6 @@ static int mmap_frag(abi_ulong real_start,
 #endif
 abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 
-unsigned long last_brk;
-
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated a chunk of guest
  * address space.
-- 
2.34.1


