Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1528823383
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:39:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5DF-0006V8-1K; Wed, 03 Jan 2024 12:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Cz-00066c-Sp
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL5Cu-0000cP-2E
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:39:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so111751175e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303546; x=1704908346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xNYPWzXiJVejiOzH0lqPZBPc9FMUdMG5VHkvS57+tg=;
 b=Z9nVS/fuQrMwOMZmcwNXTWVwCEVCyGjYTmiFMZ54JNeASEuZsHNj/QuU5UpN8zOkKJ
 EXy0//ppW7dhGwHJGsySpz98Z+egBL0P8K9/CG4ooV+BBddON/PyuG87SCECslaXAC2Y
 FXLEIK8IZZlh5VDO3sxSLj3YGShgH3s574Lx6CXwZvpRfesVsvwvV9XVEXBSRBvgOQfC
 UiX125raqTvx52hiVysjCzMPMInmUSyHdJZmfM90rTGTUcjWh9nxssSbsdkODoTUjY32
 exncFpPY/8FpS1bfKidCsx2Tp/E15+I4hMmb34lYCCYwzSqPgCK+AA2MUta88rXaqkR2
 4/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303546; x=1704908346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xNYPWzXiJVejiOzH0lqPZBPc9FMUdMG5VHkvS57+tg=;
 b=ubYUDM1IM1qlJFm29qwUtEMvxXKKlKjR/HrwxyADggWG+fal88tO8MkZrha6WVz9uM
 K8DyJ85VzoNa6xmApvk7YrLltYNBtiOqP8tIUqE6HYX18q1T3b7QCsq0FWLkSlyRDA5H
 l4C73VlQQELD8dFr47Poh/c63KYOHoJVW9LBvOdkhj/crpNCv5VKEOLWmk83nkbWGYMA
 DjIRgsuhEFgdznYa7Vi3rtw5vXhwOXxQLMbZVFiwoFb88TK/ntmCPQDjOYn+Vf/c8rUo
 rVI1v6padyxsvXepDoqUMMYaRIK/jgIBLmhkq/UeMIJmaME6VrYnRPMjsC91cqeTZ6xc
 2tnw==
X-Gm-Message-State: AOJu0YwswBSQU7R4r9Wccf3vyAtW7ZoZC0wklnV4Ghe8ryNlSzhvJQ0d
 h+jbFOvcPM7tuJXKqLv+ywDnP4Pmo5T7hQ==
X-Google-Smtp-Source: AGHT+IH6oUVPIjcqWyhSJB2yGsQGHuXcBqAGxA30oE5c9ZUEOh+o9kgjc494ZEeNCFmoTVtGbVsERw==
X-Received: by 2002:a05:600c:2988:b0:40c:657d:cf12 with SMTP id
 r8-20020a05600c298800b0040c657dcf12mr5061241wmd.111.1704303546516; 
 Wed, 03 Jan 2024 09:39:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fj7-20020a05600c0c8700b0040d77ebd55csm2974446wmb.13.2024.01.03.09.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:39:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C6095F9D7;
 Wed,  3 Jan 2024 17:33:53 +0000 (GMT)
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
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 42/43] docs/devel: lift example and plugin API sections up
Date: Wed,  3 Jan 2024 17:33:48 +0000
Message-Id: <20240103173349.398526-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


