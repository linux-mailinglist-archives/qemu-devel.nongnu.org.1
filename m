Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C748147AE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:08:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6zN-0004VD-5M; Fri, 15 Dec 2023 07:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rE6z7-0004V4-Bc
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:08:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rE6yy-0007p5-Mt
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:08:02 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d38e5b1783so1206955ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702642075; x=1703246875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Io9EuHyX//wkg+bU4mQ+LQk2gzu1GzwcSlomPKBaPg=;
 b=kALwCdZlstbkyDgJHn4Yw0wP8g7pnV6Qrrr8xXebk98mHcwyK8ZVGi2fClm1xkwyd+
 z4qTKGroDIcm5VscfmM6myXj7JGwyqIufBnFe/hcpXUq78VjaCwh3eCFwAW6uwswzw+R
 0ZT9NS5eS5a3Pqkn7Y9czcWjDlSmXNbqCACO5qYi7gJjaurmKdt1y8D3IcuO2tXzjJod
 vr1GdoJG8eXD8nM8Jb004263AxYZJJSBljlNB0f8yO0mQk8sxsspZgUOdp4eVOsQnTgu
 E83bVXHMGHei6qJwuQo+TTFMh1ZrqlW5FU6DjGJLYjX1BF0lI6LFDalBKtTcpmh0vIm1
 hdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702642075; x=1703246875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Io9EuHyX//wkg+bU4mQ+LQk2gzu1GzwcSlomPKBaPg=;
 b=TUF1svxVTOpZcW3GSu/H40Cz1o3KmSenoxzexJv6njVttwUgoGF6YBsVxzB67ga0Wk
 l0Exk4YDe66NpxaL8AdlVJ35yW63v+WOw92w2BgBjf8cGp/WoNWQCggRgiFQmnTBgrKv
 ISAh6xzVbiFC30bbE/324UYHkZ1BQktMCu0Z9nQZG1jJV/ekgH/LdrsuU9/m1kAVgjFH
 mR6wKcwXrS9Uc3wZYEPIRn4LTDBXDkMopvl4vXDuxxaDgMfeA2Z/tbQVMcZYNWBooBcy
 gVBAwza2sIYPItFf3UtrGM4YUKKxK0iMwqxKSVEKuapMrFTSEc9xw0L8x3D4wvAAII/x
 J+aQ==
X-Gm-Message-State: AOJu0YzmwVBbMj7jJIyQIsp5TuxGP0duHw96GOoIfVDFuOP31QhV3Mol
 BDct8xYQFWGVvWe8Yg/c+4OEdrkKyEo=
X-Google-Smtp-Source: AGHT+IHTk1RawDZUTfF6cGYETnsabSHe0TA0qPTKBUoVHfOEON8+H5s0nCJ4enUQ9q0FtqJ+O1xJOw==
X-Received: by 2002:a17:902:c950:b0:1d0:6ffd:ae0c with SMTP id
 i16-20020a170902c95000b001d06ffdae0cmr7047675pla.115.1702642074820; 
 Fri, 15 Dec 2023 04:07:54 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902848300b001d33e6521b9sm6610520plo.14.2023.12.15.04.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:07:53 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] tests/tcg/xtensa: add test for OOB TLB reads
Date: Fri, 15 Dec 2023 04:07:51 -0800
Message-Id: <20231215120751.545636-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add a test reading *TLB ways 0..15.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_mmu.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/tcg/xtensa/test_mmu.S b/tests/tcg/xtensa/test_mmu.S
index 1006c8cf77b2..94cd09563c7a 100644
--- a/tests/tcg/xtensa/test_mmu.S
+++ b/tests/tcg/xtensa/test_mmu.S
@@ -43,6 +43,17 @@ test_suite mmu
 #endif
 .endm
 
+test tlb_read_ways
+    movi    a2, 0
+1:
+    ritlb0  a3, a2
+    ritlb1  a3, a2
+    rdtlb0  a3, a2
+    rdtlb1  a3, a2
+    addi    a2, a2, 1
+    bltui   a2, 16, 1b
+test_end
+
 test tlb_group
     movi    a2, 0x04000002 /* PPN */
     movi    a3, BASE + 0x01200004 /* VPN */
-- 
2.39.2


