Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E810380EC4B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1z0-0008TT-Kd; Tue, 12 Dec 2023 07:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1ym-0008I7-5u
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1ya-0006oE-GZ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso57536585e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384502; x=1702989302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbDQbeYc3MqbJhEQi67twemcgBt5US82mKEOXjqMt3c=;
 b=LCWjlppoJDWo0gfsxvpcK90lyyPmjphMYVK+VJnrA0buSOwAaiMo5W4wunwDf4ueNF
 GCKjvxiduvYJl/qEgtujAVjBmGwsjHWGgbXWEVNby1GQZd4A2jTdWtHMFwKKqg05M1yc
 NuvtBTiF1ELofOOL1SXrDmKMRh6HccDPzaBt5wA0Gn0K2xMXQ+ti0X+Xz/COldVtnMwP
 QCijq4FmKwq5jWUjragRp+zBAFljcSK06iSojaC4YyE5hCkxRAgPc+uvSoOWBr6rtoRZ
 gRgg1On5SpHYjbnWokl1k7vWXbMAVW7nqy4Bagc7jIueYQE7s2ayqRSatXCH635O/V3l
 yKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384502; x=1702989302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbDQbeYc3MqbJhEQi67twemcgBt5US82mKEOXjqMt3c=;
 b=PZOslIslRVzY1m2hlxlSaUNG49DlQ2i1yQ6dgeQ2Aph99tNmdcrPUiaoHlK+bhi+gC
 e7qO6nPQBTp3d24QXPIWapw1uMaPPQjogLZy9MV7bUEZXQ9Qe6D5rvaTUzZQPruGgQkt
 a9EUfJQDyEPKANUQTIEiMuXiBZFTHvWE8+nDmyLEEQ1yUBpYCdsYBZMxnIdZf3Y6CJGB
 Z2aosdEnX+vKrl05k7w1cGc+951wbCpVuw6oP72FOMe4VDq7pIVEohYSmaPsF8Wjy5Yp
 0jLUA4sdczxuOxQmNBbZcCk/vIN9YwOHVp4plxPERTbiTBT/7W/4AP6x5DQjyI2nBeYp
 ozcg==
X-Gm-Message-State: AOJu0YyjdvDSqIAxrCSYo/YYCMkbjpx+6KqaVmvYPqVltakNrtn68xNK
 0AUaCRTjj+KdMRqvT/Q9zX6blY/Oh5NaL15o/35WBg==
X-Google-Smtp-Source: AGHT+IGAESSZtH6ln3MK23t1PKoi3W/qmoRgb3hb0VMjf3EB3hN4oQZHMKkiXJGz/0Uo3HbdxEGPqQ==
X-Received: by 2002:a05:600c:141:b0:40c:3667:9e89 with SMTP id
 w1-20020a05600c014100b0040c36679e89mr2486829wmm.85.1702384502203; 
 Tue, 12 Dec 2023 04:35:02 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 hu19-20020a170907a09300b00a0ad580e1b6sm6140865ejc.48.2023.12.12.04.35.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:35:01 -0800 (PST)
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
Subject: [PATCH v2 08/23] host/load-extract: Include missing 'qemu/atomic.h'
 and 'qemu/int128.h'
Date: Tue, 12 Dec 2023 13:33:44 +0100
Message-ID: <20231212123401.37493-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

int128_make128(), int128_getlo() and int128_urshift() are
declared in "qemu/int128.h". qatomic_read__nocheck() is
declared in "qemu/atomic.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 host/include/generic/host/load-extract-al16-al8.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/host/include/generic/host/load-extract-al16-al8.h b/host/include/generic/host/load-extract-al16-al8.h
index d95556130f..6b47339b57 100644
--- a/host/include/generic/host/load-extract-al16-al8.h
+++ b/host/include/generic/host/load-extract-al16-al8.h
@@ -8,6 +8,9 @@
 #ifndef HOST_LOAD_EXTRACT_AL16_AL8_H
 #define HOST_LOAD_EXTRACT_AL16_AL8_H
 
+#include "qemu/atomic.h"
+#include "qemu/int128.h"
+
 /**
  * load_atom_extract_al16_or_al8:
  * @pv: host address
-- 
2.41.0


