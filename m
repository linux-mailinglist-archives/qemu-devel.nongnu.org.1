Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05282D438
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:33:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGVl-0000Jj-Qa; Mon, 15 Jan 2024 01:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVj-0000JJ-So
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:51 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVi-0005ge-C1
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:51 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so4141894b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705300309; x=1705905109;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYQj7cyXWL0Qtnc1jkuPpdu9+gBdKiIK/mZUsUTXWpo=;
 b=fgpaQhAymoaTqSmu1bjABr/Ogckq4Ri6duOGLLTYhEV9AM7iKZm/SSGkSTJWsI5Ffp
 BneIpGRjK6WdkuZxe6z4Wy0SqzjTcUzxw/Km30GWlxEgVEG/32Zd0Ec9TxnFm8MBEeOM
 gwvSh/WWxaLqW9yN2f7V52wtkrJB0NN9DM5BOzcuj/UPQSjvLNkYhpADies8YBmL/lqd
 ouNA5nFsJ1IMD1T7TPp23tzpTnJwpg1NIm+7XfP8jC9JI0HGbIIL5pI43GViTZVRdpz/
 0ElT651R1TQ1oRDbkX4MADdECxcWlQji3EpPELjyEeY/XDv0qY8trrlFeaknL2oieRH3
 PfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300309; x=1705905109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYQj7cyXWL0Qtnc1jkuPpdu9+gBdKiIK/mZUsUTXWpo=;
 b=QOkG2cSpyg8vq0U0GqlerItJe0a6SQYMS5MyjnLpZUv2voNDWqIGnIzdNoZimWVJIM
 Z196QozbrX4TrbSArByAbAZ88vToMgLpEQF6D4X7jTu8h9vWcwQItcMZ6oTnCsaGpUhi
 zSfss1eWO0pujM/15rO2tc5RkhVyF2WCDv5681tCCbpqY1AafccWWtNxUClACR2rvRv/
 ptoq0SFUQDhe0zRoLzhLRTxkBuxHCYL3o8hH3yKGYTUk1v9XsWsjyLzVbxfgqT9WKS9h
 Wlgya0K6ljMPiSgr0c4s4HZV76oi7Xe5nZ+Nb1mq7PHEZ67z/MuuNrV23pnIM8uRSyos
 Sp8Q==
X-Gm-Message-State: AOJu0Ywh9jnMWc11wPhhjwVpsczJEdGX4BWVyjVMao+cCKR+5dXAVOm4
 uoR/Qd9yY+WhSns46jAzwQvPYOJRXI1nAg==
X-Google-Smtp-Source: AGHT+IG0KeD3YmIOJMYPGqcD3H0t4Iv5KSL4XAjFIddTvZP2n6iQzXfTSnwhhOYb0qtTcRVbszxDrA==
X-Received: by 2002:a05:6a20:d417:b0:199:7a43:d183 with SMTP id
 il23-20020a056a20d41700b001997a43d183mr1745493pzb.121.1705300309048; 
 Sun, 14 Jan 2024 22:31:49 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 b15-20020a170902650f00b001d07d83fdd0sm7115773plk.238.2024.01.14.22.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 22:31:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jan 2024 15:31:26 +0900
Subject: [PATCH v9 1/4] hw/riscv: Use misa_mxl instead of misa_mxl_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-riscv-v9-1-ff171e1aedc8@daynix.com>
References: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
In-Reply-To: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A later commit requires one extra step to retrieve misa_mxl_max. As
misa_mxl is semantically more correct and does not need such a extra
step, refer to misa_mxl instead. Below is the explanation why misa_mxl
is more semantically correct to refer to than misa_mxl_max in this case.

Currently misa_mxl always equals to misa_mxl_max so it does not matter
which of misa_mxl or misa_mxl_max to refer to. However, it is possible
to have different values for misa_mxl and misa_mxl_max if QEMU gains a
new feature to load a RV32 kernel on a RV64 system, for example. For
such a behavior, the real system will need the firmware to switch MXL to
RV32, and if QEMU implements the same behavior, mxl will represent the
MXL that corresponds to the kernel being loaded. Therefore, it is more
appropriate to refer to mxl instead of misa_mxl_max when
misa_mxl != misa_mxl_max.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/riscv/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189f0..bc67c0bd1890 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,7 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    return harts->harts[0].env.misa_mxl == MXL_RV32;
 }
 
 /*

-- 
2.43.0


