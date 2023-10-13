Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C0D7C80DD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDsx-0007OK-Dp; Fri, 13 Oct 2023 04:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsR-0006Ro-5w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsP-0001Yf-AN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53da80ada57so3307528a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187031; x=1697791831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRj3Up6YLJQpd6BcwTiikLCMachhKowHZltLko8L2r8=;
 b=AOzz8S7EIeX/16ZphTNE/hL4kQz8s87M8BnGiRASnetWRF3tD4jqHdxsO0yFFPgO//
 xssyvmxOC9RECzk1hZKs4wegQdaj07NSLhZyOPFJVQ7nRBG80Bcpa+UrYjOh5KYxKl9/
 PWU/aOzyyGAuj4q1uvzXlQERzkr2r1DNVE2hwoMuCuzB1wZGadJaD57dLa33kvBhueSY
 6BH8Y6zLa7ZlIEfkPuassRszkFhnNReOeZG9ZtyDyKL22wtnIhkPURV0qHSpJ8G91yRd
 DT7TxSGcNsNzetuX8DR2zngiwDUr9a7qfe6Ce9HDvY0c0dXoYAosp8tuxVrQu6SK9a0R
 j3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187031; x=1697791831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRj3Up6YLJQpd6BcwTiikLCMachhKowHZltLko8L2r8=;
 b=JorJgIsIxfasjmlZccSDc1iOdZLb0KqAQ0LBv0pHRJtP3QJtXYXrm8DA/J5R+d0HEd
 pmt2vGOo1o0cTLZFyrVG+zQSazmq/QesMiDNnMVsUKxIjwWbnh5Dnh5Bk7pb5wLqiD5R
 qUAJ1JrOI8l44bvgZZIEKbTuxyoYylrFiACr+/MD/u4q8GUdupLUZOf0iA5hMlA1CXy5
 nGXaeEBwm0cCL0MmVW041rA0Z9YWpE+hOlI8RVC1Ue0Bg7bUxolmanKI8YlZUyEQBMWj
 BagyaJH4a/4AYezLeA4bRKjbYYAGJl1WRbGnH+VQk3rqp+qgDsMjDMNuqiQ5Q4XfK/x3
 ZFVA==
X-Gm-Message-State: AOJu0YyeDDgq7BxW+2SS2aKnvU4LNXbgYP+KSvCthjh/MAk1uczwrPJz
 2YaGg4zC/Lgl5h+KO96iEWEswIp6scUVUzGgBac=
X-Google-Smtp-Source: AGHT+IE/vTN4/h3jeUxp+NaC1QOKICpj4c7/RpBhcN4+nABwUnNGHVgAshaf7fbKL9Gqi/yMcdF+Sg==
X-Received: by 2002:a17:907:75ee:b0:9ba:2da5:d9d7 with SMTP id
 jz14-20020a17090775ee00b009ba2da5d9d7mr10131385ejc.40.1697187031683; 
 Fri, 13 Oct 2023 01:50:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:31 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Corey Minyard <minyard@acm.org>
Subject: [RFC PATCH v3 63/78] hw/ipmi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:31 +0300
Message-Id: <5d8d568383206c699eceee2323c913be052cde05.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/smbus_ipmi.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e232d35ba2..b2ca02b21f 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -174,7 +174,7 @@ static void addchar(IPMIBmcExtern *ibe, unsigned char ch)
         ibe->outbuf[ibe->outlen] = VM_ESCAPE_CHAR;
         ibe->outlen++;
         ch |= 0x10;
-        /* fall through */
+        fallthrough;
     default:
         ibe->outbuf[ibe->outlen] = ch;
         ibe->outlen++;
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index d0991ab7f9..58f5328a19 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -252,7 +252,7 @@ static int ipmi_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
     switch (cmd) {
     case SSIF_IPMI_REQUEST:
         send = true;
-        /* FALLTHRU */
+        fallthrough;
     case SSIF_IPMI_MULTI_PART_REQUEST_START:
         if (len < 2) {
             return -1; /* Bogus. */
@@ -263,7 +263,7 @@ static int ipmi_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
     case SSIF_IPMI_MULTI_PART_REQUEST_END:
         send = true;
-        /* FALLTHRU */
+        fallthrough;
     case SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE:
         if (!sid->inlen) {
             return -1; /* Bogus. */
-- 
2.39.2


