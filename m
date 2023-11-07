Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E691A7E33EE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CUn-0006F3-Hg; Mon, 06 Nov 2023 22:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUk-00064s-H8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:14 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUi-00025P-PL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:14 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso4944935a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326671; x=1699931471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfcfvCM44CNzCfVh5n1nc5lCu8ey+5nlcTa0SEohSWE=;
 b=PYz2iPsDzlP9S1MTVifDdXTxZ1dACpVRoKfVTvJ+zyRV2Eoe0LISvw+dWY+Opluz1U
 q6R1/mS5huE71mgajqRWmoVgKTYfomBxXz93g+1B6OzRSRGAzri1sFWpgpjIhCHNVI7K
 W6IRook78L5+zUOejwR3qgtp6fP4q8PQlmYx3KqOr7tH0F1cvjJXQibcANucZioKXMz5
 ShsjX5iVKpXoDhIzD0KJ2+5DFbf71AANEbNdX8mvCJ79dTCEkeQ4q3ZnUY4mRQ3r0GsW
 9QWFQtv3KRrQwObF+Cecw/PgipsssJQgIXuEIYgRiAWcHIggFta5+dSw/VqHW0YS0o3O
 ttAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326671; x=1699931471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfcfvCM44CNzCfVh5n1nc5lCu8ey+5nlcTa0SEohSWE=;
 b=j4OIV/fxlsVwjnksfzMaeHNkn/s1AYOVb6s9f35A8TZ7UEFoSxaWvceDcVJiXlLV7A
 Y/DQKsy0Xx808sXN3xW/WOslvc91vfp2K3+SdDmc1Ww1EXj/ZnHXvZ0Son/Fmqk9qhrE
 7XU9pUgoBS7v93YdsLnnptsNT/mHMzfrFGrX6Yzp+cyF9iawha3GnchWIsxBTf4EgSkS
 P6szfFRscPnIn8RBvY8aDht7OCKrqnwKVX4g5HtcelmwzEkCF7Sxp4QLduFD5jcOuCWg
 tbJ3EE3EqU4ZrZAXcXyM5jVxfocKGNrFtR3OpP+PAoNTQKr17jeYIHcUYpTDlTok0eAR
 7xdA==
X-Gm-Message-State: AOJu0YwilfHYDVjhYt2kjB1Xq5n1ndUq5d0e2uiH7IPr6JsOXueo459s
 zb3PmXpCoWg73Cyq0ZokVOIb3vVAf8nFzj9T+is=
X-Google-Smtp-Source: AGHT+IFHQVPrLS3umoEYC/MszoRNf4fYZUvGj7MN8zldKM3BxqmT8UHf3Arai9zz7PwZsltp9cfftw==
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id
 gt20-20020a17090af2d400b0027cf8453e3fmr30019528pjb.1.1699326671372; 
 Mon, 06 Nov 2023 19:11:11 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 84/85] hw/hppa: Turn on 64-bit CPU for C3700 machine
Date: Mon,  6 Nov 2023 19:04:06 -0800
Message-Id: <20231107030407.8979-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 43c7afb89d..da9ca85806 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -696,7 +696,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
-    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->default_cpu_type = TYPE_HPPA64_CPU;
     mc->init = machine_HP_C3700_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
-- 
2.34.1


