Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55579866D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZZj-0003gY-CX; Fri, 08 Sep 2023 07:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZZf-0003fN-Ou
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:22:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZZb-0003WW-87
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:22:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso20013995e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694172169; x=1694776969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZx/41xnQx3UrrNBNxaWrVM+nipc/J4j8tticD5Myes=;
 b=j2cZ0o22rQdp4mPZo2LjJqtbtZVlcYmWgIJxGRTPRo8OS/IgQsSobtlhcRAYwzau8J
 j/PkjNogPTqkUmAmE8XNaoKKcs3HomhydI5Q9lraRBS99WXOFqhfPPfG8QKvKNrNsq1I
 jJT0DyN9iJFVJAE5ZFJdZ655DLFrF2aei8TW/lf+WK7uH/hIanPJlDcA7NFjzvoge8CP
 oET1C+MtCTARWdH42/zX4Yc/4OtlM+aTLdHPHcx/c9WseU7q47LdAUz86HEnoF1nZdeH
 ZQD53OlTlQXR2JeFG9dyt9HizzycDM9DLkiPCVsWD8viF9mFOum9Vdx0t4X1iX+0gEBN
 CLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694172169; x=1694776969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZx/41xnQx3UrrNBNxaWrVM+nipc/J4j8tticD5Myes=;
 b=CxAyatLhELFp3NPoDtPUpO3s8SjgwCi7/G5m3VNYnQGHtqXRrRjFR94fkQGGNuZQYg
 EksPjIjps0tOXgXFk/vpX6OvhWBAt5lVhlwnwowk7AjFSZ50LzrbyO8wUzJCL0tGtrHq
 EwLd5HBbOkQKlO7HOD/G99i4qzSg8ip49j2HSrBDDHqKkyEVBdRmevE+W1u02NJk+TKy
 4bbck5OjRCoWvaSqw8u+66cyiPm0DnyRktt6vt5Qwz+F1II/kicDps11EKduMnYuU2GP
 p5YuFtu2UW2YKY+2RVRHOEuHlW3SgRDnUCmtRAX9JN/598u4ptA4l3Vej5ZD7diDWzpL
 qJvQ==
X-Gm-Message-State: AOJu0YwEjIxvRqxeqRo8lejQ2jpjMF1wPMDYBucXvBrEk88B/iEtodtu
 Knd3bdiv/xQjQFu5i+/pMS4xZWVhnetmKGzHfr4=
X-Google-Smtp-Source: AGHT+IH7XRjTP5uF66JZG58hDnY6FVviA2T457wdwtwObuOiL8CzjSmsSi1m9YLKiOjJTzbv7WV1Lw==
X-Received: by 2002:a1c:741a:0:b0:401:b53e:6c57 with SMTP id
 p26-20020a1c741a000000b00401b53e6c57mr2164003wmc.9.1694172169282; 
 Fri, 08 Sep 2023 04:22:49 -0700 (PDT)
Received: from m1x-phil.lan (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr.
 [176.173.167.175]) by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c0b4900b003fe2b081661sm4968607wmr.30.2023.09.08.04.22.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Sep 2023 04:22:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Gavin Shan <gshan@redhat.com>
Cc: Chris Wulff <crwulff@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Greg Kurz <groug@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marek Vasut <marex@denx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Bin Meng <bin.meng@windriver.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/4] target/alpha: Tidy up alpha_cpu_class_by_name()
Date: Fri,  8 Sep 2023 13:22:31 +0200
Message-ID: <20230908112235.75914-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908112235.75914-1-philmd@linaro.org>
References: <20230908112235.75914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 270ae787b1..351ee2e9f2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -142,13 +142,10 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
-        oc = NULL;
-    }
 
     /* TODO: remove match everything nonsense */
-    /* Default to ev67; no reason not to emulate insns by default. */
-    if (!oc) {
+    if (!oc || object_class_is_abstract(oc)) {
+        /* Default to ev67; no reason not to emulate insns by default. */
         oc = object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
     }
 
-- 
2.41.0


