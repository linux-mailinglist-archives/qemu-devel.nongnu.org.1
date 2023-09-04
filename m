Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82B791BA0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCRX-00025o-SO; Mon, 04 Sep 2023 12:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRO-00022k-Tj
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRL-0002Ln-8s
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso2368641a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844917; x=1694449717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gYF3UNN3lFc0Z73zh6TAcygqYQkjiaj790AQYKykAQ=;
 b=whs90MOBGaBS40P1h/mz92M+WAyQhZ1Z5eVPjTxJu0GRFhsbq97Cbk/YDvlAG75CrI
 MoptHJkSfFIsDYDSix6KhjMi3tXKqEdqmCeeXXK+q7ZMJLRiWCJp3PFy8sT585epBamx
 /1EsYVpZatIUZMRWicAvuynYYBgqolZweQNdOU5ELM1ZL51kMZInnusJ22V+YKYk/Ovs
 CA5VR0Tu5DVZ1HXL0AXhMdsS9udqm/NlwDOJKnuX0wwLQknMuABRwWNpAF+q3FL7lskB
 G9NfeOw7v5YyguipwmDIRq1BZl0o310aPoL2WS5JLKA+fcd/ar4MtncAvbSiCvtAE66C
 CbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844917; x=1694449717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gYF3UNN3lFc0Z73zh6TAcygqYQkjiaj790AQYKykAQ=;
 b=lZzMwc4g+j1YnquX6BeN9LKrKdgMVtwxGc/13TnodCt5+kfuJ+wep+A/bZX66+1TR/
 iH+xGYCZG0eKBiRXvyu+FmqnT6NTmWCRAR2+9qp8/c70FIFEPxWjs6M2Jqm8tJ94CUOy
 oFXx7Dxl5GeKh3Rq/BVX0KrqSRmvW3XbkV4y5W/RFxS1HXxYqcj8Y9c2M6or4jCSvOji
 Im0X/fI+uOzllrfXltV1zFZ9vikffdcmnzZUa3abe5zGBjHLQexLtLMGxHfZJR+D4QSJ
 CoBIeN8MVluo1kr8HYuWCq/Tt3A5vYvkej/a/SHDTPf8ehLz9BVe4hiyrdzx7wq8Epic
 ADLg==
X-Gm-Message-State: AOJu0YxbcH13kZbetBvUGW/WUU0pGnRb+CrIOXKbLLj57HyEYwpBTAzY
 LWFcQ7/55ub1GNK5f9R/9fH+CzZgG/F+52URtOw=
X-Google-Smtp-Source: AGHT+IG7Sxr083rYNAxY5jxpWGbXjkbxusUj7YwPpHpkHQKdmBZcaWME8tca13puNGOsPLkyYWeXFA==
X-Received: by 2002:aa7:d58f:0:b0:52b:d169:b374 with SMTP id
 r15-20020aa7d58f000000b0052bd169b374mr8715679edq.3.1693844917397; 
 Mon, 04 Sep 2023 09:28:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa7c994000000b0052a3c7c9e8bsm6037394edt.56.2023.09.04.09.28.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:28:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 2/3] hw/intc/openpic: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:28:23 +0200
Message-ID: <20230904162824.85385-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904162824.85385-1-philmd@linaro.org>
References: <20230904162824.85385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

  hw/intc/openpic.c: In function ‘openpic_gbl_write’:
  hw/intc/openpic.c:614:17: warning: declaration of ‘idx’ shadows a previous local [-Wshadow=compatible-local]
    614 |             int idx;
        |                 ^~~
  hw/intc/openpic.c:568:9: note: shadowed declaration is here
    568 |     int idx;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/openpic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c757adbe53..a6f91d4bcd 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -610,11 +610,8 @@ static void openpic_gbl_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x10B0:
     case 0x10C0:
     case 0x10D0:
-        {
-            int idx;
-            idx = (addr - 0x10A0) >> 4;
-            write_IRQreg_ivpr(opp, opp->irq_ipi0 + idx, val);
-        }
+        idx = (addr - 0x10A0) >> 4;
+        write_IRQreg_ivpr(opp, opp->irq_ipi0 + idx, val);
         break;
     case 0x10E0: /* SPVE */
         opp->spve = val & opp->vector_mask;
-- 
2.41.0


