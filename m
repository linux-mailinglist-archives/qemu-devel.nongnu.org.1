Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4E768C78
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMsF-0007Ps-Qp; Mon, 31 Jul 2023 02:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsD-0007PU-AC
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsB-0001Ip-Mt
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686b879f605so2686293b3a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690786758; x=1691391558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GbeTm31IX5cqIzexOXR1Roh22wZC7AFKTuTIdglg+fY=;
 b=MarVxziPnxRXm6kwbTWGAhCQ8wuiq9G3AJfZXZAWP8rW8Sy1HT9mnZ6BhC6gyFvxmh
 ZkEM2nuhX2UsUZhi0LaWP4+WR3JO3z+ft8C+bFA9kS0n02CEdqcleI5EQbI+Sa+sZqjL
 Zn44b2QIJd3xJwlle3PjK6j2r/4bkbqtEUvGEix69mZcPyNsnGk5+Pdy+7c6SN7o7aTT
 rqIHrB++eB3kBgBeJlilm/UJdFZfBZMt3ZGJzsG7R46h7hTtdxSb45TY/q6/qQl8kX2Q
 HfccVePLIvtW45D0/6/82NtNjrDIOrHAMQ2W8vwhUWDrxnxpN4pWrVx8Vgwmd3nwgm6w
 WJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786758; x=1691391558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbeTm31IX5cqIzexOXR1Roh22wZC7AFKTuTIdglg+fY=;
 b=QMPpu7ARzc3Rt+GlVdagjm+W5PzgxpxgDNbIXCcxwDJpaHLiX4/g14Di7aezSOdaDy
 WSatxzLfUBcSFebgIjg0qrhI+JkyR1OZ+IkxUcl8hUTxkq6zTj+zlenZUUf7QiCWkdvO
 +2hUtYjWYNOnNZhtc7oQEMgZv79kKxyZIZDIwSSOT5swSZRjDyXV49EPdqpjmQz7UDW9
 V3ItW6dUIpzFp9w9F3A8+5BbdF7ra0Z91dY1rmCN7lMZ5vvH21Zg9dErDw2FbVdSqhzw
 CsdgqpbHDEFgQWcm+4czGfGIvv8S8F0xLVw/lcvjRNVFKPsk7eUSobjop7LNzOjtOTWf
 U56g==
X-Gm-Message-State: ABy/qLaZZ/WBnG/dC5g5Akf402VlnKK1wUddi/WgkWxOP657QN0oXNNY
 TJ5tOAn8RdxBQuMSd/MAuZcDvQ==
X-Google-Smtp-Source: APBJJlHat5IY7AxzhbjsrjkzgulOeWgelDiFy+7W4xfwxuWqr3qF1dGA97uXRHXpV9CBhy8mly6fCQ==
X-Received: by 2002:a05:6a20:8412:b0:130:a15d:54eb with SMTP id
 c18-20020a056a20841200b00130a15d54ebmr10019303pzd.24.1690786757946; 
 Sun, 30 Jul 2023 23:59:17 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170903121000b001b8af7f632asm7684988plh.176.2023.07.30.23.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 23:59:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] Accompany -nostdlib with -fno-stack-protector
Date: Mon, 31 Jul 2023 15:58:53 +0900
Message-ID: <20230731065904.5869-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

A build of GCC 13.2 will have stack protector enabled by default if it was
configured with --enable-default-ssp option. For such a compiler, it is
necessary to explicitly disable stack protector when linking without
standard libraries.

This is a tree-wide change to add -fno-stack-protector where -nostdlib is
present.

Akihiko Odaki (3):
  pc-bios/optionrom: Add -fno-stack-protector
  tests/migration: Add -fno-stack-protector
  tests/tcg: Add -fno-stack-protector

 tests/tcg/mips/hello-mips.c                   | 4 ++--
 pc-bios/optionrom/Makefile                    | 2 +-
 pc-bios/s390-ccw/Makefile                     | 2 +-
 tests/migration/s390x/Makefile                | 4 ++--
 tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
 tests/tcg/aarch64/Makefile.target             | 2 +-
 tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
 tests/tcg/arm/Makefile.target                 | 2 +-
 tests/tcg/cris/Makefile.target                | 2 +-
 tests/tcg/hexagon/Makefile.target             | 2 +-
 tests/tcg/i386/Makefile.softmmu-target        | 2 +-
 tests/tcg/i386/Makefile.target                | 2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
 tests/tcg/minilib/Makefile.target             | 2 +-
 tests/tcg/mips/Makefile.target                | 2 +-
 tests/tcg/nios2/Makefile.softmmu-target       | 2 +-
 tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
 18 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.41.0


