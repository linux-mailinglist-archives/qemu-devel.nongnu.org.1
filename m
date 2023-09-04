Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B81791B56
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCEh-0007HN-R6; Mon, 04 Sep 2023 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDp-0006Mx-NG
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:43 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDm-0007oE-CU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:40 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bcc846fed0so24824821fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844076; x=1694448876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bvkfrc224yUF6DF6DTCqAYqVQw+ygdwws/3+78VrLoI=;
 b=acI2z3s3au07RftiPtQGrY/MtiI/7MaaawUW9yLXUFwLCfJrUX39c11gTVG1Qi8iGV
 kbCWCcIfvA87LPXEB6a45SL3Wx/Rj1GXV1Y8p7JHKVzPnEiNBqUOwQJ9EhXdJ3BZpac8
 weJK13x562VxCKxeQ2TsyIyRmrJ+slg/25sMB05f6NEJZ/lY61g7nWrQ4T/6uFPzFLp/
 RUdmLycVPhiHsV4zW580LhXWKM3T7Ag/IVsE4vG6ZsyHObJe81++nJD3GoYVDxksc6s6
 CTJiTwVVmhrKvwpWp9cCmv+3RNemsACe+wIkZQ+Fi5d/MlnQSYz68aGjea3MLMprzfcC
 22+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844076; x=1694448876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bvkfrc224yUF6DF6DTCqAYqVQw+ygdwws/3+78VrLoI=;
 b=LcVoWXp9bMd8Qms/BEMssaDYDCGR52O3jIjVgQVNE3vHOfmUpOFNlduCXr0LcmIxKr
 CqR+HAIRRNGoL2o4nFMRqv/Jc2JYrbihEnEGP/JUYrYh6J8zXTDOu6kOaF+HZe7Pj0Xh
 yXi9QxMOf+mmelu3bXI+mPC1SixxattA0yoPZX31I1QW3aT2xFDE6nfciR27k4HsU7Nz
 GbZXqp0vPFBjDeyvsDJR7BgRQi0qHx/2nSRZb46dtHwauq3SJm6x7yiXQ1JV+5lq+YTG
 T2fEfTs+g6tED5VBpH/L7UI2ykycIYz7RZ+NWBzeUILdpWS0c31I+32YSlhdVJznH0f0
 ubrw==
X-Gm-Message-State: AOJu0Yyse1+mZ9fSi3NDGO5Iao4FyfmLg6xmB/MiS/X1wmt3NITWdf73
 T69JjdfTqVBpBEvWlBsY/bITnQ==
X-Google-Smtp-Source: AGHT+IEesCMWtIBNelqvTphhVlDDQaXrJ1066j6qk+ks7u0QsJMZ9CqW0zTh4LUp1QnyOBTENyeq6Q==
X-Received: by 2002:a2e:81cc:0:b0:2bb:9fcf:6f64 with SMTP id
 s12-20020a2e81cc000000b002bb9fcf6f64mr7227876ljg.28.1693844076054; 
 Mon, 04 Sep 2023 09:14:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 qc8-20020a170906d8a800b0099275c59bc9sm6345022ejb.33.2023.09.04.09.14.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 21/22] softmmu/memory: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:33 +0200
Message-ID: <20230904161235.84651-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  softmmu/memory.c: In function ‘mtree_print_mr’:
  softmmu/memory.c:3236:27: warning: declaration of ‘ml’ shadows a previous local [-Wshadow=compatible-local]
   3236 |         MemoryRegionList *ml;
        |                           ^~
  softmmu/memory.c:3213:32: note: shadowed declaration is here
   3213 |     MemoryRegionList *new_ml, *ml, *next_ml;
        |                                ^~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 softmmu/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..bf48350438 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3233,7 +3233,6 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     }
 
     if (mr->alias) {
-        MemoryRegionList *ml;
         bool found = false;
 
         /* check if the alias is already in the queue */
-- 
2.41.0


