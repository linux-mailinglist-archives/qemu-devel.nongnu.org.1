Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A382B0A3
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:26:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyt-0004UH-WA; Thu, 11 Jan 2024 09:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvym-0004RS-OA
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyl-0002pL-8K
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:20 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-336c5b5c163so3236972f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983056; x=1705587856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qeKSzzbqMDtEWciJm9Qsrh/SczbLK7mHOS9/ulXfvRw=;
 b=eJLFIQ2ViPEHbpHvlkuAMDTxQdXX7VP61rA0oWJ/VzWHFYiPsovf6sfXc+ZwwzNJGb
 WdGKb417KFreoqXnhoN3iiLbvL//qZ2+AAoXAdtm3eMzlY2nYHDtkjhHLCNJrEvJ78pv
 5k7tnNIvHi5Dt5Z/yVOJTWNo/sqe35C04RBsXm0NWG+s1dLaHuWk0cnRBjQC0OKPyJWh
 MKY261WV8V5p4WU22Ad90VeEyF3gFd5GcxIFwpJ0DiIFefbExzt3NvyzVg32X7loMJ6N
 q9X4D7S24nyCdt1H0GC6roP0x39da7CQYvOqLN0WyECWg4aWUkCuX5yCQwM75gsLwimc
 QRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983056; x=1705587856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeKSzzbqMDtEWciJm9Qsrh/SczbLK7mHOS9/ulXfvRw=;
 b=HY+idrSZukelor1P62I5/3FAcg8TGVa7bWIZW3OHW7DrrrM4sTxSJzvrKFld8TIspN
 8NGQZAEDJ8B2lP3f6vXGMPUhif6WQeJrJkwECL4WfdFzt6fD3FrpAuyQWSSyVIjW9y3s
 kg2gUYVQLXBdrxEG/tK5dYsaklsjPZLbj3SLgGGKRWj3iFFvViMsnGSKk5jZMyxKP6nx
 VpXECa0nTpshsD5g28eEGE1OkHu/mJMai/scD7VpsjQmAnjMM8yP5//ip/DrvcikL3ta
 5/SW1BciCNDQQzx1+Fv15BDktfZH3H6cu9uFOvEBai/4V44sm61rKEeIH8vCMGG68RJY
 7aaw==
X-Gm-Message-State: AOJu0Yw82Gli5Mzym8sC56SEZUELGiqNbc70VIFnYiPvuSjatcD7yl86
 vCGLaqLPvH0DvaDIBTYwTQII8ZT6Z8wU4MCRJmxBKPI9cCa9nA==
X-Google-Smtp-Source: AGHT+IEeARrtTfqGgUuu9Pw3GZgudv3SHcls2BgzM2g/rUr8eoBbOvnKPnYx1T/EHoKks961zb4SSg==
X-Received: by 2002:a5d:4585:0:b0:337:49ea:3845 with SMTP id
 p5-20020a5d4585000000b0033749ea3845mr505884wrq.40.1704983056189; 
 Thu, 11 Jan 2024 06:24:16 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:24:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 12/12] MAINTAINERS: Add myself as reviewer for TCG Plugins
Date: Thu, 11 Jan 2024 18:23:25 +0400
Message-ID: <20240111142326.1743444-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00ec1f7ecaf..4a621aca978 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3660,6 +3660,7 @@ TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


