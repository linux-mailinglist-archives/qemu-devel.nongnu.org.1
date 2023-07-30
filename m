Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FD768425
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 09:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ07a-000510-Ui; Sun, 30 Jul 2023 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07H-00050O-Os
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:24 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07G-000631-5T
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:23 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-56cbea15415so20084eaf.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690699280; x=1691304080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKy6YGVQs9rXVjJ6p4MJiwzWP2aR7maxASM7DQfFfDA=;
 b=ecXw8pKsGcrzZuvgklArJWcYBV/929yzfOMFXWYAjMt2LnC/o7PRIJLnNHNd+v2IkC
 Ynph3GfQ6spWvJ0wQie6xBjq4xMyWYZTTTUhDnARgB0T6Su1+Hj9PwhOkD944MCkCEzx
 LBbK03P5pLpQ2ENXlqhWeQXVItQBEUaGHa1e+dKJAKlK1wGAKXnnd2/N0eg9qAntPeUH
 TxggSQmUyNh/xwhQFlV+3mz02MW13x5tYQQSGqAd4MGQz060jV7zY5ImklBJBZCpr6ID
 W07lQJ7fap9iUqBYb8B7bW/rn2Z4J4QBxaBlLZ9sfsIfhEty63V0LKOsRfM0jlUHBDTS
 LP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690699280; x=1691304080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKy6YGVQs9rXVjJ6p4MJiwzWP2aR7maxASM7DQfFfDA=;
 b=ApduJxvd+QiYqNh5B+xn2/++7TUR6B9/VnL7osNmUvWRe3GeYxHk/upCAZZ1NpxlND
 EbQbF8sdM70syCd5oc9kkrz7LVTkH3SWj9TgqaRyjpnQ+pweVjOKFmDWdfa6Jkk2DtwA
 Ha3APyiLn5Kjt93aHnukDrm9dyfhW0H7n4UDA0d/63atTZHKDsPZ2q71T8W7JbCDfraU
 BUfn18vc/KC0KxoC3scz+rs+aGQdnYsSDwlMinrd+8YT+1pLFRr2BHySSNQYVwO26U+5
 IDJh4NbWMMZZ8jsDDWZutuOn/4bEIoEA+FsDrmmt/MerOOeISGtL7we2T6PGQp5iDtXv
 R2ag==
X-Gm-Message-State: ABy/qLb3GOFBQuJw+QDYL72U5PulnS7Zo5n4Y2Owz38botONu/kPOVtt
 8kTnEH668oNk6ltDhrT4o+cxT1pmdX0=
X-Google-Smtp-Source: APBJJlGL8E7dIX1w0lA7fmUOaxbU6/jbE4MewwjnR7OvVGE5aBj715Dy9e336HS2DxHnNVZR1xf5EQ==
X-Received: by 2002:a05:6358:e499:b0:134:5662:60a with SMTP id
 by25-20020a056358e49900b001345662060amr4634554rwb.6.1690699279875; 
 Sat, 29 Jul 2023 23:41:19 -0700 (PDT)
Received: from debian.hsd1.ma.comcast.net ([2601:182:cc00:77b0::aecb])
 by smtp.gmail.com with ESMTPSA id
 oq7-20020a05620a610700b00767c961eb47sm2347254qkn.43.2023.07.29.23.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 23:41:19 -0700 (PDT)
From: Dinah Baum <dinahbaum123@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dinah Baum <dinahbaum123@gmail.com>
Subject: [PATCH v3 0/3] Enable -cpu <cpu>,help
Date: Sun, 30 Jul 2023 02:40:54 -0400
Message-Id: <20230730064057.357598-1-dinahbaum123@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dinahbaum123@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds the ability to query for CPU
features. Currently it is limited to the architecture that
support feature probing (arm, i386, and s390x).

Ex:
athlon features:
  3dnow=<qbool>
  3dnowext=<qbool>
  3dnowprefetch=<qbool>
  ...
  
Suggested-by: Peter Maydell
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480

Dinah Baum (3):
  qapi: Moved architecture agnostic data types to `machine`
  qapi, target/: Enable 'query-cpu-model-expansion' on all architectures
  cpu, softmmu/vl.c: Change parsing of -cpu argument to allow -cpu
    cpu,help to print options for the CPU type similar to how the
    '-device' option works.

 cpu.c                            |  61 ++++++++++++++
 include/exec/cpu-common.h        |   7 ++
 include/qapi/qmp/qdict.h         |   1 +
 qapi/machine-target.json         | 138 +------------------------------
 qapi/machine.json                | 130 +++++++++++++++++++++++++++++
 qemu-options.hx                  |   7 +-
 qobject/qdict.c                  |   5 ++
 softmmu/vl.c                     |  35 +++++++-
 target/arm/arm-qmp-cmds.c        |   7 +-
 target/arm/cpu.h                 |   7 ++
 target/i386/cpu-sysemu.c         |   7 +-
 target/i386/cpu.h                |   6 ++
 target/s390x/cpu.h               |   7 ++
 target/s390x/cpu_models_sysemu.c |   6 +-
 14 files changed, 273 insertions(+), 151 deletions(-)

-- 
2.30.2


