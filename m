Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52705780EB6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:12:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX180-0006D1-FJ; Fri, 18 Aug 2023 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17u-0006CB-Qp
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17s-0007Ys-GZ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so10052245e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692371459; x=1692976259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/O6++0QHUEhAPLM7jGuNogMD5mILdjSlpdhFG+dOiM0=;
 b=E+yxl/WEQEnq9mR8T+9WdCRQvriSTAJDw1HqarhHhXKQ7wFszJJ6gPAE2hkYj619Vd
 8rn0bW/ndOeoUVM7Fb1lAOyRnVmTZqafujtXzIpiSzBqI9nELeE5r5zDKGnPwh1MiARp
 oPxkxVW4DmXF9mF7RVW+EwkFIBUsDlkfeQc6md7sPDKjKRPu9rjPtNtiL4SsyPIirTR3
 7Lkha/QgIaIEr1Q1jztxniArxdQbkgLwjMBRKF7Jk1m6KOlYFyIjUZXKfA8JRaONLgS/
 SpgXsw6rOOSAlwnSh9l0W6DOLsqWjTeYj/Qw0lHRMjwhuEPoV1J2/8xEkbEsNPxyQlP/
 B7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371459; x=1692976259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/O6++0QHUEhAPLM7jGuNogMD5mILdjSlpdhFG+dOiM0=;
 b=hYFb+RpdPOYgnRkUGe/ul2+ER0LHvx7UYz0lTERgSqsEDag9omf3oFC1yIkVZ62zZG
 KFzdwFiQhuReLPvXpZb+bVmRoSfybn0wAhdCgUNyIxE04rotIP8n2rXuzKTq7HgKyJzC
 aOYwuB1UAbQ/3U25MW/QNgOP6hH+rT3jb77j6wo1Vk/fziMY4q7zVZdt0DT/M8ZM5IUj
 YIazputKjZxzo6n0EM4cp7rwPiPOaJooyqBidH2EB+BtKj4FsauaV9FTXr+zAPUzj7Fd
 YJk8qcr/PkE+3RwrLPPb3TRDQXUUQnOvhU+c65LbJDFBWZ1PHL55XnHq0wK3UqmjJPmH
 dSSw==
X-Gm-Message-State: AOJu0Yw+4rx4rlA2/EFCxQuS7WazzwF6j+jka76L0fdWDSmu/cOr8ADD
 7c/qEkw5cmNFjTPHvvLgE01RtmVzq5oXYLyGVPk=
X-Google-Smtp-Source: AGHT+IFWWL7IoXN1Efu/79szwmTR0sYVTW5362YbQPqFqzJCPngbRh5AurSR68pUMUep8PvlBI+Q8Q==
X-Received: by 2002:adf:fdd2:0:b0:31a:d31:dbf9 with SMTP id
 i18-20020adffdd2000000b0031a0d31dbf9mr2158607wrs.49.1692371458923; 
 Fri, 18 Aug 2023 08:10:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b00316eb7770b8sm3097631wrc.5.2023.08.18.08.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:10:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] ui: avoid dynamic stack allocations
Date: Fri, 18 Aug 2023 16:10:54 +0100
Message-Id: <20230818151057.1541189-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

This patchset fixes some places in the spice and vnc UI frontends
that were doing on-stack allocations. For the vnc-enc-hextile
case we can make the array fixed size; for the other two places
we switch to a heap allocation.

Disclaimer: tested only with compile + make check, which doesn't
actually exercise the UI frontends.

thanks
-- PMM

Peter Maydell (2):
  ui/spice-display: Avoid dynamic stack allocation
  ui/vnc-enc-hextile: Use static rather than dynamic length stack array

Philippe Mathieu-Daudé (1):
  ui/vnc-enc-tight: Avoid dynamic stack allocation

 ui/vnc-enc-hextile-template.h |  8 +++++++-
 ui/spice-display.c            |  3 ++-
 ui/vnc-enc-tight.c            | 11 ++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.34.1


