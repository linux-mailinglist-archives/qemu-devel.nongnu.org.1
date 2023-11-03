Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5A7E09BB
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:01:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0L5-00088z-VQ; Fri, 03 Nov 2023 16:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Kt-00085E-3S
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Km-0005KG-Ej
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40839652b97so18879945e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041598; x=1699646398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPYnsi2vv7vTp2m4L+dzwYGsIeLimoixnt1R7Ke6aYI=;
 b=izFMecW5QboeUK3UzbGTXdwfwocJGjuq9j/8Tv0OM9wEkMzs3apMw00cDyCYmVoO9G
 uqSEWRK1Hn6VwPbl77s/I0DC04oQcFrmgPMXLRgO6T4pDdnb2tJX9HgFHgWq8z5aY7+a
 b43HWXD7Jw56uQsnK+BRd1UHdlH1BDSzyq8BbM9cvhEPHGjoZTw/ODcpKPzMHzyIiObO
 /jVMaf21q9Y7onejH9s8NcfrCnnTz7jChXkz3hYGqXcLpzDGFPZfWjUMlmsL0opzRMCu
 VhSUgObAsyGd9DB+MistL+qjhj6JLRm2g9jkh9R4ScUgVb4qDMAQTs0IFyUKbB4bvMZ6
 5+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041598; x=1699646398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPYnsi2vv7vTp2m4L+dzwYGsIeLimoixnt1R7Ke6aYI=;
 b=AzduH2ArbXX2B9nIq+vI84XYoqW2APdH1q6vbHN8fwmEoxnakdXZbeRyjnQQg3MadC
 SV4DNyO7xiZ6aG3OEObK5wNFGAW8vozeyfAAfWCZ7aLTI2soVV0iOljI1Hkupx/rVS0a
 AZegQTg/ZfAW9FrDbT5BeWqM9I3jfzviw48fTdHh0tGqVrmzOyaSpZPKXtHQAanc/WuC
 2T0h8pTzcbpjwHDUFVbfOH4UnFoc2boYOAf6BghbmHRSCUxR9ONu2/fySCGdieFJRNcO
 MGYnMMoqFa4jNbKaNBPEDrWxPDbval8q1aSfeisDffnH7wau5jiGq/8B0NC3Sfaw5vLj
 Y6Hw==
X-Gm-Message-State: AOJu0Yymn1M0SloN/QPCdFlAQ5F+bBkzqKorNLdtercTxzNbzemQz0Z2
 SSHbJR87/rXIi5XU0ijE/KMJvQ==
X-Google-Smtp-Source: AGHT+IF0EEeWumzOzRit4pV2GFbrcEQZ5ln2ATNMRp6Ox9N/rjU7pE5YntCIjWgWCe6CerKNSD+v0Q==
X-Received: by 2002:a05:600c:524a:b0:407:8459:2ef9 with SMTP id
 fc10-20020a05600c524a00b0040784592ef9mr19220943wmb.21.1699041597974; 
 Fri, 03 Nov 2023 12:59:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0a4c00b0040775501256sm3595619wmq.16.2023.11.03.12.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:59:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D47F865741;
 Fri,  3 Nov 2023 19:59:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 02/29] gdb-xml: fix duplicate register in arm-neon.xml
Date: Fri,  3 Nov 2023 19:59:29 +0000
Message-Id: <20231103195956.1998255-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdb-xml/arm-neon.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb-xml/arm-neon.xml b/gdb-xml/arm-neon.xml
index 9dce0a996f..d61f6b8549 100644
--- a/gdb-xml/arm-neon.xml
+++ b/gdb-xml/arm-neon.xml
@@ -76,7 +76,7 @@
   <reg name="q8" bitsize="128" type="neon_q"/>
   <reg name="q9" bitsize="128" type="neon_q"/>
   <reg name="q10" bitsize="128" type="neon_q"/>
-  <reg name="q10" bitsize="128" type="neon_q"/>
+  <reg name="q11" bitsize="128" type="neon_q"/>
   <reg name="q12" bitsize="128" type="neon_q"/>
   <reg name="q13" bitsize="128" type="neon_q"/>
   <reg name="q14" bitsize="128" type="neon_q"/>
-- 
2.39.2


