Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87B729758
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZeV-0000kM-HJ; Fri, 09 Jun 2023 06:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZeU-0000k5-C0
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZeS-0001B8-Uc
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f735259fa0so15721495e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307647; x=1688899647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1gQ05YVuLQqB4KG1j7pOjx2rNDQj4Y5tpKZYfWuMtY=;
 b=gM7Xu01QhbWT6jQTJNAKFdl70jHpQPVBkiQ2LEiyMLl+DUQXzBHHmwscBtr0yxty+U
 99zeX7aafIn0MrAtmoVRpnmViRXQMjC2ejLewkkKlABwZe+ev9uf4yVFP5QYETvMRJpY
 9ijxH5yAu9lWpWp1whZCGu/sy3dZbOi+sDtXusr2bGWXqgilFyVqGgE9orcPoLbeh5gc
 ijFFxSbQ99VIFCIQ8z/z3hi1qduR/00cxtJJoEosTWM7I/2tsh5aqQwGPDU/GYl6n9Fr
 kZ6SWg1bNOI1q9heclwrwRcAcdE9qPdYLx8BLzJHNRqip1uLs8y1PDVBWVnrIn6UCxRj
 pSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307647; x=1688899647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1gQ05YVuLQqB4KG1j7pOjx2rNDQj4Y5tpKZYfWuMtY=;
 b=BqHGC+rV1xFv0sxE4PnB5g550g8hPmxZvusjGh4u9eY06SomBB1E86MgcOwetbXWI3
 tIo7g7aVdbsWtl6Q3b0H7GOqdqTRqXVNym202cCqm9mm/ULerM1KYvrTPugRbAtx2pTn
 k2YxQIIruJ51VcaEsD3tVduDiJxsx/mys7pWUiVPQXy7IZV2vWuZjRBDvHM7IQPAU9uY
 YydovsY57ALovY8As7cuxwVXCKLkukhHCvNsUKykYPJ388w54H+Ne0y9nITf7Bk0A2Kl
 2NEr9ur8TpZ1+VoXLes2J9f/ji4ln8Yc7bcKSvqDqOohNQGGIeuBWlu3ZMPnEUja052a
 EZbw==
X-Gm-Message-State: AC+VfDyPe64wIXb+Bpq9Idt/8qFOP/fk5cl9l50CqrFloksvvjZEpGhX
 OVzogZINV1+ukNiDUH+BC7Sh5TeHf5oFmYcp9fIJmw==
X-Google-Smtp-Source: ACHHUZ4PBUpV63hQV36TtswotDP0ZmJrzSjtcX3DzOW2I6G5s+P3ot9hYKGEFlV4diSGc68GqFORrg==
X-Received: by 2002:a05:600c:2204:b0:3f7:35a9:dfdf with SMTP id
 z4-20020a05600c220400b003f735a9dfdfmr836061wml.24.1686307647181; 
 Fri, 09 Jun 2023 03:47:27 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c024400b003f60101074dsm2274132wmj.33.2023.06.09.03.47.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:47:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/22] plugins: Remove unused 'exec/helper-proto.h' header
Date: Fri,  9 Jun 2023 12:46:56 +0200
Message-Id: <20230609104717.95555-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 9912f2cfdb..3c4e26c7ed 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -25,7 +25,6 @@
 
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "plugin.h"
-- 
2.38.1


