Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121A735CDD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:16:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISu-0003N6-De; Mon, 19 Jun 2023 13:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISg-0003JW-EO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISe-00024l-IG
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f9b1a117caso9765425e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194878; x=1689786878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=18OB37PiymPp8QdWzggDlsju2ZBXu6+fyUF/Fezk7Jc=;
 b=NtSdXyaIR61+iOQh6m9J8YpTv6jaGXeUlBCJKdIulZqw+bK5ajm39zTGWZb3fREygr
 D+jzerwC5dZSDjGiBVDvmEaB/l0xk84U0o0UkP0rcND95dCcdRQXdDwKEm5pMPiUXQ4p
 +a29Wtsfpa1fZFQRoytg+hfYahwwY2a6C6VPZ7yRRsZxDKzePKTYJtP/su952rAVyQWa
 AIcUqvn+jhVsNBQVoLvQHLXkViBD6drptUnVpGe7kwaL/6mreqMz6QCe/0AM8He8whFj
 6wlGXaNQipmzPnfjxV85oUhx82PbBDBmBwlkScUWAem7G0SkEPdsl7RaYM3FIMuOl0UT
 wPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194878; x=1689786878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=18OB37PiymPp8QdWzggDlsju2ZBXu6+fyUF/Fezk7Jc=;
 b=igH4S+EmJvo2RKbNpFfoml/3iNMqA6UdJf1hEjRUodqdNBZOLQGt/il9P4pGFLi9+L
 xoiVn3/xL+z0DuffzwnfCnwK7E6L9G1KygJRbxuaDZRBLccTQDyILD0IDi/WZ2Bh9O+D
 kQMGKHoRJB4SUSFG8VGrzVPxQ+0BjgI9oVTD6FvG73vFnvrBZMVxmHPG3lR0mksFB10O
 0EARot3Bv9I6KSqMgKtPl+22en1ZvfuGGaSgYhO83Bk6/UdaBh/YNM3whGErWAf25MDs
 oQyW6M1vuuGi3IfwyU6+jOjvFcsvNta1FVSONaAwOBtsDibo+PSGloS2rAxSUexdcbWs
 msXg==
X-Gm-Message-State: AC+VfDym81/QiRJkBYf4vpUM7K7BjeW3CD9SE9ZFKRtFNCn7Mx0hvP4w
 88KZQBEouPmC1ZuYr8W+zI7TMg==
X-Google-Smtp-Source: ACHHUZ719CRSG1X7rUK0JbHvN/8Jfa6USEiejS8A3JCnZxEjHylS9FK4T9NEyNEbOK1ZlcBB29gPPQ==
X-Received: by 2002:a7b:cb89:0:b0:3f9:5db4:e8dd with SMTP id
 m9-20020a7bcb89000000b003f95db4e8ddmr2734008wmi.34.1687194878323; 
 Mon, 19 Jun 2023 10:14:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a05600c205900b003f9b1131a90sm252641wmg.23.2023.06.19.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5909F1FFBB;
 Mon, 19 Jun 2023 18:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/5] docs/devel: improve API documentation for QOM
Date: Mon, 19 Jun 2023 18:14:32 +0100
Message-Id: <20230619171437.357374-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

At the recent QEMU maintainers summit we lamented the fact it was hard
to push forward with our modernising plans as legacy approaches still
get introduced into the code. A lot of knowledge about the "modern"
way of doing things is locked up in senior developers heads. Lets make
a push to improve the developer documentation and ensure best
practice is easy to find.

Some sort of parable about distribution of fishes and knowledge seems
appropriate here.

Alex Bennée (5):
  docs/devel: add some front matter to the devel index
  include/migration: mark vmstate_register() as a legacy function
  include/hw/qdev-core: fixup kerneldoc annotations (!COMPLETE)
  docs/devel: split qom-api reference into new file
  docs/devel: introduce some key concepts for QOM development

 docs/devel/index-api.rst     |   2 +
 docs/devel/index-process.rst |   2 +
 docs/devel/index-tcg.rst     |   2 +
 docs/devel/index.rst         |  24 ++++++-
 docs/devel/qdev-api.rst      |  12 ++++
 docs/devel/qom-api.rst       |   9 +++
 docs/devel/qom.rst           |  50 +++++++++++++-
 docs/devel/tcg.rst           |   2 +
 include/hw/qdev-core.h       | 123 +++++++++++++++++++++++++++++------
 include/migration/vmstate.h  |   9 ++-
 10 files changed, 210 insertions(+), 25 deletions(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst

-- 
2.39.2


