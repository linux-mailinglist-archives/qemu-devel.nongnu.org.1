Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C69BA9D4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 01:24:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqY-0003fs-Ff; Sun, 03 Nov 2024 19:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqS-0003LX-B4; Sun, 03 Nov 2024 19:21:24 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqQ-0002gb-Re; Sun, 03 Nov 2024 19:21:24 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so1977861a12.1; 
 Sun, 03 Nov 2024 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679681; x=1731284481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AYuhGepsU7zeG4tt44YiLnEKuxFxxMmBcxIo9aE1no=;
 b=aZsTXWOpxzG15h3c6Pu6iRhH8VNp7cVIan0VrIKqFzDup1VOEoF2bEC3bjLGsUI+s1
 73joQJ/0JFLQF2IneU+zSHCRV2gC4tTqMsV0aZmxowOYErxCgYGaPflDSS2b+qshEzMB
 3vZs0sMwrS6nrkXTIdyNIXYsTX8XhixsILS+OsS57oAmBTL1SCTD9jqS0xMYTLHKKe6R
 1UkyioXlcFtRWhuBxOpQWjTEkYlGUcH30N9wu19YdGU+laJ3QJ+26Bt9tf1sZZiOOqmh
 IlDFgFawfh51EPLvwj/jOLcAnUSaNEYRWS2gaIGz/WSf2r6UOaY9+td0hUtomngHL3x2
 VCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679681; x=1731284481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AYuhGepsU7zeG4tt44YiLnEKuxFxxMmBcxIo9aE1no=;
 b=nGY6zQ+WAGzNlK73dZSbSXVUFOgE68pPiq5gCpoEwAZzhRiPhrU1PYHJeXHu6fi+Gt
 3lrkHincpN2KlqYGgE5v9Q6ZT/5Sgv6NNwVyxiU9bog02fBwSKed95uShS9ghUK4Zx8a
 R3XXr8jkxuiB3BKLSB6fnzOtgdfcRnPJKqvwG2tdcdGPI+DHloJm3aDARsk9w48+C24t
 a3z+EIMXYzxWju6KqxEftlkilAX/g9fDiC9DUo4N8qyN2Hng60CWWDY0BN017nwAoBGX
 Tz52apGhOqKIgtrBTlfY9NGfUE3XyaY7SH75Z58mgUc4yASJa7wA1C+Bi1fi/QdnOaqK
 cnag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUreGKBCmTjAHGvAQiYdAO49pOCUTieVpCKAxYOA5wy8CpvJmIhVA8Cs7dQSXlFGdroMdGKLISvGA==@nongnu.org
X-Gm-Message-State: AOJu0YxdmfJrw4EI6bPy1WBxsdoD2cQn0PLoK5uhLgGsaEWnQuvnDKlj
 6wSPrminR0TMMZPRYGZTuOe1KHlZ1BriD7IvhBdxVEe0c1/QmSCd2fRadw==
X-Google-Smtp-Source: AGHT+IFO5jkCvoSHccIrMP4uez9IcyzwXl0bqQttIX9sZ1zgh1eUXXsHI13vTCCdnNqJJDpr9gM9Lg==
X-Received: by 2002:a05:6a21:78d:b0:1d8:aca7:912 with SMTP id
 adf61e73a8af0-1dba5409a21mr15409643637.28.1730679680765; 
 Sun, 03 Nov 2024 16:21:20 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 35/67] target/ppc: use locally stored msr and avoid indirect
 access
Date: Mon,  4 Nov 2024 10:18:24 +1000
Message-ID: <20241104001900.682660-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

hreg_compute_hflags_value already stores msr locally to be used in most
of the logic in the routine however some instances are still using
env->msr which is unnecessary. Use locally stored value as available.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 02076e96fb..fe543ab3b8 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -143,10 +143,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
 
     if (ppc_flags & POWERPC_FLAG_DE) {
         target_ulong dbcr0 = env->spr[SPR_BOOKE_DBCR0];
-        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(env->msr, MSR, DE)) {
+        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(msr, MSR, DE)) {
             hflags |= 1 << HFLAGS_SE;
         }
-        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(env->msr, MSR, DE)) {
+        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(msr, MSR, DE)) {
             hflags |= 1 << HFLAGS_BE;
         }
     } else {
-- 
2.45.2


