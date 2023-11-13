Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDDF7EA1EF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:35:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao3-0001Wd-Im; Mon, 13 Nov 2023 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anz-0001V3-DQ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:59 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ant-0000wS-CB
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:58 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so34153555ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896772; x=1700501572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDEfmAbOy2qvpKQOFuCC1Pms2S3upBaFJxzCOL7P7rk=;
 b=SJwPmtkCtSPiBWDaZkYUkeKfoAz8FelZvp5Kr8oBK9AHr1RPAI8Q//5jZDhSFloq4j
 GjFGd+scnb56v4QmeRavu+WDhpZt9ZPeCEtIJqq0DrZJekt6vV2EuUWWbfn6qjbMGUoQ
 7/PsscQyFYdh7FHYzcbEIao5MwXsdZlU6BaKuSfQeW6GqOvIqOFRI32tldy0AAs0V9Pu
 +rkxd/W/i+10nvZ+UHAjGZK+FOTe1FI/o585d8onmSd3wpE5iBbKQiq3cUsXmjOeBwpV
 UUWvY90tkgQKs39OMsNTdNwOiDlLgApqK4dcnyhlSUNaY/XqsE0OPwpwR3Y00RMMfgnN
 /Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896772; x=1700501572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDEfmAbOy2qvpKQOFuCC1Pms2S3upBaFJxzCOL7P7rk=;
 b=CE8YIjl82zUQvx0Fq9UluaUfOXp7UuSpn9cTT0e5o4aJPkvPs2jdLjvdng3rVII7Yu
 2DnsHgh06esG4Fu+8/NZz/V61KC/QKFeZHH/fYjKsGZX4d3/aRgbcYocKoAKYOZoHrk7
 IX8d+VJhi2DzyySUyhhBk1hw2IWVTa/WcbNpSSP3wcZBBf3c9eblzedchOmpvd01WKIZ
 dS6L0PSRUTKCaaiUU1o7T/xFpplNSmINZzgkSB7y9fhT0VC5CNGI3DvvttQEg/GkhNLi
 6k2Z3GSEHMPcP2nUUWzTQB9bsZMq0RLjMI9gg9kmeFTU30l/fDHWONX7FDT3UMXlIlVv
 oJXg==
X-Gm-Message-State: AOJu0Yz6Xfj/8mY7roKE9IqG5Wda9+qAjotxmneM26436weTD/D1XHzF
 nIX4u4+HiNgapP9FrwJWcUzO0+eCmKbAneull9E=
X-Google-Smtp-Source: AGHT+IGmmrfKkwr5B8iIx8qxBIKLf/zObTVdEFnm6Y72RvGeT/4B9lvl702Qyetoq85u/bG/oj344g==
X-Received: by 2002:a17:902:bd97:b0:1cc:3c2d:1289 with SMTP id
 q23-20020a170902bd9700b001cc3c2d1289mr210212pls.3.1699896771839; 
 Mon, 13 Nov 2023 09:32:51 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 12/12] hw/hppa: Require at least SeaBIOS-hppa version 12
Date: Mon, 13 Nov 2023 09:32:37 -0800
Message-Id: <20231113173237.48233-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The new SeaBIOS-hppa version 12 includes the necessary fixes to
support emulated PA2.0 CPUs and which allows starting 64-bit Linux
kernels in the guest.
To boot a 64-bit machine use the "-machine C3700" qemu option.

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f7d9ce9b46..9d08f39490 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -34,7 +34,7 @@
 #include "net/net.h"
 #include "qemu/log.h"
 
-#define MIN_SEABIOS_HPPA_VERSION 10 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
 
 /* Power button address at &PAGE0->pad[4] */
 #define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
-- 
2.34.1


