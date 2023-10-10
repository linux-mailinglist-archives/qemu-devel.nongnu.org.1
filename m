Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 591977BF762
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq95k-0003zA-4Y; Tue, 10 Oct 2023 05:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq95B-0001gg-6R
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq958-0008OR-CQ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso8277354a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696930269; x=1697535069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WiHkuSW70dwreiTW00ZFUbfeyH/7vFgJnStNjqec/s=;
 b=Qr7H9Mw2UayX2EDnksa4AT4/hbEJVgjpTtAsgFWkCcpEh93+GaNp8FLpGYdq8Vcnwf
 9Dy99nguGqzXGl/I3Zz5bjjJb6+iS2J0th5aFpWT2h45KveVaGJzMoPoSgz1iiXmkA6j
 DmR79nNwex5LM+5LkqBujWwduAUUHDy39YAj1vKWrBo1y+qPWqqIhfwHkxPiRfAWdOEx
 nYnhFxgxrB6VVSYuOFO1Dt8nQhoSAhNPax/PKzmjPMIxLZZLYMjJsmiV3SJKoAWxX8TF
 shLaFQ758toImPWBqIlJPkExajWgi8R4MbUZpwsq9QOOkQdT92jy3lUppI/upNwyy8A5
 mSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696930269; x=1697535069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WiHkuSW70dwreiTW00ZFUbfeyH/7vFgJnStNjqec/s=;
 b=AsdcQoZDKjqajBfKhddPxnC32a1d8VPRFZlkZaAAk5hGjmS4jRsp0WnAUUcwdA0945
 P0cepowGcimhUcq6PPz6/k7IrWOZyeDfCJG3n8mwf25QVV2RVdI2GfPvnR7vHxd4vlDd
 DangnW/h9vLIhM0fHZ7PVa2ceZIs54j9AvmJky5pX+8QN0GWK8ZhxQXUybepbiG9H1C+
 iPaPpLeG3e7O98bjQUawU6HhyS0ErXPysKbi0Ej6raTAAwJGWnnRTfQL50mKY+FmXqJ6
 a7mVAT75fWPY4UNBsd6lIT8v3CiiUl4zMVid3qLCItHptzSJjor1wJM0lDZyrcprrMw5
 adEA==
X-Gm-Message-State: AOJu0YzzcQKLGgfQB5+WweSlc83t1P8HdUUxQIG5IyfWls4befKOf2Ul
 QcwENyue+UwNaN1lizQ13Wc1hCqm1TBqFHBqEDlh0g==
X-Google-Smtp-Source: AGHT+IFQfEKqRpe0/5M60rhsAq6bfbdvQGd2YsmvTr6D61r1IofMsTm9DpVidTfJXqvW/xUdUHR0sg==
X-Received: by 2002:aa7:d1d9:0:b0:531:157d:ba2d with SMTP id
 g25-20020aa7d1d9000000b00531157dba2dmr13586266edp.4.1696930269123; 
 Tue, 10 Oct 2023 02:31:09 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 b11-20020aa7c90b000000b00536246d1eadsm7353953edt.41.2023.10.10.02.31.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 02:31:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org
Subject: [PATCH 15/18] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
Date: Tue, 10 Oct 2023 11:28:57 +0200
Message-ID: <20231010092901.99189-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010092901.99189-1-philmd@linaro.org>
References: <20231010092901.99189-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
type, when declaring multiple CPUs of the same ArchCPU type we get
an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
use within OBJECT_DECLARE_TYPE():

  target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
  OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
  ^
  include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
      OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
      ^
  include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
      G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
      ^
  /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
    _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
    ^
  /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
    static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr)                     \
                                     ^
  /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
  #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
                                                  ^
  <scratch space>:54:1: note: expanded from here
  glib_autoptr_clear_ArchCPU
  ^
  target/mips/cpu-qom.h:30:1: note: previous definition is here
  OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
  ^

Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
within OBJECT_DECLARE_CPU_TYPE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e02bc5980f..ab724fab3a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -79,7 +79,12 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
  */
 #define OBJECT_DECLARE_CPU_TYPE(CpuInstanceType, CpuClassType, CPU_MODULE_OBJ_NAME) \
     typedef struct ArchCPU CpuInstanceType; \
-    OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
+    typedef struct CpuClassType CpuClassType; \
+    \
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuInstanceType, object_unref) \
+    \
+    DECLARE_OBJ_CHECKERS(CpuInstanceType, CpuClassType, \
+                         CPU_MODULE_OBJ_NAME, TYPE_##CPU_MODULE_OBJ_NAME)
 
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
-- 
2.41.0


