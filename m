Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E6779679
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWEx-0006rP-AU; Fri, 11 Aug 2023 13:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEu-0006mL-M0
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEs-0004sl-NH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e587eso21133735e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691776073; x=1692380873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZjqSHq7/cZ8OsQEHGhOPAij5Qo4MVYdiXsrrjnC+xs=;
 b=w35ls+EdmPgGvIip0cTaiXQ9UynsHAHrBCe91OI05JM1YbjcbWBQ8LfODYmJ5hKzwG
 n5NC3+/iFJASEAV1QDyntd5ywzEidfxlhNQb7X+cbLbpcjC+OSOUOMWj2JiXMli4D25X
 qX41y1DT1pJS1dI8i9f7aDMhL2gCDcEfvC2UX0YSIMgJcIyJqrN1ZLfY9L/ZLTTUSJ8L
 X146ZluavpXG9NyI7tEnvMf6ddU7EaVfePjVX3lZ420amt9vNaqhwErLI461ABqGuTQI
 fcgR7jZ30vb7T8AofcQmXizN/xVHHvEYGHRn7Jyill8zeZ0lI+J596mo7Tw7LUDYIbRG
 lszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691776073; x=1692380873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZjqSHq7/cZ8OsQEHGhOPAij5Qo4MVYdiXsrrjnC+xs=;
 b=PIyYVrVpsv5hKqDjITNUlnI3Tuv6Q1hJVRRVfa/oCN8NCdXrhqqVXZcwOn1U1ScR22
 zEKTm5g4KHMsGgSQM+6ctaVmakVV6+L9qaNOoGfhIJRZxm7T0ILyk8L0/p8w4r03OZPq
 U5u++IaovbxATZ7spDs5EM7Gyaz0ZjUwO/O3xGnlqZKXnRMFskifDUq/7J/uAr2PYDXw
 MR9xFf+yTeD8QFBuHzM9gBrRv+rYtxOt1EGt+Dt+8Pb1SMu/BAo9PgqLUBoOQWE16Rcw
 lxXPoaFICc3RYH6NSM23xfsIwEY0BHvyAfuOb1VCOSqxj9bvqCSxOpwZYi+84ixhMRhm
 ZGRg==
X-Gm-Message-State: AOJu0YwvybellUuV5wyZk8eTYTMBUo+qwRCdR5S9faprMJa/jGXB1SJk
 cqVbc57DcmbJkLk22eyOtfQ5JM9kijqdMFKjUa0=
X-Google-Smtp-Source: AGHT+IGXRpgfKcLu/x/mrYYlFfw0ZvtHjgSbUoYEC4bWU4rrGoo3QE00BhvCV10L+iK3R8QwiKa5ww==
X-Received: by 2002:a1c:6a14:0:b0:3f5:fff8:d4f3 with SMTP id
 f20-20020a1c6a14000000b003f5fff8d4f3mr2229738wmc.7.1691776073060; 
 Fri, 11 Aug 2023 10:47:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c0ad500b003fbb346279dsm5874940wmr.38.2023.08.11.10.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 10:47:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/2] nvme: avoid dynamic stack allocations
Date: Fri, 11 Aug 2023 18:47:49 +0100
Message-Id: <20230811174751.784620-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The QEMU codebase has very few C variable length arrays, and if we can
get rid of them all we can make the compiler error on new additions.
This is a defensive measure against security bugs where an on-stack
dynamic allocation isn't correctly size-checked (e.g.  CVE-2021-3527).

We last had a go at this a few years ago, when Philippe wrote
patches for this:
https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/
Some of the fixes made it into the tree, but some didn't (either
because of lack of review or because review found some changes
that needed to be made). I'm going through the remainder as a
non-urgent Friday afternoon task...

This patchset deals with two VLAs in the NVME code.

thanks
-- PMM

Peter Maydell (1):
  hw/nvme: Avoid dynamic stack allocation

Philippe Mathieu-Daudé (1):
  hw/nvme: Use #define to avoid variable length array

 hw/nvme/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


