Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28D78B64D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafvs-0004q3-5I; Mon, 28 Aug 2023 13:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafvn-0004jQ-VX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafvk-0006ch-N3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a3cae6d94so2998722b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243172; x=1693847972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ms2piM3j93pACqinVSnIUc/S2GeV/RaRkfGbo7SSmjA=;
 b=ekfOdblrMEL+IhlCauNLoN62tQHheEwOU1/5Pq24fUMbbu8nKi7Jtgt3ZUXwMwYJp6
 5uHIlJt5Jd6kdXBFwgjd9oGax8z6A0oEbO+WIPtp37TWm2uWpiKytbhPWykkw27Dbrdl
 HFzAoYrmgVrwDRFXDThOJBMR6+YeQtRZxHGi67CzGMTbdTXGHX+B6yquNvpVGcoZ9tMX
 RAKMiWA5GuxhDo3r64zvxNE80871ckkuVEDo4vJle3Tc2JimiYjCFQPzpzk5Z6521JN3
 mmJ7pS/8MJ2kRv06jbuBf6guOabi/6Blmmv1ObJrO+lxNiF2elA3S6/v3tN1ZVtBFWU8
 c5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243172; x=1693847972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ms2piM3j93pACqinVSnIUc/S2GeV/RaRkfGbo7SSmjA=;
 b=MKuW9hzYezXizhAZ2lQXViuf7X29OpdO80OXdX+UeVMO6jEit2ujmvaWQzic2SD6H2
 2+dtZNcOrmiJMx0pQ2wepGbgSLADqdg8B50+wWyT5LRaoJuDucGSgMxABi2l5WdTKeqW
 ZsJ4YNESTfBQWNCRdbMxbHeLeFcLioi6t00pD6EeUlRovOfqxlbEJRrk1pUhoyd/ZvSy
 oUcZJqbUV4Xd0g/StRlOKCtemsTOu7eX++oRselZTNimE7+gChsZUwBBQAftMNo7nwWR
 BVbJM9a5+LbEXC/cLx6xPO9HaK6C8iouCpYr3YHAn8jDZMZb2M4xLPlgRTNL+rAL9D0Q
 hiTg==
X-Gm-Message-State: AOJu0Yzf+YeT8AkHhFbo+UPnixdRtubWq/5/T0QXwI5Eh9wjbSUrCI0F
 kwro6qoIPZee+FdeHhRR+szthiWhNjQnYv+ayGduUqYM
X-Google-Smtp-Source: AGHT+IFxNnCg/KDoeUURA91fr3fA5dCublYzgagfo+wHEwrwcugdfYDdjhaiz1APYrjam7JifbcpMQ==
X-Received: by 2002:a05:6a00:2e0f:b0:682:4c1c:a0fc with SMTP id
 fc15-20020a056a002e0f00b006824c1ca0fcmr33331948pfb.19.1693243172332; 
 Mon, 28 Aug 2023 10:19:32 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a637357000000b0055c558ac4edsm7697985pgn.46.2023.08.28.10.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:19:31 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/3] Dirty page rate and dirty page limit 20230829 patches 
Date: Tue, 29 Aug 2023 01:19:19 +0800
Message-Id: <cover.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x433.google.com
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

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-fixes-pull-request

for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b23:

  migration/dirtyrate: Fix precision losses and g_usleep overshoot (2023-08-28 21:03:58 +0800)
----------------------------------------------------------------
Dirty page limit and dirty page rate PULL request

Hi, this is the fix for dirty page limit and dirty page rate.
Please ignore the previous PULL request that accidentally failed
to send and apply this patchset.

Thanks, Yong.
----------------------------------------------------------------
Andrei Gudkov (1):
      migration/dirtyrate: Fix precision losses and g_usleep overshoot

alloc.young (2):
      softmmu: Fix dirtylimit memory leak
      softmmu/dirtylimit: Convert free to g_free

 migration/dirtyrate.c | 10 ++++++++--
 softmmu/dirtylimit.c  | 26 ++++++++++++--------------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.39.1


