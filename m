Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966EA22C81
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 12:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSgu-0001So-Qt; Thu, 30 Jan 2025 06:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgi-0001RV-8Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgg-0001h0-Mk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso6842505e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 03:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738236378; x=1738841178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oDChLXLxiN5PUCRf9Wn7YvcZIExpYAJcx8WIUe8Sv+g=;
 b=G6gSTGcB66KsznpNr2tZHaJLWBINVUi8xKb4i3e4C+mMrsEo9F5R/9b6IHuuNqYFNb
 6XOVu1nqu/nsixolldcmShIaNt3Ao0CuX9CH5IW/X1ZzkeUP+udK3A49WWsKTOv67BCI
 crYqYTJUn0fLoGxzNorUWscuxE6fEofLpJsVhaiqgeUENZqMvd6wNHe2IB+hSsIP1l0d
 HU/iT9eVkWdUPpQwjdFUHc6tCKvAeqWZNua2CvzKDBc0/wYlgDEcvOGvShqoOzQUZEvQ
 kKB/QLHyKAZkhm1AETbwTYgcTiX989JvndccYo4u52EJpQzn9jKagKBloTl4GXkq3RAr
 OfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738236378; x=1738841178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDChLXLxiN5PUCRf9Wn7YvcZIExpYAJcx8WIUe8Sv+g=;
 b=oxIwx6I7vI3Dcw/kwWqpXIMpO+j8lqFyTCEoqKiKN/M3kSPy9FHdhCBUEiIQQhuhpl
 rUZApnnBn7gFvRZ5Dxfv3K//WLYPuw0nDLdgic6hLPciiQZV+2ehtarerjrLXZyuBPBj
 cP+OfqRPdQ2fQ8b86ZAOGsu6gBehZ2vljqf2j3+EuesV2TTHEoV1wFYgfFcyx91KmREw
 oQGTh9+orpLq6aGe2ydLU7iMxLjI/r4c7oehOLBXktYkRPhn0qCp4c8OgMqJvvhyzC/J
 GhOXxQ4bI7KLZu0TEd0H5ttpEKEOeIi1esCueqvfCMOT72emDSArtJADpwbwtiNqKDyS
 QLWQ==
X-Gm-Message-State: AOJu0YyXre7aJJ7EgxsTjrPbteCoAGqYM/ZJSfQSNry8FfUEa7Tb4gC8
 Q2IZ7Gs3UdZlQqPVYpaP7ltvh2Cf6FHV0+yvSE35lwdX5U7g1FDC0b0wFImJGHhbG3T5aJv4Rq/
 o1Cs=
X-Gm-Gg: ASbGncv5ijhISvUuesUHTUqDnpJWWXn86fLDIwyS0hSE/bQv+CSkJ3Znp+9ycHja3qn
 sDTcX+UPQb91xYs2ds1TCRM3GF0BXLF918/BMb/rbk1uvlTB2/2UHd7ne92mllFnWFkMxxZ2OMt
 dlM2KiUA9KOmACdvEKxmOtZEIJZySf1hNwLLd4l6BViyysP5jvrJ19CO4BDbwUgynl7OE/lKnK9
 Rp+lcheRJxQMsPCphHQPRsKG0Msbz0i4qt2Myic0RFAH4qm69bA48dm2RIe+Qe25WTVy/ElNOzj
 bv6W/zBwMi1isDIqoCDD3tJ7xvdzSWhR2bQgQBnyX4IKoN77FLWe3w+3G7FNcyRSLw==
X-Google-Smtp-Source: AGHT+IG+B79msK8cp5mjAb9pPP8J5AfMn2ksyOmQViNt2B2CptWS0ARDYIJLi1A5FZl6pabV3hQY/w==
X-Received: by 2002:a5d:47ae:0:b0:385:f6de:6266 with SMTP id
 ffacd0b85a97d-38c5195cbe3mr6337833f8f.24.1738236378234; 
 Thu, 30 Jan 2025 03:26:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81a39sm54569145e9.35.2025.01.30.03.26.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 03:26:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/arm: Minor cleanups around MPCore code
Date: Thu, 30 Jan 2025 12:26:09 +0100
Message-ID: <20250130112615.3219-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

(series fully reviewed)

Hi,

This series contains the non-controversial and already
reviewed patches (rebased) from this previous series:
"Remove one use of qemu_get_cpu() in A7/A15 MPCore priv"
https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/

Posted separately to avoid keeping rebasing.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  hw/arm/boot: Propagate vCPU to arm_load_dtb()
  hw/arm/fsl-imx6: Add local 'mpcore/gic' variables
  hw/arm/fsl-imx6ul: Add local 'mpcore/gic' variables
  hw/arm/fsl-imx7: Add local 'mpcore/gic' variables
  hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
  hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro

 include/hw/arm/boot.h    |  4 ++-
 hw/arm/boot.c            | 11 +++----
 hw/arm/fsl-imx6.c        | 52 +++++++++++++-------------------
 hw/arm/fsl-imx6ul.c      | 64 +++++++++++++++++-----------------------
 hw/arm/fsl-imx7.c        | 52 +++++++++++++++-----------------
 hw/arm/virt.c            |  2 +-
 hw/cpu/a15mpcore.c       | 21 ++++++-------
 hw/cpu/a9mpcore.c        | 21 ++++++-------
 hw/cpu/arm11mpcore.c     | 21 ++++++-------
 hw/cpu/realview_mpcore.c | 29 +++++++-----------
 10 files changed, 118 insertions(+), 159 deletions(-)

-- 
2.47.1


