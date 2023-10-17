Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C877CC1F3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiPd-00030z-CZ; Tue, 17 Oct 2023 07:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPb-00030n-GK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:38:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPY-00014N-5f
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:38:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso37613445ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542611; x=1698147411;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w+CjORXYbin1I2R24r6eVbW2BrU8KNSBitebl2lNH7Q=;
 b=2jGRyQtsMoBW9vnDk77KjxjXNf3ZI+7T5NlVVhSHNXHtQH+k8zWOJDDHVnGj8ZInKk
 vyEGmWhhJyedFrxpzqxw4FE5gXWVdKABNlybmkCE2BQKhsulicCDxmA10hvFfxh0EboA
 VBFOlBXA94D8XZ8AMr/Vg71r7/alAQ+BUg3DyWDMtsQYcUnbdTSZlnxsR67tVpCTTbjo
 OWPbCecf4t2IkYc2sP2gDU7omGGO8rFm5uLTrqFJbuxbunou5iBlQmQ5TUTNcMjoQsMq
 CpTEFpNn38rPDUfJglqUcJ/44zjFGGe3KZmHlakgBWJSeeAxyYvzqilherMzaJPO5Hos
 PNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542611; x=1698147411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+CjORXYbin1I2R24r6eVbW2BrU8KNSBitebl2lNH7Q=;
 b=YZQqkQujuDyJ4wJSXiGfExQfJZLvW9lYN8kwAvKlddgwFQYY6sHV4ZqWABojlbVFto
 3cc9ep4mYVIixyKOCrKF0I1fLM6CE2einALo4ByRYjvumJVWebRarQ+Qtp+TAcB4raLn
 ymk4erR69MNxyXPYvbFhiajB+O+ZGtI2gZ6LVOH9D1xU3E7zIB53950+/adV8rkOrrlL
 nolmrVoE28K4WH8T5o5MpCvwHXfz45JX3aZrszsP7iEurbLLZAYx0GKoBMyFJbXdrdcK
 3k/lkFHxMRy+ekQx41Hta313eKGdOxVNsqPJkEnql+axniaILEkgiewaRjxITvpSvDst
 8jXg==
X-Gm-Message-State: AOJu0YwLOhJkwVRqweM4NWPTvp+K80ZpDImCBMr8kV6d9orQHSKvY968
 FLKr8w7gS9GAomOSUgVk67Ua9tU7h43pH9Y51Igh2SQY
X-Google-Smtp-Source: AGHT+IGYDGXgvj4LGWtSraXyC/S/Akm2wOqTI50KMfuQGAW+nIKk2rtPSPnjSaiFWJALIHGae2fdXg==
X-Received: by 2002:a17:903:22c2:b0:1c5:9d00:be84 with SMTP id
 y2-20020a17090322c200b001c59d00be84mr2319428plg.33.1697542611287; 
 Tue, 17 Oct 2023 04:36:51 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:36:47 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 0/6] dirtylimit: miscellaneous patches 
Date: Tue, 17 Oct 2023 19:36:03 +0800
Message-Id: <cover.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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


