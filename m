Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C24768582BC
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Feb 2024 17:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1Dj-0001OT-Oc; Fri, 16 Feb 2024 11:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1Dh-0001Kz-95
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:37:49 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1DW-00044l-EE
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:37:49 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5129cdae3c6so312628e87.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708101455; x=1708706255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=FRhpPI/UvzaOPr7LEiWyqcPKb7tgZ2KEXgCanxPb29x4TgNw8ab8viIBix6O2X9SpD
 iZ4aKoukKp/xH+YP2/H/hkAk4VtZ3K3/gZ5nokUzLrr/TIt0mn4y+UI32QlWPolvRtZO
 77kQa6wrXPy0VDJtG8avNHKH0/oNlbZ2X1j1To5W4RriEjIHttdoyzjLaVW7fsCfzT2y
 kI/cwZSBAnoqnIDi97gV5VRuYIPYQqy5aXcvke9m/TETWQjWqKYrHGZQKDeopzE96BA3
 jmyOww6POgDH5dHj/oMQE1nJQals75tx0AVZ6i44pvYVdu4VmYsLQOgVUSNu3flmOYv3
 loyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101455; x=1708706255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=KdQTPsAA+thLbenssCU2i126jL5anWZoba2g/GylLcqLIghzJ4VVk9mJ5rhRBtP1cc
 W4LchakxC7jM6htV6gsAfhbBM/3FE+GVprh5OB9v7OmTk9VIp3CBicQVIaRwMYc23rHX
 inKIrq0clRh6E+9O+Yyl5zq2S/kTCdQRSBnGDdVOyWMItaAca4e8mVHS3c4SQ/sgeYjh
 F6/R0w4GOzOXfTWAhyeWy+q+tUObNgXMAagKFIVIzmZCbTtGyTtGIXUXoib7ptpf0eFx
 TR9Gwaqgzs4Ym4nxfLdD/9eaU3CNlJj6uHSrjCoJOBmERizHWp8E1Bm7USroBYk9uYLi
 84tw==
X-Gm-Message-State: AOJu0YwP1IFjYXBBQvbuVweo9B1YnQZ16zGX5gyIvTqZyaA2A/YCHsMJ
 FM2Dm4GgL1LoGVEt+RTOgdf63OX2ePbwV9YwCPgDLcvLnn2/g0YhPKxDOn6xjo4=
X-Google-Smtp-Source: AGHT+IEAnIai7rTph2JUBh7vTqJtbsNW6pnLmhjfv2DO8x6RZs1rObZ25FtpNv6J/ZrekKNLEpmTzg==
X-Received: by 2002:a19:5513:0:b0:511:b3fd:76b0 with SMTP id
 n19-20020a195513000000b00511b3fd76b0mr3696119lfe.23.1708101455536; 
 Fri, 16 Feb 2024 08:37:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f2-20020adfe902000000b0033cf24700e5sm2622794wrm.39.2024.02.16.08.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:37:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A5A85F9E7;
 Fri, 16 Feb 2024 16:30:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 21/23] docs/devel: lift example and plugin API sections up
Date: Fri, 16 Feb 2024 16:30:23 +0000
Message-Id: <20240216163025.424857-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216163025.424857-1-alex.bennee@linaro.org>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

This makes them a bit more visible in the TCG emulation menu rather
than hiding them away bellow the ToC limit.

Message-Id: <20240103173349.398526-43-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-plugins.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index fa7421279f5..535a74684c5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -143,7 +143,7 @@ requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
 Example Plugins
----------------
+===============
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
@@ -591,8 +591,8 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
-API
----
+Plugin API
+==========
 
 The following API is generated from the inline documentation in
 ``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
-- 
2.39.2


