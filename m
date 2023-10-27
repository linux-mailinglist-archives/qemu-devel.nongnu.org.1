Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15A7D9C21
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0x-0001BG-Hn; Fri, 27 Oct 2023 10:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0P-0007P2-VJ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:12 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0M-0008PP-BB
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:09 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so32161981fa.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417604; x=1699022404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48ASzG0nX+0E7E7CWtcLXtYWDsJYhuDpjzE47KRjlq8=;
 b=vyJzmSU1eysC6jvV7DcQLDGvmd4V8WAjh7tCywoci0WQw0zjp1j95mVR45shsyYJ5P
 Q/nlQZ7x/KGbbK4TapCk8PkaVBdqXccuaU+BU/dlDgYQDfJJn7zHFK2LQYXvhrl5p8PK
 mkFXomQKH54WqBU78gE/zXBtSlA1WpH2BMbPDl/46UaejY7tRuCUc9B4WUALseKHGgJB
 wGUMJSYBA5rnl+eOt+c+Vo8xCz4fxkEeKKRTABYa4lNki8fEQj9z2JxwLrdWbqrlXCLv
 FWweNqVVw5njRcRmup+4kPV1uzQdPg3jivF5VEM0xStpGuJf76KOeFjJLRhqzmwmk6J9
 B8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417604; x=1699022404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48ASzG0nX+0E7E7CWtcLXtYWDsJYhuDpjzE47KRjlq8=;
 b=Ii+P4ceLlkA0kJ+QfWAY4pfhGdMbBbQfbxvrs4ub3lz4h0Gp/RFk6RnbMSWnZzkt+u
 VUKojYhQtu3aokwbBrwad2hU6Jb9pKi6S6ARD+RmscwPTNDjWFVOHeK/cqZNbwybILtT
 VOb7AsChoo02+xaiAwvEVsVpx2PUkC08aLbLORJRDwCg29s4n5Np9iumt2MhD8ZHVdja
 memYS3YnLcYuXDmnDEF06t70dJacq4sfICHuB74G7Xkck0yNJZL+Qtb61LBYLG5elFk5
 jqkDPfHj+rokRSD3b8/EVCjOWmhRgeFPGTDV+/IK9dGyptcThxbj8IIuPbpYnMsVxy64
 yNtQ==
X-Gm-Message-State: AOJu0YyA7J0tuSTf1PbrSV3MmJ3HqMuWauSMDWBoObFad6+EuNTXXp8H
 URCtCWY7jd5N82PVSwtX8Dqwxyj13NlszvJCBCY=
X-Google-Smtp-Source: AGHT+IHya5TR412clGy61F9lw3f45RwvgjE5vluCIP/mImNfUfCYyyq37hbO3XX89bShm5vGb4Akcw==
X-Received: by 2002:a2e:3604:0:b0:2c5:1ad0:c318 with SMTP id
 d4-20020a2e3604000000b002c51ad0c318mr2083965lja.44.1698417604546; 
 Fri, 27 Oct 2023 07:40:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] hw/net/cadence_gem: enforce 32 bits variable size for CRC
Date: Fri, 27 Oct 2023 15:39:42 +0100
Message-Id: <20231027143942.3413881-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

From: Luc Michel <luc.michel@amd.com>

The CRC was stored in an unsigned variable in gem_receive. Change it for
a uint32_t to ensure we have the correct variable size here.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-12-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 06a101bfcd4..5b989f5b523 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1105,7 +1105,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
         rxbuf_ptr = (void *)buf;
     } else {
-        unsigned crc_val;
+        uint32_t crc_val;
 
         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
             size = MAX_FRAME_SIZE - sizeof(crc_val);
-- 
2.34.1


