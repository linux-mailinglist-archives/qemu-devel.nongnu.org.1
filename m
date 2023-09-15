Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF087A23A7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBkc-0008FM-AB; Fri, 15 Sep 2023 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBka-0008EW-2T
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:33:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBkY-00037H-Jm
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:32:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fc9e0e22eso1938327b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694795577; x=1695400377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roQeQsya1pJNmaqO3L7g1proDq+Pgx0B2L/hs/vf2TU=;
 b=BUb9ga6+9KOd60zUZ3WLPmCp6TwPWnMkhWqdJVtDUiKy526rNvT7NgfLK2Sj/e2CkL
 pkT+hlQx4pw/KCoMB6CbYHU+eYe8JCk81oRpd7W4WLPoAYbzUXsUUcSjGJBiq4ApE8Y/
 /8eklMNysROvzwclCA6Pviq3WC4x/uS0jEV+Z6lEkgf/hvuSrodNsYRD8N5q0xdtl/OD
 WpCKB6UMH6VeLUTxoKBbbQM8FPK7Z66jzETr3jYHnM4Mzvr8LiGXjNlbnBb+6H/o89Do
 hFMmIXCvKrlmrMjIN2XFmhcSYiHHgYay/q4P9RW5SZA8DvTcT47ytFuE9oesaLh/pnmj
 8/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795577; x=1695400377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roQeQsya1pJNmaqO3L7g1proDq+Pgx0B2L/hs/vf2TU=;
 b=UmPB1WHXNiDxuimXwMjuTY3k8uUsE3t5zrcOuvmfJcaJBi1n4sShQT+LIShnHHUqYA
 h4Y3vSzQgnxzGCaolNs91CxtOBoDjHrOf7g6g3HW4mYlREi+Zg3p97i9OKp6sH5YKBbz
 z4LidGEv+xMHO362GK2fY7JMHTh5J8monAp3KmzORxda+gogtD+I9MTkXRSABGTMjl8P
 aca9uIWFZewGqwht4KtypIQtYeRXAnqBXQXtyIIeouqIjegMmf5uxaMSA4woGHwo1L+H
 /FcEk8lNO+MXwO/P0s27PrtByfxNlnH4mPAbv6mrQ8wXUhjxeWTBZK2ffVloZMtY5Lyb
 +scw==
X-Gm-Message-State: AOJu0YzaA+bwbIsGJpEQqfyDcbsfToZ6QPJodylTItMhYOUziSzmfBv5
 Be+6jp528zguPr0msyzpXmTTo3aotIjN5/BTfME=
X-Google-Smtp-Source: AGHT+IGKI0YKamdN3yHj+xj8V0xVFvuA216Tz+cccLsnHVVcUg/eUa/3bhQQGuEiRM/maL3evvmaiQ==
X-Received: by 2002:a05:6a20:12ce:b0:137:2f8c:fab0 with SMTP id
 v14-20020a056a2012ce00b001372f8cfab0mr2706822pzg.49.1694795576927; 
 Fri, 15 Sep 2023 09:32:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm2958497pgc.39.2023.09.15.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:32:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 1/3] softmmu: Use cpu->created in tcg_commit
Date: Fri, 15 Sep 2023 09:32:52 -0700
Message-Id: <20230915163254.123338-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915163254.123338-1-richard.henderson@linaro.org>
References: <20230915163254.123338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Use created not halt_cond to test for cpu created.

Fixes: 0d58c660689f ("softmmu: Use async_run_on_cpu in tcg_commit")
Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..88fafec1da 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2515,9 +2515,9 @@ static void tcg_commit(MemoryListener *listener)
      * the memory data structures.
      *
      * That said, the listener is also called during realize, before
-     * all of the tcg machinery for run-on is initialized: thus halt_cond.
+     * all of the tcg machinery for run-on is initialized: thus created.
      */
-    if (cpu->halt_cond) {
+    if (cpu->created) {
         async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
     } else {
         tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
-- 
2.34.1


