Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4137B7161E0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOk-000192-0K; Tue, 30 May 2023 09:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hh-AS
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMr-0001QF-C2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so30781065e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453188; x=1688045188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wHGJTqnWnJZeP8ddXaC5XrHOdzJhFhTnUrSm1b3ujFA=;
 b=hrrlmmutANBkVOrC18nFaM1oCZ7ykvTYKLmU/o1OSch8cZJNM+dVCrQxsQ1DdsaNm6
 Y3GqfW5CsuRfootSNndjF6I1vYWGG9Oo3GU6DWLm/tZdeBpWE7000O7k1LWM+zZ9AeWj
 5B02W8KvMLWvpKGOlcuE3Ad7HDcxIEG3EZRClQlbjdsWCEA74HPoP7sSAe9LaGVAZ5Zk
 r3oLkGkhQOaoKRgG2ggR8J6NpfA/pjvAgcTb5oIUUA1Ppw/zttVl+V2KnmBSsGRy8CD1
 qAD2dUELW5GjEO5+JVtJOFoCa9H8Ez8Lw2v+IVUG0DeZgIHfqERCWUJr0rF1iIoALbzZ
 iRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453188; x=1688045188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHGJTqnWnJZeP8ddXaC5XrHOdzJhFhTnUrSm1b3ujFA=;
 b=SQzcd8Q0jSrTISc2z7gzweqpHxW3+7VHldhiwtGNCu4///JV3iYO8SyxUftNAVO06g
 I+CoBTgD7OblcLptXPWXT2pI/2A9NXYevgx2o/qBHyUR+T0r6MQPsF74HnogGoGqvaov
 oIJq7LNhsltXGnAzawXWqT0WsqzbVM0eWZ0NSc/UIEYQgxcPBxDSEqS6yd5aKDdKmc74
 1XG96ZtRtNZhrRd5ln9Iaspy6O3/Rv4VVeAnPFvtkM7Dwwu+UGRoFIQrbugBeBDJNDbp
 90DCS1/9lWY84CbzLWn6KhCF45CkFIgMOkWXvcGGJbKj3m+LBjgoDpKgppCk8j/aSehU
 qKNA==
X-Gm-Message-State: AC+VfDzU6UKmn16RVUEf5qF71iRr4IsteOqqZEX8emADfrPZi5shIBqI
 GZp9nhpG7EyHyuMO1UbwBVSJ8mA7Eox1vBt3bxg=
X-Google-Smtp-Source: ACHHUZ7KFoBvatXl25CnbBc2MnP3Xv0Cs0GRFhGpoBByf6cixlf48o+F1AeCtCO12qrVg6wenlFdrg==
X-Received: by 2002:a05:600c:2296:b0:3f4:bb58:d174 with SMTP id
 22-20020a05600c229600b003f4bb58d174mr1695974wmf.22.1685453187903; 
 Tue, 30 May 2023 06:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] hw/arm/xlnx-zynqmp: fix unsigned error when checking the
 RPUs number
Date: Tue, 30 May 2023 14:26:12 +0100
Message-Id: <20230530132620.1583658-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Clément Chigot <chigot@adacore.com>

When passing --smp with a number lower than XLNX_ZYNQMP_NUM_APU_CPUS,
the expression (ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS) will result
in a positive number as ms->smp.cpus is a unsigned int.
This will raise the following error afterwards, as Qemu will try to
instantiate some additional RPUs.
  | $ qemu-system-aarch64 --smp 1 -M xlnx-zcu102
  | **
  | ERROR:../src/tcg/tcg.c:777:tcg_register_thread:
  |   assertion failed: (n < tcg_max_ctxs)

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20230524143714.565792-1-chigot@adacore.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 335cfc417d7..5905a330151 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -213,7 +213,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
     int i;
-    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
                        XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     if (num_rpus <= 0) {
-- 
2.34.1


