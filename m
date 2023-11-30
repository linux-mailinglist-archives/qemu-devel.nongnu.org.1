Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8A7FF1BC
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 15:26:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hz1-0006G1-4Q; Thu, 30 Nov 2023 09:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hyr-0006CO-33
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:31 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hyo-0008Jx-04
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:27 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a178e82a445so141309566b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701354322; x=1701959122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7kz+EmRH6e7FNOo9AaU5Yw2D2TcG2jscWc1DZXFhalI=;
 b=d6fefebxDo+ZTD31jVQkPnRPg/PpAQ+TZfH06nIZ3NJec9jBJUInIXaGgCFOKHk7XH
 6aX9yTx47uTaUY/OTylc4/Ez1IIREu4polJNAeyE4g6ygfH+NhuO5Fpk38drIeN1QOnr
 p5Hi+lxM/kLeFykyoJLEZtflY4kJIn8u97G4FND+2DhNNmlNxDWNop4jn7lwj8ESRrDC
 QggquvYTIUsyR3CBxCSfuwNjsKMrukwOrTsrB2p7N9UpBcmseMVxadFiOO9MtwR5K9Rz
 unk8IXlQMoRueGpW9qfDX47SyHTW/9aTHXmqC3IMqwnB2jEXZCwkEe/01/UPydiaNcmU
 QNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354322; x=1701959122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kz+EmRH6e7FNOo9AaU5Yw2D2TcG2jscWc1DZXFhalI=;
 b=r2H478zRuawj12vWdZHsPS+U3D8Pls1jV6AUSDq8UDrpT8a8yJ9WfDo0kj4rVO4c5f
 j4yzRJW7oyAuZ4BSXz8v+QJ6dUe93kLRwRa1o0ra9sTiNo9MRBGx3p00h/A4E+dzgR42
 MrE0S7oUr4Eb1GaDXOKZgcKrmJMqY8cy7jQcuG+MoQepI5Pk7INUZ+nPewygJRKZ0WaN
 lN6XM3gHq6tj1kl/YEmJM4jQgDJMwOygYYVSrjShBR2Pdi049PnSk7o1tLLqaQS9zVet
 lLilb875pxRDms2Xq5d0wpmZ3IBVlQxtEtPCTqgnGqlfZPajr70emjSIctBmTKU+u5WU
 aDeA==
X-Gm-Message-State: AOJu0YyaBixH09kKd+/0KVNqI7pK3IKLi+93O0t+i618nqwVsRsFcYNS
 RaGxGSRCDsBp7gEXykxMFkCwCDKTQzFK7OGVmIWeEw==
X-Google-Smtp-Source: AGHT+IGlwEnrCWaSiaTljtWSjgJG28xJCEJG7LcHqJ+rWjM6iCBzxqwwIcSE74YgTrh6Iov4jQ4TdQ==
X-Received: by 2002:a17:906:18c:b0:a04:7cdb:ff97 with SMTP id
 12-20020a170906018c00b00a047cdbff97mr17479212ejb.0.1701354322313; 
 Thu, 30 Nov 2023 06:25:22 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 hg1-20020a1709072cc100b00a1933a57960sm205200ejc.22.2023.11.30.06.25.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 06:25:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/3] target/arm/tcg: Few non-TCG cleanups
Date: Thu, 30 Nov 2023 15:25:16 +0100
Message-ID: <20231130142519.28417-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Few non-TCG cleanups extracted from a bigger rework.

Philippe Mathieu-Daudé (3):
  target/arm: Restrict TCG specific helpers
  target/arm: Restrict DC CVAP & DC CVADP instructions to TCG accel
  target/arm/tcg: Including missing 'exec/exec-all.h' header

 target/arm/helper.c            | 60 +++-------------------------------
 target/arm/tcg/op_helper.c     | 55 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 3 files changed, 61 insertions(+), 55 deletions(-)

-- 
2.41.0


