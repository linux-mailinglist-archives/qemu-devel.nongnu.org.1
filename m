Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3B7AB4C8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qji6b-0005Ln-Gn; Fri, 22 Sep 2023 11:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6K-0005Ha-Ai
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6I-00007J-B3
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401187f8071so18009525e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695396588; x=1696001388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4Ow+VsK9jJEZHPQsnuiyJ0dMqoukmN8lv7f9IShQS8=;
 b=OvwVqymKoRFGIYQj3RADNy+xsmWGjO2CxbPpdrd7Lvc7GSW1g7b7+GxEI5oeSJOhD2
 MhfSefCkfNOX4F8V6Xhmh99E7vVl8Ujt3TxbWD/HgzWMjLgIt9uJWBn3vaK//ArlxveQ
 4+EZxBju9eQhQKhGp6QBlnqKjPMoWvapQAnT5N8eBNTR2mVUFKyG7psHHpaCCBKSONKR
 eIDIXrjHt/LZ/9AhdkeEk3YzepwiW1B2F06BOZEnKo2XcTL2nJCpdfS4DyBpJBVGT2NL
 8QYxLdeOmLIa0xk43CH517gwPp+tZEQ/wMYpodFsBUXhxmPo8Di12fMkoGFcT+tM+BxV
 0dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396588; x=1696001388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4Ow+VsK9jJEZHPQsnuiyJ0dMqoukmN8lv7f9IShQS8=;
 b=h9WkdNnDUVmhACFkgDn0t2qqnWQLcmgDCjoLpPkseySljyrGDBZnPrNAeDQG25sRXn
 uFVmrhL3cGe/AXJiMbuUXHQkEYz2t9zjm81gDPWkVEYt5H58UK1IapYryCd63Y3bmwid
 ix7y3to/ZswMXzNgF+Q4Dx1+INCEFiKK7V0ix1n4eEx0crkdTw6FxUta22Fi42jT3W4f
 YZGte0qJb7TfPm3oepFJY1Cskk+0c2OUqkrc+eIY7r9bDQepMAqbQhbMSpio4pDTp2iX
 6+QNqd3HpnOokujLg3XJbADRIk1rEHz/tNmQo4Jo8V9mfLOcFzibZc0oAF1jjyCnWY/S
 Lpkw==
X-Gm-Message-State: AOJu0YzsvCnITSyIeX6yzg3eWsda64JXYmVFxRoq6d06pXiGfupfc2dL
 KeXuRNqTIWQdXTtDWFCC5x6Fdw==
X-Google-Smtp-Source: AGHT+IE3fNOvkyWfgjJUSfeCBeOkuzcjxqj+JjyIeTKQ/CeZZhu3Mh+fMIrldjUGn1d+8BPrj0BHuA==
X-Received: by 2002:a1c:6a1a:0:b0:403:c70b:b688 with SMTP id
 f26-20020a1c6a1a000000b00403c70bb688mr33263wmc.6.1695396588688; 
 Fri, 22 Sep 2023 08:29:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05600c171600b00405442edc69sm777137wmn.14.2023.09.22.08.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:29:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/4] hw/intc/arm_gicv3_its: Avoid shadowing variable in
 do_process_its_cmd()
Date: Fri, 22 Sep 2023 16:29:41 +0100
Message-Id: <20230922152944.3583438-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922152944.3583438-1-peter.maydell@linaro.org>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Avoid shadowing a local variable in do_process_its_cmd():

../../hw/intc/arm_gicv3_its.c:548:17: warning: declaration of ‘ite’ shadows a previous local [-Wshadow=compatible-local]
  548 |         ITEntry ite = {};
      |                 ^~~
../../hw/intc/arm_gicv3_its.c:518:13: note: shadowed declaration is here
  518 |     ITEntry ite;
      |             ^~~

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 5f552b4d37f..52e9aca9c65 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -545,10 +545,10 @@ static ItsCmdResult do_process_its_cmd(GICv3ITSState *s, uint32_t devid,
     }
 
     if (cmdres == CMD_CONTINUE_OK && cmd == DISCARD) {
-        ITEntry ite = {};
+        ITEntry i = {};
         /* remove mapping from interrupt translation table */
-        ite.valid = false;
-        return update_ite(s, eventid, &dte, &ite) ? CMD_CONTINUE_OK : CMD_STALL;
+        i.valid = false;
+        return update_ite(s, eventid, &dte, &i) ? CMD_CONTINUE_OK : CMD_STALL;
     }
     return CMD_CONTINUE_OK;
 }
-- 
2.34.1


