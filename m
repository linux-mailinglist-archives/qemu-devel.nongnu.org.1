Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB77371F1
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBePS-0003bc-IK; Tue, 20 Jun 2023 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePQ-0003b5-3C
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:48 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBePO-0002Em-3k
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:40:47 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9786fc23505so600496766b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279243; x=1689871243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nrgBr8VT0PXLnSa9zJ03BPSllWsbIS/GvRhvSOUaymc=;
 b=TXcY9ztiOfP7W+jqfId1xJj+SfZAdquAcaSS/8Vfw/8HhzvVLT6MKeWnLPkXy+4/74
 AUbkiHVL78t4s64OS/knHIfu+NUcJ1UOQVaUGZM7EGOhv+FrTC6NjGPvUaJ+iVQt8LEm
 v+ZpdrWI1zDHxIZpgKYgb7Kl2V9qHzrrhKOsSWHxN3TFDXIk+urrSw+Wvi6cVLvTuhuF
 YhAe8d7E2tgi4v9VAGxuRQxE1ruIGPmZYm+2lwZBihVFPqUImqv6aSdKgOKCC43blc72
 OtJY5rpY7JfL6rPXOgMJivu98HWHx7defrLBJqVlUrmpNxbQ6MpMVKm6+saIA14dV+vX
 ad2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279243; x=1689871243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrgBr8VT0PXLnSa9zJ03BPSllWsbIS/GvRhvSOUaymc=;
 b=hBMY33pTGItQxIbRaZi9P3WtocqZyat+vfMX1DOY0D6damVVsK2vBRvZ3hDpLCxc2M
 +WIjE4FuqjCmNHe8fKhjLKUs+rYqF1Z48p6WFV5Z9oYaeyBgsqdqs3aK5hQK7IogfCGw
 9e8gDboMIzqajzIQQFjn1Fhd/2zbb/mcfNFZP1d2mqH9swojBlJehPfBUm8ilqCQt2no
 aP/nB7JdVG98wQBOkMYFuAC4HpyswJicCYzukN7HJDmWt0B0wJOFrrMTcn14jBYxkf/u
 7Z7jjm5X1ju+9kWAC+E12NwNOsu19W1ZUe4DHhjgjG9mLAFdQRCrlX+3+FmenxCdfOnr
 5WyQ==
X-Gm-Message-State: AC+VfDzhDdbMmQAYn4vfK94/Y1UQRThlXX5fDZyaw49WNg/vlErNPJys
 GMO6qB1B8t8YUMncpdEKYn8RBQ6FmgDKQM4X0wmFl0y6
X-Google-Smtp-Source: ACHHUZ4bnn4h821Z84+z0o5Paesv2nY7am4PGQDbJJL/9GrDALhpc7fx82Tyw1jGVVMvTirvF1iNPQ==
X-Received: by 2002:a17:906:7945:b0:982:781e:ba13 with SMTP id
 l5-20020a170906794500b00982781eba13mr12353549ejo.39.1687279242738; 
 Tue, 20 Jun 2023 09:40:42 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm1685589ejb.126.2023.06.20.09.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 09:40:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 0/2] target/sparc: Enable MTTCG
Date: Tue, 20 Jun 2023 18:40:38 +0200
Message-Id: <20230620164040.912490-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

With the addition of TCG_GUEST_DEFAULT_MO, there's nothing in
the cpu emulation preventing this from working.  There is some
board model work to be done for sparc64, where max_cpus = 1.


r~


Richard Henderson (2):
  target/sparc: Set TCG_GUEST_DEFAULT_MO
  configs: Enable MTTCG for sparc, sparc64

 configs/targets/sparc-softmmu.mak   |  1 +
 configs/targets/sparc64-softmmu.mak |  1 +
 target/sparc/cpu.h                  | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

-- 
2.34.1


