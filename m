Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D4711D8D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2MwX-000263-2W; Thu, 25 May 2023 22:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwV-00025k-MS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:35 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwS-0004sY-3U
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:35 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-25355609a04so419222a91.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685067150; x=1687659150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FNRF6w4CpPg049MveJknZOPdS5hwdTZRumodXS6OWiQ=;
 b=v0RGPHnxX0+wQfu8ORgpo/urgVtn/7tlJbKXg+NFcULekwMoZyA0w+FFFH8d0m9LoE
 4qI9gmp/6nAc6NpcFHARAUnxpewun+B5eqZBvM6REHNtAYJrIblLH4oTZzqgWAHj4Q8N
 drBex+KDMuZmT+6EgTp7GhpHXRmotGrSFSZoHLFoQRrzcsD52zCIE4lsPOYyTAriuYzS
 txe3l3Jf4LJcr6oA0I6YZRMt8sAt7vitiYGVAZWmbVwB8sEIeqlan5Cp1wDjjHAc8j9U
 V3elTbCqBygId2yMFx0tY1iMaM+Z8z5byCNxCOzg+WafnS4yHaxMutjI4Fh2zgM1+Mpr
 QUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685067150; x=1687659150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNRF6w4CpPg049MveJknZOPdS5hwdTZRumodXS6OWiQ=;
 b=fmpSWI6zwzXMaPzYvLmPxN5Ofj63oQ6RX9MRgKC+Sg2LqlO564zCM50Vd2796lGV9o
 rd37fySbUvUPPbaPoh5dbGF8pflpUSBvikV6ApNOrByaqOrgFhQH7nOoFK1QJ/VTOX7V
 FTjOD5GNxlapZHGehAL8WI9ZUCbUQeFFb2+GTZde/a3PQyb5omN2qg2GbVuRcaDBStTe
 IV98sPBF6fXnZOz22wJuYeHw0EZ9zzzrmUQh7uqe/KJcIgmhUj31hHWLrYBuiy8Cdhv4
 VdXunQny7vEmmLVzEKgfxCQSGMYr0KOPMFfSK6KTRwakZYdtSQyQ9e4IsaxOfBgMADBX
 x7bQ==
X-Gm-Message-State: AC+VfDyFthKUpCUN8I0uBuiXMVYZ5mrSnozczYDmtmQ75xiC9sRbhglw
 0BnStoiDQEf3J+MDM5JDHyepE35DXYZccm4YRHM=
X-Google-Smtp-Source: ACHHUZ5OQu2hq9deLFvWgE+z+Kr3pNCpm+DcresZ0Otjpp4bTkpzxUe1BFVkoKMZsKR5Oqrq097csg==
X-Received: by 2002:a17:90a:7f95:b0:255:67e3:98a with SMTP id
 m21-20020a17090a7f9500b0025567e3098amr812136pjl.11.1685067149955; 
 Thu, 25 May 2023 19:12:29 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 oe17-20020a17090b395100b0023a9564763bsm3594086pjb.29.2023.05.25.19.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 19:12:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 0/4] tests/decode: Convert tests to meson
Date: Thu, 25 May 2023 19:12:24 -0700
Message-Id: <20230526021228.1777917-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Add --test-for-error to decodetree.py and convert the tests to meson.
This exposes an exception error that had been hidden by the fact that
the script as a whole did exit with error.  Which proves that this is
a better way to run the tests.


r~


Richard Henderson (4):
  decodetree: Add --test-for-error
  decodetree: Fix recursion in prop_format and build_tree
  decodetree: Diagnose empty pattern group
  tests/decode: Convert tests to meson

 scripts/decodetree.py    | 19 ++++++++++---
 tests/decode/check.sh    | 24 ----------------
 tests/decode/meson.build | 59 ++++++++++++++++++++++++++++++++++++++++
 tests/meson.build        |  5 +---
 4 files changed, 75 insertions(+), 32 deletions(-)
 delete mode 100755 tests/decode/check.sh
 create mode 100644 tests/decode/meson.build

-- 
2.34.1


