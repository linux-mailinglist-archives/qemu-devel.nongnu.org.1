Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9447C890D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL5-0001pT-Uq; Fri, 13 Oct 2023 11:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL2-0001nt-91
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKy-00055B-JR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-405361bba99so22355385e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211867; x=1697816667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuSr8E1JHxw9471vJ6srdIxy0p7ZUnJrQB0oMmjioCk=;
 b=J24Qz/ClaGH5NERuj2GWa1rxn6r7E7cSo/MyLmFB8QfKhmfAwAVhyvZWXV+FIbAwgG
 7w2OeFn1nuT5RtsZDUyn8ebT8w2LsadT4uP6fy4T/nVX6Yp7J1+psvOgV633L2O64B86
 xaorttdmCq5/cuPckyz84WdvzG4o4/uzT382EKcSC+6fMysZdOhkLtKY5jDG1RbazoYx
 MM2gP/sP0iahoQz6dECYVSjVUQhATRmeFPngevRvvO1GRYqueuQjrpQLBJY+tct54Pf9
 WoWyB6CxjXOESiV5zXVuGpPKnQYGIWh9ANA+bBuovkjObsnOmfD2R+jUBPPEX/gS3SNO
 tkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211867; x=1697816667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuSr8E1JHxw9471vJ6srdIxy0p7ZUnJrQB0oMmjioCk=;
 b=gPS7D35+BshQR2z+TwTQItUEceU1GeBcT0tu+C93OcnWERRsUcPQmjMz3rVoZzIcyl
 PdSZ+n9NPW5xhdomIgCTH0yqEuGBPsWEbMB7/ZOP4WvaFaQH1hBepvc0jCAKnL2UAEz2
 oAblP2GvOnTPTXgZlgAqkLeHzdbOertwW3dghwS2LJj4g2/E6kQre7Zldz8aYPx203IP
 JhxYPy1n+mW6zl7j9DlHoozwzZb6J+RR1LW+GgbvELI4V1L6ewom00qFVapffquHFq+0
 4IK6Z5S4zC4A4V4hh5yX4b4LslwQxKOc5jYzRqFq5jwVgV/1864xgGPQQdbM8kvU0DEL
 Nl+w==
X-Gm-Message-State: AOJu0Yx0D+64KTpm1ATe9de+1o2jwZdrBU9+CHh2SvcXt8rlfPVHgeRT
 pPx+XrpkpUDzhwe4aozGVMSAWHWrSaE0Is+oKuc=
X-Google-Smtp-Source: AGHT+IHMx/I7Q5Lgd/CzWpQzV5XJigGjkRWmUfWDucK8lKM+NCin3R4h1C3Fnl/SajShqB11xLkrcg==
X-Received: by 2002:a7b:c419:0:b0:3fe:d630:f568 with SMTP id
 k25-20020a7bc419000000b003fed630f568mr23426256wmi.39.1697211867183; 
 Fri, 13 Oct 2023 08:44:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4004000000b003197c7d08ddsm21152340wrp.71.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C65BB1FFC0;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH 5/8] contrib/gitdm: add domain-map for Cestc
Date: Fri, 13 Oct 2023 16:44:21 +0100
Message-Id: <20231013154424.1536392-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: luzhipeng <luzhipeng@cestc.cn>

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
Message-Id: <20230628072236.1925-1-luzhipeng@cestc.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index e676da8d47..38945cddf0 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -12,6 +12,7 @@ amd.com         AMD
 aspeedtech.com  ASPEED Technology Inc.
 baidu.com       Baidu
 bytedance.com   ByteDance
+cestc.cn        Cestc
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
-- 
2.39.2


