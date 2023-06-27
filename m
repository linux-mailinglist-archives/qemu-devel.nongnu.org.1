Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E67400BD
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMI-000122-5j; Tue, 27 Jun 2023 12:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBME-0000yo-MB
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMA-000896-Ga
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so6452493f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882553; x=1690474553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=cQJnroOavKx8Pi3iD1Ye5zaJPQqpPiCCs9yFwr+io/Tzq1k1aPbKpuG71g7SvrfLjo
 uE82mjE8RQCXYQA6f3xHuCQCxhvzvKLASsTZx1vN/nOhNHMSP0hK4FzUvDvkkAPChcvk
 PXoDR4kSYDlUm1HeHkHTT8DeYhRqkOiq5NiIkRg2mvVBcXsTepKg8X+yPUFKbuPaxzJ7
 RQmTw3zmErlcG6FTuvpcv9h9GZMuOQkD8+GFHgNkxJENJzdxkpLoPMJ6LFB+2N5Gpqjm
 kvzV+84L+orzmx2M0AXP9CqSbZrwah7N5aP5WxOMsFXTFcm/VFp+KjcLF/g7h4J6Qpbt
 HQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882553; x=1690474553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=OYY+jtS1jlsTtCz/XFWQhSUF/Y7NwPUikLea83LixyVbbEN4nTmQ30lXbk4s4OUJSa
 iQI/uaJiv4aSNPUM89xpdQtGv6iqL9pnCsaTiC7LB6Nb7JNEr0JohW4/3hLB5qJff9VB
 c8L2z55WIhuKRBmxYFeJvo91YEiunf23FJgXS1AfI/4euttMZil50jV2U6vV5YAtNiYf
 8aSzXQg6+A2OdTAlcW4ny9jl84vQz6UjR6AF7onp6plG6Sz095qf5SYmD3Ma90drUGXe
 QQUuyX1tD1YOSP7pu9PEGjAiuCATzgeflxiik9OcHaYabT30XTYYT4gV/58LubQ4KMBU
 jkCA==
X-Gm-Message-State: AC+VfDwAS1v29LGgkwYQGLkUFc9x99+JqPX8nPCMMFuVBIvfu1ppcZ6x
 5zh2G8hKJ9yvtFyk4wa/+4QXGw==
X-Google-Smtp-Source: ACHHUZ7XkeBjDKZZFWlaWHkTm65v0s0YiGu67s0CQqQSi3bYpR2Wxn96ozJ6Hqm0mstIfmhAoDzeFg==
X-Received: by 2002:a05:6000:545:b0:313:ef93:9257 with SMTP id
 b5-20020a056000054500b00313ef939257mr7900702wrf.32.1687882552006; 
 Tue, 27 Jun 2023 09:15:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r11-20020adfce8b000000b00313f3c11512sm5416736wrn.89.2023.06.27.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A9AE51FFD0;
 Tue, 27 Jun 2023 17:09:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 23/36] docs/devel/qom.rst: Correct code style
Date: Tue, 27 Jun 2023 17:09:30 +0100
Message-Id: <20230627160943.2956928-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per commit 067109a11c ("docs/devel: mention the spacing requirement
for QOM"):

  For a storage structure the first declaration should always be
  called “parent_obj” and for a class structure the first member
  should always be called “parent_class”

Adapt the QOM rST document accordingly.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230622101717.70468-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/qom.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c9237950d0..2828843058 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -26,7 +26,7 @@ features:
    typedef DeviceClass MyDeviceClass;
    typedef struct MyDevice
    {
-       DeviceState parent;
+       DeviceState parent_obj;
 
        int reg0, reg1, reg2;
    } MyDevice;
@@ -147,7 +147,7 @@ will also have a wrapper function to call it easily:
 
    typedef struct MyDeviceClass
    {
-       DeviceClass parent;
+       DeviceClass parent_class;
 
        void (*frobnicate) (MyDevice *obj);
    } MyDeviceClass;
-- 
2.39.2


