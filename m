Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B665983095D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7cl-0007xC-MI; Wed, 17 Jan 2024 10:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7cj-0007o9-T2
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:37 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7ci-0005nA-3d
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:37 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso6694457a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504474; x=1706109274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NhlggFtbJPWMoqQJ+HB7NzhCS/+mnYvNfLuAG2nhja0=;
 b=BcNNVoKFbs4lnHyfpKe1eJvuOY2Rd5yMsB3XlE9I/tOX2V44uL8dvTwM55LydG72rZ
 EWdg+qBZmwe4mrf4fAwNqgW14EPT06YQD1F3ydSjIpV4Y5IYSgsroWC87J2jEEvb8PvZ
 YDkTHS38sbJcipvsC43DlwGY4X0omjQ0gvLqfj45+5Ps1ogg1hQsDLVRrEUjtHHtwrAL
 /3vIPeVQX1vnzVsK7nPniNPqR+68ZYHh75Nm3cbxMGI5BDpZ3n3aAzNMUz7gqSWHiI6W
 UB8t3V9LNXhAou1mqI7tiE5ePGDNWHe8hKeA40VKviIIaUclgv+o/JFgBWBcrKnA/gnV
 Ya5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504474; x=1706109274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhlggFtbJPWMoqQJ+HB7NzhCS/+mnYvNfLuAG2nhja0=;
 b=mItX5i+Pyi5PFzVUL01mQZASg6wEtcw51ILlQ8bSdET8rHwiXP5I/2pFIxMUDP06Pr
 bFhe9XcR0/2W9XTYH6uF0geKDYo6H2O3i4fPY5DTj7iAwW7m83ya2nxhJTyK8sAXpAc/
 PTADgh0czFFk8ddaX6JuhBOoyKWRkwJ7npaHHl++fjEaX4kQnnTB0AQHUs3ZC3tzbgLl
 BNBa20czA8nLPgf+nv1f6mi0AJbnUqbgjCE4T4bd8wa04pBah9J8DlTmdVG64XMLWTX+
 7l0+s9Ku5I+0hnsD8FHpsmpdnw0fbBIEAlnY4VIqoQzgxkmyaNllNh0o1hlkCiI2bldG
 F/og==
X-Gm-Message-State: AOJu0YzR/U9egGiCINEcLDppEWuEqqdJ2yF2LtflBEuf6zzCUWtiQ3HG
 3TilrwDph4eKHPiMGDWLCVKsl1m+Vl4mC+rQnZ8bEskFVmM=
X-Google-Smtp-Source: AGHT+IEeSmvFQtQS3qAAMneMy2zkFkb4IIeC3d87YOZMM58JF+/j4bKmAcHxzk/dpmIIAIDpG/Gh6A==
X-Received: by 2002:a17:906:54d2:b0:a2c:6bca:dd20 with SMTP id
 c18-20020a17090654d200b00a2c6bcadd20mr4394172ejp.67.1705504474169; 
 Wed, 17 Jan 2024 07:14:34 -0800 (PST)
Received: from m1x-phil.lan ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170906561200b00a2e99c12ea5sm1624592ejq.157.2024.01.17.07.14.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 07:14:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] qapi/hmp/cli: Remove the deprecated 'singlestep'
Date: Wed, 17 Jan 2024 16:14:27 +0100
Message-ID: <20240117151430.29235-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Deprecated for 8.1, good to go for 9.0.

Based-on: <20240112100059.965041-5-thuth@redhat.com>
          "Remove deprecated command line options"

Philippe Mathieu-Daudé (3):
  qapi: Remove deprecated 'singlestep' member of StatusInfo
  hmp: Remove deprecated 'singlestep' command
  cli: Remove deprecated '-singlestep' command line option

 docs/about/deprecated.rst       | 40 ---------------------------------
 docs/about/removed-features.rst | 24 ++++++++++++++++++++
 docs/user/main.rst              |  6 -----
 qapi/run-state.json             | 11 ---------
 bsd-user/main.c                 |  3 +--
 linux-user/main.c               |  2 --
 system/runstate.c               |  8 -------
 system/vl.c                     | 18 +--------------
 tests/qtest/test-hmp.c          |  1 -
 hmp-commands.hx                 | 13 -----------
 qemu-options.hx                 |  8 -------
 tests/qemu-iotests/183.out      |  4 ++--
 tests/qemu-iotests/234.out      |  8 +++----
 tests/qemu-iotests/262.out      |  4 ++--
 tests/qemu-iotests/280.out      |  2 +-
 15 files changed, 35 insertions(+), 117 deletions(-)

-- 
2.41.0


