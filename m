Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C55825FAD
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 14:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM6go-0000bj-P8; Sat, 06 Jan 2024 08:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gd-0000Zl-0E
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:04 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gb-0005yV-HN
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:02 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so454523a12.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704547559; x=1705152359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVIESXOk5bK140JAyI+BSQBXs83euXAOCnCvVsW03eQ=;
 b=Z30GFj4hRzSPx99Lo85e/zrLuzDfLJxQJcAH03c2xSKpxCR2gUM9LinK+w6rcIvgJv
 rZbivZAc5dRkjXIMis9crf9j12isg4mp3pG2m55Ueu9nLeRiEFdS93uyIWomirGUSosV
 KvJhmUWdPd+XvYeKz2LA080zy50Ba2YY4BPZMy3TL85fLvoo/bAMF28iPf5viOPqthwf
 5bLl9IBRYVDvqRXFA+MTxeKYOdYOtRiUrvJ+wAs7IrrQtFsjVZqRSpLPJvzOIwCmNql1
 qc5JVO7TslklhAMhsJ0xmERDhoW2sl/6UTPpLmPd7yo2Og5k/zKVVu7wJvIv5M7qzVn4
 YStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704547559; x=1705152359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVIESXOk5bK140JAyI+BSQBXs83euXAOCnCvVsW03eQ=;
 b=iwUAFp6+tOdoxAHIMLHxjAYn9liflt8JuSuM+Yyw1eHQmXPVfsQTzIloxgntWA4q8h
 bpM/5EdEDEIMRXw2zjyjymhoQkvWnUJhTfqhmWByx9yEbn+PeKnawbWmUEcn2gP9zwlL
 zHijnJvMKTFb4w6DWFkz3sxM+Q6q8lPXr5CM0NxO7n+X3icv/Mycu6BsKZyh068UqAa6
 DnuaJAlwpOHdUm/GarZwgLwsWDQv2VNBfzPpFUT2eF/U126o8kdl2CaGXuxSByk0Y0wj
 vTHnNGkD6e+YD8FOYFJ96JNKYFw8D1tWkrA8vBp9VVCATiX67zl3L3nm+7ZaVIKUmby4
 0Vng==
X-Gm-Message-State: AOJu0YxYcXkZoGgmchmt1ePoUz4RQqU3HhHtCyOaRmyLzxpB7f8mbjMJ
 x2FF9RE8++iDnknMO2MAhehmP3VHS1s=
X-Google-Smtp-Source: AGHT+IEHVgmFHG/slMf/wkbvSNJ8IBWa1UDTFSBK3GF4z8UlOuvIQQtA74Vo++VkRaHCNdb4l0H1VA==
X-Received: by 2002:a50:ab15:0:b0:557:34d4:e523 with SMTP id
 s21-20020a50ab15000000b0055734d4e523mr506665edc.39.1704547559206; 
 Sat, 06 Jan 2024 05:25:59 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-174-094.77.11.pool.telefonica.de. [77.11.174.94])
 by smtp.gmail.com with ESMTPSA id
 3-20020a508e03000000b0055515b40464sm2159752edw.81.2024.01.06.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 05:25:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/3] target/i386/cpu: Fix typo in comment
Date: Sat,  6 Jan 2024 14:25:46 +0100
Message-ID: <20240106132546.21248-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106132546.21248-1-shentey@gmail.com>
References: <20240106132546.21248-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2524881ce2..7d11edf4fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2178,7 +2178,7 @@ static const CPUCaches epyc_genoa_cache_info = {
  *  Conceal VM entries from PT
  *  Enable ENCLS exiting
  *  Mode-based execute control (XS/XU)
- s  TSC scaling (Skylake Server and newer)
+ *  TSC scaling (Skylake Server and newer)
  *  GPA translation for PT (IceLake and newer)
  *  User wait and pause
  *  ENCLV exiting
-- 
2.43.0


