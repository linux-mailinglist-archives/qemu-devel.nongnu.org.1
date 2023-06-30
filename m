Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE2C7441F5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFId3-0005T3-Oz; Fri, 30 Jun 2023 14:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIck-0005Rm-36
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcg-0003XK-9f
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f58d6652so2428904f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148812; x=1690740812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=dIC0Zv9/w87dJC0fdYzyuSo2cKcLhYfbBjAqYq5V1Q6ZpAVnZ9mVuaZFlJy/ACH5f3
 Syw8wQujtkt/V5CBMYUEnBWMoVcgM/BHrg7BwRFUBY7mbZieu2jhVImCGxEXwz8wKCmN
 Zx14PbBVFzqOsAZNQNYZ1XqfgHBluD67GrpFli5ABqtIvHw2f+omWdhWMgDwG+4fHT9z
 4huZ9YQko3HRwTRMqYK6P5KapzJerLuBi94VFJ4OooVQChWQnjSCajxXViDE9PWuGUGS
 C8ED7K5YxTNilCGUHtgdIOwWBxkgQHvflkTthDsBauWD/8OjhBcFPHThM0fgQlSxB76O
 agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148812; x=1690740812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=kLhFwLllLBcABf0FLHFOWJ1JpdPmSLhyETzCroUnu/O3rS3sRt5mN6t6TXWNrmHUGh
 g7tXrXnvgsQ35HpQ4oNkFRjbFdWR61d/MDE6Wd9GBIZnogpLSqIZ9HAEGLgzvVfOtd76
 2iNnMD2uKuQ4tGbEnE4oFDpTpAYyywOy2japdrYcpXHWl8bwv7AmD+LOT3Sf0jd2ATnd
 xLFfO8hKOOVqoWmoayNjhUEocc/BkLzqx8AfiVfnqLdkJr1awtD51GY2hofuYeYtwHw+
 1mqXXJt/8ANpeK+uTiUVgyvVaAUQR8lDXgH89Z9Mhk4AHIL0qpOKSboZQCPF+PXeozgP
 dMBw==
X-Gm-Message-State: ABy/qLZ2wfkzYUURfoyLDoBRswhKgyXn3LX3u08TEPvUia0MDlkOGB5n
 sL5Aqr5RlBOZCkBSt/hsZ8LRqw==
X-Google-Smtp-Source: APBJJlHYXZUQzWQH1AeJdPQsEXfZjwXFpQyOBmlYd26D4B1If6piOr3WSvSfZNjh4NGUV4A8no4ozg==
X-Received: by 2002:adf:df8f:0:b0:314:c99:cd2d with SMTP id
 z15-20020adfdf8f000000b003140c99cd2dmr3099118wrl.10.1688148812799; 
 Fri, 30 Jun 2023 11:13:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d5941000000b00313e59cb371sm17576229wri.12.2023.06.30.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8BBD1FFCF;
 Fri, 30 Jun 2023 19:04:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 25/38] docs/devel/qom.rst: Correct code style
Date: Fri, 30 Jun 2023 19:04:10 +0100
Message-Id: <20230630180423.558337-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
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


