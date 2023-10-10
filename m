Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2257BFE7F
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDBI-0007J9-0J; Tue, 10 Oct 2023 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBF-0007Iy-EL
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:49 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBD-0001gj-BS
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:49 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so1026245966b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696946025; x=1697550825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nc/UUSzDQPj9EpwY3ZRK/pMdPSsApFE7vlIyd1HncRs=;
 b=vXLP2LRMznM/5HKVhLsqq1DaYUk1mqsDBodcqvF6EYqAM3u3kZ1W/+Si2OFXARGOxm
 VhtGx+2mM8jCB1MiovNEdAwPRdM8vDIgw3tpkyHIeVSGUpgQKCgQNeiT+6QnXSJbcbNu
 qkRcghNUxrBjpgglN6rFPzQq7ebx7q+s7dtYmKzQrSfTppRwK4bwqaV+xAURkzMOOW9I
 W02pTWP4USPjMfvUfC+7veFz2N9aJIRPKYFTYy5QBUwEMIFAWEv5hNYGkgPRUQGTcMU0
 PukyrxEqnuYZkRtcDq36iVrQU+Agi7QYPOJED1ONdNUBKxIttTspTL98pEyIfxzeagmN
 b/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696946025; x=1697550825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nc/UUSzDQPj9EpwY3ZRK/pMdPSsApFE7vlIyd1HncRs=;
 b=l6/AhaZmTnrvPi+Vf6iJwsBkuIHpOIrxtWy25DIzjDme59yn8caqawsq8qcDIsrOwD
 9HmCtCLioCgfdXSELTLm5vasLrB49/lbxUf2ud6vxUdp+WWkk0kAwGDy2moI4a22nB/2
 Szn9bIixV6Jwa1GzWUajcfXjPHXbBqaK8WgVGEhdRRXxZOb+BKu4rC/FxwmkTEMwUXTW
 hBl/lfPQiin0v1Z6hxY7WdumYG+XcAMIaob4Q5U2zXtdAY6Z43EaSOpj8MgPQcgLjBaI
 cPPj3Z+f23/PsNlNdABCfstgL8KZtgCg6M+6n4swjUsBEnUM5eugPF3BmbGyR1JWPh8C
 SDfA==
X-Gm-Message-State: AOJu0YwB1ncWgmBzU4UThzrnyg0BQi71kfkHBawGBMZgsIZfrwIiIyvd
 nXndKeWxoguD8ChMcnP6bOdZYntYs0G5GDpRlDsUHA==
X-Google-Smtp-Source: AGHT+IFNyr/rYUv+eCTUvJU73etUdEE7L/FLlrK6aLYMVPl1CIlaCyd8C6FEazqlSqygtsIlw95euA==
X-Received: by 2002:a17:906:73db:b0:9ae:6a9b:274e with SMTP id
 n27-20020a17090673db00b009ae6a9b274emr17694458ejl.8.1696946024771; 
 Tue, 10 Oct 2023 06:53:44 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 ca9-20020a170906a3c900b009ae587ce128sm8468815ejb.216.2023.10.10.06.53.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 06:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/loongarch/virt: Remove unused ISA bus
Date: Tue, 10 Oct 2023 15:53:40 +0200
Message-ID: <20231010135342.40219-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ISA bus and serial aren't used by the LoongArch virt
machine. Remove the dead code.

Philippe Mathieu-Daudé (2):
  hw/loongarch/virt: Remove unused ISA UART
  hw/loongarch/virt: Remove unused ISA Bus

 include/hw/loongarch/virt.h | 3 ---
 hw/loongarch/virt.c         | 5 -----
 hw/loongarch/Kconfig        | 2 --
 3 files changed, 10 deletions(-)

-- 
2.41.0


