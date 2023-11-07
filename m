Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E77E3316
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Btc-0003dp-HC; Mon, 06 Nov 2023 21:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bta-0003S5-FL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtY-00035g-Ju
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so26948685ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324367; x=1699929167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKii+d4PtY6EkSkbRy6s8a4hhZ0mY/MOu0EltthXHSQ=;
 b=HybNIJ3bmAIogXoxqtFLskVm95bFJzTvPLVo9WuXFHVzha80Blhbj4IH5JL8up3m3w
 uEW+zFY8HpM4jrHnNOm5tfcSvyPzAmrag5w94XCbJln3aCTdjKlcJQV13NRL64v9EXox
 RW0Raq+fDVaPfijpWHfJlSFsC2ZalOyNYjGGh7uPKb+o22nW0beJuKjnYGnGKEFRS41w
 Z0HEdjErMShRfr+U9IGS2V5gqgD4yLJXk0+J9HFo2GBGKBi2w4u8MiTHxoqFiqGoVV08
 qpQF8uLKlBw5yT82bko2fSspFoTLSdGVsAC0zsHhnSnmfcc/qZtxDQ9bxCmeV4EnPV6X
 iQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324367; x=1699929167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKii+d4PtY6EkSkbRy6s8a4hhZ0mY/MOu0EltthXHSQ=;
 b=udi9az9NYDec15DF74LEmYxOyZCFcIfbWIE+hcxWqtrHJQ64AI0hmjfmdmuC6Vy0Hz
 nxF8Yl3qyNHKRd2agRqVXji6XJiel/tWwZWTP/A5B0uLO0ZYc1/3BlNQ6ug8NJBKOiUX
 BRANHjJVnOk41PxsFc0PbsHMa45Riqr5T7oPfhLF7bCQ4xBXXw5trtRicM4LDKB/X7jo
 n5bietGP/tZS7nHE+KoRJRrbzAq+V82m+UltJJkqp1NB6eW3BCt2OyVcFdDE+kUn5z46
 WuFvrkKAaPRq43c+eEAFjl0OzeUzM93U/MteEZfku+1EBoFml6ZrqvCDhFFP+wYxG2Hq
 7Sjg==
X-Gm-Message-State: AOJu0YzMMywm8i+F0iI5/mTJKCBb0f/D+AjvmvhW68ZPxvj5XrKIEAh6
 ca8MWoWUTZALcJh/kQ0tGvB2e/ObyG6GQQ==
X-Google-Smtp-Source: AGHT+IHPixmYKjVgQId/CkyEsAa99QNwm2p5kUr8cJvorzH5YxZExexmPIYGFOZmAmvs3OSfxXhLPA==
X-Received: by 2002:a17:902:f94f:b0:1cc:3be6:b714 with SMTP id
 kx15-20020a170902f94f00b001cc3be6b714mr21786032plb.23.1699324366845; 
 Mon, 06 Nov 2023 18:32:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:46 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 49/49] docs/about/deprecated: Document RISC-V "pmu-num"
 deprecation
Date: Tue,  7 Nov 2023 12:29:45 +1000
Message-ID: <20231107022946.1055027-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

This has been replaced by a "pmu-mask" property that provides much more
flexibility.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20231031154000.18134-6-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ecccd5d3fc..78550c07bf 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -413,6 +413,18 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+CPU device properties
+'''''''''''''''''''''
+
+``pmu-num=n`` on RISC-V CPUs (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to support more flexible counter configurations this has been replaced
+by a ``pmu-mask`` property. If set of counters is continuous then the mask can
+be calculated with ``((2 ^ n) - 1) << 3``. The least significant three bits
+must be left clear.
+
+
 Backwards compatibility
 -----------------------
 
-- 
2.41.0


