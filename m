Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE987C5503
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYYi-0006Uv-Fk; Wed, 11 Oct 2023 08:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYb-0006Ob-4X
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYY-0003CM-8j
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405361bba99so62761415e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697028195; x=1697632995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ISV6zsFK1CMKylDGnocB3bZI/sXgRYAOuOzMNfIpS3U=;
 b=WLCyWctEB/+AUb3qqtPfff9WPdE74dXj6W1Kqompb7j5AvF6rPCZsmf20ptf1klOPm
 mHLX6asMI/3VL262YanLiDDt3BazX3N717pADQI584tPM2TgHxrZ9Q+hXxs4nnaukROh
 YSmYOqyHJp7EKKwz1pz9WlR0t+VOF0mSCVHD8Whs4E8L8iryx5UsCw6gnsb/iisKnCuM
 lekWpjaNjVqxxj27GU/S6pbuoFhxkLpOd2uHhKVbGFA+Ik+3U34oqAIxSFDxZcSppjZ4
 Rhm8fZClfJabwq5G5OUvN4JsVZrfdjnXgBXx75yDSgyp6CB5waTal6jCxljmxUWkMip9
 geyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028195; x=1697632995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISV6zsFK1CMKylDGnocB3bZI/sXgRYAOuOzMNfIpS3U=;
 b=w3sYili8Q/6Jca0s4GKMoR57ZTCYWY2icLKuvR20UnJSg2HPWhLhiQP2Q/hCaSLb1p
 cPC5mrd1YVHYuieWdaUkWnlaZtRKV4784KKIFKwAgcDG0rWI9SoGLqUGRS006HqTQsC2
 FtlH3ZgFakku3cbSM2pHFRQSDHk0vSNGVtqhNgxfu4hyUC98C3qUpiHOGz1VlPXArd4P
 u5+WmCgJg9iUYWC/qyOpf6A1OsKikbV4iEEmbRduEXKa+1pYMOCk0m8mAqBzqDTE4iar
 a5u0TqA5iSu/29XRGNNihLH1VRBC4ZHzaAdMxnOW8lPnmjqPEO1FFFFh78B8AXnPGTQt
 kOjg==
X-Gm-Message-State: AOJu0YxOPOS1FyuZ6089sbyHuHasfL6NEU9BE9SFVXyrKjoitHFwkgQy
 FnEjLXOk3LeIyRjgethPTkQYq+9fiqTxyQikh4E=
X-Google-Smtp-Source: AGHT+IEDnLP6ApTX2K1eKktsFqYbYSWX+JmqLoJV/vG02c/yq5xUREXnNdcWLCsU80cXYdE0HhiewQ==
X-Received: by 2002:a7b:cd8c:0:b0:401:bcd9:4871 with SMTP id
 y12-20020a7bcd8c000000b00401bcd94871mr19747351wmj.21.1697028195209; 
 Wed, 11 Oct 2023 05:43:15 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bcb93000000b003fe61c33df5sm19091110wmi.3.2023.10.11.05.43.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 05:43:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/ppc/ppc440_uc: Maintain and remove dead code
Date: Wed, 11 Oct 2023 14:43:10 +0200
Message-ID: <20231011124312.60476-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

- Cover ppc440_uc in MAINTAINERS
- Remove dead code

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Cover hw/ppc/ppc440_uc.c with Sam460ex board
  hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()

 MAINTAINERS        |  1 +
 hw/ppc/ppc440_uc.c | 40 ----------------------------------------
 2 files changed, 1 insertion(+), 40 deletions(-)

-- 
2.41.0


