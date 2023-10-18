Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DB7CE185
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:46:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8j5-0001bA-Qv; Wed, 18 Oct 2023 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j3-0001aH-Dl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:49 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j1-0004xZ-VF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:49 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a936f4a9so5037589e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697643886; x=1698248686;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRqVDcHMqARANKEFhhC2+XL6EbYrppRzGje9U4Xk56c=;
 b=g/P+GmzWu13jEhwy093JSd4bw5RSv189WKDQbx/8dQFoXzJVxlOLgKOD88LXRToyi0
 OMdfEB2IeMIPVouNkE6E6bvAHYfTDVdrAEFmnMe7no08nW4dZviWhLFY4cxgWcbZ6moh
 ZiXR4FsL5tffxcvORwLDQ/P1ynOHM4aC8f1EWzs2YAi02newxah3jEpVrYAPrEyzni33
 4AAU6H0+Bt1Ld2RK49dPX6JV269yooZctYvLsJDoKrAGz4yP9dsUdUcNMbg8wqBB4m8c
 drRHNT0gUV07IN7gveqx084rDCiF+ov4e/bf3dySM4X3xBju9yd5OYXXc68n5uuju05E
 QyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643886; x=1698248686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRqVDcHMqARANKEFhhC2+XL6EbYrppRzGje9U4Xk56c=;
 b=L5IiqxcAqQij7qd/b7YZ/qocYS/5E3Wmgv7j7TnJgiLkhtRa3Z2gCtILDKpieJyoPM
 j9XubsHQ/hkEYRQBue04j31vSJpCrJ2GQFJMbNuwJd4H1+WeJEFM6vRDxzIOVjBneIje
 iFBjUY05Kukc38QsLTjuDdL6Kh8kva2cvEW1k1zUB/GjeG3aONLLzjdWLO+dK9tZ94zq
 fF6ESLi0RTAssyTBAvmFjf9L+G4GzlWm91AN0DVN1J2mZSnBVaE4Ng66oo60HZC0bfwR
 tHJYLIhP9uWWBKtJtorKkaItZSU+qMjnQnr6crZc8iKUvXZ0RXG2gcu/wu1YSp7H7scM
 HtlQ==
X-Gm-Message-State: AOJu0YzXSUY+2ChWqr8wYK+1p/D6r9cK9pieZPtUQcmp0fouZp+I60Fy
 64QaWFPJx6nBuZc8RLmsmNztR69HE8PnrWVuvWecew==
X-Google-Smtp-Source: AGHT+IE7UL5s+pZKTFVXYiEQO8p5f5uiQfM1vEfJj2/7uNU94Vxu0bFd5GytrYU7dbIAC8LyvuUuJw==
X-Received: by 2002:ac2:5939:0:b0:500:9dd4:2969 with SMTP id
 v25-20020ac25939000000b005009dd42969mr4176937lfi.59.1697643885813; 
 Wed, 18 Oct 2023 08:44:45 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm1963580wmq.31.2023.10.18.08.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:44:45 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>,
 libvir-list@redhat.com (reviewer:Incompatible changes)
Subject: [PATCH v4 5/6] docs/about/deprecated: Document RISC-V "pmu-num"
 deprecation
Date: Wed, 18 Oct 2023 16:39:13 +0100
Message-ID: <20231018154434.17367-6-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154434.17367-1-rbradford@rivosinc.com>
References: <20231018154434.17367-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 docs/about/deprecated.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2febd2d12f..857b5d4fc4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -405,6 +405,18 @@ Specifying the iSCSI password in plain text on the command line using the
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


