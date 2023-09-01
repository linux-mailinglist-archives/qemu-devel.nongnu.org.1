Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FBE78F722
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtox-0006SN-EP; Thu, 31 Aug 2023 22:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtov-0006Rx-PN
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtot-0001Nr-Hk
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1137382a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535014; x=1694139814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig/BU1p5rBUclrU24B2APEaCZb1m4+3FwcOcSczB0lA=;
 b=FVqRnsBdrlE+cAAcEvzLGzyK4LxUVuWmMOdMYtbN93MN/G4Tsa/PI6vD9gH4RN1sUR
 l9e4PKEvaZUxer8jup9ESG4+5zX1lvEXqoAzKmiCz5+TUPeF31uQaA44aVK0ZaFSTo6k
 CjFJo1RDYTbHiqHbhpeJxe5YlmXNbnkxMujq/OgWwOJBJMvA8y4tSz6UBc4WdZZlHkmq
 iCozjbD8j2Ti5Wvz2d7ez7neYcIk9vLALYbFRGcvssKGoaLiptE7dlSst+dIvpAcdlLU
 FrgRkcwuc8M+qxMgu9I4jjYupzf0jPcVkq4vFOEKtiqXkKH0+4Ct0GXqqfuUe7JC2U/H
 e0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535014; x=1694139814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ig/BU1p5rBUclrU24B2APEaCZb1m4+3FwcOcSczB0lA=;
 b=WVb4DWX9dRPgxmLBoYpeFvcRpcVGUHvKtm2CBdh1gQRMszUEzLl4q4JUSg2MCzN389
 B2MQ4sCqSZ5un85bk8WAHU7+bIsBDa9TKsrk+po8d0Z8qFXqH4hzQN42zp521iy46Rxm
 rZA+Kl/Ijy+nT9fM+zCo5uZ3hukZrNSMz3Zg1MRzmTM47jXd175WT9fqm4d7XnRqiTH7
 Xx5ky2Yl8SM20rzWkdczDs8QeHh5jR1GmclSIPWzmqxuB9JQkYx+cBBF/9t/GvnzoZ+m
 UYThwXj7OuPyLtsuPh8Y55FbtUer73H2PROJE+CDbv99d/nRrlp/EMq6vyxldOncd1W/
 Kx7g==
X-Gm-Message-State: AOJu0YwDQ1mERFPm/vRd98gAw+3Z7sdNtgYEm0yraMpYL0ih8HbsujwO
 LuFA9pDLhtbtwAFzRwq5m3+7ZsUYsFyPXxaorxM=
X-Google-Smtp-Source: AGHT+IFaLzWmRWv7Om/dKuPxqaoSASrJBQ+Zkr4UjPiuBx7H/7c1VaKRHifuyB3UBKwZdW1JHt2geQ==
X-Received: by 2002:a05:6a20:440f:b0:132:79da:385a with SMTP id
 ce15-20020a056a20440f00b0013279da385amr1995020pzb.23.1693535014208; 
 Thu, 31 Aug 2023 19:23:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 02/33] linux-user: Adjust SVr4 NULL page mapping
Date: Thu, 31 Aug 2023 19:23:00 -0700
Message-Id: <20230901022331.115247-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 19503d8469..803281a53a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3730,8 +3730,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


