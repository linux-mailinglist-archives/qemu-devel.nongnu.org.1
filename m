Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFF7D12A4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrOA-0002xw-JX; Fri, 20 Oct 2023 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO6-0002nn-L3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO2-0005ym-2D
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso7624475ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815440; x=1698420240;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=izmLDPG7JXESsO0093qh5Y0RDXrMk9Zz0Zx5CaiPJCE=;
 b=HqZWRbPl4BC9eIJrDIuDC+ujRG8QFTHh0sE5vtb+sMAbr6sJ1AAtFbRGGI/Z62A/Qk
 MybNDLWfAmJ+kT02HhK3T/GrWPS6VTOVgrkH20ub6tIq2syy/4SksJ3E4J+zWr4DKIIr
 tBl93EDfAxEtLx3CgKAvQ79oU1tFxtuo5oMrUAkevf4ygZATK1BTHDRykmfx0ptocSyM
 f+NLYJUci+v6axe6Fa2+DMbt1V0NY8nIElFknQB+91hO8CuYMBiVOambQZGw4XyL7m4F
 c2UN4TyJF2sdSMHTNunPi593JppvLgM8IyKkbBaLzFOyKIV2bYSdmPjU84/pZP2e9JrW
 4UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815440; x=1698420240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izmLDPG7JXESsO0093qh5Y0RDXrMk9Zz0Zx5CaiPJCE=;
 b=oRma2NXlSpWOk42++SXMxWtqnZgFmeRIcIf/t7MvqR03tzgX4NqjQZcXtT09arY+nn
 wdNs8b148tZEeC92c+ZGFXNMeaC4ghznD0ZbN9PaMgiJe2r6ZCZTPo6B3X8B+Hm27X8v
 eeg0N4HHGbavw1ZL+UXWZ9m8/okrvouXrXnz5fSAr3zw8hVVk+FaOHBn9oNR5WAuJcKu
 eB90jC7mNyGGhWq1wxPCfFgRjk0L+A+0zaUEOfs0XWedgSBku2zdKKKAbI/Ue31d2PC0
 7UPcRDTjcCiT78Keo9e2nyHeCsGymecLTWv/s9DBPGT9dMqrs/vxBMbnMOZCmHBpozfg
 Q+zw==
X-Gm-Message-State: AOJu0YwJxzqF/dCpN6EOgKMm+2l5CKF7xyxHXtCoJtbK5TwexAkALZ74
 ZIzrul46DKJiQDrDXqOr1324BmV5uz7VxR1TjTs0VJk7
X-Google-Smtp-Source: AGHT+IGGL8V39BZ+mG61TWWMU6Vg553jjNwoIdc4fUnjMkWocMGrWgIa5HZrZs/d6PNv5sw5IuU4pg==
X-Received: by 2002:a17:902:c402:b0:1c3:19d6:3559 with SMTP id
 k2-20020a170902c40200b001c319d63559mr4037953plk.1.1697815440183; 
 Fri, 20 Oct 2023 08:24:00 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:23:59 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 0/6] dirtylimit: miscellaneous patches
Date: Fri, 20 Oct 2023 23:23:42 +0800
Message-Id: <cover.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

v2:
- rebase on master.
- fix the document typo.

v1:
This is a miscellaneous patchset for dirtylimit that contains
the following parts:

1. dirtylimit module: fix for a race situation and
   replace usleep by g_usleep.
2. migration test: add dirtylimit test case.
3. guestperf for migration: add support for dirtylimit migration.
4. docs for migration: add dirtylimit section. 

Please review, thanks.

Regards,

Yong

Hyman Huang (6):
  system/dirtylimit: Fix a race situation
  system/dirtylimit: Drop the reduplicative check
  tests: Add migration dirty-limit capability test
  tests/migration: Introduce dirty-ring-size option into guestperf
  tests/migration: Introduce dirty-limit into guestperf
  docs/migration: Add the dirty limit section

 docs/devel/migration.rst                |  71 ++++++++++
 system/dirtylimit.c                     |  24 ++--
 tests/migration/guestperf/comparison.py |  23 ++++
 tests/migration/guestperf/engine.py     |  23 +++-
 tests/migration/guestperf/hardware.py   |   8 +-
 tests/migration/guestperf/progress.py   |  16 ++-
 tests/migration/guestperf/scenario.py   |  11 +-
 tests/migration/guestperf/shell.py      |  24 +++-
 tests/qtest/migration-test.c            | 164 ++++++++++++++++++++++++
 9 files changed, 346 insertions(+), 18 deletions(-)

-- 
2.39.1


