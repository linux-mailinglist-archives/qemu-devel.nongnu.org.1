Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729797C80C1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDsf-0006Cy-VI; Fri, 13 Oct 2023 04:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsJ-0005un-GP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:27 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsH-0001Xg-PH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:27 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5079c846dcfso331222e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187023; x=1697791823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdceJFstV87KcQ4+fAEUK1DgJy/aq7o6zVfz5eSMszE=;
 b=ks4VWx5yVqLzBH765GorJoG/nfoj0nV4+Gh9YqitcHQ4uv8XLCKPL7KhaIauQ+hQvR
 MzSI9ADpacmffVFYck/H+eUNk08P1eK8nb/GVZfT/2aLV+Lls7Rb5T9lKnXOcLjQ83s5
 aoha8tzXSJjpOh67zfn7KnW+mnKRzR6l6RJYkJAvahG8u6uwcJ+O657raAQx+JFdEQEk
 4OvWTWsfi2W9ZFrP0x/ijnd4TUkWuaV41wNjh7/G4qaERaQPOb8bxAQoSZYAy0b513K2
 apES0k0sK257WQTqdpbsejfG9cLSHrIUEzjKV3l0R5oad7ygdlAueR60VEYnWcWJ3qr5
 YdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187023; x=1697791823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdceJFstV87KcQ4+fAEUK1DgJy/aq7o6zVfz5eSMszE=;
 b=UEFyIf03P0bN5LzNO1/ZTpB5dfeVU0Pbp4ZAP2wq0UZ4kbKlAx1cf8K3goX1cN5wgH
 iMDuROnDPSV7LUW/0AHiRRz30PlWGSe0KSWba2L7AzFPeHW+X7XAtM3FMOlA9ptlo/1y
 jdKwAdYUAFput3eDB67RkXzQqdw4RU+yBze19ibhW4WqUy7yAtfgFc02yT2+XC4onyrp
 +FcIkx1v4vMqgfdHEKlxsqFq+1EUivQTXP0WWe5EkyWDXAgoqZE+bfdUr/t/o1lVtq3Y
 VewcN23OOIC1MMpKm3suWNoYGQiRnRwLwwUMf3WIAJUTPrISVX6jOEU9SVJ13cbtBYrG
 Zvpg==
X-Gm-Message-State: AOJu0YwP3wIH47DgfvhFDEG1sFEeMYucerH9NVi9TQEeTUCwniDtdw7D
 S7W1dnpt9bc3O0EAXntgNzfuIXAPnV2zbLbcly8=
X-Google-Smtp-Source: AGHT+IE5KDEt+SdB1u19MrTX2ThtShM2Q6NqT+80WMCF/lSPhPmUSlbLJMrHhAGYBxxRgOvK5lFJbQ==
X-Received: by 2002:ac2:4e85:0:b0:505:7fe4:582b with SMTP id
 o5-20020ac24e85000000b005057fe4582bmr18402909lfr.35.1697187023552; 
 Fri, 13 Oct 2023 01:50:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:22 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC PATCH v3 58/78] hw/ppc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:26 +0300
Message-Id: <226ded7066ffc9e279a75b34e45f573e50f1418c.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/ppc/pnv_bmc.c      | 2 +-
 hw/ppc/spapr_events.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 99f1e8d7f9..9bff7d03cb 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -210,7 +210,7 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
 
     case HIOMAP_C_CREATE_READ_WINDOW:
         readonly = true;
-        /* Fall through */
+        fallthrough;
 
     case HIOMAP_C_CREATE_WRITE_WINDOW:
         memory_region_set_readonly(&pnor->mmio, readonly);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4508e40814..9d51746daf 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -423,6 +423,7 @@ rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
             break;
         }
         /* fall through back to epow for legacy hotplug interrupt source */
+        fallthrough;
     case RTAS_LOG_TYPE_EPOW:
         source = spapr_event_sources_get_source(spapr->event_sources,
                                                 EVENT_CLASS_EPOW);
-- 
2.39.2


