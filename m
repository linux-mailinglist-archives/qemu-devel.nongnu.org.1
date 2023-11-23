Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E39947F577C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61Xn-0006IM-Il; Wed, 22 Nov 2023 23:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xm-0006Hq-1U
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:26 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xk-00064a-0y
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:25 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b842c1511fso330769b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714542; x=1701319342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjKPY5uNF9R+Jnwg0amtOzmeSA/AKoApnoQmZc/PaUQ=;
 b=UZqjOg3SMbaqlEULftfSQsa7+fg4XVRksC+UsKrT62tGLHxzS6yznRc6dWKZkXdmPM
 BK0yfFPi+T7maOejHTmuECwwvR/v7uZbId5isTJNvpdqxNFSmQAuqgh/2UdP24w+BKGd
 16pw7GtDsaKkjLlYYu6nWbFdQYUw2Xw0OURae6wsRg2qS7kLedKn5LB875OfcfCeQHGD
 T9Mdfez9wRPUaihhg+Sz8xoPuLnwwS2L3PfBsfKYdYX6COhMpIemjrwzpf3MNv5X2lEb
 9gXFDyQUIypcbcshNmwVJA8SxgvcIEoPLn7dbP441l4Jd+WExG4lzzg5je/bbbRIQqJD
 Nk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714542; x=1701319342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjKPY5uNF9R+Jnwg0amtOzmeSA/AKoApnoQmZc/PaUQ=;
 b=BQipcmxQsR7H0AZT9zbyI+dfb8LnMbwTxyQGy0zGcVwFTYraRBhyqIoolJRPJ9nklm
 BP6+W582wmgGGNkOcnCHXFy4aJTgwxHtfdzYjAWYpXpKUOMRPrB2A4tNud9P5LDBJDVX
 dFhhlVPA4YUEnSNmKOC5BPjPjCYF2Sh5KchqPnRwR0QkSdzL33GA6+o8bu2DGeAB767h
 b7JT4/98ygtvv5dc9B3anSf8WL9sdsIE5oalMe96Oh//+1fh3s5YEnYL8CKvPGCmeYUl
 EcSiJp08/wKIqRhpHrUuXDbLryyM7RvJ0+uQ1byR9Vk6Z/ziLxTO1n0Z+QPilI7Yn4MN
 sDIg==
X-Gm-Message-State: AOJu0YyltEa0tbOq1E8I5b+urhcOcmI4w6N63164x3NUOu8bzRFFeMkl
 GL/1TuKyOf+CKbxfXw+0SjYN6b5c7ki3N2dMsz+A9QOu
X-Google-Smtp-Source: AGHT+IE0sm64WuzXPJHQ3rg9EIWodmeb+ASWtiDwTXwC78Wks3QbHwuH/uqyFEayJwPSG8L8sQxTmA==
X-Received: by 2002:a05:6808:1911:b0:3a7:2390:3583 with SMTP id
 bf17-20020a056808191100b003a723903583mr6301855oib.38.1700714542378; 
 Wed, 22 Nov 2023 20:42:22 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/21] accel/kvm: Make kvm_has_guest_debug static
Date: Wed, 22 Nov 2023 22:41:59 -0600
Message-Id: <20231123044219.896776-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This variable is not used or declared outside kvm-all.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..f138e7fefe 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -98,7 +98,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
-bool kvm_has_guest_debug;
+static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static hwaddr kvm_max_slot_size = ~0;
-- 
2.34.1


