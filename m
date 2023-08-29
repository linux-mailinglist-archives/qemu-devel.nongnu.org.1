Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3178C8A9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0i8-00082t-2Z; Tue, 29 Aug 2023 11:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0hw-00082T-Hu
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0hr-0006ep-6g
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d7so27767305ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693323034; x=1693927834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lk8xOu4YBnELd72Ln9hqvaYLmOT46/BZgtsop+T8B+M=;
 b=qqHym05MvzC1/PT3TnE3ioeV194gCwHsaTIIAz26593SrDuwa3G8LlgvdvvMTMN0n3
 KLgtlTgL3gL30E9RJ7LNK17WBG/2O5/Mx+C921O8xpt8V261wWMY2wP0DT42vc97WRF2
 kDXrBkKNqPRT5uqEyAefzDSPnY1j50L5ClEfzAEjSlYRZ+l1QBW2D19BmAYJRsfM6rBg
 g6HENu/vJ+hCkzMPHCiQ8jtIVXMEIIb8PSCdfCXio89aLZmgZnB7Jp8cFs9aE6gPXIBp
 oOBPK4mvaoedjd+dXTwvqFtzz7HBMUfLYacWxGgc+U40O7ldw/Vu+AExkp9peYK/Q3tz
 7Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323034; x=1693927834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lk8xOu4YBnELd72Ln9hqvaYLmOT46/BZgtsop+T8B+M=;
 b=HxUswvDBwEpHGXwBW/h9iOmTAc3BfzXCV+OngSTIwSxGatlYtTRBhMj0B5/0UnHAsW
 g0wf7FMGUH5lEb+ahiDx1y/uF1TjuaQPmroxoyUAnf/+5mjLcglhn+JOWKj2rvLUM1BD
 69+BlnAFMyQP/8UASmGquornqXxV1lDw/omEPkzZQkF9BRaN4R4LAe9lPVnBDtbHSJtR
 jmZxjq0A/rShz3Jkv+26oCCHGAxWo1RnOzObA5zBs4jHV98OcwJ8vDVktNBpITIPEc6E
 LGwhYUBSS5yQHosoSPWtIwPN2VP7/UYG/jYatupn3zCcuiS/Xg4Y38eNyhDDEegNee1Q
 TSGg==
X-Gm-Message-State: AOJu0YxmCXUOxSwIjHmR4KMJiENrXUAJlQqh34wAzW5i2FFBFwCtPlKL
 tRG8f6C4jGtmjbgg3Def6ptrKWSnUsXLUgrYCwvVMcTP
X-Google-Smtp-Source: AGHT+IEO9aXs4GDc16O08wC9+LDlrkoO3SqyDZ++A2QiI+70aHmE0KVTVIlH7X5GRHuHucUE3ifh4g==
X-Received: by 2002:a17:902:ef89:b0:1bf:6c4e:4d68 with SMTP id
 iz9-20020a170902ef8900b001bf6c4e4d68mr20151967plb.48.1693323033968; 
 Tue, 29 Aug 2023 08:30:33 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170902d48f00b001bdc8a5e96csm9510282plg.169.2023.08.29.08.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:30:33 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/3] Dirty page rate and dirty page limit 20230829 patches
Date: Tue, 29 Aug 2023 23:29:47 +0800
Message-Id: <cover.1693322363.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x635.google.com
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

The following changes since commit f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81:

  Merge tag 'pull-tcg-20230823-2' of https://gitlab.com/rth7680/qemu into staging (2023-08-28 16:07:04 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request

for you to fetch changes up to 3eb82637fbf8c0471990b59e6733fd4beb1f9939:

  migration/dirtyrate: Fix precision losses and g_usleep overshoot (2023-08-29 10:19:03 +0800)

----------------------------------------------------------------
Dirtylimit and dirtyrate 20230829 patches PULL request

Correct memory leaks in dirtylimit and accuracy losses in
dirtyrate, respectively; make minor corrections to overshoot
and memory deallocation.

This is v3 with a signed tag. Please apply.

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


