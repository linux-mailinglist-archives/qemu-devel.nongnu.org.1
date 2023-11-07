Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCA7E3312
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BsV-0005TU-Ul; Mon, 06 Nov 2023 21:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsT-0005PL-3J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsQ-0002tT-GY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:39 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so42324565ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324293; x=1699929093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cx7TXN0jX80ie1cuAfoZHAEv2pv3Ph7XnHY01EPWzwQ=;
 b=cXjBXNw5FxbXnstFOEx2ivSQvC1xzH9PGGvgJ94DNGkhDl/SjWNY1vEjh5Fo/ZEzPm
 EoYIe7aUnwLhh+xwZ47CpDo6NMAnrv2rHsgeXgSbcc24sblJGRy3mqO5V2sj6NkOb1rt
 o1s2KgZgirhuNq+TXB/UAUvql5QWnx38ki7zlYoksSnZylLSdaLiAtKETjaj3NYbEmaZ
 r63mSuWNlup3bkMCEYkTMG1UK4IynDCQOMH1ZxA9GkecLzQ9alMfDO1zwvHO+0uWzQLc
 3EHkH0qYKjfQZ7qPE7AODaI9yI7e3rfbKeIHNtLeuuGCscTX0+9BSZjfpRR/mc3ewA0t
 8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324293; x=1699929093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cx7TXN0jX80ie1cuAfoZHAEv2pv3Ph7XnHY01EPWzwQ=;
 b=ZWbYerOMHxvooXb2bv/8liOcJXUxj9m65/eBai1xNiQHvQQO7iL6LUHHlrXFsIMSBR
 gyAii6fjQSlftaT3Dh8oMEeRXYZP1dRyzGETAZrxNc8x1MBxLa7RFzGJs4UGJDPjvcS7
 Mvdl8I4zrT6Vl0BmnlwmjuaL8ykNzTqQKKYR4tD68T6WWlt7vSnQcDICdsqAce6nzsxw
 Cl8d9urq9WQzMiFmXN5FzKXMEGe3Zz+a9wTqT1fVpEaY3GM7d4BNa7xPYKW8L2c0WAhv
 NLY/BNT8RM56LlLWvL0M7IUE68xaJQ6YA4jPZ45B+5pe2egAG0gicRFaRP48TtvY2CXa
 U5Pw==
X-Gm-Message-State: AOJu0Yw/Y28purk9atqj4cBzA7qwQ5OJRoPqXN9G9TTp/7MjOGOtgZSr
 bRCRkgPPDydzwFobZJHCaKhMJPb2217okQ==
X-Google-Smtp-Source: AGHT+IF5G7F/F1I4XBIdTP89gw6BQndc9tQufVUWmJfauWlgZa4o9F2lC9yp102BzRJABxFBdukG7Q==
X-Received: by 2002:a17:902:ce88:b0:1cc:636f:f37c with SMTP id
 f8-20020a170902ce8800b001cc636ff37cmr21817407plg.13.1699324292706; 
 Mon, 06 Nov 2023 18:31:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/49] MAINTAINERS: update mail address for Weiwei Li
Date: Tue,  7 Nov 2023 12:29:24 +1000
Message-ID: <20231107022946.1055027-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

My Iscas mail account will be disabled soon, change to my personal
gmail account.

Signed-off-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231030081607.115118-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8a7d5be5..1de7f381e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,7 +323,7 @@ RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
 M: Bin Meng <bin.meng@windriver.com>
-R: Weiwei Li <liweiwei@iscas.ac.cn>
+R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
 L: qemu-riscv@nongnu.org
-- 
2.41.0


