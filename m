Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3420B190B3
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Aug 2025 01:23:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTn-0005e3-Rb; Sat, 02 Aug 2025 19:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSs-0003kj-N3
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:35 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSn-0002aJ-Vp
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:31 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741a8bb8aa4so158601a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176589; x=1754781389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v7h38Ym+Ui66y9qX3SHeDcnGzU28Qfcg8CwHunalrk=;
 b=bI/dmQ6mRCCD7GizaXlY0NUkPSzV0o1Xo3T1+i4u6YzXkpzlGkyqc/DL3nvgXFQbMc
 X3XZG09tvp1Qj/UNUxFLC4vguCYtr+V4bpnzqJ2iU6l5dGQBOeEKPQp6yrwzWPiZRuGF
 IGm3NsZFqnbXLDqyoOU8pSdcJGpDOZQ3yJnP6BDbdLcI9XTgpmtNHxBcC65MFAM6JuXt
 WRPUkCn7eb4r2uxMfeKtYRg3KokeT/X1khcSgBtdgiALbt1odpFDuiIbtBhYrMxO30EK
 ZkWGQ2p8HNK6cLmlpzW74AwZQIfkxKnP2wXYeTghPuQyJsX2qFID8edPfdka4G/ojt43
 LQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176589; x=1754781389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v7h38Ym+Ui66y9qX3SHeDcnGzU28Qfcg8CwHunalrk=;
 b=dwHIuejH3O80cse/fMgENUW2iFkO6MEoVhSr5hiVpXz+S9we1rn3I4ilplbFVeGB6v
 8aS1V6I70yvqjr7f8eHAhJAreDsT9Do4as+Thkvo5kYuRXwuzBubGUF6VK9pR/rLnSoy
 LGO9Cxs56AdCQlgCdGE8U17Q+i0K+45lbBSQpeu9TYCPxx+YYsdCVh0LrMvhulVO/f8o
 ERGOfV4bygKAXYopw/KdU2EF48gyPfF0HCaL8N/hCAQ2YVwSY8otODpVnznpKggpOkVl
 4GTnOiIGX8nkAp93Nbr2xdoJAQWU0cWVHaGIMv6l0tDnUjHbKJiDcy1CsomyTYnKRlJF
 2A4g==
X-Gm-Message-State: AOJu0YxdoGzmdeS9nNqHzxowKDPlLtpY8JMSHgtW8tF4ZUHZn1Kr7ktL
 u4X4x/XVU2qAy41rHCGk9hezxxZKMFJbs9RFBpvps9HTgpJh3Nkt8dK4qLFQ5UwKlWolUQDz0Mx
 aWPHy3KE=
X-Gm-Gg: ASbGnctyaSQJVMMeleO1MZbj8GtXcKwaOSFN1IA31wdvxBdInAlDAmE6W6e+EX9MVhz
 rB6i+L2oWfnrsj/N63fotYhUOS/nOKETxdET5gQ75MGUyZFrdTU4D1SGd00i8JJOlKFzfINQu+c
 3q0RVlIHuII/oWW7RW5voHFmv4xsJHxwpTNf7/D9V+uG4M0YSm2rbLu63ZUA3zAPwG0jQfFlyqZ
 mjqTMxyF/+ZF6UiNgBiYhgZYtfiGnK+KAjaTARDnhS8X2Z6dQBLkEZbieHobECg0MQH4clB3l5F
 4XBDb7v0rCqw8uOCxYtsAOgUB2RObqjijGtnq3maLi++apqawGmsABjMNR2/S8SDYBrhx+iHBoq
 awV1Mi7XptRgFAm+u4nyP0EJe2lo+QQ1V4N9pdVig297FCj59b+3mMe2Mlt5+3CA=
X-Google-Smtp-Source: AGHT+IH8bueZZ2XmgU66EKyprSlXwSSONhv1eaknaIMjMCH+oSwIsBKYkpxYT3PtulXspXPdHCOCkw==
X-Received: by 2002:a05:6808:2508:b0:408:f80a:bab9 with SMTP id
 5614622812f47-433f0239a78mr3396293b6e.11.1754176588602; 
 Sat, 02 Aug 2025 16:16:28 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 87/95] linux-user: Remove ELIBBAD from elfload.c
Date: Sun,  3 Aug 2025 09:04:51 +1000
Message-ID: <20250802230459.412251-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

The last use of this fallback was removed in 8e62a71738bc.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 135c4f319d..c45724b33e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -110,11 +110,6 @@ int info_is_fdpic(struct image_info *info)
 #define MAP_DENYWRITE 0
 #endif
 
-/* should probably go in elf.h */
-#ifndef ELIBBAD
-#define ELIBBAD 80
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


