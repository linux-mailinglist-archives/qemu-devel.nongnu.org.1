Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93B80DD04
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:27:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnij-0002Hv-HN; Mon, 11 Dec 2023 16:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnia-00029l-5S
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:36 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCniX-0005aJ-JM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:35 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a1f0616a15bso554159566b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329692; x=1702934492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2w63ljFdqIz1JzgOaJC6yCkuASP8vMkY+wuXlFzHsQ=;
 b=FWaDrIg44cRSF71NBUvTHkYEk8wNlu4+ipuDWl2Fmfnesy7e7CY/V4wIvR5HuY408Q
 d0NJGB3zh1MkyZ+HTDrnqG+Ugq4TrmOpPApWara0paat/fdfUlxsHnIqjRiGNyisOfb0
 1htjqIMRAH/8IfH9kZhYr7kjIwXbaIyPsvH2NEbECX6kXSjkXpHxlGOaOI6Q9oejNLa4
 Ln9D5+3/YqTkER9Hi4WkpU7csGxY/1QWhyJqt65ZEnB5vwMYZH5znXUKnId2pI8nPr7Z
 6oWK9ybH90C0BNPz2YldUmo2xZLXKeQPtYWlnTrYk+ncd5z4hXTZDmyLKdfJtkoUItCI
 vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329692; x=1702934492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2w63ljFdqIz1JzgOaJC6yCkuASP8vMkY+wuXlFzHsQ=;
 b=uY69Tuvr9Y26JmswXu2Q0Eef8YBtLvvab/f97v0eNrRSnndTlZdUH1Nk162AnAboGK
 GDnJ8VeqtM3bW/I5w1yRe1rYX1svibaDRkZsSMBPRb47gl3O2W+qQg+BqyS8x8uYMZJD
 c3lAy2LtvsZ67Kaa6+8KImz1lY3O5nX+zWQUmcFeNVHJwwobNEYX4K9Gu8zK9zEJ7IRS
 1Vg2HRf2YiGwZj6wTaSYxM6X+wIIP2Daay9LHB1Y+14UGbR5Sdyi+uUnfJJ1qNCsYvAe
 pEkTZVaTReq5zaAwBjyum7Ud7jlGDKfw2d/zcUyVhtb8BXmX8gplNGtbAgplSvEH9LyD
 RZ/w==
X-Gm-Message-State: AOJu0YwKFB9K0vuPJnJB66QYH58K2WTXGj9qYxfOfr2d4I7z4/RgRCXT
 RutieVV9OglpAixGMueLzvlbOXEYdgmzLgvOtezJFw==
X-Google-Smtp-Source: AGHT+IHPiHbU4zyhYynFno5PODyyp6MkmIQrhrcW4VtRL7mGlUhbV9KC4i0etCle48wLlV6QIbSgXA==
X-Received: by 2002:a17:906:b389:b0:9df:bc8d:fbc8 with SMTP id
 uh9-20020a170906b38900b009dfbc8dfbc8mr2584832ejc.37.1702329692122; 
 Mon, 11 Dec 2023 13:21:32 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 mm15-20020a1709077a8f00b00a1b6ec7a88asm5320964ejc.113.2023.12.11.13.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:21:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 10/24] hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h'
 header
Date: Mon, 11 Dec 2023 22:19:47 +0100
Message-ID: <20231211212003.21686-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

mips_itu.c only requires declarations from "hw/core/cpu.h"
and "cpu.h". Avoid including the huge "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mips_itu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 5a83ccc4e8..37aea0e737 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -22,9 +22,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 #include "hw/misc/mips_itu.h"
 #include "hw/qdev-properties.h"
+#include "target/mips/cpu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
 /* Initialize as 4kB area to fit all 32 cells with default 128B grain.
-- 
2.41.0


