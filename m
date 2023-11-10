Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1177E7DB5
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 17:19:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UCX-0006dP-MF; Fri, 10 Nov 2023 11:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1r1UCV-0006dG-LW
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:17:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1r1UCU-00052U-5a
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:17:43 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084095722aso16610075e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699633060; x=1700237860; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aYeszopDPS2sWFGSUBt5YWzdaZRZHzlScHWA5XAbyZk=;
 b=nBnYJZOmsSrUQAojyZVCqUnFZY49kz3SGGjGSOO4uPPvbUudeJSwCRM3jz0Y0mxRiv
 3GBfB54tdm9jwyRFLtz3VJTWhiRSoniddYSNgZ80H3EIYLq3FdFfSo/77xRzY/wLz0kA
 fo9A652VHXYd0l1vfZIO1l98O/NemVe6ABy1XXrxKWo0TlbofB7+Z2tnvcQwDHTKrhzB
 6RHRaWOamBoBQsD4+t6/gGvFJKGxbWtGWAfWptW7ZBl2fDy3g6oQmf1cXsCKpz5MtpX5
 OA5EJUZhc2ryGdUHqr2Rt7WWswKNx5sY0JZVpK+lJ4TeEwPLOZSLZ7QjkWzuqs0BB9bY
 EOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633060; x=1700237860;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYeszopDPS2sWFGSUBt5YWzdaZRZHzlScHWA5XAbyZk=;
 b=Ou2VRJ3B41/zYh5fy+I+TTmAG1zF4qXaEy5UWWb9aGGzRi2s/mSJDlqUZFpja9Os/6
 qb+G7w9l5aF07vDguVE4DjoSg9LIRKk39L926ftWUsx2Yq7Ld/txexdRMPO3aalelUZj
 hAXcy+FhOq1EWSLq4BJ5L0lClfA3uF9OkgcrmpTZunKgjiYtx0kgwVWqWsC5LNP7APNE
 YOuXXkxQfpjY7p5LwtXt0PhU6pGOsOHAN/d+QhWaOSa3eS5LRNxaT0hOUpVLU1cFibPg
 oQQQvI0YoWLl+Y6PjrtGz22FsJVV41TypeFywI8VOyBN7r3pErrBQDovLfpAtYWFrYmq
 ueCQ==
X-Gm-Message-State: AOJu0YwElofZyWxZnzoRulo8IUVvwpDPJtfNpjL/MAKMPtjWBxwzPezf
 dDScUn2D6jb4Ns+WYGpoSWo8/3gwJFriAg==
X-Google-Smtp-Source: AGHT+IF8zoLm69xRcPisV45sATm4e3WVep2b1UQ6O0HcmS1MyR99B7KQAA+CBEPp60vpY7VpuUz5zg==
X-Received: by 2002:a05:600c:3398:b0:407:8e68:4a5b with SMTP id
 o24-20020a05600c339800b004078e684a5bmr7895488wmp.38.1699633059756; 
 Fri, 10 Nov 2023 08:17:39 -0800 (PST)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 u24-20020a05600c00d800b0040a463cf09dsm2097879wmm.33.2023.11.10.08.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:17:39 -0800 (PST)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH 0/1] ui/cocoa: add zoom-interpolation display option
Date: Fri, 10 Nov 2023 16:17:28 +0000
Message-ID: <20231110161729.36822-1-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=carwynellis@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Carwyn Ellis <carwynellis@gmail.com>

Provides a new display option, zoom-interpolation, that enables or
disables smoothing of the scaled display output when the zoom-to-fit
option is enabled.

A 'Zoom Interpolation' item has also been added to the view menu to
allow interpolation to be toggled on and off as required.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>

Carwyn Ellis (1):
  ui/cocoa: add zoom-interpolation display option

 qapi/ui.json |  6 +++++-
 ui/cocoa.m   | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.42.1


