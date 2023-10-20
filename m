Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEE7D143E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:41:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsWP-0005dJ-4O; Fri, 20 Oct 2023 12:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsWH-0005Up-Hl
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:38:42 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsWE-0002i5-TL
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:38:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so1550859a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819915; x=1698424715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut1JVFvFLo+kLIKZi8qPYnpjR7G6cNfFgvYYDUExNe4=;
 b=Esduh2x9POfFkAkyY7CW+rq4rzhGBP5AXebWZsb5QXaAWv2BvfhbQdnKzu/E6x0CqL
 FE0dl8n7msDCpbpRVMvPpsZ8njjhmjBfgrmL0dqZ0vb2pMTdmtMuhfB3jElQTMkdOWcc
 dSpu5FWUTr9cBGDuiDp3I8UwuOfoWmrT7/2j8XSGYern14jE+aD6yorMxVXejEeNJLla
 tB5aYk7cNgZ+leM+0hy+YIfQUPpqn2uz8SL7BrvdxcCREa/lSWUAyrQO3u3XctD1VCUs
 D02j7jNjiOUrtiAvnqgaUOxSAD4YMKQdRW6HXy8Yk3/jrkWYfoWZugSspxBOVaHKCurz
 hmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819915; x=1698424715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut1JVFvFLo+kLIKZi8qPYnpjR7G6cNfFgvYYDUExNe4=;
 b=Kl1BQhadM+/FUePUBjlJPy+uoLE94JUhf9kVcfV03NuMV9ClgqipXhIsWBwQ7yEPSO
 SPyl3vSImsnFGRIXK95S7NsbCSgZoyPUhp7w9mdRI438+nIcVLQ4iDNKdJq7q9g75Bl+
 m6E/V5ariADvvnI/yYTx1SWA8YfAlZY76KZPEjeqFqZTiQCFo2qFloOPcX5WhBPLCN5Y
 fTuLl1MaQFVNsPYwZf4NS5TibEhxlgLeg6NKEDY0H8iANvGqLWYKEO+qgqSV2zET1IOC
 GqWwJTAalweBWMr2ES0nrlBWShL0PW6a3zkjBghZEUjQM7k9eem7XVyvk4/wr4NPlo/A
 WMdQ==
X-Gm-Message-State: AOJu0Yy1kKT34O8UPyGaAvGzaxV9CYEqGdSJIGf8v4KndvqfAzUHbOmY
 +Siz6TY86IZo3o7sVDydDKjtzISkVIbee+iINHU=
X-Google-Smtp-Source: AGHT+IGl73D3b984YgVSErMYz9RgMLYGAfiCqAnw0A/C+rUAgxUldvhOIDj/46hx9nsUEPP1al9X2g==
X-Received: by 2002:a17:906:eec6:b0:9b8:8bcf:8732 with SMTP id
 wu6-20020a170906eec600b009b88bcf8732mr1841258ejb.43.1697819915304; 
 Fri, 20 Oct 2023 09:38:35 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 kf14-20020a17090776ce00b0099bd7b26639sm1820597ejc.6.2023.10.20.09.38.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:38:34 -0700 (PDT)
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
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 14/19] cpus: Replace first_cpu by qemu_get_cpu(0,
 TYPE_S390X_CPU)
Date: Fri, 20 Oct 2023 18:36:36 +0200
Message-ID: <20231020163643.86105-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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
  +   qemu_get_cpu(0, TYPE_S390_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 377f43416c..1f2296f456 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -674,7 +674,7 @@ void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
     *cs = qemu_get_cpu(ipl->reset_cpu_index, TYPE_S390_CPU);
     if (!*cs) {
         /* use any CPU */
-        *cs = first_cpu;
+        *cs = qemu_get_cpu(0, TYPE_S390_CPU);
     }
     *reset_type = ipl->reset_type;
 }
-- 
2.41.0


