Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC062784FEA
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEC-0004uS-Jv; Wed, 23 Aug 2023 01:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEB-0004sf-1B
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgE8-0000s4-2q
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so41570825ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767778; x=1693372578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cwesx2AGuzSdw/4/lmiPtTHlqGFUWBv1rm59eZTCzX8=;
 b=bROPTNK13I+Gt/K3zvGSypcXQKR49WTNo1cP8pl1urExo2JAthCjoSEH9mmUQzzSNh
 BpBa8LBTyMsowKBdD0kgvaQj3gxE9Z9xc51+Xg7RZws0a257uJfzQMNl25Tj4YpB5TPN
 phiZ9X80ccJVsuy5HtdTHR050toT02Dboq7Htf31oA5v2Y8yAj4vsSiRDknpvR+b7NPO
 c5o8eX3zw0jLFj9MH+KmOQUBJxPKamvLQWjPAYDB8x9a8oK8NdMwmLKDPWhW+Z2zRwWF
 9ZDFmsfc+CXlfcUnzHYRf9VdJqJCM8IRTty4AhneDubVQgriEmZh+RohsBUyxUdISlBR
 EnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767778; x=1693372578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cwesx2AGuzSdw/4/lmiPtTHlqGFUWBv1rm59eZTCzX8=;
 b=Z2T2aIf6MFLQcEQDBGorBQM8Oj5RSWe24R9QuehAjQPZIRFYbBfq4q91xCFScUibde
 4npX3PGZdd+8141sk3QqHSkJFwy+7Xk/fs5ozFdWxPVF+0lqTjCRLtrBh9iPqHlFl3Dt
 W/D1nQ6JzTnUfOaiiq1u5NgH26vgKlqR601QCTWIrA06WJ9o7NZJI79eAyxSUYbDVDzx
 fepZLZWxEPT0cZVjhuaaA6AJ+sbKoLi/cQ1tEVoc1XqPbCGER/NqPBkZbC+3liKaCmQg
 ZgOS02vGORupZpH7jvdfySavxI2Zxu91CPHw9lYL/UzQI2k34FYc48+ITkLDldL/Um3V
 LFBA==
X-Gm-Message-State: AOJu0Yyt0C8G+VSBRrDPvXHZMRm4BRQy636n3p9F9OuSSfnyXmnshEME
 /bC4btnKtZuIc1j4L5rflIS9exy1uW5Q5pq07T8=
X-Google-Smtp-Source: AGHT+IFYbF2NEuWCJg+595NB/Hyp1RHkLUz49q5/i8Db9SpRGV1r19OskWAZpZxTvJz69sVJT8arzA==
X-Received: by 2002:a17:903:447:b0:1b8:971c:b7b7 with SMTP id
 iw7-20020a170903044700b001b8971cb7b7mr11052207plb.56.1692767778249; 
 Tue, 22 Aug 2023 22:16:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 00/10] linux-user: Detect and report host crashes
Date: Tue, 22 Aug 2023 22:16:05 -0700
Message-Id: <20230823051615.1297706-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

More signal cleanups.  Mostly tested by temporarily adding an
abort, divide by zero, undefined instruction, null dereference,
within the implementation of a guest syscall to induce an error.


r~


Helge Deller (1):
  linux-user: Detect and report host crashes

Richard Henderson (9):
  linux-user: Split out die_with_signal
  linux-user: Exit not abort in die_with_backtrace
  linux-user: Use die_with_signal with abort
  linux-user: Only register handlers for core_dump_signal by default
  linux-user: Map unsupported signals to an out-of-bounds value
  linux-user: Remap SIGPROF when CONFIG_GPROF
  linux-user: Simplify signal_init
  linux-user: Split out host_sig{segv,bus}_handler
  linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP

 linux-user/signal.c | 400 ++++++++++++++++++++++++++------------------
 1 file changed, 240 insertions(+), 160 deletions(-)

-- 
2.34.1


