Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6C81B3F4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGSA-0004Oe-2q; Thu, 21 Dec 2023 05:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGS1-00040o-Bz
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRp-0004Aj-PB
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so6490575e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155114; x=1703759914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG0GNTBkS5OA4bLgzcXFuNl7bQt30v5WL9SIW527gOo=;
 b=iznHfq9a0du0cRV3HC677htFFZse4B2PBC8BNXAjB/AVraKF/H6oDwRDPyXXJYVvZi
 koQsfB1gb2ur9YufS8qdX2zfHf0WrknL/fVKk46u7t640L2xEFLPhYhenvUuHkvkbE/X
 JW9X1NBGY2fyp5+E+a+wKqu9tXakwwOwJ/air9YOoYteGG5T8yeZUFbqcDFnldvrbIJG
 YeshZjcR3TFVjHFUzZnzkoqhQqYqPlLJIGNa98FjtAgwo3AoK1FJIqhvhJquluUjdd8t
 kDhZeoKMjryHc2ai0eL0wg9qIlJ+/I4vbyDXNgsIQqbTqdFTPtwNbwEoEFKy9VBX1M69
 PbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155114; x=1703759914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NG0GNTBkS5OA4bLgzcXFuNl7bQt30v5WL9SIW527gOo=;
 b=Ukj2mGRSNsUzBsYGNDuVfqeVPFXPCBJNRAwogo/1ZC+FB5BUZ1lfFe/rERq2awbP/H
 hJ7GbRNcJJ6PYDP35jfZ/kox2FiQNoNvyVR/ZF8Ura1Q9WPv7krMzqVLcAqZhQlYUh7X
 f3I/jcF6RNDjtMqggUksTrYrrYQoCrp5Me8YW54y8jMGjnk2p4d6Ti48AM6RqrmXNkuJ
 5RhkNjxOh2TDLTSaQZM3jAg+XOkuzg5+BXZ/U3yFATH4JFba6eokErE5XTRcHZ8D5DU3
 2G0DI/a0SgjhiigcunGhSLb1Y31tXlRem23lNEJSMnsDWtYlz8rwzLOMGOywAchbl2AY
 Ds1Q==
X-Gm-Message-State: AOJu0YwlTD7TXShc7IbmCUg5xDT9E6Koy0JDk90H+uepZMpAdhtQ1MqV
 qYLYRIVTUFPlt+9MzhZldIlGPA==
X-Google-Smtp-Source: AGHT+IHtw299z4GcZk4ReQAPdhRPfcJ81XOj4Zsroy61A+dimT3sxJq+bziNhd0DzLsBRbi1nCt9BQ==
X-Received: by 2002:a05:600c:4583:b0:40d:2e2a:18df with SMTP id
 r3-20020a05600c458300b0040d2e2a18dfmr324147wmo.213.1703155113719; 
 Thu, 21 Dec 2023 02:38:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c459300b0040d128e9c62sm10647702wmo.18.2023.12.21.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ECEB5F8D8;
 Thu, 21 Dec 2023 10:38:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/40] qtest: bump bios-table-test timeout to 9 minutes
Date: Thu, 21 Dec 2023 10:37:53 +0000
Message-Id: <20231221103818.1633766-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This is reliably hitting the current 2 minute timeout in GitLab CI,
and for the TCI job, it even hits a 6 minute timeout.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-12-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-12-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index da53dd66c97..6e8d00d53cb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
-  'bios-tables-test' : 120,
+  'bios-tables-test' : 540,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-- 
2.39.2


