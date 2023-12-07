Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFF8085D7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:55:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBC1f-0006WI-02; Thu, 07 Dec 2023 05:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1c-0006Va-5B
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1a-00076Y-Gs
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40bda47c489so8289925e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701946469; x=1702551269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VWib7g51s4LqF4o+fXWTb1K6zI11XXQH5HvJiK0NBFM=;
 b=Opx7nHwPHmxfqZaO+khkoN8b0yq5TOJ2reRISZbDrWPt4P2/VhIUTkrVT+LuL3jNqT
 cBVsf/+C2Dw3KbDaMs3NA3mw7AVSvDurYUtAO7RQZJJJcslgSzSx9k58f3H5xjxKxr9q
 TrgsIdjvUhYAMBjept9Bo3O3++7/OZINkD6mEv6t+UO6Tn3yoxoqD3XUTzYqKBUuYz2j
 SdhKOtsFhrTh4qUNpvw0xpME3e43DaJdeYRulYRjl9x9Kp2vNsa7SO2hXnSLK8mTpAtZ
 b22bP5dAI6S+ygfXuodjmvdKWbuT6ZT50oiaX/pjpsYmnutLdvGeY8zcSRaPotifclXX
 +KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701946469; x=1702551269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWib7g51s4LqF4o+fXWTb1K6zI11XXQH5HvJiK0NBFM=;
 b=csdg1nG2cBo5PO5FwXnl9bvJiZoxEKdwg8XOQ1nrfIoHabwjgiLpHwwrkd3twNmqZA
 ongRWCWyMbfFFg2SREsIpsGjdSFQaeEawsP85LIdKSYkKsKvs8nmjpzDxlj/X/muzGrL
 fpAv+ddAJ+VrGbuLHe4oddj5sUdNQ8MaJjYwJvNxcsGMPZ6n2bE5VUZ+4IPOBOoTXDs+
 RnVXnMNbUipCbObhAyQbaXIvWebMYiYvGrnW9SRAbou+WczpgFxPOY21u774A7q7kIpw
 4GVntXWsFJBjagGrhecW5nI8pswMFgxG+OocRYcgyzukGT86iK0rOlkBoSiPXGTfhwi3
 B08Q==
X-Gm-Message-State: AOJu0YyjixiEeoElZkdw0VUR6WoSYex6NDClYFTDZVYjFG28bBrAwGrx
 +EjVpnC1nMumHCV+65kQMiNt+OLPYid1OQ1lDzI=
X-Google-Smtp-Source: AGHT+IGriYr+FUlOdX6HkEVRWl/3AOswnl0+neJWAjizjyK9ug+vv4vrZBFM3vvWm+Kj45ynUeIFBQ==
X-Received: by 2002:a05:600c:4b27:b0:40c:22b6:ce9d with SMTP id
 i39-20020a05600c4b2700b0040c22b6ce9dmr1271799wmp.141.1701946469052; 
 Thu, 07 Dec 2023 02:54:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b0040b540ff0a5sm1514033wms.19.2023.12.07.02.54.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/alpha: Only build sys_helper.c on system emulation
Date: Thu,  7 Dec 2023 11:54:24 +0100
Message-ID: <20231207105426.49339-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Extract helper_load_pcc() to clk_helper.c so we can
restrict sys_helper.c to system emulation.

Philippe Mathieu-Daudé (2):
  target/alpha: Extract clk_helper.c from sys_helper.c
  target/alpha: Only build sys_helper.c on system emulation

 target/alpha/clk_helper.c | 32 ++++++++++++++++++++++++++++++++
 target/alpha/sys_helper.c | 18 ------------------
 target/alpha/meson.build  |  7 +++++--
 3 files changed, 37 insertions(+), 20 deletions(-)
 create mode 100644 target/alpha/clk_helper.c

-- 
2.41.0


