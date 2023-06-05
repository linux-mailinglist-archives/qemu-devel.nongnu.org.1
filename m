Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA645723110
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgS-0007qc-3T; Mon, 05 Jun 2023 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfx-0006vM-Kp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfs-0005mN-Pd
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-651ffcc1d3dso3032214b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996371; x=1688588371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkNu/07W1UabgEGL3O6iOC160FND+mo9VSEEjlVkKeY=;
 b=XDGE2WGu8l+ug47KQuZTMl/7P5Dn6IsEa5jHBxLwrX7ceKA7ax4dUvW4U9tHzcBPC+
 4Lkc2CgFn3Udxc9Jxnrb4OrnNOz4fs5QwRpplXh2LzbTQkOv+pRs3GtFy9goIfrTWI3p
 eOvIHofw0z0+fc+RQDrUQIYVOXViq5kDZf+zsjvSpAc2skqBf6NnWLKIpzQ3eGpCIMxw
 IeKI5ZPQ0o6zYkTvQA9m85YLm9Lo/m+DHksqDGh0i01wQlSNZr+nCGpEsvmGLmo9F2++
 IwQ9oT72fs9pDHLfBiomyMwP4ZnjuaBfcVAL7wxp7lvf/wpR8u1LL8EEfdByN4X9ssr7
 DNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996371; x=1688588371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkNu/07W1UabgEGL3O6iOC160FND+mo9VSEEjlVkKeY=;
 b=ML96MxCFsuEoV8VFlfpI4q0POOea7heOXfnwXD3rpMFKRP4qXoEDQfr3ZR2UdGSQQ+
 LCuGnvPiGjtsNx+6F4+QQqPIaP2jJ5U2iTx97a8H6FLm1M6xPXIPbFYaB9kN9pj2oPnR
 eEJ/j85E2sc7uTApK58OljQpQ/zDtCH69y+f6E2t35ae/k0PophNWUW09haO6WvWOO+N
 aKMA0sBQ+QdQzETBWQrKxdkpJ+TxEzIJ2VpHBrBjB72hvQkhj+Eg6qpiVClQVa4bmd3p
 guu548J5hh66MIiDQ1M7W6LLS0ppAoIg7jD9NCm5T8xBBEF3A+AGuZchH+XGw0E1PocH
 bttw==
X-Gm-Message-State: AC+VfDwHDWJSFOHLttWdVDWQrzGTEcPqRtPtigWlQtBVzSIKFCdEX+zn
 Tk2Yc0ttjb0OjRobgSbITv2uf7LrTDCAj33jThc=
X-Google-Smtp-Source: ACHHUZ5IYLuv5BOWrv9r1QB/sn0m3pUL75PQJgDfGAAulj4Hlc10rVdJ9ObFP3EdBdLlDJGFyafAZA==
X-Received: by 2002:a05:6a21:789c:b0:10f:1e5d:9045 with SMTP id
 bf28-20020a056a21789c00b0010f1e5d9045mr95764pzc.45.1685996371550; 
 Mon, 05 Jun 2023 13:19:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/52] plugins: Drop unused headers from exec/plugin-gen.h
Date: Mon,  5 Jun 2023 13:15:44 -0700
Message-Id: <20230605201548.1596865-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Two headers are not required for the rest of the
contents of plugin-gen.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index e9a976f815..52828781bc 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -12,8 +12,6 @@
 #ifndef QEMU_PLUGIN_GEN_H
 #define QEMU_PLUGIN_GEN_H
 
-#include "exec/cpu_ldst.h"
-#include "qemu/plugin.h"
 #include "tcg/tcg.h"
 
 struct DisasContextBase;
-- 
2.34.1


