Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9781B3D5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGSb-0004pN-OE; Thu, 21 Dec 2023 05:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGSC-0004T5-Es
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:39:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRt-0004Hd-U3
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:39:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so177930f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155119; x=1703759919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjgnYFLBOv5uB2tWkg/kIZdJs8xT0wOiNJtUez299cQ=;
 b=S1mw+Hqt/xNnpAV+2zt4a4wKYzuxyITzvuaQYTvf2J+hAGTCmJGG4JuFSfa2Ku+84J
 OUiRZiOP64cVac/Fp1D//geo4UqPIgQMPLWKsrZkE1nAtydyura9uaGugRbqTOiBilBZ
 k5ljynlxT5L0HARWELvtkp3KZX1Om8axx047REz6es3zmXpAdI1J6dM5z8yTvr98gYuG
 mXrO6UxflhTk1aYO7B4rK8ALWdQPYiwZ3LOlx3yysnp/qInDsq6ZYeL7xR07sI5fvFOC
 ivShR5/OUUni/bLVtfXVPlrr9Ear59eH/uI9B0SVnORDpEGEWacVa6b8B14tlzuoBeqb
 L/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155119; x=1703759919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjgnYFLBOv5uB2tWkg/kIZdJs8xT0wOiNJtUez299cQ=;
 b=tvypgEhpWsacOhlN2RGmAacnL0YHyU1sv0Dennz8tGVjHPPfz8Duu/V8PVem5UREWl
 5EHJo920BTKHT/uwpn8A3xrM44ud7cNXn/C94FDUxt/QnRCnNbTSsFTBl6Tmdirdhw5m
 HNHC064abWDWiSWDOUVNDqOlVYWvHwlitnQYFDpAm1WFoTTdCzdDYfmfdmCr5z3NZilE
 RfrtdUVHcBzTYdxlE3xC9rPAaQ30A7AruUOeth7lUdjGuVpfiHnIG61v0HRYZQ5kBL4X
 ONItNvY8SuirhgnTY514RSx4gAs19vzUs9MSlDTT7JFiMobeosxynmetAX+li/lW4Rv+
 5arw==
X-Gm-Message-State: AOJu0YwPCFTcefA+0/bVUP0kK7htoqIJiG4R8pYqbJiNs2aqJdBau4Ju
 Ng4oGteoDbDCPCp6ca+DoOLKDw==
X-Google-Smtp-Source: AGHT+IEzYxVwlU5vLXnRXYLYc4mdvFjddVid7e+dmI0N5Jhfnqq4QSDEATHx8NRbGDzvJadlAOUBtg==
X-Received: by 2002:a05:600c:35d4:b0:40d:3ff7:9bd7 with SMTP id
 r20-20020a05600c35d400b0040d3ff79bd7mr273696wmq.143.1703155118806; 
 Thu, 21 Dec 2023 02:38:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w19-20020a05600c475300b0040c4620b9fasm2789726wmo.11.2023.12.21.02.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5F765F90D;
 Thu, 21 Dec 2023 10:38:22 +0000 (GMT)
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
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 38/40] contrib/plugins: fix imatch
Date: Thu, 21 Dec 2023 10:38:16 +0000
Message-Id: <20231221103818.1633766-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

We can't directly save the ephemeral imatch from argv as that memory
will get recycled.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/execlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e2..f262e5555eb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -199,7 +199,7 @@ static void parse_insn_match(char *match)
     if (!imatches) {
         imatches = g_ptr_array_new();
     }
-    g_ptr_array_add(imatches, match);
+    g_ptr_array_add(imatches, g_strdup(match));
 }
 
 static void parse_vaddr_match(char *match)
-- 
2.39.2


