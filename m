Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7A723155
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gg5-0006wh-3J; Mon, 05 Jun 2023 16:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfq-0006t0-Fn
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfn-0005jh-RJ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-256712d65ceso2358193a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996366; x=1688588366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vy1+4+EjeJN2rjgv7AIR8YQgARHZt7Wh5OCajfSPz44=;
 b=Ce1Rnzf+64b0JsRtu+tFIAf2rtgoz4sy4h3dAoBqVq2PRQx18/WxoTuxWRbD1oNRPR
 XusInUwhsiT0esQu2AuTDGHPlNybFFBpFL3ds8pv58HGdvXQjwQgVtdRWeO0ZESyHtq3
 ptMa3CvvNBA8LWR/Ud6kZ02iS5UGNtjJLQDN3Z5nb4riEEzkguyJ3VSI5QraE7dQyUPK
 0fwRm3ul37xbZ8InVdvy+5G0ztpLH95AlhrPd8/jKvwSRjKjDsD75sxhsZauBhk3ygB/
 EpiGymtHM9cIN0JnF/DAV6TNJDCd7M3iimZuYcrQIj1oEZLiBEdapKVrI3GFhE1bU6cW
 +1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996366; x=1688588366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vy1+4+EjeJN2rjgv7AIR8YQgARHZt7Wh5OCajfSPz44=;
 b=UTrRawhOiS8EfKfdx05TRmdSF9RbVlUqFdZZFMOEXAxE6itZ0VqqcB3otJ56s50kXM
 +aE8whQaVEKa5DZyHHbm3Vpl5mITwZGSCMhhp4AjadTLzHVthj6SnPFBniuPD5GGmw/O
 2jOQgk4jwLO+gvtjZhizldqLchS9ReyoEdgsNoo23xTdo+Ltn9t/kupkYUqHXNNm+81o
 JSafeaXP5FLyhokG8LZmtAjy+U0lA7uOzLykmNZWuze5KGj6myx0eRP+ilq/AQEL54G6
 oXUs3CQARhxX1SgGFiUdBwVReQn1s/W4LBHyuriRHo4Z9aKw7z9i/IPtwjQyDWFm5SvD
 9r7g==
X-Gm-Message-State: AC+VfDwaapeq1jbxvFGdJqlWpIhCue1ce/l3ifbDXTtbtv7f0sTxSnzf
 ue9uPVkUc+P4EHXYu2O477RZR4g0MHDNQee3E9Y=
X-Google-Smtp-Source: ACHHUZ5fKMnzT+oSeVjQ7Y8cp6wYdR44oQpJNa/aYolX9Gz8O3wQevRhc8rTtpYyszPX9jfkKo7lag==
X-Received: by 2002:a17:903:22cf:b0:1ae:40ed:4b8 with SMTP id
 y15-20020a17090322cf00b001ae40ed04b8mr55267plg.22.1685996366508; 
 Mon, 05 Jun 2023 13:19:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/52] target/arm: Add missing include of exec/exec-all.h
Date: Mon,  5 Jun 2023 13:15:38 -0700
Message-Id: <20230605201548.1596865-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

This had been pulled in via exec/translator.h,
but the include of exec-all.h will be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5b53b6215d..4d88197715 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -4,6 +4,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
-- 
2.34.1


