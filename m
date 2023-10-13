Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA757C83FA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 13:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFvg-0000OE-9h; Fri, 13 Oct 2023 07:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvO-0000Id-0U
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvE-0002E7-Kb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so1761446f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697194895; x=1697799695;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JZHdSiwRUYjXMXaey8Jc3lrt8drXtY7mpembZSBrZM=;
 b=mdV0dJVVloEqIn1/8rvGJjPPyek+VYSQumC1IdnVhayVb+UFraQR4sZsuWy9xroOKq
 deckm+lQFhMMyC6ZQ68bsTpuDoYSM3keZ+geOaUWkI4/mCE+A2QThRbowfCrh1jX2vOG
 0Gpfb5lIHAEK5UbXkQKaQxxRPMHi0GXWayQKrlfmeXYmk4RTJ34JxeK7fhtng5NiXtU6
 5+T9dU2lfngmigi3dc2vTLaoJaRTpzZBOzhrTtLqGh9UnIsqxA8+1JaahoCd+M15Awgb
 nQuNhm1wB6az5sOszhnTf2wWi9hrEFOxgvuPw1KoWzsKOlTWHrA5/9N9U++IGibdDs2n
 RGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697194895; x=1697799695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JZHdSiwRUYjXMXaey8Jc3lrt8drXtY7mpembZSBrZM=;
 b=BxCgpi1la4P/YtX9QZlpSUGashB7/OzIFptS/XbQ4NuT2e0FOrDrf5Df1BLQpPWgX7
 cWFp6YahiM0qj811bN3hQ2eUHlRb1OxJjeqyESl6bpKdTX1bP+0COcI/kewpvk9HVdzg
 uNkI28J6pxs3LPrygUlVU08Fc6c+a7UolF+nmECnto/STOkfNOHQHrznY/87aWiPHOaW
 PywJQYEWm06D5Vci7fRYtHDFXbF5TJWaQ1FqYGKGALy/pCkKwTZPWzCH7TJFIRXqpKGu
 yeda9/gE6Hd1SQ1e0GEvTSGeMjj+RPqY9lYhd2TLJfQpPHBQW8xq16ge8YUl/FK02wBt
 sKNA==
X-Gm-Message-State: AOJu0YxYc6DVM7SsU6jEP8NJLrV5taUSUD4Km2Ndz/oYKnee/t67AlRh
 NMEQ5zXxSd1k9NI/AqkCZtqTePvnYiGnW3i14ZY=
X-Google-Smtp-Source: AGHT+IFr3NpAaKU8Gcmmez6Yi2VUO+0WdWeeXa8Xu3lmT3hO3K/LgbapK9DcF8RPMwhZE3VEI6HHkA==
X-Received: by 2002:adf:e550:0:b0:32d:9e48:faed with SMTP id
 z16-20020adfe550000000b0032d9e48faedmr913006wrm.25.1697194894878; 
 Fri, 13 Oct 2023 04:01:34 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfce08000000b003271be8440csm20455185wrn.101.2023.10.13.04.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 04:01:34 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>,
 libvir-list@redhat.com (reviewer:Incompatible changes)
Subject: [PATCH v3 5/6] docs/about/deprecated: Document RISC-V "pmu-num"
 deprecation
Date: Fri, 13 Oct 2023 11:54:47 +0100
Message-ID: <20231013110111.34619-6-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013110111.34619-1-rbradford@rivosinc.com>
References: <20231013110111.34619-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This has been replaced by a "pmu-mask" property that provides much more
flexibility.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8b136320e2..37f3414ef8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -361,6 +361,16 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+CPU device properties
+'''''''''''''''''''''
+
+``pmu-num=x`` on RISC-V CPUs (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to support more flexible counter configurations this has been
+replaced by a ``pmu-mask`` property
+
+
 Backwards compatibility
 -----------------------
 
-- 
2.41.0


