Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832580EC01
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:38:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1yc-00088W-NQ; Tue, 12 Dec 2023 07:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yX-000853-UX
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:02 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yF-0006jf-SF
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:00 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1db6c63028so640850566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384482; x=1702989282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNDHIJ1gpHeb2DpFjhHXsFTasuOwWoH4S7CHuQ8aaek=;
 b=ojx0WGqEhwWpQJ9gSrJkBwvq+gLt6iEtHEYJcQ9rC6FXxXhY5DeTulIMw209Bl3owE
 TTldd7D8uGxsqxxjvOjwIBt3QZJSy4Ym8q73MMz62RsMASr6spAOMBkLWlFGN6kqGn7j
 aqaEBmERxFz21bU2NSwh2JQDC1KgE+v1xemBKeNJjnWs9K+itYLnzgV3yzqAdDVWi5l0
 gL41/NhlS5JcWUsb0dEhcZvNwsHsARwaNIk9AE+7rnFvVHvpngIvZoTHnkQnex0XaXnD
 o/Dgk6MRzy4Skc1XThzC2DXfd+YpY6LUm5GDAyL8/mJ346Fu9OGdjZ2KdxVQ66lIZ0e7
 ySTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384482; x=1702989282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNDHIJ1gpHeb2DpFjhHXsFTasuOwWoH4S7CHuQ8aaek=;
 b=b5sDsGMTu9Vm4rOH6+3J6+cTY6b9KfwTqrsqUTOO4y1XfiaFkZ0ymEv3mP9YcG237K
 QilO49EzK0T3XBGac/Z/RbKvwjEXGyGHDFHKZRRVjqwk+qcM6OvNZ2KSTjaOCmUVq5td
 e9hVbDMsbfRnX+CG94J4w1E34f8/0Z6Kcj6jthLbXnPOkQWHKpOCcG4d0ghqH0xkmbbG
 o3kC9//LL+I2H5yt8ajxwUkLV1p8g1AChVpSgNOXPG7oJCxfyN2FnMhdXQPVp7O52vuA
 pbSt+mva+GaPOakea7qey9N4W/0Fx9LdUxbGPNHApfeanFKDf8q/osp8nnTJ0+KcgCPI
 JdLg==
X-Gm-Message-State: AOJu0Yx+jyGocJloBKpWDAvofNkekdQuuvzQjLh2NSXJm9+dIKV4gquR
 hmM9JJDgkKI+GXzVIN9z2H2LRqlGpOpEbMqD56EVPg==
X-Google-Smtp-Source: AGHT+IHiL6j5LJnv3YMln+vLFP1FigAz4tB19Y+jgocfMjyUq9luEcj8SPD9gopactYW2HlxIZ9OXA==
X-Received: by 2002:a17:906:13:b0:a18:cdd7:3987 with SMTP id
 19-20020a170906001300b00a18cdd73987mr3301144eja.2.1702384482325; 
 Tue, 12 Dec 2023 04:34:42 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tb19-20020a1709078b9300b00a1cd30d06d1sm6337726ejc.14.2023.12.12.04.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:34:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/23] gdbstub: Include missing 'hw/core/cpu.h' header
Date: Tue, 12 Dec 2023 13:33:41 +0100
Message-ID: <20231212123401.37493-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Functions such gdb_get_cpu_pid() dereference CPUState so
require the structure declaration from "hw/core/cpu.h":

  static uint32_t gdb_get_cpu_pid(CPUState *cpu)
  {
    ...
    return cpu->cluster_index + 1;
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 46d752bbc2..034a4ac211 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -37,6 +37,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
 #endif
+#include "hw/core/cpu.h"
 
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


