Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A334082DE08
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:57:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQGE-0006Fv-Ba; Mon, 15 Jan 2024 11:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQG9-0006F8-Bo
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQG6-0001Wd-Qf
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e80046263so4757025e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705337778; x=1705942578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G5MCkR7FWMOFNxlqR+QuPvNAiySpq5CrE/hsZe8v380=;
 b=OJIBwC3YI/RWkiXAZVjNomnLRHf9y9gG0FOkCjdQkRXvgJkTis0rP4vIfpkqvvUezE
 WOwP/qqJ6C3TGwOJmARwAeVCGKpCv5w4l2r2wUvdXlxrTh5rGIWhw7CQliZ31+OhV5SP
 tqvdg48vr2HsGMNdP1zg7a1cmeJ3t5LoG0k+B/d5V3lUrFNBG48QkTNLCSG0edl6MU79
 75Im8r+zlwwk1ddLC+SuyMQs64euR1tI2UGoD8vTFPz/u13nWizZbQaEXBi+yDWjUKmv
 jYCsLLbiN5L3yYT7xag+lQMARd7xgMZfict8DrHmI+x3gVN3imdGGzWt9jEALG1ByNcU
 rK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705337778; x=1705942578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5MCkR7FWMOFNxlqR+QuPvNAiySpq5CrE/hsZe8v380=;
 b=KnrthRggYLDxvppKI5SLv0yKATsflbdtuYf8yUcsEgyHdjnNqsRr2+v8kvZn76qG3i
 a2Ll95czf12STeODKaxvgKZp8Z+5VbgxHhaVCYFoaYL7PmfEo6VyZhMkC6K+FnlpsuD1
 u959PuAN4R8FFSUhdataX1fSw1SQmsApFJrLs5FD3iUDKmzAPmDNssVpg6W2DHw5jMon
 vI98KMUOxXiWc0m+hQu86UTg4I8b6EDKTLUMGiL08iLmXtlcJKsJ+gO/XKBf2ty0FmF/
 02Zhh+1kMCUR2+bLoxv5QRpNhiEaOCJNNs5+wsbn53QLNQz304ZjdxYe24qRzywqkJZe
 EI8g==
X-Gm-Message-State: AOJu0Yzt4nfI+Z5mB46XuKLgDeWBnlSOz2C1vJyM9/Y5OFgh9hPQQfMO
 Hkg51z143Hr4OK/bKPtFZrdvpr1ohvlx8kNOdqQR630oP+c=
X-Google-Smtp-Source: AGHT+IFK4HNkWcX26PtmawH6qecBdevv5Qrs8KcnDr00el3+woCTMosSlrLcO6cHW4cDwGAyLVMTDw==
X-Received: by 2002:a05:600c:3115:b0:40c:66bf:c6a2 with SMTP id
 g21-20020a05600c311500b0040c66bfc6a2mr2601862wmo.92.1705337777845; 
 Mon, 15 Jan 2024 08:56:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b0040e6726befcsm12689460wms.10.2024.01.15.08.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jan 2024 08:56:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/arm: Unconditionally map MMIO-based USB host
 controllers
Date: Mon, 15 Jan 2024 17:56:13 +0100
Message-ID: <20240115165615.78323-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

When a chipset contain a USB controller, we can not simply
remove it. We could disable it, but that requires more changes
this series isn't aiming for. For more context:
https://lore.kernel.org/qemu-devel/56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net/

Philippe Mathieu-Daudé (2):
  hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
  hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller

 hw/arm/allwinner-a10.c | 49 +++++++++++++++++-------------------------
 hw/arm/nseries.c       |  4 +---
 2 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.41.0


