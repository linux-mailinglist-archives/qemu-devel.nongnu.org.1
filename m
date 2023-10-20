Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 841577D1445
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsWp-00078Y-GM; Fri, 20 Oct 2023 12:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsWb-0006K7-I2
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:39:04 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsWY-0002sU-QO
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:39:01 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9c75ceea588so157087766b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819936; x=1698424736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m78jGvmF7oKs3bQ1VJX7QX1qGqO5WzM4SQXqj75reU=;
 b=SvfDSUg4dnWRcEgLtcEvDjOpIsoU1UQjwjSVWFyT37INaabqsKK/7TMoOTN4FxlnEx
 SaHpXUmb2LuLD512uvREtkrUa6k1t+mrYTHg7pYfRhi9OZ970MA8w957xvr9DteWKD4z
 S/zkEck5v0IKcFrP+wLR5n0GjbYwn2pIBQM64O/NIlZ7bLlupKrdxjz+JiSxjEfw5H/M
 q2zB/Ih8XAh73l54TG+kElDZF3ZGnYvG1/fHJuqOVmgIjA0KBAkK7nTlkKoEGEl74dLg
 7eeTECeDnN8w/ryFz0Qg119wI8UjOpuYSbOBmsAPWINJIvEpthu2DBHEOXhM0DnsmczO
 fJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819936; x=1698424736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m78jGvmF7oKs3bQ1VJX7QX1qGqO5WzM4SQXqj75reU=;
 b=CyozIn874BsQsR/qxCBqVSPGjkvyxEOAIRSftcXsWjyY8uNMJgXI4ytbk+hzL4VLZg
 mzZt2w5DjlrR1N3/Hm0JvVAesccFeHKELmQiSgXH21ncW0buFAvxZ26Hbj1o7BVA2mZm
 HEZMur3LCsbS39BXzCFyFXYT/En49HnSxipYdmHd8QSSTDqqCxFmuCf/cZWhbne/8LdG
 1cEjjWsGGEEexjVMiLnTmRpDAFRbde8qyUYvCFsbhnC6QCrerwmWMfK2xeJf7eSBcleo
 6dH5NpQb1/T/M+bowxFnEWxrydfiy8y3RMOzfN+/GuIM8zqMjhRGOZKZKKFRfoPIYPpV
 TPUQ==
X-Gm-Message-State: AOJu0YxedeQ/Gs+qme4Bw+8IBmBRyH5QMyNM5ecR3OdGXDldIWvVb37s
 txju7XNQ3qbYGDkR54UDE0TUxZgYT4uS8j4Nnqw=
X-Google-Smtp-Source: AGHT+IE8yq5L7NgEFg2BL5r/TirE3WBnMy42fdTokTdcZFul/3aVleWuW6Vwfoas6PkQGpsaPs5PAA==
X-Received: by 2002:a17:907:7b82:b0:9b8:7746:f176 with SMTP id
 ne2-20020a1709077b8200b009b87746f176mr2150472ejc.34.1697819936618; 
 Fri, 20 Oct 2023 09:38:56 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 rh8-20020a17090720e800b009930308425csm1788733ejb.31.2023.10.20.09.38.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:38:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 17/19] cpus: Replace first_cpu by qemu_get_cpu(0,
 TYPE_SUPERH_CPU)
Date: Fri, 20 Oct 2023 18:36:39 +0200
Message-ID: <20231020163643.86105-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Mechanical change using the following coccinelle script:

  @@ @@
  -   first_cpu
  +   qemu_get_cpu(0, TYPE_SUPERH_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/sh_intc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index c9b0b0c1ec..be76a96ebc 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -44,12 +44,14 @@ void sh_intc_toggle_source(struct intc_source *source,
         if (source->pending) {
             source->parent->pending++;
             if (source->parent->pending == 1) {
-                cpu_interrupt(first_cpu, CPU_INTERRUPT_HARD);
+                cpu_interrupt(qemu_get_cpu(0, TYPE_SUPERH_CPU),
+                              CPU_INTERRUPT_HARD);
             }
         } else {
             source->parent->pending--;
             if (source->parent->pending == 0) {
-                cpu_reset_interrupt(first_cpu, CPU_INTERRUPT_HARD);
+                cpu_reset_interrupt(qemu_get_cpu(0, TYPE_SUPERH_CPU),
+                                    CPU_INTERRUPT_HARD);
             }
         }
     }
-- 
2.41.0


