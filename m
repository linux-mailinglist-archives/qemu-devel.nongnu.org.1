Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D77922B8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVKz-00034d-Ow; Tue, 05 Sep 2023 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVKu-00034E-Vs
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVKs-0003Th-PJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31de47996c8so2176622f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693917553; x=1694522353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNyRQan96Bf1rDRGqalFCVPtf/3GFPoL3n5h/X6kicI=;
 b=S3pGlQApP36sAIboUGcr3BeKUaWc+yk9HTjjWFBsIGgTUlA2wADQzXrPiVJ4xQ7UNu
 Ma7ytFWw2MqW3+NIggwV4m59qBnHjoivL5u8lRUH+wG2f6Fp5Qnl4tN2CZCnl+dfu47g
 fCdlfuuZAVXz1PsgkDPuB+hdyJJtCYJ+qEHT9VzV8Yp+Y5m7HDn/Bbjt7B3Jj0sOuuwT
 J/UGuBEXH3daQqpCrjv+Q2p1olA7U18RCmawMsl/VO+OxoHdRdVgkFACjTgA6THTsUMv
 rD576f0DfDlA+/iB1VW1nFPwv5CEkHLOXqVp4TAR2zUXhzaJH2hPyfXjFnvzQ2Cja1B9
 Pm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693917553; x=1694522353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNyRQan96Bf1rDRGqalFCVPtf/3GFPoL3n5h/X6kicI=;
 b=HRaxoc0CQ240z+MzRfeNyF351n7ro9O3sbdK7Bl6ieo0fnaJ6VFfaMyKcGhFX7iiBp
 tcybZ9IYLXP9r5GB3pNMwIjOsOObNCQh8GSftpSpiaO3RpeIPbkxaMaoOJPk/n7pSBrZ
 KLFag/ZVdqoQeHRESuQKFplprtrtx8RrFnCuRI+PWLLO4unZzjXFv+riE1A3c+IZySrn
 JywCVBnDkk/oHu8Stumyi28KFToRfJk4TiA87RmZo2I6z1OXxoNvmCBeSKOS6zlZXnsS
 kElmFaS45fdY/Z03mmPcQoTB8mtgn7htAsE0a4xjoaD8NwKv3PPW4SBTUyhAzOQ4ueNk
 9xNQ==
X-Gm-Message-State: AOJu0YyDunI5xxKolhge/qNXubOmx/GQE5cTnELUrrpnUycDYs6DlRhb
 QP+/Vl1HQzObNXV2Enmpm+ag7oHS8viitSqrkeE=
X-Google-Smtp-Source: AGHT+IHfW0LBYk/Ni1p4alrX08qHlFRmZ+JD0K5shDchOj7thQMz5LLoSafjeTCHJImc5UtWQd8PWg==
X-Received: by 2002:a05:6000:1143:b0:31c:6525:770d with SMTP id
 d3-20020a056000114300b0031c6525770dmr8823030wrx.1.1693917552958; 
 Tue, 05 Sep 2023 05:39:12 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 c4-20020adfe704000000b0031c5e9c2ed7sm17406813wrm.92.2023.09.05.05.39.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:39:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/i386/hvf: Remove unused includes in 'hvf-i386.h'
Date: Tue,  5 Sep 2023 14:39:05 +0200
Message-ID: <20230905123906.6880-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905123906.6880-1-philmd@linaro.org>
References: <20230905123906.6880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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


