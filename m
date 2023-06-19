Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A340A734C84
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9Wk-0006eZ-FC; Mon, 19 Jun 2023 03:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wi-0006eJ-Bx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:16 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wg-0004RP-Np
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso3186555f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160533; x=1689752533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BT5WpWOETZMXxgChaA/hO32lYMuyGzMiCBmIgxW1Frk=;
 b=umUk00NvLphY0IlIANc5KbQE5bhlJwwKeZcl4fyhJ+EZSz23anx/rnx/RicmWgOAN8
 vKdUKaJ+cygAKh8Ag5pABbRBT6My4hLE+VguA6+tWbYsttlF8kUYD9Yv6hJiNOBRF8te
 MbDEnFWFo2Ll5DnZXAhoXpAj27yUPDZgr9aBArCoCr5Uv+be4fVQtozKE738Gcz5RkRx
 VAocvAr6xuBWwkmL6iGs/iQSSR4/6yq1FwslQ+NPlwNGNFzkUoJwWsDAUr1eLGci6QwQ
 ytOjpInInl/HGD7j3iPmU/+pQkNwflfEf9Q71ElIFMPoMRbyBKW8PJfkIQewv9zxyywf
 Z28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160533; x=1689752533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BT5WpWOETZMXxgChaA/hO32lYMuyGzMiCBmIgxW1Frk=;
 b=N618W5DyUcqbT2P68gEUPCgtlPNytaDUEyD9xUpLlemzKc3YpG0I0mALEzxFmuFOR/
 x7vo4eXeuYmofBvhFC2xiADr+EnrQ+RbGN8wGVLSbLZuCmHEXUFphgcQugKFTLeOCWTl
 7LXefcPOWQmfO9ILsDCdAFP/LjEBRqyS7s/SESoFoIxJI4FSjCFgJGQkoPx2nlzycByb
 DdMbzSjIxc1p+0aHM0Epnokq+5Fpg+9JY1xI2+1Mo6UuP2ehDMtIeAAGw4jf5Jwv5lQp
 EbCOkThXEe2MQerjTJ/gQs2SFHgspt36fw9TU/RVKTX0PRRAZjZ5eDWNgSbNBBHsR9my
 /yJA==
X-Gm-Message-State: AC+VfDzCDD12lUsRObu/LD+cooOgk54JlUQs3l3xWSrJ5dlUYaR6wXlc
 Qpr9yyh71xU+AYsPh/6tGZnjQLITiiUlZI+AxSHo6Q==
X-Google-Smtp-Source: ACHHUZ5h2BLgoGUrZ54XYb21bpMoPxOtd7xTNMLSSiHnhPZ0Imsc810frdGVzsuPUdg/pyCGUtpTrw==
X-Received: by 2002:a5d:668c:0:b0:30f:ca58:cb10 with SMTP id
 l12-20020a5d668c000000b0030fca58cb10mr9968812wru.22.1687160533141; 
 Mon, 19 Jun 2023 00:42:13 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 t1-20020adfe101000000b0030e5a63e2dbsm31033657wrz.80.2023.06.19.00.42.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 00:42:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] exec/address-spaces.h: Remove unuseful 'exec/memory.h'
 include
Date: Mon, 19 Jun 2023 09:41:52 +0200
Message-Id: <20230619074153.44268-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619074153.44268-1-philmd@linaro.org>
References: <20230619074153.44268-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

"exec/address-spaces.h" declares get_system_io() and
get_system_memory(), both returning a MemoryRegion pointer.
MemoryRegion is forward declared in "qemu/typedefs.h", so
we don't need any declaration from "exec/memory.h" here.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/address-spaces.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9a92..0d0aa61d68 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -19,8 +19,6 @@
  * you're one of them.
  */
 
-#include "exec/memory.h"
-
 #ifndef CONFIG_USER_ONLY
 
 /* Get the root memory region.  This interface should only be used temporarily
-- 
2.38.1


