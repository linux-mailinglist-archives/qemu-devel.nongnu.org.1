Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3557C7D5A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBCW-0004tp-QQ; Fri, 13 Oct 2023 01:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCV-0004ta-2n; Fri, 13 Oct 2023 01:59:07 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCT-0007zA-Fw; Fri, 13 Oct 2023 01:59:06 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57b6a7e0deeso1011020eaf.2; 
 Thu, 12 Oct 2023 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697176744; x=1697781544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hqmS04Lvg2hKtiSaCta/l5wYVHHNvrw87DvoXKqmEtQ=;
 b=ZDsTVpSNp4Wm74zPb9lVJQf0SMZr6mteipLgDjk969yx/NHTAXI+HiVCWWZ3LGmgz7
 h/vELKWJoZHx1XO7DlkV0cILasCO/7KPMe4jNnieAf5c1lRme0L/hKSolXYwDV8yqVUb
 ajmrJ42yl+El1GNHZ20tkH6QNkj5Cc3USj8iptkC4jmTlraFRixDv/g/dVeLSgh9+oON
 9KX0lhb4vhDq4feoDqHvRpkUo/TQRl1CY9tDg47O1WAUtB3BKyoTAqrLeaOHk9mppVIY
 +aqU1Hus1XmrnZ3apkfqrT8EM3c8oTSFFALy0lUDimXmI1n0fMwAbSf4v5JMOIkSxJ25
 RC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697176744; x=1697781544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hqmS04Lvg2hKtiSaCta/l5wYVHHNvrw87DvoXKqmEtQ=;
 b=lFrIigfwyJm+skk+SerWg/kl/Yht7s4LXquTDb8qIAcG51dpkui3i2gVroVblOPv03
 4/UzwKNZwzOe2VoNE7DsikvynmpBDcvUVGK+UAGglAg0S4LgmR/iXnb9wgHeuSuGIOgB
 N4IyqTSSngUsLjPrwlU/+9naiW5slr+VlVQL40Ts8/6FMHcI6GKtdLK8VsiB5+P++jIu
 KdoJYTVd/AD0K2epCbTaUN/QQX94rnIExpNMqvix2BxMJuHLa87ZcYYH61CHLDe05DDh
 b2Zk5zzAIa4yusX+ITnRAKjSgTpByKi5lHpbPBrx7rzj01IwqX/Iv2dLVyhYoDjgKyyH
 1tjg==
X-Gm-Message-State: AOJu0YzESNbSP+RXkjev0O4Xm8jRdbUNHQf+5selSXqkOZSzbC2NY2mH
 bJvGGJqza4v1IqYM9UyKTIk=
X-Google-Smtp-Source: AGHT+IEjlscA7qZfB32FZTHSL1FGPMYmtniVPMeKreqgiKv+f6h6EEP0aDOhsxQrDyoY7HfbpDhzmg==
X-Received: by 2002:a05:6870:9b0b:b0:1e9:64f1:9c30 with SMTP id
 hq11-20020a0568709b0b00b001e964f19c30mr9572301oab.18.1697176743821; 
 Thu, 12 Oct 2023 22:59:03 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 6-20020a630806000000b0056c2f1a2f6bsm394071pgi.41.2023.10.12.22.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 22:59:03 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 bmeng.cn@gmail.com
Subject: [PULL v2 0/2] hw/ufs: fixes
Date: Fri, 13 Oct 2023 14:58:40 +0900
Message-Id: <cover.1697173209.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:

  Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20231013

for you to fetch changes up to ebca80bbdb5c1650e4b753a3d13b43634e7dfe05:

  hw/ufs: Fix incorrect register fields (2023-10-13 13:56:28 +0900)

----------------------------------------------------------------
hw/ufs: fixes

----------------------------------------------------------------
Jeuk Kim (2):
      hw/ufs: Fix code coverity issues
      hw/ufs: Fix incorrect register fields

 hw/ufs/lu.c            | 16 +++++++---------
 hw/ufs/ufs.c           | 10 +++++-----
 include/block/ufs.h    |  4 ++--
 tests/qtest/ufs-test.c |  2 +-
 4 files changed, 15 insertions(+), 17 deletions(-)

