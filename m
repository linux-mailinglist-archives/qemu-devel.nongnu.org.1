Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C407E8273FA
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrkt-0000aS-G3; Mon, 08 Jan 2024 10:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrko-0000YF-F6
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:41:31 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrkm-0001SD-G2
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:41:30 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33765009941so1622782f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704728486; x=1705333286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OgFybPQwNuMp3NAFbCe3JoR0imHvNQVIavgG+VFaK5A=;
 b=j8InsCNr2tKOzvyLiaSEr24bZXrMCLN/8vnu7ggvl06qOUwNIMe3WV//oJEJDZA2ka
 Zv7tLZHC3xanz63b9UfDzsX0eOukoAvPrji7O0CsAmlMX8bkPSRC0XS1Njhqq+gzpv3i
 IMqaKiqAadiaK/6LdbZZ1OHCFr+TGSG6jP7UPVnl3KCYvv8mW4Zq6nWNws5VlCW+MHGx
 FM+ZhgHs5vlb+zKN+rbTG+xUShfstepbU4WMGC1CR5FfDolGiA37zFIYzXX/XWHh3CMH
 8YQheqm+ifGnyPulbweRK+8xuUkCTEtuTysrVDRiwLUjwvnHt9snZRMieS2ArogxVhOz
 DeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728486; x=1705333286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OgFybPQwNuMp3NAFbCe3JoR0imHvNQVIavgG+VFaK5A=;
 b=upi7EctyA7SU5BRtHpR8ofRtS+6O1HiJtWlYiKKQjF7mCAlVOAfzodKCtDlbOauE1x
 VVWHstavVYpDtb8awwE/Ui9XiFA4kPGavIe4hUVodl14+jtOuFgoB6PZgACDxqlbSR5c
 ndboD2FX1V+l/zGynnDapM278lPcXjIn15dsOrJ+gpzIOwinnjIDL8n3r5iw359Fpq9Y
 EvvfD97SDxsxaD5318U5z0NV6jnNxlFGOYTAvGEEfsgboJ7/amsixglHS7GQNLn023op
 qQBUKZArD10MPdEfZRlYI6mseNZ/hGmPMde0oOGE91yqRPGX6ABQ9qUyF2zK0NgzbjZW
 6JUg==
X-Gm-Message-State: AOJu0Ywou+6AMVWT6ioKV9ugQWwgmkvprB3b+B0Pw+udrulHroIlfou2
 Nb7OpFRQWtz+VrWb+3iXduvpnFIryIAYkpi/TenhLXPHz9M=
X-Google-Smtp-Source: AGHT+IGsTHacUUL78K+z3TJue6YRbJrCUTd72LKP7NY39Q5sAGck/L7q3e3fZVxwRGJehAJtaxpOfg==
X-Received: by 2002:a05:6000:14e:b0:337:2940:ab7b with SMTP id
 r14-20020a056000014e00b003372940ab7bmr2615978wrx.1.1704728486010; 
 Mon, 08 Jan 2024 07:41:26 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfc98c000000b003366aad3564sm8100493wrh.30.2024.01.08.07.41.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jan 2024 07:41:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] net/eth: Have eth_pad_short_frame() take void* arguments
Date: Mon,  8 Jan 2024 16:41:23 +0100
Message-ID: <20240108154123.53680-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Any kind of buffer can hold an Ethernet frame, no just
arrays of unsigned chars.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 net/eth.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 3b80b6e07f..d73737f07d 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -434,7 +434,7 @@ eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
  * @pkt_size: size of the original Ethernet frame
  * @return true if the frame is padded, otherwise false
  */
-bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
+bool eth_pad_short_frame(void *padded_pkt, size_t *padded_buflen,
                          const void *pkt, size_t pkt_size);
 
 #endif
diff --git a/net/eth.c b/net/eth.c
index 3f680cc033..25c6eb9b20 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -520,7 +520,7 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
     return true;
 }
 
-bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
+bool eth_pad_short_frame(void *padded_pkt, size_t *padded_buflen,
                          const void *pkt, size_t pkt_size)
 {
     assert(padded_buflen && *padded_buflen >= ETH_ZLEN);
-- 
2.41.0


