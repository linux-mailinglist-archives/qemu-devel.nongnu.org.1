Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77487E1ADA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztgA-0006nf-46; Mon, 06 Nov 2023 02:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-00018e-C1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020I-N3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so3052138b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254136; x=1699858936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCH7H3uv1j+F9POX07D6yayi/ajggVOOyJwLNgcSu1o=;
 b=nSKF6mB7hcbmCcvkTZorGn96LVg9ke2nna/OswB9NIR1Vp0FpD4hh1Mp/a9S/IqMqE
 edVLCjV7CX3xn0Z3+Hrpr3jEOaDkwc92rx6tDdTp+N+ui3kC1V+Y0+okoh+WZUBl4e5V
 3HcZwtREVVq8aAUNYgCkltD/Q03VmaIpXFbYKJeHvetMVdii4D8+2f97OySf0ww3zBEh
 z/Et0ZLsxPfCw8fc0TKRnAL/h5xdzqTMWp5piwUPDGtOwToajgA9/ZHFXyaJT81nmoze
 KuJRIkSJexqfmJC9JDHbZGjM0tDj55sXBWCmJobQ41ah/+wVUp+vgelKNfdYBJlnfJ2C
 3z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254136; x=1699858936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCH7H3uv1j+F9POX07D6yayi/ajggVOOyJwLNgcSu1o=;
 b=luuQixE11WqiTRoa7WqCNTRiw5pDRimKR05DhyxnxnwvftjMc2cJ7iuqPusuxNCkA8
 3c49P/aSfAJN7t/YpOMpkx8xrH/foUzuDKGnYvGIpt27dm2v0bq110iZhAZ99s4ep6R1
 JYi6AXF8i34obwxf8M44onwslBTHMDX0Ui+hc31n0fDMvqT/1ixrje9lc3hHojUN2b6k
 4UaOp850LQ1lUPuE+WErV8Czt7jxLE6He7fvnwMGdIGdw+IQY4lwfexCntHYl6NbFhQc
 LVPcqsPR/WN0NZTvcRwvvJ81b6qHeszaBCqRyOZTIEtISXYSvL6Nz9E1jOipcSmapR1F
 QYQQ==
X-Gm-Message-State: AOJu0Yz8Y79Ep4vrf4mnaUtTOz2vp+q25f5HcAftI0kx1Qjgb88I4TZI
 Dw/q6fHvczqCd2Y3ZKaNAMFX3JfReLj/0Gy60jw=
X-Google-Smtp-Source: AGHT+IGllJ+zND0+rOmqjnw4iooHOqjlIh9URdvLqddlrZzzea9b/rVKvArQjaScGSXfO8VccYCLDg==
X-Received: by 2002:a05:6a20:918d:b0:17a:eddb:ac65 with SMTP id
 v13-20020a056a20918d00b0017aeddbac65mr27380613pzd.9.1699254136039; 
 Sun, 05 Nov 2023 23:02:16 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 54/71] hw/sparc: Constify VMState
Date: Sun,  5 Nov 2023 22:58:10 -0800
Message-Id: <20231106065827.543129-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index eb40f9377c..06703b1d96 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -331,7 +331,7 @@ static const VMStateDescription vmstate_iommu = {
     .name = "iommu",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IOMMUState, IOMMU_NREGS),
         VMSTATE_UINT64(iostart, IOMMUState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


