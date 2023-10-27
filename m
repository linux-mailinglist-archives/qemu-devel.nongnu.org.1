Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DEE7D9C0F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0t-0000jK-Sg; Fri, 27 Oct 2023 10:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0Q-0007On-NR
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0K-0008FD-HL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40839807e82so12980875e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417603; x=1699022403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K78hyFiUfjBNQ327SfBAJK9OTghHVAMBRjNgq2p4Bk0=;
 b=ZT3Fjw/TsXFmfMnHGVCab/I7hDj847TUccGpgoum4USD9iu7sVVnlZJf2XOH8Hiw0u
 XYPwgkQDFNo3YDVdvpDuGB5vfIgA8PhoGbtCi4wz3y58QXlFi83MLrFrM8QWPav5tVE6
 FL3AFC0JZV9tuh8TD9GWpwcb1tLhpzdCmDz4AsvJN5l9g8hEJ1r/9TRUlU8Di3XKgKEt
 2LYzb85Hn7tp6QQnZ3zIJlgpNTKfhYWbBRDY7GOJ56fq2QCBzukCLPGxIohFRKSTkW5L
 +rpinXoh/q0jyuvSI0Az74a2mTBqoRKAtjMFdXHfm9KrZ4n6BlO+Bg+hYTkntmPOKBC0
 zO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417603; x=1699022403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K78hyFiUfjBNQ327SfBAJK9OTghHVAMBRjNgq2p4Bk0=;
 b=D54LNFx20b1Q001nCeku+7HFc/6ILar2BXjDrFlGzC24d6wkbiRK01IU5DSAteLKps
 nAGxlrXMziWjvHawKN5M/PK+1krtpotNlx5kh6AbFfEUXEYK4iJTX3U23a7J+ZoeZbHu
 DoteI1ZP0s1lG7HF+m2EkkWu87St7I6A3MlG3U05oIFeOWwq03uWXpjQfY0HHkgVVyw8
 UIDGpFnuxU+Ds2fbkkRRKoNbEkNAWXljfOC3e7r0G9OGq/MOHWW/34cfaxYKH9a/ZxIC
 Z6Jx+8XgVF2i/Ilz+qXF48YdGc/3KTntezIgQPa4LDQxBJfSCC6bNtzWikiSI1gJZrvp
 hspQ==
X-Gm-Message-State: AOJu0YzW9k5gyLoutf3ShHA1S7G6maSD2d8uk7nCx5i9MIDfQkXfeqYr
 weLvIIvQKcTOn/iJ0OiXFZiPTee6TOw+9zIUKNk=
X-Google-Smtp-Source: AGHT+IGudAHt79dh0UoQArOwii4NbCA1HmZ5yR2Fk3OhIF+CTp8P1s/YV8OVEx0/arRJ2nOiQfIzRA==
X-Received: by 2002:a05:600c:3585:b0:405:3be0:c78d with SMTP id
 p5-20020a05600c358500b004053be0c78dmr6681313wmq.3.1698417602753; 
 Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] hw/net/cadence_gem: use FIELD to describe DESCONF6
 register fields
Date: Fri, 27 Oct 2023 15:39:39 +0100
Message-Id: <20231027143942.3413881-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Luc Michel <luc.michel@amd.com>

Use the FIELD macro to describe the DESCONF6 register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231017194422.4124691-9-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7e6cab71071..dffcc64df25 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -283,7 +283,7 @@ REG32(DESCONF3, 0x288)
 REG32(DESCONF4, 0x28c)
 REG32(DESCONF5, 0x290)
 REG32(DESCONF6, 0x294)
-#define GEM_DESCONF6_64B_MASK (1U << 23)
+    FIELD(DESCONF6, DMA_ADDR_64B, 23, 1)
 REG32(DESCONF7, 0x298)
 
 REG32(INT_Q1_STATUS, 0x400)
@@ -1463,7 +1463,7 @@ static void gem_reset(DeviceState *d)
     s->regs[R_DESCONF] = 0x02D00111;
     s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[R_DESCONF5] = 0x002f2045;
-    s->regs[R_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[R_DESCONF6] = R_DESCONF6_DMA_ADDR_64B_MASK;
     s->regs[R_INT_Q1_MASK] = 0x00000CE6;
     s->regs[R_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
-- 
2.34.1


