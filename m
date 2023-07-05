Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F107484D3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2Pz-0007tt-Nt; Wed, 05 Jul 2023 09:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2Po-0007hN-Hu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2Pk-00074d-H7
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:28 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e29964942so278139a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688563160; x=1691155160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igb0JyNsA2PhSTz0dTyRLO9tMn947tv2lHWj3R8IWaI=;
 b=bybfZR6Z/vuhtdmB02MgRLaG+6BSZOPiqsYw1U/g+EwHUyEr8Hi7ULvPRtcuXljuTP
 xp/fzoEfuMeShNID74HAAAWDH/54lw5ob1j41hXV2AeR8NFICp0tLOIRLTaGRmU23KiX
 qOJKj8nUL7vUinVA1TBikbeCPLrDXcxmADXYWihr8+lN7NTCJFTZSmPrrR5O9SvS5smO
 5GSleUPmPpU0GwW47xOSWLL8bwvRuvtNxp92+UpVapaNr/FZehkdKsnpN1vrbTaSFDww
 TUELwkHZxGymg2B3zByPqwB4DkdUaM01sNCFJ5UWw2dV41Q7kLwmeNHLq+U+SwtyVtHY
 QrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563160; x=1691155160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igb0JyNsA2PhSTz0dTyRLO9tMn947tv2lHWj3R8IWaI=;
 b=TGB/ZD2gmv/8HD8TpB47kg67Yr3AqSrS/454Ze8rVKbpeMysuNZZsuDPXbBb1VZ1Be
 w+Hq4HHmMVTe+dL1b5sbVmSgkkP9dqLnMV4g/ssZprbMkza/i7J2pHM+tbO/0modB5up
 XKBSwOBXDYFpahUfpmiCp2HhfQTsZOFzZwpqg/PCCs7AlTG96AqtA2EGA3pGQiy9ltHW
 ptFJnRJdQ9U51BFvs2zg/xqoi+nHo4H4JHH2A6TfrSgxjktbyoWvdPNjW3sYQLa2/WFA
 SyLHFevuJL9XleJSGBojxBXOWJRz3Nnt6aIJc/D3opBNytwSW3wMJUTwlHPZljNuiOQJ
 2w0Q==
X-Gm-Message-State: ABy/qLYAQCgiCYAD1xDmrqmcFGzwsday84QaZEJuEr9DtUc/Bdx3CUnE
 /zsuCUFiNPysPMip5svnh9zBDinV14y4JXcQ/sk=
X-Google-Smtp-Source: APBJJlEmVxSKmWN5A7LoyxH08TTEihkYGwSXQdL61kObadmKOMK4v6Lp4D+GzEtKeWCDr2IdPjgkrw==
X-Received: by 2002:aa7:c74c:0:b0:51e:22d8:178e with SMTP id
 c12-20020aa7c74c000000b0051e22d8178emr3472345eds.18.1688563159936; 
 Wed, 05 Jul 2023 06:19:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a50ff11000000b0051a4fcf7187sm12859379edu.62.2023.07.05.06.19.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Jul 2023 06:19:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/3] util/fifo8: Fix typo in fifo8_push_all() description
Date: Wed,  5 Jul 2023 15:18:57 +0200
Message-Id: <20230705131859.53970-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705131859.53970-1-philmd@linaro.org>
References: <20230705131859.53970-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/fifo8.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 28bf2cee57..16be02f361 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -46,7 +46,7 @@ void fifo8_push(Fifo8 *fifo, uint8_t data);
  * fifo8_push_all:
  * @fifo: FIFO to push to
  * @data: data to push
- * @size: number of bytes to push
+ * @num: number of bytes to push
  *
  * Push a byte array to the FIFO. Behaviour is undefined if the FIFO is full.
  * Clients are responsible for checking the space left in the FIFO using
-- 
2.38.1


