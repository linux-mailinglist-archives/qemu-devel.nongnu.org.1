Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1774AECB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHipA-0001iU-6W; Fri, 07 Jul 2023 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHip3-0001bb-5Q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHioz-0005IN-Fh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:20 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso2743823e87.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688726174; x=1691318174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UyAYOyHT5U4sX8M2MRGyOMGKkNeDmSPha7//ljkmPUE=;
 b=mdz9UDGyae2kxQw/TBW32brGAA/qnC6Mbvy7SF91TSllR8ZJrnVgbV0PAumiFBzYjj
 7J5u/D8pYC5/afqkOG/3nNbaOO3zQjcPNrS9lFAMbKk5BXVtPNCRyY2a5Vvu6fnrDP0w
 CPqq8J01cwk7eol8stc8kKoo1WJHvHQZ44JtALdQvlymCROIHHzc7DV3CYdkORz1MLPd
 4ICDhDAHsOzOvq61X5yD/2riPpbxElTMx3nFqAz9nGLNRFihOWUf8JYIHQdeR2bdpm8z
 G2h7de0rccOfRiQTr/z/TYR3ZFj7CNGlTsSuq+q5dVGcSct+uBwtCzXxVTF/ljw1JPq+
 KwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726174; x=1691318174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UyAYOyHT5U4sX8M2MRGyOMGKkNeDmSPha7//ljkmPUE=;
 b=Cx7XyzIMtolc7j/240D/2d9HxMqhRFs245iWseiCTtLfBYfuCVmoxfpgdWTVlOsaoV
 VuBy1TwMm0iEWzI2Dd2cgnKwnJx8XI2H/nXXHw0QBafRkTjrNThaJBBSw5oy8snHmYEH
 E/F4Y5LaYyloB2aSRYa6n0kZauc2H7+wM01crW5XDCINkbGWF22WOA2sTsI3C4XyMKq4
 YAyBLeap8+sIf2rR8je1dy2N8aKGp+ivaXSSZl6AQfoj0Xi6934BmjdstuyYGcGU8uAv
 iB1ev3cem2Sd8TuebpSeduNRHVJKWkjGZSeeevhSYJSDFdP2DZFBrU7edfSN0KPFEhjS
 csxQ==
X-Gm-Message-State: ABy/qLa3AyzanMefOsuaWXOFlyze4zgGBTZUhpZnA99JixZoX4MReZ7N
 QIuQ8yonX5B5v5KYFx71SnKpJnJ35DRrsRxLQUg=
X-Google-Smtp-Source: APBJJlFTFVxIOEBh2YG1u3kMmQisjJoDhhPbHoQG5lL5WJIUDrMex113385Iva5VtPso8bMNOdz0eg==
X-Received: by 2002:ac2:4e07:0:b0:4f9:5a0c:85b8 with SMTP id
 e7-20020ac24e07000000b004f95a0c85b8mr4198024lfr.36.1688726173982; 
 Fri, 07 Jul 2023 03:36:13 -0700 (PDT)
Received: from stoup.. ([91.223.100.9]) by smtp.gmail.com with ESMTPSA id
 q14-20020ac25a0e000000b004fb953f74d3sm626966lfn.264.2023.07.07.03.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH v2 0/2] accel/tcg: Fix race condition in tb create/invalidate
Date: Fri,  7 Jul 2023 11:36:09 +0100
Message-Id: <20230707103611.5906-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

Changes for v2:

Adjust the change to cpu_exec_longjmp_cleanup, which should now survive
user-only testing.  I'm not really happy with it.  I suggested two
alternatives in the block comment, but neither of them are trivial.

Please re-review, if you gave it a glance before.  And if you have
any bright suggestions short of "use real exceptions", I'm all ears.


r~


Richard Henderson (2):
  accel/tcg: Split out cpu_exec_longjmp_cleanup
  accel/tcg: Always lock pages before translation

 accel/tcg/internal.h      |  30 ++++-
 accel/tcg/cpu-exec.c      |  63 ++++++----
 accel/tcg/tb-maint.c      | 242 ++++++++++++++++++++------------------
 accel/tcg/translate-all.c |  43 ++++++-
 accel/tcg/translator.c    |  34 ++++--
 5 files changed, 255 insertions(+), 157 deletions(-)

-- 
2.34.1


