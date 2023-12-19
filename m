Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD0819070
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXG-00024J-19; Tue, 19 Dec 2023 14:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX5-00020s-MS
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX3-0001t4-PQ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:35 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33671384e50so1164622f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013209; x=1703618009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0NHBQEa3FZkeVazUjrvD8hJIhg1weYMkC8vKZ2fiVRE=;
 b=Uib49gWLdb3vfuqC1OgxGc9qf1gdwR5yZM0+LnQIYiNajlGzLrgcbR1wmvgwlUCHzd
 mtrAAI7eyBypJ1kTagNB8tqEmit+230lxwFQzF5Cbp7ampuU2P6JdWg5IOYg38iFazyI
 acn6IU943hGiy0k1dn9I1gr+1sG7CccPmEnEkQKsWqpvvf3Va/zuhg4k0gr2SPZBNAg3
 /0bTmScO3ltRoCgytMR1v1/yjNOwFNCZyhztP+uvgX7rxfnPmx/KJUIRAH3ZxflVY5r6
 SV+9NLHtYUOqdfLTuBiih+4xzn1WNCflOHVI3DXvdwqEtFEi7QFL2xSvZhMMl26kymQU
 B0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013209; x=1703618009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NHBQEa3FZkeVazUjrvD8hJIhg1weYMkC8vKZ2fiVRE=;
 b=Uw2FuAtPl8J+ZbkgJ0964x4Pj9qrwhuypZRQ9f0L/IHvSkm10bshPLN1Cc5yzfrW4i
 E2B0qROBNmAqAC+p5utepF1y9/B37eFFXreoVMLUmWg0CSj4yKn4G3Do/s4XalMANcNI
 AVMffOZZywJ7Nl9obgxZcJf0egudY0CiLC7lsG/qYNS4GrLnMJpua1OJX87xS0jgi+Dg
 9bGFEZN9iGvEGoLuWt+NPaZS5SSIcysRGN/PnwGErkC9y0AUzGYyYYkOQvnocGxWwNNh
 900UTbSmsK0MYfUFkJiOShVDO12USAcJWdeGbjM7ryCLFVgmvn8PTBPBWudwHUiB6pl3
 1BKQ==
X-Gm-Message-State: AOJu0YwtX8/mINhkBWyQJ9Jc1HILe7IqEqwxlQ6EpHePBxgpXXVW50Rf
 d+YfJwRTKwMYIRws4whv/542pX+7HcUATPS75e4=
X-Google-Smtp-Source: AGHT+IFxEc4f2AF3nvMouQGecjJv/jjNyUVwBQV2vb2oHX3i/3yNTc4JMDWGbT/0YpY2cICeFCyH9g==
X-Received: by 2002:a5d:458d:0:b0:336:6059:5329 with SMTP id
 p13-20020a5d458d000000b0033660595329mr3399738wrq.46.1703013209042; 
 Tue, 19 Dec 2023 11:13:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] target/arm/tcg: Including missing 'exec/exec-all.h'
 header
Date: Tue, 19 Dec 2023 19:13:05 +0000
Message-Id: <20231219191307.2895919-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

translate_insn() ends up calling probe_access_full(), itself
declared in "exec/exec-all.h":

  TranslatorOps::translate_insn
    -> aarch64_tr_translate_insn()
      -> is_guarded_page()
        -> probe_access_full()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231130142519.28417-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a2e49c39f9f..f3b5b9124d0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 
+#include "exec/exec-all.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
-- 
2.34.1


