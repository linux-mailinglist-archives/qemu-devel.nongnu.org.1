Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6897C890E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL1-0001n2-Af; Fri, 13 Oct 2023 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKy-0001lW-Nm
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKw-00054q-Ul
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso22961655e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211865; x=1697816665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9MMbyBuswR9G+sFmNjydmicR9+5AI7UWtO0HoNWNNDs=;
 b=p23m6k5B1wiEt653UOVn0VRVzUst88wKMyGHrWpdIFKG/aVOYc+v7VE3aZhFowUZ0O
 TJHDoYlKVz3hyu0NgjHCK4ek8o+vEY8s4sbB3acL8MPlMpyWvj+RTcy06qTOvlk0FU4X
 9Vm0kAR+O7O1GyE/fFcv+TbNRY2FnQMHA1axZKfAa+Pm5ZqubLWpptrK1ReT2fgsBpyp
 CGzd/eIu7PCb1NJ1fX6ZxnTOwKdpGsc7QXIKenKx0+Ayt1EIl3kNwN7e26J+NfhffWm5
 RGdAckiKx4S5EahJRbsyflhjhS5ZJY34/KSiRWBvd1fj4iE44lrMLueO8pLmBQhp654Y
 xB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211865; x=1697816665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MMbyBuswR9G+sFmNjydmicR9+5AI7UWtO0HoNWNNDs=;
 b=mUah6zhDuZu3567Q8oJtQqo0L2T/XihCB7U5u2w4K/tP2uWhSea+FGXhNNmNRNdSXs
 AZ/yh0cYmPM8J1o6CWV7fYqDHjf/5rCUw+7056/qg7assyC/xkovdtgKkRpOWOdI8mQB
 9zsiZdRonfCtVx1tTYoaMer+/S2zDftlHFEWN8d2Wpel1taabOyts7OUxy2yaN/JpKKl
 5hBcWLnFMeKlJvKvPZAmvtS72xvBIffE8gzHTTxyz3/Lt8o7P5Rfh5LMrHhu/yxplr8l
 CkHIE+F6kCcDuk/rHsrWQ2Ub1AdGZRzmlRqo2WEv+QYkZvGZPhg0+MNZ24gM2Yyu7yzJ
 gziA==
X-Gm-Message-State: AOJu0YxyEUul//H8a+UoZamH/12nQs9PVYkSDutzXPEIDpuf+i31VxNG
 suviRIBhKfNtzgUNZ6sRc86ST/+povOiNEYAJHo=
X-Google-Smtp-Source: AGHT+IEsy04559IWzo1VvkVoogv7azqszka/tgkHz2/Vq30r+RWd/4wpcY9e7E9PGnla8AW8Qwnysw==
X-Received: by 2002:a7b:c456:0:b0:405:3e5e:6698 with SMTP id
 l22-20020a7bc456000000b004053e5e6698mr25672515wmi.27.1697211865126; 
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b003fd2d3462fcsm367149wmo.1.2023.10.13.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:24 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 520991FFBB;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/8] gitdm metadata updates for Oct '23
Date: Fri, 13 Oct 2023 16:44:16 +0100
Message-Id: <20231013154424.1536392-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

I was looking at the stats today so I've done my usual run of gitdm
and then attempted to fix up the missing bits. I've had to patch gitdm
to deal with gitlab URLS in place of email addresses and will have to
work out if that is worth upstreaming at some point.

The Rivos Inc updates actually got acked a while back but have been
sitting on the tree waiting for me to bundle it in a PR. I've added
the HiSilicon, Daynix and mailmap patches. The others never got acked
so the come around one more time.

Thanks,

Alex.

Alex Bennée (7):
  contrib/gitdm: Add Rivos Inc to the domain map
  contrib/gitdm: add a group map for SiFive
  contrib/gitdm: add a group map for Google
  contrib/gitdm: add more individual contributors
  contrib/gitdm: map HiSilicon to Huawei
  contrib/gitdm: add Daynix to domain-map
  mailmap: fixup some more corrupted author fields

luzhipeng (1):
  contrib/gitdm: add domain-map for Cestc

 .mailmap                            | 2 ++
 contrib/gitdm/domain-map            | 4 ++++
 contrib/gitdm/group-map-google      | 5 +++++
 contrib/gitdm/group-map-individuals | 1 +
 contrib/gitdm/group-map-sifive      | 5 +++++
 gitdm.config                        | 2 ++
 6 files changed, 19 insertions(+)
 create mode 100644 contrib/gitdm/group-map-google
 create mode 100644 contrib/gitdm/group-map-sifive

-- 
2.39.2


