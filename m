Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B6744222
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFImS-0004eW-2o; Fri, 30 Jun 2023 14:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImQ-0004dY-Aj
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:38 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImN-0001fx-D3
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:38 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so2599213f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay2STL3w3t73igsB7L/HM+7h1jtUCGIXFOIRbzQEacg=;
 b=jxYXEAWM5fsjiwKZfee8MetTUA9eXz6nKU1Ol41fy6BqsmPOsg4u1fS7cvBG+CqfDi
 UFSeLAlYxjjd1lukeLo/oVf2Bo4ayxc6qq2LL1yMnTzOJDKbyEpGdHpd2Vs9LGDN9nFo
 YZtXylLYvo1u7OQqbltk772UI0lBF2CA2mY42nkGEcUzXIkK1SKSA1ugAkoFNJo97Bm4
 YabmDgN1DjNaMNUsKqJirm8U0hve6az432WjtNwF8/tnALYvOx+2TJRcxWhVkO9cqVEA
 A8tGENOnyqZOp9Ib8VSOU9qyvxmFLA+6vTlDH7SKDiIbxACJDlfsexrT0khMfj/9Q5/O
 etYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ay2STL3w3t73igsB7L/HM+7h1jtUCGIXFOIRbzQEacg=;
 b=XeDifliTX5PL/auv0sghLqY+LS7QMGNAxjVJYQYEGglIvTAHkXelt7vpjxRD0MHjvx
 nfr3h01GnKBZlRYFKu3/8kQ941GiTf+9U+f6EW/3YFKIRFpztMnI2ccTFrD/g64FQd/8
 PsdMMcHlPqJNWBcUr0D8KOk/6qjHYlINOCcmcGV9SoRnoaT2oiXCQzdKorX5eg7Xt3a4
 oV8kPhnC/44s0zw9lDo9S9d3nfZzuvTg1XbjbHx+6+VAaj7aXohMzMWEUX7i5ZkQQx+w
 uhYxuvbQ2iaZEqofalTiEv29zutIxz5Nt7DmEQyzFbr39ZUtfb54S5ujTfSn+2JD3L2l
 wPbA==
X-Gm-Message-State: ABy/qLYH+B2hwE9omQ2k5RbZkQj8AjjLgbGTRn7min76LRwo2jBBWVJf
 YcVlYQUzXiV9ku9t32M6C/K0PQ==
X-Google-Smtp-Source: APBJJlEHEMVokSgMENYvgkK902y9Xp7BM76tCo5FE1g7EEd+iLoKuxJLkWG/xbbQSFLS2BnNv0Opzw==
X-Received: by 2002:adf:f992:0:b0:314:1e87:f5d3 with SMTP id
 f18-20020adff992000000b003141e87f5d3mr4250739wrr.29.1688149408331; 
 Fri, 30 Jun 2023 11:23:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m9-20020adff389000000b00313f551b032sm13070406wro.53.2023.06.30.11.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:23:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB88E1FFCA;
 Fri, 30 Jun 2023 19:04:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 18/38] target/arm: make arm_casq_ptw CONFIG_TCG only
Date: Fri, 30 Jun 2023 19:04:03 +0100
Message-Id: <20230630180423.558337-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
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

The ptw code is accessed by non-TCG code (specifically arm_pamax and
arm_cpu_get_phys_page_attrs_debug) but most of it is really only for
TCG emulation. Seeing as we already assert for a non TARGET_AARCH64
build lets extend the test rather than further messing with the ifdef
ladder.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - tweak comment to rth's suggestion
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6015121b99..42355caa9b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -628,7 +628,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#ifdef TARGET_AARCH64
+#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -709,7 +709,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS. */
+    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
     g_assert_not_reached();
 #endif
 }
-- 
2.39.2


