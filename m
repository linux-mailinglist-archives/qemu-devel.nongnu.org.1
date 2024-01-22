Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F8C836B03
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:38:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxHr-0004At-Lr; Mon, 22 Jan 2024 11:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHS-00046D-Dv
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHQ-0001hF-6u
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:14 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so3883380f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705941369; x=1706546169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bjp0S/N+NhO4FsZAdOW5c5zn70Yf5efsmf1R/p4lRgM=;
 b=iezkToXIyht7uL3NZRR9P7fOf3V7OLd6P0neyxh3rS5BrwM9VTeNi1K5jbA/dYqCDP
 I5WEuZlibOGkkSELWRdcJFJI8onwYQhSUr1/d45MMQimGJaxupEHJtNjUzhTsCvW7+m4
 sSwE/9pPS+Ar1wtePllyFtxqaOOrz9Upk/ndcN5YZrDz2PMmtXH/ByOaSPrsUsp9yRH3
 fpgK9Y5IJiC8rkXqybKw5AGmpO9i5XME55aG+1fbGyCnHpI7rwYh+gG7KMyUc9C7QcYC
 5/oJQGV0pWLyTKRb9raOafQwJnOBfxGJNYPthxs4rPHt/sS1/7nXNUi2tUASutZF6w1e
 17Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705941369; x=1706546169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjp0S/N+NhO4FsZAdOW5c5zn70Yf5efsmf1R/p4lRgM=;
 b=pRmsAWOJMKvS0ksFvKJOF2/WP7Y1fWfuJHIqU7MMglQzFxjE9XWOyUyik/7CsaYeVr
 HkWyFYfBbaQ8xkuHcOB/YJ6K3+4YWu55z7Ref/kDlI1+ICGuMtHlKLp1nlXIVZLdS+Bq
 yK18iARDLHFXzAN/VG8rOO/fI7TEQsni3y/1CD6E58UTRdds020csxMf9+rMm8hPveuF
 gxn/6y+P+NxQiztIc9PLSdyh8p3DtXOg25+dICh2cDEvO9n01PCh0QgMRVyjycrUeE3H
 r7nbsbOyD8XBUDjVInDdNUKx2W6Xc7xMrfgPaN0Zl2Hn0m9dHG0LKfC2NM0N8Zi2osD4
 ufzA==
X-Gm-Message-State: AOJu0Yw9sQw6HZS1nOdw80GBvwhK8u8aHkSyV74w7ZOTPc1VgTA9BRUH
 n3/stO8ZhBWzDKHuLznuFH+kP6a2fBwMF0kuMb7w1gdYVumnd4hdjZ39KuyCRWdhooBxESnetdX
 Q
X-Google-Smtp-Source: AGHT+IG3ALe3GgBcgewCv8XdsL/OwVNbgUBVONq0caXN+GUAyKsCGy6+pGNF6h3ymPcQyyCuPPwxjQ==
X-Received: by 2002:a05:6000:1e81:b0:337:c260:9e6e with SMTP id
 dd1-20020a0560001e8100b00337c2609e6emr2883465wrb.16.1705941369156; 
 Mon, 22 Jan 2024 08:36:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a5d530f000000b003391720fa51sm9188728wrv.60.2024.01.22.08.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:36:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] system: Fix handling of '-serial none -serial something'
Date: Mon, 22 Jan 2024 16:36:05 +0000
Message-Id: <20240122163607.459769-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

(This patchset fixes a bug reported by Bohdan Kostiv at
https://lore.kernel.org/qemu-devel/CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com/
 -- my patch 1 avoids a bug in his suggested change, and
patch 2 is new, improving the documentation.)

Currently if the user passes multiple -serial options on the command
line, we mostly treat those as applying to the different serial
devices in order, so that for example
 -serial stdio -serial file:filename
will connect the first serial port to stdio and the second to the
named file.

The exception to this is the '-serial none' serial device type.  This
means "don't allocate this serial device", but a bug means that
following -serial options are not correctly handled, so that
 -serial none -serial stdio
has the unexpected effect that stdio is connected to the first serial
port, not the second.

This is a very long-standing bug that dates back at least as far as
commit 998bbd74b9d81 from 2009.
        
It's possible that some users have commandlines that mistakenly
include a previously-redundant '-serial none'; those users can
simply delete that option in order to produce a command line that
has the same effect on both old and new QEMU. We can mention this
in the release notes.

Our documentation for -serial none and -serial null was also a
bit lacking; I've provided a patch here which tries to improve it.

thanks
-- PMM

Peter Maydell (2):
  system/vl.c: Fix handling of '-serial none -serial something'
  qemu-options.hx: Improve -serial option documentation

 system/vl.c     | 22 +++++++++++++---------
 qemu-options.hx | 14 +++++++++++---
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.34.1

