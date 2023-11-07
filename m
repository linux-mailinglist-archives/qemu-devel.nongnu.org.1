Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8637E334F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9A-0008FL-Pd; Mon, 06 Nov 2023 21:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C96-0008B2-Dv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:52 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C94-0005qR-VR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:52 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c33ab26dddso3701205b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325329; x=1699930129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rcy6tJPZhV/oL1h74tlFxUFs2PlGqEM/vFlNrg2lUyY=;
 b=fZfQSfZu0EWRt9boml5U2qnQAlOQunb0aclszvCLDlihFsFuq2TUY3xbxAqlvQn+Gb
 4IzbudUGiLHL8LnvCyWQfzVV8SgrtOReKsFuDRVvVlXWEpmutjisTLBe/SPWxBcz4Uk0
 Cz/OXhjn/t2SIZebYJBOteOgufnEdKKXpoOFlO7Oq0LYiJJbmbrMO62q0+fTX0usXTOy
 OMInYQhyn37X1yMr3UKMqcbj+YHXBVPq8P63xKlij/by8FLl9ZZMHG8t0Zzsq14n+d6B
 6IqUWvwslE6UC+MA9PAPg5SNIb/6EzNqowfuwYKs4TOUaN8scs0/ot9xXpPY3bwHRzg2
 qyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325329; x=1699930129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rcy6tJPZhV/oL1h74tlFxUFs2PlGqEM/vFlNrg2lUyY=;
 b=WU2HWaz+B/ZsusucCWt9aRKAqj03+kgyYX3tXLe4F+jKVUbEgUp0KqWR5GKapGe5Ki
 t4rUlEyVEd15/LestqbMnsQyXrYC0Z6MkK/aCTBUaMWWXU9ApjtvUMA6HzPUiC0I6cqQ
 vzjTBQ2Dx6H4qFiQowd4BvW04g1DR9yI64eOgF5bbpmUqson8SkaRAJW9dVnu1qVwBUs
 tT+65pjM6GaVv+I9BBukei6YG1giNDi9FUSTMYcqM+5xQ42/zIhXx6V/4x0h8f20ruJ+
 m62c/g65N9vaGMYHQh16wwfd31x5J7+XMLJRPOFUD1hmGggnuTArkKgGsx228w4s3fXc
 W3dg==
X-Gm-Message-State: AOJu0YzIjH2wUvBVRKz2ZBsFLFdC8sSHM/O2OGdZ3pjHenvOv5QKxWxc
 +2Wmz+9kIYR22MRHK+cJEBukAmPudGUTvGbUdOw=
X-Google-Smtp-Source: AGHT+IEBmop1PcSwZkQ5Lfd2+15VGdxPU/Lm4pDRE8Da1u22g4kj0ThaOmZH8g0P4S4RpqonvbCEgw==
X-Received: by 2002:a05:6a00:280a:b0:6c2:cf23:3e2a with SMTP id
 bl10-20020a056a00280a00b006c2cf233e2amr12993220pfb.9.1699325329392; 
 Mon, 06 Nov 2023 18:48:49 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/35] accel/tcg: Remove redundant case in store_atom_16
Date: Mon,  6 Nov 2023 18:48:14 -0800
Message-Id: <20231107024842.7650-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

We handled the HAVE_ATOMIC128_RW case with atomic16_set at the top of
the function; the only thing left for a host without that support is
to fall through to cpu_loop_exit_atomic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230916220151.526140-7-richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1cf5b92166..e8f97506fa 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -1103,10 +1103,6 @@ static void store_atom_16(CPUState *cpu, uintptr_t ra,
         }
         break;
     case MO_128:
-        if (HAVE_ATOMIC128_RW) {
-            atomic16_set(pv, val);
-            return;
-        }
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


