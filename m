Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4497E1FB6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:13:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxRW-0002Vi-UO; Mon, 06 Nov 2023 06:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQz-0001ei-JZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:06:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQw-0004O5-Jx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:06:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so32860215e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268766; x=1699873566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R87QIdTSbuBFqtOuBBqCdN1J8XfSkpLJYhBFwzXT2iA=;
 b=Kj/1LaOCc8ohvfAmi8Yz10wI2m4KbFPHjnDS4xi3yvwiMQPOAWM88ygVYIxCv7WE6o
 igHycHZ1IARjealLc8DwDef/bsE6vWViPkuyzYcmuWVNarBlrOx7JnHX99TgWu4oSYd0
 TXpckHGQTlrzg2IMJASV/+1uF+j2jqlMRGaxVcxpfsxZbxWXwlqZDWeH+iYuPiZjHhtg
 o7fYOJTNTVFip8+civVvL77jpFN8ws/y37wyNxzxSLnelktqSKQzz+ph0NlJ1gpyHzyD
 vdaPi1M2MBgBwbYNPaIzXZVaFh0oq08rVJaGb3L/eHoLhyvou3bbwRrksAPCONXIiqT4
 yt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268766; x=1699873566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R87QIdTSbuBFqtOuBBqCdN1J8XfSkpLJYhBFwzXT2iA=;
 b=hDpq2HDUZw1F6P0OcN0RSchzZYK5N048TTKEhhsyzTQrE1tDxn5E4VnTIEPasxyc8/
 0SUmQEma63WKTobQtGRBQImOARWhClyAlhwP9baiZUgQf6hBT7MOKhqm05diTN3RHOmm
 EtLTLjaoFvBiiCUC3Sq8p+N9TRAQFhzI3DDvtpc8ntRcb2jFHHfQBSUIZbP6QTI8dudj
 zTHddzer3OVwT9XJkJ0kVhVNlhPICDsyT4LlqX0vNWHTmxL0TT+ec88xUm8zIAg/vXaM
 JKGghEx8gjK2n+EYEi+ubp0eX0A8OFDm9biE03CdZVmOWHksRgn/BXSlr703Dfisrix0
 sAqA==
X-Gm-Message-State: AOJu0Yx24lytU/jkrNHlUh+zqhKw8M3pVFJ3e7w0/Bp2REkRYGUM36qf
 98cpLwMi27WK+OseY8cckyyv3ym7gBUh6Ky39xA=
X-Google-Smtp-Source: AGHT+IEAb7mlXjiV+t8xOiAWlZzqIbRP1ddqvYwThww0DxTtH+DpaAZtlEj/6Pj1UY+lnDvwGergOA==
X-Received: by 2002:a05:600c:3148:b0:405:1c19:b747 with SMTP id
 h8-20020a05600c314800b004051c19b747mr24127659wmo.15.1699268765817; 
 Mon, 06 Nov 2023 03:06:05 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a05600c355400b0040839fcb217sm11896421wmq.8.2023.11.06.03.06.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:06:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 21/60] target/s390x: Use env_archcpu() in handle_diag_308()
Date: Mon,  6 Nov 2023 12:02:53 +0100
Message-ID: <20231106110336.358-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When CPUArchState* is available (here CPUS390XState*), we
can use the fast env_archcpu() macro to get ArchCPU* (here
S390CPU*). The QOM cast S390_CPU() macro will be slower when
building with --enable-qom-cast-debug.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20231009110239.66778-4-philmd@linaro.org>
---
 target/s390x/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 8ce18e08f3..27ffd48576 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -77,7 +77,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = S390_CPU(cs);
+    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
-- 
2.41.0


