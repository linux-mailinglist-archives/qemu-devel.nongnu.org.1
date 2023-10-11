Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164937C5668
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZsd-0000E5-CC; Wed, 11 Oct 2023 10:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZsP-0008Rc-7p
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:07:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZsM-0007FH-Pw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:07:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso63867665e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697033268; x=1697638068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoDUpCbTedzPU30CQb9d9uvflh1nTk1L9uLqEJ+jbds=;
 b=iLKg3bSopm2nhrNM8L1r2ItPIhTXalwhpy/uFBwIZiov/5866RyzSJqyNyiwTO2qKC
 ULOXhhXCHGkLru4/CZbuJ1E/1ezVmYayZm4tWwcIJfTuxdm/8ZYhvn1aO2lDVp83LqZJ
 1N0Z9a9fO8jYLRhyamDYO1zdXoq8TRL3hkGJPKNcHOsgY2fAfCmZxrU5CZGVGJfcmVsg
 5ZVMcmiAPh1xewS1ylZ3laCAxQtTeaOHcOG9xJuXLCnaWO1x7rwtwIurDP/jeLgH+1RS
 GFxNokI6O7FcH/XQGlogYqaRmOO72+Mr6Xkw0ksOIQmvONG22Kt6pCMZbHK6FJ/stzXs
 NBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033268; x=1697638068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoDUpCbTedzPU30CQb9d9uvflh1nTk1L9uLqEJ+jbds=;
 b=YpyIdbWO58Tpvcx5iCldqE4tT+lrPtbzXaOCFf3vW0RWto5IrCHU4UYgj3f3agQmgi
 s+8rGAoyHUoVkZGaJxNufgf51rVddzfYQTKyy03iWCwhmIkaIBahimaJEmxuNNaF4xPS
 KKOHu8LH4ofe+KF7+C/jGqAZeVzX0SKy18pFMcFsVh0tKFjh8itSWAFXgxCTIQRayS4g
 tGlazLGsX10aoQqZ6rtRdHiD9rb8mN6+ZYWmWgm/FEDWtLZ+vbdAfOmLoFmqPRyusM8o
 /tj+qWdW4GWkF0S70oszHkoHxNn9nbhPXpwoKrudT6bs5duGHwh8UMN2kaubr5QaX8Rh
 aJYQ==
X-Gm-Message-State: AOJu0YwJws3hUWyRnRJd1XCqPEzoJCyY9RTn1ZWp9IzVnVbaD820ETje
 XZ2YlklDm9fiy9PVKfULgj2NNUd8Hi8f4kdVkhA=
X-Google-Smtp-Source: AGHT+IHG8C+TqNC8Dic+04CcGJ7nl+DUuX+FlcIogEE0TXokQFlgx18gYzvShoAVRRz5wv2PW8C9WA==
X-Received: by 2002:a05:600c:231a:b0:405:3a14:aa1a with SMTP id
 26-20020a05600c231a00b004053a14aa1amr18051202wmo.18.1697033268480; 
 Wed, 11 Oct 2023 07:07:48 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 z19-20020a7bc7d3000000b0040641a9d49bsm16646145wmk.17.2023.10.11.07.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 07:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] MAINTAINERS: Cover hw/ppc/ppc440_uc.c with Sam460ex
 board
Date: Wed, 11 Oct 2023 16:07:20 +0200
Message-ID: <20231011140721.3469-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011140721.3469-1-philmd@linaro.org>
References: <20231011140721.3469-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

hw/ppc/ppc440_uc.c implements the TYPE_PPC460EX_PCIE_HOST
device, which is used by the aCube Sam460ex board.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e7dec4a58..8c07d07927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1482,6 +1482,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/sam460ex.c
+F: hw/ppc/ppc440_uc.c
 F: hw/ppc/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
-- 
2.41.0


