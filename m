Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 106817E41E8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9j-0003hD-Bx; Tue, 07 Nov 2023 09:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9W-0003YS-PQ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9O-0001Rm-6p
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso41706525e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367615; x=1699972415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nVxjPXGNwOO7Fm7pBmxupI07He4/krctavyNo4y7go=;
 b=DIP3PCAzNLazngS3s3+f7nbTNkgqyo8UOa915AH9ZWDu7MMxYlfgqBt6i7R0lrXFZv
 59RgFJ583iEuro9Gxcn7RK2RwmX7Yla3M34i12eKLwvgTrL4ivMc0B661UXrNyWDvwcR
 rIO1snO1yhp8CJ9CqK5V3kx6RC5wqIxj4kXP3x9tijoH69HltwklvYyEsU1D1j+oYh5t
 Ut6wh7C2jQysZMs50GCWW7Pen4nZKzJyeaAqt2hMLsHeEKvXJ1/AIkwqQDGuCyan3sXa
 ELKgPhEinKt9LNiB7GGA5KNzbWkNneOq/pp5iBghfgQjMBdQUACSixG+QD9komJYt/s8
 IMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367615; x=1699972415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nVxjPXGNwOO7Fm7pBmxupI07He4/krctavyNo4y7go=;
 b=LtPVgrV6rivMZnTHkEg4rqYRMBSC2K6rIYx8q7mB23MruvpZKdGECOmQLT42PvfIfC
 yrFLKA1oj5FShhlzSsNGywNha1+jTIjyWzrbunPskIoxtYCMFFXzZjeTHnNvYMy2x0Jy
 D+afuTINfSW9oZESIDtsNN/z8zw2I4OC/AvHtyIkD9m3PX0KhV476gpdVUTEKdh1h2Sk
 vo3lJHqdEXpINAydsEvM28uozUOwSH2EAdohaQUs3HrqQq9fN3dQLEDqgXIxzBFWxNb3
 10wSsYxZoscSDNv/D6GRrbCg63ulKE3JxJrd7bSRsJvrwEH0lHu++fd8Um28trgx3CMB
 03oA==
X-Gm-Message-State: AOJu0Yx3IyjU9KUEXWF9FcQBL6YyVGfS2tEyThUxyi/+1RyFB98rLNca
 C28yKdP4DbvHIyP4Rb0oLIrqsI2DF9eQfXe070Iwfw==
X-Google-Smtp-Source: AGHT+IHTHGmYOu3Oxd1rVVAGz+QEKi2aSK7nHIwyrybz3Spo+pedfI9bh2rceRTbs+b+vLGqIimMwg==
X-Received: by 2002:a05:600c:310b:b0:409:295:9c6e with SMTP id
 g11-20020a05600c310b00b0040902959c6emr2504978wmo.30.1699367615211; 
 Tue, 07 Nov 2023 06:33:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c14-20020a05600c0a4e00b004030e8ff964sm16559119wmq.34.2023.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:33:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38AFD6573F;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PULL 18/23] contrib/gitdm: Add Rivos Inc to the domain map
Date: Tue,  7 Nov 2023 14:23:49 +0000
Message-Id: <20231107142354.3151266-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Whatever they are up to a number of people for the company are
contributing to QEMU so lets group them together.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-18-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 3e31a06245..e676da8d47 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -38,6 +38,7 @@ proxmox.com     Proxmox
 quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
+rivosinc.com    Rivos Inc
 rt-rk.com       RT-RK
 samsung.com     Samsung
 siemens.com     Siemens
-- 
2.39.2


