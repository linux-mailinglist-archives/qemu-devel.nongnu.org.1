Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2B74B044
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgt-00026n-DT; Fri, 07 Jul 2023 07:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgr-000252-1Y; Fri, 07 Jul 2023 07:31:57 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgn-0006ZL-GG; Fri, 07 Jul 2023 07:31:56 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b06da65bdbso1655525fac.1; 
 Fri, 07 Jul 2023 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729511; x=1691321511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uviHD+0LDa2GE+uG7Tg16v52aSEimIm9yJJ2mi2M4+0=;
 b=FSB36f3/cMW3c+DpKFaEmu407KXDTA9oYKvCqE4tC1fRZ3RTGQ0+NTfLYjzRJV5NPA
 USH6uLaexsSLS4C0ibbO+4rL94vaH6PP7wUzg/YC6+ZONRZv6c0PqiAwp4/9flcxqAQk
 RPD2qMw53RPpgAk1Qd7OtpIdZ0lgxWz/jK3AKsnNaezih4bqqEOxoixSu3XTeqyDoy1z
 HgCFgo7K2zIAHizJ/fATnzXitppuewIlpadBnUP+BrPSJgll2IyS2M4wlWghGt08YY7e
 3B8uJy4kbk1W9CCU6JdKpXCsG8z71oU0SSaM05kCG2ug0L/pS3lkontEwrMj61hmjnHm
 dGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729511; x=1691321511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uviHD+0LDa2GE+uG7Tg16v52aSEimIm9yJJ2mi2M4+0=;
 b=CcipYH9UbfdQjw70AOTMdePd6WLSw2Hu2Dz36VGIN62mh145rQPeknE/xOsDRwYh4i
 6ndipmlNrSq3EgerOpxG7xTNdiTjTXrz0KASqSiS3A+wUGIilMAemIqjyLUf1T/zyR2N
 NSJ+UztNeEg8YCPQLJUxSpxiGeAqigZl/UJ2EB40vcLB5Q1S9Hh/ZMS9mIHnHYYf6iss
 DVjQyNPnuYFc3nQdXs4U2pfnW7FBZiBjUwAVRsvCMXZTC6X+BUNdUvOecv/ZB3KjPrlo
 k8pjG8RBxFsapdN7n1ppGIOK+D/LEk/RSwKvQG971goFjE4nb78c95Nrt4TH8WJtMkqU
 Kw4A==
X-Gm-Message-State: ABy/qLYKG5w3Qs6sGZMwVEeMInbmnijuAh+TYn02Ql3uBy75U8RstpKW
 syIJ2iZBKRZHPyjhPrzzgynO2ZjbHC8=
X-Google-Smtp-Source: APBJJlHCmid8NfzEv/O5PUAu+adXCtQ/0KnQOOD+VIkRINVk6zW/C0XllXUnKQBD5hx7ndaFst7I0Q==
X-Received: by 2002:a05:6871:60f:b0:1b0:3b98:50e4 with SMTP id
 w15-20020a056871060f00b001b03b9850e4mr5426829oan.58.1688729511114; 
 Fri, 07 Jul 2023 04:31:51 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:50 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 11/60] pnv/xive2: Allow indirect TIMA accesses of all sizes
Date: Fri,  7 Jul 2023 08:30:19 -0300
Message-ID: <20230707113108.7145-12-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2a.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Booting linux on the powernv10 machine logs a few errors like:

Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)

Those errors happen when linux is resetting XIVE. We're trying to
read/write the enablement bit for the hardware context and qemu
doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
access can go through though, as well as indirect TIMA accesses on P9.
So even though there are some restrictions regarding the address/size
combinations for TIMA access, the example above is perfectly valid.

This patch lets indirect TIMA accesses of all sizes go through. The
special operations will be intercepted and the default "raw" handlers
will pick up all other requests and complain about invalid sizes as
appropriate.

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/pnv_xive2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ed438a20ed..e8ab176de6 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1644,11 +1644,11 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
     .write = pnv_xive2_ic_tm_indirect_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
-- 
2.41.0


