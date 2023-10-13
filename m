Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF857C7F6B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD41-00009D-Sb; Fri, 13 Oct 2023 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3w-0008Ei-3d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3q-0006m6-VA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405524e6768so18755135e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183896; x=1697788696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoOAm/+YqzAoYUm0iWl4CDp2UH+g6Xdk4CGXRsLOFtI=;
 b=IJA2mJgXvdhkBPHlHPrNQLV0lniUg9cC61eW68M1webgqWSD4mmoWp9zWQMniVD8en
 Ea+ajT+YnBVL+8jsiivJELiqNNUrKRUR6lasRXn2zWLj+g1Mbt04GTyhoiTXRkriO8+Z
 NHRW8AJoRW0Bn17KKLi0R8Jpf6qwL0TgOV8TuZTTZNf7rXSXNjYWWyRAPfwl9bc3egwb
 Ic0DLOyD14FRF7LclZpKcEvvvF0zxbXc8PbAZeX6TozY8EyaFW+AJqmrCEqjsY9cVu9z
 umIQt3bRCJoHA6+uYOOoIzzh4cFPhGfElh1Ym/XWi83oi2n/rztYT0tBpDbJbx5+h+nW
 3BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183896; x=1697788696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoOAm/+YqzAoYUm0iWl4CDp2UH+g6Xdk4CGXRsLOFtI=;
 b=PerJ0duJEXHSxgfNMjzms9M4AwLTcjelmTCYl3bzJFXO+TLXlMpjMZ+0BEFR0tPT/F
 e5pLzC5z/H9QCQXlE4GVE8pKsAtxcdeUZShcikXmDv0XFWJkn+xKpY/PFjYbQHmKVD78
 0lnD/Q4+/Xp08HarqQtcVOL7KUnQWQNd9MGSHFIYNuAHm6dpoBD/fRHchiVvVz1aiE/l
 XWCnZKEb7rOYVVKgN4kQVaa/2ftiVADZoeRqLb6IlGj1mlbKMTFwkffuJgIfUznN/SsC
 jbkglVx9FbKjPyXzdgpiuD+qiTUWx7Q92cSM/2nXOhkLJQ0/nFTV5TL52mfdTon4MLBD
 0Iwg==
X-Gm-Message-State: AOJu0Yx9xoZPE1j/MyBCBOVwza5Th+ekVVWD4/iGvuthh4PuXJ3FbIfW
 UGhwh5LlZ0pz9TR+1uMVcC8dcnyGewinnvBE1GY=
X-Google-Smtp-Source: AGHT+IGNhYkiV8wPsdMJPmV7WbBlwG0y7VJWXJ51dCF2Rz9GCELgGS1GQLmTkVP6kRER7Czg+rY6TQ==
X-Received: by 2002:a05:600c:21d1:b0:405:1c14:9227 with SMTP id
 x17-20020a05600c21d100b004051c149227mr22912935wmj.33.1697183896301; 
 Fri, 13 Oct 2023 00:58:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:15 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org (open list:IDE)
Subject: [RFC PATCH v2 10/78] hw/ide/atapi.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:37 +0300
Message-Id: <cef77c3b4f13c967f371d203d1aba515b05f3555.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/ide/atapi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index dcc39df9a4..85c74a5ffe 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -1189,53 +1189,54 @@ static void cmd_read_disc_information(IDEState *s, uint8_t* buf)
 static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
 {
     int max_len;
     int media = buf[1];
     int format = buf[7];
     int ret;
 
     max_len = lduw_be_p(buf + 8);
 
     if (format < 0xff) {
         if (media_is_cd(s)) {
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INCOMPATIBLE_FORMAT);
             return;
         } else if (!media_present(s)) {
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INV_FIELD_IN_CMD_PACKET);
             return;
         }
     }
 
     memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 ?
            IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
 
     switch (format) {
         case 0x00 ... 0x7f:
         case 0xff:
             if (media == 0) {
                 ret = ide_dvd_read_structure(s, format, buf, buf);
 
                 if (ret < 0) {
                     ide_atapi_cmd_error(s, ILLEGAL_REQUEST, -ret);
                 } else {
                     ide_atapi_cmd_reply(s, ret, max_len);
                 }
 
                 break;
             }
             /* TODO: BD support, fall through for now */
+            fallthrough;
 
         /* Generic disk structures */
         case 0x80: /* TODO: AACS volume identifier */
         case 0x81: /* TODO: AACS media serial number */
         case 0x82: /* TODO: AACS media identifier */
         case 0x83: /* TODO: AACS media key block */
         case 0x90: /* TODO: List of recognized format layers */
         case 0xc0: /* TODO: Write protection status */
         default:
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INV_FIELD_IN_CMD_PACKET);
             break;
     }
 }
-- 
2.39.2


