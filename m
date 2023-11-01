Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC957DE1DF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:07:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBri-0006Tz-Bj; Wed, 01 Nov 2023 10:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBre-0006Sq-CW
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBrZ-0004mi-VI
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:32 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso33315455ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847465; x=1699452265;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qRz2igsaHGlLla5mzeRdKPoAHcy4/c7V9DIdpyXPrGg=;
 b=0TuJIajakkdXNJS2sJV7gSu5o/jEwdpHLyaIzEbHwcYera08tWG/UySjxRy0ducffv
 EwyJ9hM0TRYpl28Hw/5nnj3jtF3hSVbkQSH5bZt9xYQ6iZs9n0PGElLegWKzrY9obNbb
 X50xPB1R8LYQkUb1wlP1HXa55lriPqifkQogHVxKc/9EB1ZFckjU5TTe7yrzXm1ZzW3m
 EpCKA3q7UykuQODfoTuFduNgjN2ecPh5PF4DNEiZt3SLwLZ7B2OrXrtzhxYqS38ts1A4
 XmsG9pwISRj+Fb3fVck+Qwln/gLoc+KTeq/Y4JndSHaIjIu9He5sZXNuPAmNXH5LYZug
 P9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847465; x=1699452265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qRz2igsaHGlLla5mzeRdKPoAHcy4/c7V9DIdpyXPrGg=;
 b=V+Ditx4MehUDGbeUn0tsAonhnEIJ+ps4/WK/FPPTkqbxiMZ3BVHeKBO7oC8+uRfALY
 dWmzPcP/wQEiDqkrRYnbZUsYzvXSUzzaZwUxEyD1WAr1dJU8xqlXsiLvavcvv3PJswWb
 l01BTSqNBwDAoXQoEe+A19mh/APuJhEwXNYGvOMJAArrjfuaXm+XujTSubVtlyJ43XHp
 P020uyQpIeD0qwOrpbvE35zLDrr/Z6Pc00k+vn+FVu6xCsiHexubV3g3LiaWoxYWGBCY
 EemKvLjrjsaFhizSttd5nfJkVcYY3njBvbyTtMFyI08arY6g+DiMVtu5HjX7lA2VMMY8
 WwFA==
X-Gm-Message-State: AOJu0YzDWkodHJHu8wb/aJh48eu+TwEcXGhPmJmewQSHIBtt9oMbWHZI
 MH5XeC8EmniLMskRDKncw+dKEVVE3Sdw4B7DxudaDqn7
X-Google-Smtp-Source: AGHT+IEhFlcQo9bhOgX/z+eNIw7ej4IIC2GLcfZxDRsf6fqD2c2Snh+00NVhQv0wV7qMMg248HVPXQ==
X-Received: by 2002:a17:902:cac4:b0:1c9:e68a:1b58 with SMTP id
 y4-20020a170902cac400b001c9e68a1b58mr9581606pld.54.1698847464410; 
 Wed, 01 Nov 2023 07:04:24 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:04:23 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 0/6] dirtylimit: miscellaneous patches 
Date: Wed,  1 Nov 2023 22:04:03 +0800
Message-Id: <cover.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v3:
- do nothing but rebase on master

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


