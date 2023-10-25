Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 054337D6E61
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveVV-0000DV-KU; Wed, 25 Oct 2023 10:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qveVL-0000CB-TB; Wed, 25 Oct 2023 10:05:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qveVG-0006Rh-QG; Wed, 25 Oct 2023 10:05:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so4004422f8f.2; 
 Wed, 25 Oct 2023 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698242694; x=1698847494; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wHe83ByeV2XV4KcSh7weGirooP3OeflYjgrtiBprCbg=;
 b=HRzOOj6RHgL7HSfVwJInF9XxOhVQKJ6wH59r4QQb84lPwpyWm8EmvRc18+HoYEMH8A
 SgE1fPsLWgEY4vzg1vHgu8+V8oG9jFnffrgeB5rv5vSpffdFk1eWvmrnQdfo5DSrrD6K
 2hK6woGd0qLQ2L/RggUQVLaE1OcqHGXNNk0K6JoJrNQY3IM7WVUP0JzMaDjQ2CgoyEm4
 L/mfmuKOc4Q5FsKr5v11n+vdAipiY8rQAlvMSOGbBTcfJuQamCz0cGcNfgWPF/oeLU9y
 LMcdeb6GudEFBz/OYeA0TR3h2xjEddekuv3/zrlhDJuXoWCwO0lYtORaFia5Sdp+c/+h
 apkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698242694; x=1698847494;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHe83ByeV2XV4KcSh7weGirooP3OeflYjgrtiBprCbg=;
 b=NOwzYXdN4odGRfLBoaxdhitHU6fy/4mTiAFQosHHmW5O2OGzCKjAbFfue2Erl6bju4
 c4TO55sAWLrE9LyAp6xDUJLGKe3cMmcMusqyDfL2+DKt2GR7kH5G86Lae9zpeYdcsGWs
 NnE7ewk+gcf6Wk6nPGO7NKwrxoiYSXpGsabvkovxMdZhP5KOocyYl23CVt4BLtC3SsF/
 G+XNZ1tFDjBI3PpXrZS49tVRGyv5as7giNjPaMBlJYi9/fCPyVUfqCsoRzyiMUwwmHPs
 L4TbNJnzB26XPkxWfBAvs29HvITrA55UmMEQFjMozoY4KpgByUcAbYpAUasakoV6GdS7
 +FFg==
X-Gm-Message-State: AOJu0YxgHTaQjr/y8KJcCT7sa3nTiLXai39CZQLcrLJtkzLHB0lpFDRf
 fGRs501lubIcEWOIFu8LVz2ehA6EAKg=
X-Google-Smtp-Source: AGHT+IHKCpm0KV3kIaF2dzlmRoweqCLTrLrJ0HZ33EVaRR4JM5KVNkKDpkvhmEt4jXGuN0PztxQYbw==
X-Received: by 2002:a05:6000:1c05:b0:32d:89ca:1761 with SMTP id
 ba5-20020a0560001c0500b0032d89ca1761mr16923730wrb.43.1698242694173; 
 Wed, 25 Oct 2023 07:04:54 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 d17-20020a5d6451000000b0032da022855fsm12103044wrw.111.2023.10.25.07.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:04:53 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 akihiko.odaki@daynix.com, Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH 0/1] ui/cocoa: add full-screen-scaling display option
Date: Wed, 25 Oct 2023 15:04:42 +0100
Message-ID: <20231025140443.68520-1-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=carwynellis@gmail.com; helo=mail-wr1-x42e.google.com
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

From: Carwyn Ellis <carwynellis@gmail.com>

The intention here is to allow fullscreen scaling of the display to be
enabled by setting the display option `full-screen-scaling` to on,
allowing this to be set from the command line without having to interact
with the ui menu.

Carwyn Ellis (1):
  ui/cocoa: add full-screen-scaling display option

 qapi/ui.json |  6 +++++-
 ui/cocoa.m   | 33 ++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.42.0


