Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C0735974
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnI-0004Dw-MF; Mon, 19 Jun 2023 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnA-0004C1-B1
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFn8-0000iQ-M9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9b4a71623so3162265e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184616; x=1689776616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zU9ou4hqLV5xqA32w7uJfBC6kax4N0nvvEuBAns+Vl8=;
 b=wRFJbPt6G5GRAdCmwdWu/VFPJJPBdMZ+0DzX0iN6lA8swwgCjGqEXc/plhNjY/+34t
 i0E47Yj3i65JFppyoLs5IIOLTyYWcr1NQb7xSSeXSTWbgi/NbXHc7ZgkyES6T5gstBMS
 cmI7NO84fZjK/kIRO6pbIKp9tNRx6G4G7TENAtWdEkFcbewmjjLUwRk/7544DH1ypAek
 8D5nGfiHPgCc58ivtiq/wpowVeU/MOZqH5PqWKSqzT29h0mD+1W9QEjOe6zTwfHnR9/C
 eIrPwAKfTCBoksL4qjAjpZZILVCj44xsaqJmAFrE+pggwHyOxUSSFOZsc3bstBObUVgr
 Qo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184616; x=1689776616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zU9ou4hqLV5xqA32w7uJfBC6kax4N0nvvEuBAns+Vl8=;
 b=gaKMpgR469iXKEfdE3hEMBUCIuhG9GDHxXAgMKBpc2QXe7nnqr/a+4jgl44c4LPKou
 tbUpda9ExGGzcGsnSMONbl7S3BpxGix+dJVGUscmSuLGJabYiV573aazZoBzbROik15q
 hOyz6zBxbxiczyUtiMOQosZ1tznikCfUs8cGu6Nc7q89+9PLu+vjQ/1felLHcp6SOzsY
 +EOm4QPS+66EfE/a0QsuSt+DESl2C30/fj92QcoAo684/HfBCz8ZU0RX6ELkbPSyUANH
 qDHfJNyPxClmdR+udrIZzpyuKhvKf6CHwE5lfprnZeVCiSEe8Dfu4mN3PgXl6JE9jNkj
 4x3w==
X-Gm-Message-State: AC+VfDxVlO6N2r7t/TIWcfbuIiiAbxurNGuCyEcKzh7uBGsnTnw2//8O
 fCMgdmcoUEuVo+tOjUklxmnAqxA7P/WKfhJ7staTGB+F
X-Google-Smtp-Source: ACHHUZ7e7/EPpVDDs049uKhnUkWANJ/IAK1tMPuCBjXjEOm5Us/je82mRmTUrC6NRLXAtYOzht/J1Q==
X-Received: by 2002:a1c:f718:0:b0:3f5:1728:bde9 with SMTP id
 v24-20020a1cf718000000b003f51728bde9mr6822856wmh.2.1687184616662; 
 Mon, 19 Jun 2023 07:23:36 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] tcg: Issue memory barriers for guest memory model
Date: Mon, 19 Jun 2023 16:23:28 +0200
Message-Id: <20230619142333.429028-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

v1: https://lore.kernel.org/qemu-devel/20210316220735.2048137-1-richard.henderson@linaro.org/
v2: https://lore.kernel.org/qemu-devel/20230306015710.1868853-1-richard.henderson@linaro.org/

Changes for v3:
  * Update for tcg-built-once.
  * Require TCG_GUEST_DEFAULT_MO if TARGET_SUPPORTS_MTTCG.


r~


Richard Henderson (5):
  target/microblaze: Define TCG_GUEST_DEFAULT_MO
  tcg: Do not elide memory barriers for !CF_PARALLEL in system mode
  tcg: Elide memory barriers implied by the host memory model
  tcg: Add host memory barriers to cpu_ldst.h interfaces
  accel/tcg: Remove check_tcg_memory_orders_compatible

 accel/tcg/internal.h    | 34 ++++++++++++++++++++++++++++++++++
 target/microblaze/cpu.h |  3 +++
 accel/tcg/cputlb.c      | 10 ++++++++++
 accel/tcg/tcg-all.c     | 39 ++++++++++-----------------------------
 accel/tcg/user-exec.c   | 10 ++++++++++
 tcg/tcg-op.c            | 20 ++++++++++++++++++--
 6 files changed, 85 insertions(+), 31 deletions(-)

-- 
2.34.1


