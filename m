Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210381B3DA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS7-0004GA-0C; Thu, 21 Dec 2023 05:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRy-0003tU-NL
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRn-00049h-Li
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33679c49fe5so508512f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155111; x=1703759911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7uxGZGov81O+5jLuoaBr/C5I/uZZh1/zGx1+p9cIt8=;
 b=wn6HY0qqfgzoqA3mnBjrnMK8LKAfVexaGcaOc09+YSLVy+8XSd1fRIcIt69+fpn093
 Vp/EaU5VSj+ceM2HqI9U3KLr8qyPmjW9RXIR/79pCxe4puFpblWmigTX5PAYeGaldyct
 IWkFzOHvsQA/GJ5HAmR8fuua5cKbKwRveFlJ2793oK4wmM17eGXAZ27eEhWUZKAqhwjm
 qyiA8/lvgvRCS+tAxFtaFR56pYs9+/SGB5KMI2MepqUSMpwl7Wu4Ht/EasCwhswMbKBI
 UpzWshjwpR71Z704VjQDwS3VDdzlueH0UBoVj6F6hO4dsT6dmOzU3UdSFnPuL4eTmkvG
 x+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155111; x=1703759911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7uxGZGov81O+5jLuoaBr/C5I/uZZh1/zGx1+p9cIt8=;
 b=T6CwSQDfbbcusFTvNVDbyIqd0LNAeRNcgAJdGRT1H1wJ8qiTVYPKT+umRxlyjTdUNf
 KYgTQvEHxWGZd8eG918GXRaTM+xTxSEzZcSINUnbU+L+d7fItZZMLQ59/hVDmRhDH8N1
 MksR58ULfqjIE5Zj2IN/jxL3dAQ7FPds9BIGhP33donSG/SC9cEZIHsbydpQTpwVXnQl
 +Olxt9WPOy4TieT1/OMMLYr82FwQUcgscXk472sCVRnnz02fiASYB/NgSdxd+Dxdbip4
 1tKxtUTqPIkP0T9v01o6GmSx5jxeIjlXJ3t3WU0St2zGPnlqYUhOR6AcpVT/EUZPvubj
 YYMw==
X-Gm-Message-State: AOJu0YwpgrxjleVXOH4wsqZ6si7BdMKrjS1felmDqKENshTwm79FcLv1
 llE/FDqrJSgT0COYetJjICtY9A==
X-Google-Smtp-Source: AGHT+IHDkK7DDkGONkWeeg1etyQrE038hwJH58HJmds12JAmwy22MbScTVnibljXYstd5tpPwiyrKA==
X-Received: by 2002:a5d:5385:0:b0:336:6f89:9eca with SMTP id
 d5-20020a5d5385000000b003366f899ecamr616253wrv.66.1703155111228; 
 Thu, 21 Dec 2023 02:38:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w9-20020a5d6809000000b00336768f52fesm1722017wru.63.2023.12.21.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CE1E5F8D6;
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
Subject: [PATCH 13/40] qtest: bump qos-test timeout to 2 minutes
Date: Thu, 21 Dec 2023 10:37:51 +0000
Message-Id: <20231221103818.1633766-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


