Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500198328A3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:15:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmpd-0007WG-DY; Fri, 19 Jan 2024 06:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpW-0007Vc-MN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:34 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpU-0007ID-26
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:33 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2c67be31edso71383166b.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662867; x=1706267667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E+lMoeMoENzkmlbQHjTZz2Re+qm7+NP5TWh7XqMJhP4=;
 b=cPJuDuT6mH+WCkgVpH4C8xESHwCBmQR5MpuecSsNQsN29H2j7WXkIQOZWJhLQHBjG1
 osbHhBEVMURWmukx33cpy2qPkTjFkR5b7fvVJymis+KwYNMTtaFHZkswSUpJ3bQBU0sr
 /6tx1uXJ0ANTQMfIjpmd8aBPGs8Bz1dgkBoTGS49kr2K6/zl7EiyA4xUZC+vDoYPoQ+4
 D+Cn56SJPIdntzDx7bA2euOHNEsYFTj1e/js07vYY6S2oxF+neqL42grmZ4r42i4kUbQ
 HwME1roh5RdbIsYkZ+dPpNbk1r4c2eDgNP1DO+1csSWQqplPOx9AqshCia9e2qo/hzVO
 nDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662867; x=1706267667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+lMoeMoENzkmlbQHjTZz2Re+qm7+NP5TWh7XqMJhP4=;
 b=U3uRMufno0uVl/bdB/zvKLk5cTUMlayUgwtqPephTvzgD95DqbJ2yvcY4MhF16PZGA
 h+BZhHjYvzXGjqbcbfZIc8LLCKaET/Z5db2czs+fQvXta4zXCYpTq2UR7ZLqmxlNb7Py
 N4tCRLZS3D1EQl0tQWYJzOnVQdBdh7G2nLg4I50OO1stgYvS7fh9o0Nk6DNYQKfRh1uF
 JasOaUAxJEHVonmCQqEsjHiFR2HHJ0vkFrZPEO/QnyNXiigaEor64LbC9uwNk74YtsKw
 D+NQBu6eo1KCaHQkTgmycHeOFOPNX4yCftabXHT7SeLRPYR75CJwBfVLNeCkEv0xPcxx
 xTZQ==
X-Gm-Message-State: AOJu0YxOrbdJ6q519ap9DzncZtGx7Xgro5k7Ixsh9/1D8ukVXsI7fEo2
 DUeeQ//e2flGO4VwR973VkNHSkUa2pN6WwjawBVz6tk6d5W6O3QM+J3v8cSfb5LljIe07KJNjMo
 H1ro=
X-Google-Smtp-Source: AGHT+IG40CgX3vOLQiJgJm70QwwjNvZv0B3z0ek20UxsECgAhubD+AJ+rw987qMVtTfGtNiOpQHV7A==
X-Received: by 2002:a17:906:b809:b0:a28:d68e:4372 with SMTP id
 dv9-20020a170906b80900b00a28d68e4372mr558547ejb.74.1705662867371; 
 Fri, 19 Jan 2024 03:14:27 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:27 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/6] hw/{arm,xen} convert printfs to trace/reports
Date: Fri, 19 Jan 2024 13:14:18 +0200
Message-Id: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

This series changes some printfs to use the trace event framework. 
Additionally, it converts some error/warning reporting fprintfs to 
error_report/warn_report.

Manos Pitsidianakis (6):
  hw/arm/z2: convert DPRINTF to tracepoints
  hw/arm/strongarm.c: convert DPRINTF to tracepoints
  hw/arm/xen_arm.c: replace DPRINTF with traces
  hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
  hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
  hw/xen: convert stderr prints to error/warn reports

 hw/arm/strongarm.c      | 49 +++++++++++++++-------------------
 hw/arm/trace-events     | 33 +++++++++++++++++++++++
 hw/arm/xen_arm.c        | 26 ++++++++++--------
 hw/arm/z2.c             | 26 +++++++-----------
 hw/xen/trace-events     | 21 ++++++++++++++-
 hw/xen/xen-hvm-common.c | 47 ++++++++++++++++----------------
 hw/xen/xen-mapcache.c   | 59 ++++++++++++++++++-----------------------
 7 files changed, 148 insertions(+), 113 deletions(-)


base-commit: d0f4aa7d50d485b1fb5ec8ab6f934e5df852ab07
-- 
γαῖα πυρί μιχθήτω


