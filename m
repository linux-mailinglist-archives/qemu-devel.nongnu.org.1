Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FA273EE66
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuLr-0003KH-He; Mon, 26 Jun 2023 18:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLL-0003B1-VA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLH-000716-AF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so5503583f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=FGR2MZ6EMI02Ucd5wWjy7V/egqOJMi5nVn1esQiLF+i3ntR1MsFaPfeR/T6DqgZMQp
 8SvHKYCOy5XfKti8HjE61pj62sbAD8cQY3/3/R/zWb3Tyo0WkAeDfTjvct4De/4W7MFN
 k4Kd/DlcjQWAY5ViT8YpQMU5hmlzb4o5aruKis9jJy29rjbc75kkVNb1E3DW6qVfwyo+
 qHIX1kHr4t5Xe039oWeBP73xHFLwdvH4TYRtvikgoKSAmdoqNbhUCDBewPLKrlWf2kXw
 Z+SjYqAWV1nxtgeAZxzds69ykW66sd/7853R7+O/vejNaSkJy9fn5Mn8k6w9WqNBkOY8
 PLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=NeOpwqswDEr7B25JJGpuVZXdTxJN8ETXnAR1CU6yQ0V3f11BW0GIT5oGqGgtIbf56m
 OecVs5xB9Joyo/QtIlrIxa4wV6ivnwOeYYJfhEj+0H7sUylB+OKcRpcZLLKUwLXpzV1a
 8JHdBJcylzIxeyjw3ytUTZ3+X7O3aCPidhJcMtYv2KvjkdC/3DUmnasMXaIGzCBrPQFT
 kFQq9x1gz0J7YyWOvZ5e6NPwYTr9V/zdq90a2yMOdNMPOyZg14Lb6KBTVlgo7iXwDMWz
 aJxwT4aX33AmrwSCREU74uiE0+/hJ8ZBbfu/Pbkiar7DujybFIKYsUjx4smXIpzaSDYm
 fI/A==
X-Gm-Message-State: AC+VfDy/iKooctmM1GzBj2W0DS8/uvVfMkDl5POBkU73N3nxDvtEeRR9
 B4cmO9texxC2ohdJtyFYGxOEYg==
X-Google-Smtp-Source: ACHHUZ7BzfMVgSjmMQYDPOZce7lOqwr3zHM0fz/CZanc6P5jtCLNkDhICzWWE+6+AT/RfiZ3HRPMJg==
X-Received: by 2002:a5d:62d2:0:b0:313:e8f9:dbfa with SMTP id
 o18-20020a5d62d2000000b00313e8f9dbfamr8144855wrv.35.1687817149583; 
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0030e5bd253aasm8527934wrj.39.2023.06.26.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABDF61FFCD;
 Mon, 26 Jun 2023 22:59:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 23/26] docs/devel/qom.rst: Correct code style
Date: Mon, 26 Jun 2023 22:59:23 +0100
Message-Id: <20230626215926.2522656-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


