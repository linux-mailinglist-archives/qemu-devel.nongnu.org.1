Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7D7A5F39
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:14:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXix-0003IQ-GJ; Tue, 19 Sep 2023 06:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXiq-0003Ej-Vb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXin-0005Lp-Kq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3216ba1b01eso217008f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695118363; x=1695723163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr6Clrpkq6ESZV/UlTcHGYlZcIctctlsSFi4SWetSSw=;
 b=v0xR1bP749p2pcUKZwyFb3EWhFGtTSoMvTqLj34LgjbjOc3w8MkCdGKnrcrci0nSke
 H1VD68xYLe50Wxwi9U/7jjyTmd8mU+BHpXFsfs0qtVpxXd2yF17UCokCI0Uwtr/0LRXa
 2kl6i0cm8qtfNFWNLjnAeYMkDftO6UEWwKZfIWZViqRk0Q4Dx4xw/Fob6KAVBv1Q8DMj
 BTWeIqfm3Ymftz5fRwNi4q/tAiVvghhnBf0jyqGAGavbIMUKl6WfcHgId9r3WHKr+wB4
 XZnqUvwZ3JRnokBEKTHXrhzFdHcroiTkwchIH/tDxj1W7isqLNLhk0VK0gSte791qLTk
 PHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695118363; x=1695723163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr6Clrpkq6ESZV/UlTcHGYlZcIctctlsSFi4SWetSSw=;
 b=pKjNgSA1TN+b9WLyyBcKdrNabUwuVspz+vac/3UnzJHQmV+/iOLy04B7v/bT+JtWGx
 3anfPI8xOmCfZL/P9GHR6rl2f/nRgJs1WByZTQLdcn/9MZV7QTmFs998RgiiPAK5um8W
 lklkRGY5ABWbjsNZmt3+KT88WknoGvmG2eDuNM4anWF7fAwtaObM0Dsi6YALob2jUdEy
 CNoskSZxaQOeocHrAvgywj1ifeFjti84KB5sCz79ZWu/8z3unRXMD8g1SI44LzajON7O
 n7E3pNUlg4XmoyrXSCrDXNScLnpZQRXKRPbIiFIT9m5Vjd0Dxfv1MIer2b5b24sTuvyf
 g0tA==
X-Gm-Message-State: AOJu0Yw3DIxj9v1MpACnSwQXXtFbJMyBReD9YDySfO6ev9Of/50fEJw4
 En34M+pkFFABnDNXRKe+dwslVA==
X-Google-Smtp-Source: AGHT+IEiWYHow24aeTj0o97A2Mz7GJID0yEo8nrdjwu0F5OFhaop+9GNxFu8yHVbd1Q4ofNdm3HqIw==
X-Received: by 2002:a5d:6851:0:b0:31f:e5b8:4693 with SMTP id
 o17-20020a5d6851000000b0031fe5b84693mr9285336wrw.25.1695118363207; 
 Tue, 19 Sep 2023 03:12:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ba13-20020a0560001c0d00b0031ddf6cc89csm12290136wrb.98.2023.09.19.03.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 03:12:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [RFC 1/3] tests/qtest/bios-tables-test: Allow changes to virt GTDT
Date: Tue, 19 Sep 2023 11:12:38 +0100
Message-Id: <20230919101240.2569334-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919101240.2569334-1-peter.maydell@linaro.org>
References: <20230919101240.2569334-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Allow changes to the virt GTDT -- we are going to add the IRQ
entry for a new timer to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..bcf131fc160 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/GTDT",
-- 
2.34.1


