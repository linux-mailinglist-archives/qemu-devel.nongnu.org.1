Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D077BE23
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaTw-0000U9-Ho; Mon, 14 Aug 2023 12:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaTt-0000Tb-Ng
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaTs-0004mY-C8
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:49 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-26b0b92e190so2753670a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692030706; x=1692635506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3t+9A397lQQSC+zK2Tr4yJQWC0olwqt/KSJsEjco+I=;
 b=etxG0Ki5ZE8Ma/BfgH7B/FZQ6FrBlH1Qsg/D1R+o5IEICIVkTCjeyPTQrOH+qKnzFO
 6t4I2oug/Fe5NYK0v/BuJJSs5gf+kvU08yDv+LqaFhXgGTSCItBtMQTNdsrOoAgrUV0l
 7FJpk7UnvERcXwj/rMdI6ptlCifu1CZYyZ/Vjo1SIYLjoEruM5nv3grW54TSyPSWHJpQ
 zaLCnKDtrtKT6yoThueJDzVSA5AY/Wdm+tSvnpxoUamHsWoZsrRXqb8wmDYX/gRQNug7
 GEcv1WTIK1qeMToJegUk5u0k66SV3woeE9sORhUpd28PX8+DL04ztL8cBeTiVmkPpUx8
 kaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692030706; x=1692635506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3t+9A397lQQSC+zK2Tr4yJQWC0olwqt/KSJsEjco+I=;
 b=TLu4V3vlINNXr/jtnLaFaJiq5Usk5SfnL6yWC+OQWgtu3wwY+9rd31ace2aZ64o9QA
 XXT/1KNXgH5iZSm73SikmlY77CCZXGxXJfoIbtTS3wc/MxWxHI0FNvSfM8FebyZu5ozQ
 SCDCYrMJWQD83ZlJVYnIuEaA1ZqIFu0/X9CGMvcu6fyk6g5U7EtAUYn9Qiixdv928y6E
 DFPzs6Ol90zVHcnl5+wYmgn4iSOtprBk9gNY8yV6Ini4/I8ZIru4xLhWLrJXgc2ox/Pg
 h2dHxFhcVzb1wSRHTK4zvw4klHd6TmJGXwKa2KGyb81lQd3tVaTwYVjvEtx7a0cQTgeu
 gdHg==
X-Gm-Message-State: AOJu0YzsjK5z8cNtL0nA5juBP5kejlXsBwfxwkvwOV4GOVzGnoKmrIX6
 RKQrl853mXQrtoqjUnDAwkw=
X-Google-Smtp-Source: AGHT+IGjfrVec8oaS7LDFbEH7YfbRoCR0xBCNJM09lHpQ3Ow/8E1awbLYVWnXkAFl0WJ0xqU9m9aRw==
X-Received: by 2002:a17:90a:de0d:b0:268:5aaf:fbe with SMTP id
 m13-20020a17090ade0d00b002685aaf0fbemr17748644pjv.10.1692030705900; 
 Mon, 14 Aug 2023 09:31:45 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001b8a3a0c928sm9613263plc.181.2023.08.14.09.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:31:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH for-8.2 0/4] Assorted replay patches
Date: Tue, 15 Aug 2023 02:31:31 +1000
Message-Id: <20230814163135.187882-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

Hi,

These are a few small things I have found helpful while trying to
implement and test rr changes. Patch 2 depends on 1, but otherwise
the patches are independent.

Thanks,
Nick

Nicholas Piggin (4):
  scripts/replay_dump.sh: Update to current rr record format
  tests/avocado: replay_linux.py add replay-dump.py test
  replay: allow runstate shutdown->running when replaying trace
  replay: simple auto-snapshot mode for record

 docs/system/replay.rst        |   5 ++
 include/sysemu/replay.h       |  11 ++++
 include/sysemu/runstate.h     |   1 +
 qemu-options.hx               |   9 ++-
 replay/replay-snapshot.c      |  57 +++++++++++++++++
 replay/replay.c               |  27 ++++++++
 scripts/replay-dump.py        | 113 +++++++++++++++++++++++++++++++---
 softmmu/runstate.c            |  19 ++++++
 softmmu/vl.c                  |   9 +++
 tests/avocado/replay_linux.py |  16 ++++-
 10 files changed, 256 insertions(+), 11 deletions(-)

-- 
2.40.1


