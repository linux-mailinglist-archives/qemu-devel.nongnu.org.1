Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34297E5D4A
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nMO-0007Qt-TV; Wed, 08 Nov 2023 13:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMN-0007Qk-0r
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:03 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMJ-0002va-Gd
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:02 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507cee17b00so9471472e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699468374; x=1700073174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+uQZr3Lg6zblZBi+iv4WzPewq3iyMI5xDv1R/01phg=;
 b=MSKhyRn9oBOxRHLDMlUvqo/TxF8eE2xaHmeQZ25cQeXM7Vfb7H/26a3Gxj4PLdC1C5
 wjhjMWdY3fbcodUmH7GroRh6L4aWfaS703ma8lARkm7IIDJQY4706ceCw9vv0GNRL17i
 6TjwxUm9FdB1syj2JSsvXKbidJEe/uOqcXtV0/vYdR6My+yMmcu3hfzQSGTZab6kjuzA
 7ywNSINzODVRYdnqA0tpMYyTu7jBGUa2HAO3iYt0VDkYGFYbCn1JpxtBTyMZJBlH663L
 pd5AtDglPXK1x4r9gddX65etqfpYHbRBi473SbSKcwPGzPr3SMMi+nmdbBVOazsCJ2cK
 nJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468374; x=1700073174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+uQZr3Lg6zblZBi+iv4WzPewq3iyMI5xDv1R/01phg=;
 b=IbrX7NA/ezsvV/9Xh7xlN5kJk5Qv4VtzsMSB0qnWJqDkRV6VzDXYlo/WnZJhnRjFW0
 KXyL9xiAtbPiFBNZwS6xDC4TVtR8JMOGjyL/mPFSRy9InoR+H4fgxx/QGThCz3ShmjFd
 PuveYDC7ilgj/YQdEN+mJ2v7cTroZAFdWRzzy0bF+wckPMXmGhgxVCQAEaSDKQ25Lx3o
 0SeIizDIRbF1VhDiKnVFDzZmht7j0goC0ZlL5Zf/a/SZ3J3Tkk2TUbhMWCC/BvPBnJHa
 cyjUHq1QR8hA16OI84FkkQzyJXjbd4Ky9WF5UdrENy1KJZefTL61g4dX7XG98ZdBzqrD
 SGPA==
X-Gm-Message-State: AOJu0Yyf/jWQZt+LWHqC5h1/XfsHR8IT9JHi06pYVpUlse87qYQ+OWC4
 oUtUmAIzsdlN/7Lxm+XomQ/kjFwqVYwPenecdIs=
X-Google-Smtp-Source: AGHT+IEzdauTmA3EQngseVYUWJ0WT+0ZEPlY7kb5m0MNGvFp/1Em1Ed59Qz4XKPxGGJYPfzVkulFMA==
X-Received: by 2002:a05:6512:746:b0:507:9f69:e8d9 with SMTP id
 c6-20020a056512074600b005079f69e8d9mr1687268lfs.49.1699468374385; 
 Wed, 08 Nov 2023 10:32:54 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05600c4f0300b003fc0505be19sm20197162wmq.37.2023.11.08.10.32.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 10:32:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: [RFC PATCH 0/2] buildsys: Use host meson on macOS Sonoma (14)
Date: Wed,  8 Nov 2023 19:32:49 +0100
Message-ID: <20231108183251.80572-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

macOS 14 "Sonoma" was released end of September 2023,
developers who upgraded they host can not build QEMU
anymore due to some issue with meson, described in
https://gitlab.com/qemu-project/qemu/-/issues/1939
(mkvenv ignore the host meson and forces to use the
old meson 0.63.3, which doesn't work on Sonoma).

I have no clue how to fix this meson issue, but I put
these 2 patches to keep testing Sonoma out-of-tree
during the release freeze window.

Successful build:
https://gitlab.com/philmd/qemu/-/jobs/5491256155

Based-on: <20231108162022.76189-1-philmd@linaro.org>
  .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
  https://lore.kernel.org/qemu-devel/20231108162022.76189-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  configure: Use distrib meson on macOS
  .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)

 configure                         |  9 +--------
 .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++
 tests/lcitool/libvirt-ci          |  2 +-
 tests/lcitool/refresh             |  1 +
 5 files changed, 36 insertions(+), 9 deletions(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

-- 
2.41.0


