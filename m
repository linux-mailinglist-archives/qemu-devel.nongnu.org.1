Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 532F682337A
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL58n-0004MP-1Y; Wed, 03 Jan 2024 12:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL58P-0003yu-U2
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:30 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL584-0002Ve-1t
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:29 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccec119587so48543231fa.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303243; x=1704908043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7uxGZGov81O+5jLuoaBr/C5I/uZZh1/zGx1+p9cIt8=;
 b=Auu0NJM0w0lP+xQ2nDVJjbOs9Rh9fBl6lkEe1wrdgaCbZIHVUNzirOuVa6rwdMzi4N
 j6/wcgTf1iitxO9BX7U53zwkWy1g0IWvsCygTrnG4W8h1Kfd62eSPkx/a3YnVfFjWIWC
 HC9nRuz+pRcOHzs+H+Tr7+WJe49Pk4yZt/5AEqAvjYdgjb5wC+Rkk+P3b4WvRBiwgvQB
 dZu+PczlBaOH/H68UyN5PqtcwhVCJCmM++IDvbWRhlyljzM2ivRMLraxfR6UL7nGWoeO
 E3GJO1bxYMzStvkODb0/8LlZE+HddafIjHTzzCRMF48oB50MVsDVaqzeDbnw53mQqSSm
 KSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303243; x=1704908043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7uxGZGov81O+5jLuoaBr/C5I/uZZh1/zGx1+p9cIt8=;
 b=rJaAKBmL5uFQA2RrpSj+im5DJL3ktC21z414va37yfdqxtact9I7TsS2AWDo90NxGH
 VuFK70s/PhDE7e/T+YrvskY/S3nQ8pzJ1jwaHxFqz+BfSD8oRBrn/83FoudmJvlVlrYM
 4MoPIFrBH4Tx+s4y4Fu+wBOMderQgLTXAykgOgK2hvNTiTwsUs3cqGQlBr9pa6co8d29
 XPoXiBofH7+YQP//RZrSFyFMHGeLaNuhhiCZ6L5DnBU27EFH4TcDfkRZicQ0sHd6QfdZ
 id6Li84vWfDgEJ2x2bFwaCMC821EQl7xv8kuM4VZ8WAQ/x3w4uozHOC3oyGXX01KYsIB
 Z5Iw==
X-Gm-Message-State: AOJu0YzrD9AttMGKBijXg7XBubILT29Rtg15FoBuzanytuL9wbjlC9jL
 a9ZJFLEtQJOZz/dPjK34fBNuUHQ+9jXWPg==
X-Google-Smtp-Source: AGHT+IFhNAa0ExWYCS2KvTjl2oi2iRsIB5/oaggT0hzzaXckkjHspuvOE576DfxADqAu/SUDJduuEQ==
X-Received: by 2002:a05:651c:686:b0:2cc:d555:bc66 with SMTP id
 x6-20020a05651c068600b002ccd555bc66mr4899025ljb.76.1704303242728; 
 Wed, 03 Jan 2024 09:34:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q28-20020adfab1c000000b0033690139ea5sm28923405wrc.44.2024.01.03.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 817AB5F944;
 Wed,  3 Jan 2024 17:33:50 +0000 (GMT)
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/43] qtest: bump qos-test timeout to 2 minutes
Date: Wed,  3 Jan 2024 17:33:19 +0000
Message-Id: <20240103173349.398526-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qos-test takes just under 1 minute in a --enable-debug
build. Bumping to 2 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-10-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-10-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index dc1e6da5c7b..b02ca540cff 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -7,6 +7,7 @@ slow_qtests = {
   'pxe-test': 600,
   'prom-env-test': 360,
   'boot-serial-test': 180,
+  'qos-test': 120,
 }
 
 qtests_generic = [
-- 
2.39.2


