Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23478700A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAAj-0000Vn-5I; Thu, 24 Aug 2023 09:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1qZ8I8-0005Mk-NH
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 07:14:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1qZ8I6-0002Gu-D9
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 07:14:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so52459265ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692875656; x=1693480456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oce7xfDfyTMN8VV3YKg3SNqws6mxx6AoApuBYAlhMpo=;
 b=qLV5Z1jhab4pUOFRtOI1wnsmeeHTStfEDg1QX4cKUKNuCH2NBNt0JT3GsVbHf4O/42
 3K6QKy8zu7UmDzRckHl5lkGNjzKPKydCFz3IZiNCuNH7JpCV5WrxL2vNKRVybgrPZmkC
 cjImpb/CFZRECQ9nCgOR3s+VwLnJ1PEu8nvHgFYXEV7F0yIg479WS8sFUXK3cVql+upc
 1ugOTAjG6GVWIFhSVpny4IKYvTxQv42WXK4SOD1kOLzcqKz4JqOMuLZjdbA0DTVh/zY2
 kdLbejvMxxJe93+S/TXlSRP3qZWqqeys9C2fqOslj0zE0iA/G3lZq8v61yKxRqFE6y+V
 0/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692875656; x=1693480456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oce7xfDfyTMN8VV3YKg3SNqws6mxx6AoApuBYAlhMpo=;
 b=DjGujLsr0d3Z3afljEZ4Xitg8u03/xCTC6JYGFfh7plL63zqWbkRgppaTLPXKG5bR3
 Y42b5ZyRmp2E0dd4ghm3DXEcUiMxmAIiCejp2/JWptOOEAL95HDFz9shvg3haWuOhxAl
 wqekbBSMfcUyb6Ho7LLwH4E82cl8FbGOkek3u64URkzFZDWYonSUBmnZgqw1jfOeqRx+
 LGIBuSqO9M5JHmUyBfec/H6rWcNVjdrvmmotE1mEZJZ7LnloAp2IavA8qs/jQmG7Jvsc
 cfpCV469LqBxTu8R9+Y3Rm3gxfXCTa09Nf4obekX2/baqNzOrDYOwe986MhWhGdhrAtf
 NBmQ==
X-Gm-Message-State: AOJu0YwcGcV8tD0xXzNVayjjmNaepAejXFPv9R2QJpj/AZfoUjKJacuv
 I02fznJML8lnsYdQvlFCNYfGuQkpAnOrpA==
X-Google-Smtp-Source: AGHT+IH8XcckUHIpfqtX2LBAdfd/Asg7xz4mmlKcgsa96ez4aLzQR1BgAhmNvs1zj9O7QepGEX6UvA==
X-Received: by 2002:a17:903:1208:b0:1b6:6625:d3a8 with SMTP id
 l8-20020a170903120800b001b66625d3a8mr17477623plh.16.1692875656470; 
 Thu, 24 Aug 2023 04:14:16 -0700 (PDT)
Received: from localhost.localdomain ([45.112.147.145])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b001bf846dd2ebsm7990869plg.303.2023.08.24.04.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 04:14:16 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH] target/i386/tcg: Check for valid descriptor table before
 loading segment descriptor
Date: Thu, 24 Aug 2023 16:16:38 +0530
Message-ID: <20230824104637.216258-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Aug 2023 09:14:47 -0400
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

LSL and LAR can cause segmentation faults in certain scenarios under QEMU. 
This occurs particularly when the base of either GDT or LDT depending on 
bit 2 of selector is NULL.

On real CPU, invalid LSL/LAR does nothing besides clearing ZF.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1376
Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 target/i386/tcg/seg_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index e8d19c65fd..4c36462162 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -78,6 +78,10 @@ static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
     } else {
         dt = &env->gdt;
     }
+    /* Check valid DT base before fetching segment descriptor*/
+    if (!dt->base) {
+        return -1;
+    }
     index = selector & ~7;
     if ((index + 7) > dt->limit) {
         return -1;
-- 
2.41.0


