Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A818233B4
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Cz-00064V-OC; Wed, 03 Jan 2024 12:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Cx-0005wX-Eb
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Ct-0000c6-PU
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0c4dso100136865e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303546; x=1704908346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUTepCaXuSvQff7RpqKHmtGuMDeLUnEdp+0FVQ8ed3M=;
 b=e0kOxQ9tX/ZuiLXXv6bq2N7gALaUO6jr/J1yPe+niPz+NVDoTa+tUVSMHQFeRNWMXx
 /2/vzefj06458WvLokbA77IZ04qFKGf67As8yadr1gRnqQg5tM7gD4x/Z4uaeXKmgAdP
 WomrVVbL8Zy4m2gk2jAScojfvovsuF/GIiLAP1g2fDm418pkqVy4S/Zs1MjHqMHSaSiq
 Iqjf6Tml9MWo9aNAUwEIDQVCo+hlq7oelxZBIRbxO/Y+u17WEgwyI+wSj+wfP7N5PByB
 /1O3HyqXuNl6SZ9xJBxShOpGVpLaXZ7cYiU/yd9xnOL4Pq/AqGafk6ib6m69OdHErBD7
 lS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303546; x=1704908346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUTepCaXuSvQff7RpqKHmtGuMDeLUnEdp+0FVQ8ed3M=;
 b=jHnHmoHgtl2baan1biz7OS1TE8hzmMGZgfum80N6NN3kGKoc8ppmtPLAKYY4nxL1jX
 TLLl2YEctLVuOoDiBiFjWscVtDHKIbh2i8Yqe5zDk9MqZiAYUiWXPJEoTfZnEkktHPqi
 CROyTMgn3aQsEi2F+92z51LnXSXuOlYj9BK+P+BuBYGLZgGUr6JGuKfU+w24OiEnC+7X
 c++ceMTTq1XlMomdQ1SSQ1+pA9gh/Ik9zye+HJeP6BzLDei4/qTx+DRBeARy4+Uq/jrs
 C1xCYyZvwSAP19r68pAR60VYBKcjK6n9U08pDp4NJMg1ALc/ZSxAbRALigOgBBZUrK4A
 k2iw==
X-Gm-Message-State: AOJu0Yx68UODrc1boo92pZQR+fs5g1LxW65AJASW7Jl75KD0eX/PinoV
 nknKzGx1OXfgdP+bN7oQW9NvYNke3xgfDA==
X-Google-Smtp-Source: AGHT+IHV3d3uLZOx2ZZIm3V3IDyg+ER70O0YZMaSn1IluGAzIzdge5YqbqU0eBqZOj56X88eutaFJQ==
X-Received: by 2002:adf:e7c7:0:b0:336:619f:4647 with SMTP id
 e7-20020adfe7c7000000b00336619f4647mr8666036wrn.108.1704303546236; 
 Wed, 03 Jan 2024 09:39:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k4-20020a5d5244000000b003368c8d120fsm29995262wrc.7.2024.01.03.09.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:39:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57CC25F954;
 Wed,  3 Jan 2024 17:33:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 22/43] hw/riscv: Use misa_mxl instead of misa_mxl_max
Date: Wed,  3 Jan 2024 17:33:28 +0000
Message-Id: <20240103173349.398526-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The effective MXL value matters when booting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/riscv/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189f..bc67c0bd189 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,7 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    return harts->harts[0].env.misa_mxl == MXL_RV32;
 }
 
 /*
-- 
2.39.2


