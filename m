Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C2A7F16EA
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tg-0006L0-32; Mon, 20 Nov 2023 10:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tL-0005qL-8l
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tA-0001Cv-7s
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084095722aso19156265e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492918; x=1701097718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFCIY8a2prU+vxKx/Khs2e4u+A5y+AyU+weaY1KLmL0=;
 b=oIuUzylEAc/Mtmflle9r+o+O2IPhKKxloPSQZxmSJjqmklXenc1irTJq6Je5HIeyUg
 piRJU9/hSdfJdrPRmVeXDFKHE8j1PhEkq6KEtD7wIfqfygRgXtVh0yX45P7JSJ7FOoVm
 0jAOCefOpSuwghwuXHaH4EuAq+ALjOpAZhdrU3boXOYb9eBr1HG4YG0FH3tN05wdQQBW
 nY+A5tRiXh5dO7/K+kBc7LMkaZYVRpdvzV1047tcVNLI7V5ZRqUitxMpLwMPDKVjxKWI
 dqHDZOR7v+LWYY4JVsX8QTbhC6VWCjmSfvafus1Uo0tg4iW4EQF+465OKxUPzV//TBvF
 qUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492918; x=1701097718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFCIY8a2prU+vxKx/Khs2e4u+A5y+AyU+weaY1KLmL0=;
 b=sXrz1AFYdpbXDxLFoTrW6M4jL3KjX+zR08+ZJpU6mjD8Rs5ppxdavRVSpsSzvhM8S8
 eospmXZSgoviQbC4zioMdOnpsPUv5VGtaJF1/IiueASecce0tx/2UIcFT03kOpkLA50y
 inXVE/WKj1z4VOCqxOSFPIcsvZJPvDKj25Jjntd7mDyhOowDhhch6Qa4tu0uXHDsBcAw
 DPaWcAv1XZpUVsyDfNG0Hg7hEKXsiJ7T3j7OmR7mR9fgZ2wt3ODnx8LLjPXiaxonNQEF
 jE0iqOuLvxC1IDB/6rHf12lgUdjc+L5WT94WaEFOHJPz7IoBb1ja7zhQT0tI1CIeV35U
 w1GQ==
X-Gm-Message-State: AOJu0YzplxzXef21zXisQtm0aiIAmGOI1vGoili+Ur1j6+I6JNCU6BGA
 KzOTBsHYd2723ea+59i5wEo2FA==
X-Google-Smtp-Source: AGHT+IFWf+YmPnVGzqdxPMTnA5Iz3M/1ufBsQ/wEjLZEn7xo6vDGlv/iSCCXZT1Y23ItSWDD42yXiA==
X-Received: by 2002:a05:600c:3106:b0:404:4b6f:d70d with SMTP id
 g6-20020a05600c310600b004044b6fd70dmr6806538wmo.17.1700492918405; 
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b004068495910csm18174146wmq.23.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B663565776;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 08/14] docs/system: clarify limits of using gdbstub in
 system emulation
Date: Mon, 20 Nov 2023 15:08:27 +0000
Message-Id: <20231120150833.2552739-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1274
---
 docs/system/gdb.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 9906991b84..c0cc0c9c7e 100644
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
+While technically possible to debug a user-space program running
+inside a system image it does present challenges. Kernel preemption
+and execution mode changes between kernel and user mode can make it
+hard to follow whats going on. Unless you are specifically trying to
+debug some interaction between kernel and user-space you are better
+off running your guest program with gdb either in the guest or using
+a gdbserver exposed via a port to the outside world.
+
 Debugging multicore machines
 ============================
 
-- 
2.39.2


