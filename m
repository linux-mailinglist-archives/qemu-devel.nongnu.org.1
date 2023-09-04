Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC6791B9C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:29:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCRL-0001tZ-9q; Mon, 04 Sep 2023 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRG-0001rR-Bb
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:34 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRA-0002Hq-Np
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso237129666b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844906; x=1694449706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3IKuhws/bAum6TTbwOlIp5IuJegkUw+g88cYhxcpc0k=;
 b=YO0UbzrgdjgB42DprpS3yLYl241AkLfjeNs+vqYR7CdsHqLyHi7zNr49lAHp/QDX9D
 Oia6OlzdUL1Jtrp3tvdnbzrQh0a8XZuvR8IG/TmC8DKaP0/6dZX8WrEcwoQ/vxyf1T5R
 9zANgDP5LytbMJlTfNDgfkYrslqh/T1hUtRjb7t1fRFYiEuHDyp7RGX9CSf2WA/P8rgF
 YJonyzEsM7/NkwRYYJZlnat3BgzA30t4D9zpsrs1vyQgRMA8bQi2f+vHoDNP2ZFY+RJ6
 VQOoVP1YZ8vKKOjzAhlTG0arq7FSsvDWUnxCSB6+k/rl6a1MN1zg+06uSeS/82KTLJXp
 rIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844906; x=1694449706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3IKuhws/bAum6TTbwOlIp5IuJegkUw+g88cYhxcpc0k=;
 b=iPQqhgohx0WXofaVFM6tVRh2lIAdiW2Xez/yE2ggHkeqH7CEmjBmH9DE0knJpLzUmu
 mUU/vemxqw7tIsCEJfvOlUpSNQC6r/aG3ae7hhfqlPHhH37mK2uAjSYp/E8zaflom3CK
 RKW7TPvvBdssHgMS/Z0c96U5eHpCri8lW81btxBwyKbvJ0goIfaoObGtQ2QCYCRTjtZD
 aOkjRdfIdr2w1JqKmXyxwLrzW5yWsCWnPSKXgsQEIPoM+d6TJmMIuDRfkCzm+VsQkpmO
 ECa0VZ/Mib1NaY+egldqsG+7zYinVJ/188SGUQYYn5CgV60ArzXoBdphwuQlCuwwT+Wn
 7Sog==
X-Gm-Message-State: AOJu0Yy+tcHRDCq2sSLCVA5nyXw/+6RX2Y+aCtQG8eYxidcRp8tluKHE
 YQq/AfhHIwA6uSW7md813X9m8t10P3j8g2d2mkM=
X-Google-Smtp-Source: AGHT+IFnJ8DAzLsSIyw3qOlWEhN19OSMJ4kRTy1Fz5WNzDbcLUaVJJ8L5LwPmafr5VX1ZMqOOa6bRQ==
X-Received: by 2002:a17:907:a076:b0:9a2:292d:ea60 with SMTP id
 ia22-20020a170907a07600b009a2292dea60mr7555853ejc.40.1693844906698; 
 Mon, 04 Sep 2023 09:28:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170906248700b00982cfe1fe5dsm6384747ejb.65.2023.09.04.09.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:28:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 more]
Date: Mon,  4 Sep 2023 18:28:21 +0200
Message-ID: <20230904162824.85385-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Just missed while posting v2 eh :/
(https://lore.kernel.org/qemu-devel/20230904161235.84651-1-philmd@linaro.org/)

Philippe Mathieu-Daudé (3):
  hw/core/machine: Clean up local variable shadowing
  hw/intc/openpic: Clean up local variable shadowing
  tests/qtest/pflash: Clean up local variable shadowing

 hw/core/machine.c               | 2 --
 hw/intc/openpic.c               | 7 ++-----
 tests/qtest/pflash-cfi02-test.c | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.41.0


