Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0E7F6375
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4C-00060F-GD; Thu, 23 Nov 2023 10:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C46-0005yS-Si
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C45-0002LA-2w
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:30 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332e7630a9dso69253f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754987; x=1701359787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kYdFlz/DbR9wiBLu9uW1n60WPr7r2xH09X5l3DXY1k=;
 b=Ldc+IsudMHl7Che2NDxeeMoOhw8suxHnbRvO+JbCbYD+wjdMDTNoN1m/GmLXkGzTFF
 I+RMBMVr4K0FNGOeevV2ZecRxsFNuiv+asKXO9arPxNoSkxQ0iL9vnFKMX5WQ9WGXcH9
 +6VK3gX53q6s+GREj/ZP3ixd9Oj0dRsHgbz5Xsn4fwJZak+MjK4Ewr+LOnDOhyD2o+mD
 +ukkDf42V54gJ2W7SXVKvRxzAaeKGisILz0oL107pnK1pvyI4HFVpUtXnfn9WtK4OSGg
 9fry3pB5a9nHQlvF3+bUAvFVaR2FFvi75Y6vM9qCdp/HahFj0NEUZsbl61fCTsBdfbRG
 KKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754987; x=1701359787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kYdFlz/DbR9wiBLu9uW1n60WPr7r2xH09X5l3DXY1k=;
 b=cvg4eiWsmBv2QKYOv+cv1+DzFG4iCrJKZh9IVm7qqR/TuBO7Dama4A4LDPE/EXchIZ
 KoQG7G7qUrkvBOR2f98Qxfc6up6K87PyQCY4bIg2507hRyf1jUpfiqvPtmzHXWjzPSvq
 P3cIwAJ+vUXqW7cnh+ThBY6xc2vNTIVVD/gz026iRTetSqxonoAXl5tARuXorxiUzZG1
 8+xiEP88tAs09R2BgnYd9bcmT/I+M38TxHzQGwTVBtD21bHGkr3c6/geGkxsyG7pKcnY
 VFuTF893PqLFU+vS9dOE4f4CCdtGZTcPLsSt75an4K+Mrsh3TFdEF5qT6x7qDw6vXwzO
 c6/g==
X-Gm-Message-State: AOJu0Yw2TPcILlMxmO58sxFC3qYcLM2JWUaiJP7+9/lnLuSMMGrN3FLN
 G4Xvb9pvN9QBqADTMkj34BrMrZOULDVF6/Dhkhdsog==
X-Google-Smtp-Source: AGHT+IEr3Zrb9GSufM4eo8dtozeAy0JC1V93Po7AeDXqoxZJ3xHbf/Ovr5E/18fzZuZgZVH0O7EhUg==
X-Received: by 2002:a5d:5644:0:b0:32d:81fe:7104 with SMTP id
 j4-20020a5d5644000000b0032d81fe7104mr3782456wrw.63.1700754987681; 
 Thu, 23 Nov 2023 07:56:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c11-20020a5d4f0b000000b00332e67d6564sm836043wru.67.2023.11.23.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BBAB645FD;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/14] docs/system: clarify limits of using gdbstub in system
 emulation
Date: Thu, 23 Nov 2023 15:56:14 +0000
Message-Id: <20231123155620.3042891-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

It seems some users will try and use the gdbstub to debug userspace
inside a system emulation. While possible clarify the limitations of
this approach and direct the users to a less head scratching way of
debugging user-space.

Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1274
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-9-alex.bennee@linaro.org>

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 9906991b84..4228cb56bb 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -60,7 +60,7 @@ As TCG cannot track all memory accesses in user-mode there is no
 support for watchpoints.
 
 Relocating code
----------------
+===============
 
 On modern kernels confusion can be caused by code being relocated by
 features such as address space layout randomisation. To avoid
@@ -68,6 +68,17 @@ confusion when debugging such things you either need to update gdb's
 view of where things are in memory or perhaps more trivially disable
 ASLR when booting the system.
 
+Debugging user-space in system emulation
+========================================
+
+While it is technically possible to debug a user-space program running
+inside a system image, it does present challenges. Kernel preemption
+and execution mode changes between kernel and user mode can make it
+hard to follow what's going on. Unless you are specifically trying to
+debug some interaction between kernel and user-space you are better
+off running your guest program with gdb either in the guest or using
+a gdbserver exposed via a port to the outside world.
+
 Debugging multicore machines
 ============================
 
-- 
2.39.2


