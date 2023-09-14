Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800977A0E95
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsOL-0005gi-Eq; Thu, 14 Sep 2023 15:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOK-0005eA-3X
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOI-0006lg-KS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:43 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso174725866b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694721161; x=1695325961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqTzRZqnlvONF3ZM8t6uAZIEh+prXa466EdrDg1ej9c=;
 b=kf2+SrpgyHqHM2Gc3hX4ijG3xeBkFSYk4IdA16cFVmon5JM3nu7n0RFhjhuaZF7QDl
 0dm1uu1Ju6eATFi+gdSvjPoz19zwdoOxJ7Ss3cIswZS79KjgJiyV+FksPynr8zB0bOQK
 KEIPIYnGV53K/kWYK7mcdYEAIQ+RE2vbfSeLiz4VShT5+FeWNdhSxWlQGFKFvy0LGB/b
 eea5X4gzwBXejlSHjk1rbq9Jhb5MkA4Yvi+ryu/I5pESFGxY9YM0R3uPQaaDl6dHAn0j
 5ciI5h6GnEhTXBrZU2LqrcUEB6TkTJUsAO6WaPdDOjI7FIA/Su8E+39ASpqX2lknW7Wu
 AofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721161; x=1695325961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqTzRZqnlvONF3ZM8t6uAZIEh+prXa466EdrDg1ej9c=;
 b=bxGoZ+yJd6tVqCLTN70eyv3e8EQQnZemincctiW8t6Kh97wmL7NuYuF003KQ2iqST7
 NH1wsZ3NqeqWuYbazO5a7lhycYluZrZ+s6NUtZ+e/6QWCYuYdR6CPCAYIEsKxhjYy4jA
 h2dIbQ93Qvh8NEfbL/ebwss7zpzS0/a1djYtbDn8pzkHuXyBwMwfBmSRiyaT6BhA63Ek
 fTn3rla9Y7kRSlfCOkWHqzPWioxPg7d2p51JECTime8YD4G3ap7avih4GeQ9H/IYpdID
 afENUFT4/Cos1Yl1F9zZPkwpfA6nTI/sV794dL7Qmk+V4kjEU68o6HKcY2+PLBXeGe60
 AfnA==
X-Gm-Message-State: AOJu0YxPe6mFW+bL/nHDZcJsFv4Yzyl6jxN3SL6eLiH13jyKn3t/u7Gg
 J48nQwgZ822WZyt76cvVuotBVuI4DdSSkfVvvjE=
X-Google-Smtp-Source: AGHT+IFD2mXEeKb7LvmLo0tQ3i6MvQ3KLLOC4uDgyJbnHjIDcB6RpNbCfVgqydagutx8sJrj5Wb91w==
X-Received: by 2002:a17:906:300c:b0:993:d5bd:a757 with SMTP id
 12-20020a170906300c00b00993d5bda757mr5694413ejz.19.1694721160831; 
 Thu, 14 Sep 2023 12:52:40 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 uz3-20020a170907118300b0099cc36c4681sm1423925ejb.157.2023.09.14.12.52.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 12:52:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 1/4] accel/tcg: Remove tlb_set_dirty() stub
Date: Thu, 14 Sep 2023 21:52:26 +0200
Message-ID: <20230914195229.78244-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914195229.78244-1-philmd@linaro.org>
References: <20230914195229.78244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Since commit 34d49937e4 ("accel/tcg: Handle atomic accesses
to notdirty memory correctly") there is only a single call
to tlb_set_dirty(), within accel/tcg/cputlb.c itself where
the function is defined.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/tcg-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index a9e7a2d5b4..f088054f34 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tlb_set_dirty(CPUState *cpu, vaddr vaddr)
-{
-}
-
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
 }
-- 
2.41.0


