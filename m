Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C327C7FBB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4s-0003NF-HX; Fri, 13 Oct 2023 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4m-0002iC-Od
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4k-00074D-96
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406402933edso18915325e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183952; x=1697788752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZTz17RhWxoUZ3hVHX7ypZhIj3NVSXDU2Rg89KVwrPE=;
 b=Zx4I58iBSLM0Th+k0zpGxmCIQJ0kJFiA9RlUd0NygBuMwe/uYMV3yhvHQ/FVv6xyPJ
 56DUfPos9w0BNITKf+VYwFsYDeB71d4asiVSG/M7+NEAXJwi+sIOwZ9Xr5bEcSsZdo1V
 VnU0I4GSHzOuLDPnXxn696oc5LAEG6OQ0ET9p7zZv/ltUsIzxNLqKOD/213AarsiQB+5
 Fy6PaxyLQDT5U83aCgJDh85sSGAO2dkqva2CzQ/Jw7xBTq1bMvxu3C3WgasZ22CIPcr1
 Rx1S48Sj4JGN9cdNEkgE4tHsheeP0pADN/O7U8dzcEHB38Zk3K9CViUjNm/mzHvsoE+x
 OSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183952; x=1697788752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZTz17RhWxoUZ3hVHX7ypZhIj3NVSXDU2Rg89KVwrPE=;
 b=KNVMlKjxc/+xUsbgjCATKamiG8q8n8ODeBPZBMrf39JGPYlEI87DOvksN9qJ4KFGJC
 feEFE48PpGK94uCEqj3i8Ijh2qg65QUNbQOnncoiP+oqw1a0XjH7HxnwXv6QQ6i+vvoG
 oYRscAiwwl4As1p+M8/lp2hAmzpbhB9KPiPLMzk1ZT+JUuGVf2RbZBEHNGhb110Aah0P
 o/mjDX9adHXkLNw9MVy7LkgFxJNkcJVt0E0g2IcwpNm9KeuiiMYLhaczaLZ47HHnKBGb
 H9thWDmIvrQWroE5DPuvpmQzIFzOotsRTN+NWIhhMkS4ez00wabcIwfmL5Yq6fENwJUu
 kWRw==
X-Gm-Message-State: AOJu0Yyq4KIVzSC8Eibw5ECJho288Pw7D1NT269yo19P75wXLFh6R2wi
 kBpKiY5+dm8Ymbu9ZEwAw31KArjo0lvh6r5mcz8=
X-Google-Smtp-Source: AGHT+IE0PVv4zhpOSZFw4JqB8e9QHz07F6SOniBgilNosONi3QOBHv+xsZhbm4QztMY5l7uPS+aZ9g==
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id
 o6-20020a05600c378600b00405359ac965mr24100328wmr.4.1697183952446; 
 Fri, 13 Oct 2023 00:59:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:11 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [RFC PATCH v2 44/78] hw/m68k/mcf_intc.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:11 +0300
Message-Id: <afd58b7b36d587594754b695313ed01232f6735f.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
 hw/m68k/mcf_intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 4cd30188c0..9556a0ccb7 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -58,34 +58,34 @@ static void mcf_intc_update(mcf_intc_state *s)
 static uint64_t mcf_intc_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     int offset;
     mcf_intc_state *s = (mcf_intc_state *)opaque;
     offset = addr & 0xff;
     if (offset >= 0x40 && offset < 0x80) {
         return s->icr[offset - 0x40];
     }
     switch (offset) {
     case 0x00:
         return (uint32_t)(s->ipr >> 32);
     case 0x04:
         return (uint32_t)s->ipr;
     case 0x08:
         return (uint32_t)(s->imr >> 32);
     case 0x0c:
         return (uint32_t)s->imr;
     case 0x10:
         return (uint32_t)(s->ifr >> 32);
     case 0x14:
         return (uint32_t)s->ifr;
     case 0xe0: /* SWIACK.  */
         return s->active_vector;
     case 0xe1: case 0xe2: case 0xe3: case 0xe4:
     case 0xe5: case 0xe6: case 0xe7:
         /* LnIACK */
         qemu_log_mask(LOG_UNIMP, "%s: LnIACK not implemented (offset 0x%02x)\n",
                       __func__, offset);
-        /* fallthru */
+        fallthrough;
     default:
         return 0;
     }
 }
-- 
2.39.2


