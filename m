Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC087D9D67
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwP5f-0007Pf-4S; Fri, 27 Oct 2023 11:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwP5d-0007OV-0F
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:49:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwP5b-0001D2-HK
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:49:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40839807e82so13480925e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698421774; x=1699026574; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x6KKFyFQxpqm0x1XuZKP2XYctzabAy+VkUOVXYUasiY=;
 b=AXt16+FOPxAendirEz685yFsXAbFmIgXS6fph7AXmh95qirURwThx2IfRw4irhMMss
 gCP+U41PxfJglFJ73Kcv3d3/5M9KecCweTEv7mKLzD/QQLQdC+MRt0Sg2gIxwUgNh3UM
 U4Gt8m6pilqn590+KUuY6+YTrqNfdSFDoe2RndcJGlYsJIZM1i1EX7ZdXhQMe1pP1Lwg
 MX6qKnxx777DkfIgf+CIqPKPBoHTkqgNF/RXugpoaVu23DZnIyVAve8noBKYiSf39XmL
 5cdE5Pz25Yok1LKVekI8PJOQNvEMg3z/Dia3FLXRmRbo4Io+C78f9BUDwAr1l2uKGElk
 Sbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698421774; x=1699026574;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6KKFyFQxpqm0x1XuZKP2XYctzabAy+VkUOVXYUasiY=;
 b=BPzXnRnc0DhIWD30m5dHmix6eZl4p0u4OLK96yN1m4d+MwqhTWJhBesDFFNeYpyRt6
 p8yT7aOZktagNwh0EijD/a6ymfFXYsizEH15mixvgVfy0yOp5xhBR2iH22dhDwW8Peyj
 p55tpia5o1AkB3/dIoiC/6mBBqhBPR8LPO01PedGW5ZFw0M42XsNSfF6/IokypEbrqiZ
 PEDr/b7iJXX28W1/XAM/u7Wy4xS6pkMYFfOuDPc/DcGUjHul0jsmjrfwP81aZp7qXO+c
 WeV6TZaHqSCxDJLf9TNOzQeSUhSZWZO5UYiXLXmSYWdRL21O6sy5D8RsFOXlDjpC0IVR
 NC+g==
X-Gm-Message-State: AOJu0YwG9OCCEzxzICIzNpceRVmIgt90U6MYITxo3HBIhN5oIWbmoXlD
 9NiMerBoNRoDp2dpIOZ3O89di5zUEwc=
X-Google-Smtp-Source: AGHT+IGqAk8JvYcCfiK+aj9ty1q1EQn8+Q568Pymj5+3dhXp2EpDOTM6M5YdOz2zGXqxldjz4+mE9w==
X-Received: by 2002:a05:600c:1caa:b0:401:b425:2414 with SMTP id
 k42-20020a05600c1caa00b00401b4252414mr7249615wms.18.1698421773757; 
 Fri, 27 Oct 2023 08:49:33 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 u7-20020a05600c138700b003feea62440bsm1910362wmf.43.2023.10.27.08.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 08:49:33 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH v3 0/1] ui/cocoa: add zoom-to-fit display option
Date: Fri, 27 Oct 2023 16:49:19 +0100
Message-ID: <20231027154920.80626-1-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=carwynellis@gmail.com; helo=mail-wm1-x329.google.com
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
enabled by setting the display option `zoom-to-fit` to on, allowing this
to be set from the command line without having to interact with the ui
menu.

Includes changes requested by Akihiko Odaki.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>

Carwyn Ellis (1):
  ui/cocoa: add zoom-to-fit display option

 qapi/ui.json |  7 ++++++-
 ui/cocoa.m   | 32 ++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.42.0


