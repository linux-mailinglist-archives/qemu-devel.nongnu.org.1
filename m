Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D97253A9
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 07:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6m0d-0003pl-Vg; Wed, 07 Jun 2023 01:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m0Y-0003p4-T1
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:46:59 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m0W-0006Pi-QN
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:46:58 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-565eb83efe4so90368167b3.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686116815; x=1688708815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8cK9rNQgc0oxJ8PxsSPf+eFLNBo2sfJgQlOnfioPI4Y=;
 b=JqPLIQdMrP5X4bDlSZwNYntk4NJvDkEe1LveESHJS1uNjhiHgEvSRdNtTrONkclVku
 T07lJGqD2piJfG3uZE4Nzq6lsD+6OrQJUu/oztLcEV89eGjL1eDi9PQAqGyjpnwUikGj
 rczq7io9fSnfzjHGtNzdvrDfo9uPUx4Bf8tJ6Rc8kkN295BTEZJqtoQjMKV8hr6MS+TD
 5IaMJPmHFVV5A8nwwytfJuUKaxpZ38ZocL0v1CSPFfZx/g+StLza0MPJKGUpHdxnq72p
 CX2iGEgmKXHqkqqytEm9k9C3xF1pCz2SWz9S6C9cdSGU5xAMYNfCJW/WeTzDEkjTULc6
 6kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686116815; x=1688708815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cK9rNQgc0oxJ8PxsSPf+eFLNBo2sfJgQlOnfioPI4Y=;
 b=R8cFTFOkPgFPOSIu/yHv6QAOgo/he0HxZ/DFdy8za7U8CbghzAfj+DzfoalAXZHq2O
 98q5ZUevwTJa2jjVWhLG0Susv3ARzAvFQ1b4flWYxETB5pIq8urr92ZIesrohdFHNBQi
 SdYD2pVCfv1gmhk3Gl65XimEmQqB9PxoHqJCZAKymPQ9YWdQZeNcaM9B/Hs5H4XgDlot
 PfNc6z6AP+dpmoDtTciYJGqlIBxs94PUoREx5pLxDyv7/raPBKVRajSS38wSNRA+AP7I
 5SrfVNDUb0QSyweGw7TIktUKL17JIYv4cqdPSppHLdYk/+1esY7oiYXffISCxQwKT/yl
 YWzw==
X-Gm-Message-State: AC+VfDxiwNnCOPRcOkDRmq+FtWUFS1CCtxG/5r4ZGccHP0k7YIQMfrAI
 K1IPWgqkUQ/L5VfYkS/8KVmLn25u6vcPsYXPgYk=
X-Google-Smtp-Source: ACHHUZ4hAFm+OnfbYhhHNzNjFijuPzKB9pUFMIesM6yxwU5Ho68TCaY9kUvEEyId1yjV5+j25t6oyQ==
X-Received: by 2002:a0d:d941:0:b0:565:bf0d:e27a with SMTP id
 b62-20020a0dd941000000b00565bf0de27amr5957138ywe.15.1686116815649; 
 Tue, 06 Jun 2023 22:46:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 fe16-20020a056a002f1000b0064d48d98260sm7640310pfb.156.2023.06.06.22.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 22:46:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de
Subject: [PATCH 0/2] tcg/tci: Two regression fixes
Date: Tue,  6 Jun 2023 22:46:52 -0700
Message-Id: <20230607054654.622010-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

Two recent regressions, both related to recent tcg changes.

Our CI does not test TCI with --enable-debug-tcg, which given timeout
constraints is probably correct, but in this case resulted in an
infinite loop on aarch64 multiarch/memory.c with FEAT_LSE2 enabled.

r~

Richard Henderson (2):
  tcg/tci: Adjust passing of MemOpIdx
  tcg/tci: Adjust call-clobbered regs for int128_t

 tcg/tci.c                | 30 +++++++++++++-----------------
 tcg/tci/tcg-target.c.inc | 30 +++++++++---------------------
 2 files changed, 22 insertions(+), 38 deletions(-)

-- 
2.34.1


