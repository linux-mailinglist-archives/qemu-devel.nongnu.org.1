Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A580EA69
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:30:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0yG-00068y-E9; Tue, 12 Dec 2023 06:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0y9-00067I-N4
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:36 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0y6-00049w-5n
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:32 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a22ed5f0440so50336266b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702380624; x=1702985424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fkaQw1wTm7vzI2qvTLdmXvYwQIxTgYgYOSzytSBkrc=;
 b=iNN0HKL+vIJqzv4LpCcMa7R8Sb++BAMQbxyIUJmV5T0+w1ot7QPHe8a+ZI/AoolMVQ
 M0SGc51D/lAFhbNKylH17UI3TR15x6nHoAhSUiF6mQWSP9ObcWWizDfHLRzZeC3pqRzI
 4D/rMsYjn5QvCK4FkF5L1p8v1tUX3DnBBQR8vIvZxpe2N/YR94NS5MVNJGtMBSwg86ry
 vq/VFD0OPo5IuInu/a2vB2GrMoCyEa+WhEM9KLG6wOSuDDZyte8vEZV+HfXE5SlnKQhO
 HdWLnrY41Flgjla0rGD+3C3iqJFw06J+ZFZ+/GFGdibOH2deC8aOv+482P7jzh5tKOMC
 wZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380624; x=1702985424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fkaQw1wTm7vzI2qvTLdmXvYwQIxTgYgYOSzytSBkrc=;
 b=IzZ7RUC115rLGiDZiGX0/fgGnbcYwvXet9OTL4p0YiT1L/1lr7Gzj3vkFSs8YBAa7k
 RSAsUttPT3ne8wjKTUO9PfWtfiifZjtZUVmdWekcS5ii2ZitAgpHwoNr7sm9Ezpgl8lQ
 lbZjl44Qv2hGWQv1VtDm766vSVLHS93FMkFrIMmVOwOVc4NN9BGB2zv5w7CbZ7oXZ1eJ
 K8ixXUwE6ZcMwXPhrg1ggq/6+KmAOTcnWGD/9YQAjGAaNd5bvEev9EqxTxW72AATesxf
 yrAhlnjIorHEu2BgdLUi5MkHHOA/vhfxHADGCOrmN7aGFyJQNB59idCERCPH+1zd+tAV
 9UQg==
X-Gm-Message-State: AOJu0YwJUdMAXpFjWmF7Sor/kF6/ednKlaDebKxjtXe9rtnNNFBYt+lK
 YM+u0Ll+Fw+4Lk42ia9N6GkA/MU7ySTBa8xcgRtT+g==
X-Google-Smtp-Source: AGHT+IFIx+C0xTXu+zxx3FrDRRVzMU0y+G6DazBAJAo6jeivBp6A8t1MW8bzR/dAEY8zKSAlHQty6w==
X-Received: by 2002:a17:906:e085:b0:a19:9b79:8b40 with SMTP id
 gh5-20020a170906e08500b00a199b798b40mr1892770ejb.81.1702380624549; 
 Tue, 12 Dec 2023 03:30:24 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vt4-20020a170907a60400b00a1e1a1dd318sm6174614ejc.137.2023.12.12.03.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:30:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] system/qtest: Include missing 'hw/core/cpu.h' header
Date: Tue, 12 Dec 2023 12:30:15 +0100
Message-ID: <20231212113016.29808-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113016.29808-1-philmd@linaro.org>
References: <20231212113016.29808-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

"hw/core/cpu.h" declares 'first_cpu'. Include it to avoid
when unrelated headers are refactored:

  system/qtest.c:548:33: error: use of undeclared identifier 'first_cpu'
            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/qtest.c b/system/qtest.c
index 7964f0b248..6da58b3874 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -21,6 +21,7 @@
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
 #include "hw/irq.h"
+#include "hw/core/cpu.h"
 #include "qemu/accel.h"
 #include "sysemu/cpu-timers.h"
 #include "qemu/config-file.h"
-- 
2.41.0


