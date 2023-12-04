Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C558036D6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAA0n-0006Fh-Oj; Mon, 04 Dec 2023 09:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAA0l-0006Es-VA
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:33:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAA0k-00066U-Aw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:33:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b4746ae3bso40658365e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701700404; x=1702305204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUD0R+dvJ7NeflreLzYFg6rMKq/ier4mmMv5BiWoMHc=;
 b=h+CrcOJUVMKBtHFCb8K5+FA3+riIoALdx2NNSG7bBka4hPTQUd7KX95WxluxFia6GD
 HCYr0QRV6cFbc3osNqCozvod/MmH4M/lM0W74kCdtnFzrNEAJMdI+yIwI/8LJP+RtBo6
 d4z9UiXyDQvrYthzdHQLkGP9o/y4+bru3mP/97qEpF8+A6Fi4/rNy0uuA2Er3eBtgUmO
 ei0k40So71Bz29chTHTNYq8ffq6PI0Bd6OS6TVcRpogaHVJ7sWIVrT5SfdHsdhPIkJ5d
 QY0FL7Z5CR5wRm6hWakm5gWmtOADwHrl3S61nsqLJI0U1uKO0SzwbThQJusiysxvI0e4
 h4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701700404; x=1702305204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUD0R+dvJ7NeflreLzYFg6rMKq/ier4mmMv5BiWoMHc=;
 b=eNhWY3Tl282l/TgSbVipkIgHnB8f8I1IddhQmFx5lAG8vHHutDZjiD5u14BjyACYnB
 LdAkuCWdfImoWDRNJwL67HZrdj1vRzEbCr7jZ4KP5LGf68Kg5cvoIkBEqYAl8LWB8hHG
 XkpsCJnzUTn1oCfso+kTNmGLGvoAx11mikOohBseLLQUO+lerQNbLneZEYWeEMXsh6LX
 2KLH6CfSmVC4CLkEsfqz13oYn0zzmJXY2/IprqynsKJLCEGtYokwmuijkL8UWArbxNzJ
 alC85YonsA9RIvq4w8iTppv5n3R1oSCBnmhAoyJHqLwduGJXOOKe265wZe9LD8oaledW
 3YFw==
X-Gm-Message-State: AOJu0YziCl5Hym0WmOm/VFAN0i/H0f5oKd7iTTB+v976lGaSmYELbELd
 TISGJb6dImdV8iQxE64YYyhzed4GHsfgqPI6Xg0=
X-Google-Smtp-Source: AGHT+IEBpN8kH7yK8ytq1/fBxVexs+OagzQzXfNXbu7m+MLDNlgSpUcxCAOIqgOhCAZOCwojEte94A==
X-Received: by 2002:a7b:c012:0:b0:40b:5e59:b7d3 with SMTP id
 c18-20020a7bc012000000b0040b5e59b7d3mr2480497wmb.176.1701700403789; 
 Mon, 04 Dec 2023 06:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c4f8a00b004053e9276easm18736143wmq.32.2023.12.04.06.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 06:33:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target-arm queue
Date: Mon,  4 Dec 2023 14:33:21 +0000
Message-Id: <20231204143322.837136-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Just one fix for rc3. Technically this isn't a regression since
8.1, but it is a small change that avoids the user being able
to select an oddball combination of CPU features that currently
QEMU will assert on.

thanks
-- PMM

The following changes since commit 29b5d70cb70574b499517ec9e9f80dea496a3cc0:

  Merge tag 'pull-ppc-for-8.2-20231130' of https://gitlab.com/npiggin/qemu into staging (2023-12-01 07:29:52 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231204-1

for you to fetch changes up to f7767ca301796334f74b9b642b395a4bd3e3dbac:

  target/arm: Disable SME if SVE is disabled (2023-12-04 13:34:16 +0000)

----------------------------------------------------------------
target-arm queue:
 * Turn off SME if SVE is turned off (this combination doesn't
   currently work and QEMU will assert if you try it)

----------------------------------------------------------------
Peter Maydell (1):
      target/arm: Disable SME if SVE is disabled

 target/arm/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

