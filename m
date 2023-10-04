Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDA7B7C0E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny8B-0000GM-V6; Wed, 04 Oct 2023 05:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny8A-0000Fy-8v
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny88-0006WX-Q9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1734498f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411518; x=1697016318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRWPGyvamS9BaoZFO7yButK2HqJrbjFh2qkgdvEVg64=;
 b=IYHnlVjo/fO8K868lxPmwQ6lwq7ZbvUEDXbT9vALQDu0snFXK6zYHoDaNLBBR5Y80x
 dYo1j5G8apdbO+X3GWqEsLzTQe1hPRVSwUCD15fSPC8/YmbbxAdXWU+Rs96oofp8cye5
 Lu6CtY21n/P7r4RyIAVs8bLN6X5Rupt+leRoUSQzyL3fg4FJ4Jus9dDYYREfVe8Omohg
 kongmMm+0Lq6dFVAmlHglS4mSC1oidjrZPJ5V/cPXy3ahFk2xrCPCRCEuZLed/b24ZHV
 4NvsFb67Ax+/cVUkYQs8o/oPD4QXIpp/yavD+1l7kU0lcGpfLC9UZkw3wolOjNqambpo
 mYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411518; x=1697016318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRWPGyvamS9BaoZFO7yButK2HqJrbjFh2qkgdvEVg64=;
 b=GcY39I4VhtHh0PKzDFBu7+A7bTkdtr4wMzdffTdq/72o1Y5+8zWVAjISZe+0HPDf/m
 JaKccAedI8jOmg1+seSHFgQj3AVmN68YNWnt81WFF+wJoRzfJLq44vWtrEgYcCjjIh+u
 tCfQ7T3Z5H85Ay+E/i0Hz0LTomZ8orD1lBgjgwMA3Sf6Ly/xBMNhroQFHipFLelwx/YI
 P5PTCy+88dwLhTz4RwFx/v2rCHgUOdHsSytIEG00kK9SsPvgV+1snOgdx2EM39V4UyIG
 /QNc/xFshLwYl9VvU1EmOEbHjUrMC2dSrTkr9iPRFxUMhoTF1A2375fgepSXspwzO+0O
 U13g==
X-Gm-Message-State: AOJu0Yx1d5sETRS/XffHM3cxbdEKsaMDzmaPRqi9NETXwvXMvTKHQhJm
 e5nDe7YG3buYuIn5RaySYx4tNvPvvWqMYo4EbEs=
X-Google-Smtp-Source: AGHT+IFuFZreDy3qyIlJHmh6DquPUSR5Mg4Q+rPsRUYNROq5KORSMHqS5Bb14nM/PABFsF2U8Ri+bw==
X-Received: by 2002:adf:ea4c:0:b0:320:bae:2dfd with SMTP id
 j12-20020adfea4c000000b003200bae2dfdmr1625172wrn.5.1696411518596; 
 Wed, 04 Oct 2023 02:25:18 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 j10-20020a5d464a000000b00317a04131c5sm3534791wrs.57.2023.10.04.02.25.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:25:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PATCH v2 1/2] target/i386/hvf: Remove unused includes in 'hvf-i386.h'
Date: Wed,  4 Oct 2023 11:25:08 +0200
Message-ID: <20231004092510.39498-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004092510.39498-1-philmd@linaro.org>
References: <20231004092510.39498-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The only non standard type -- CPUArchState -- is forward
declared in "qemu/typedefs.h", so no particular header is
required here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
---
 target/i386/hvf/hvf-i386.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 95b47c1c2e..243bc111cc 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,12 +16,6 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
-#include "qemu/accel.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
-#include "cpu.h"
-#include "x86.h"
-
 void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
-- 
2.41.0


