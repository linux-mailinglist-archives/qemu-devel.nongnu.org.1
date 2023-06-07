Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74E7264E4
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHR-0001WB-M6; Wed, 07 Jun 2023 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHP-0001VO-7K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:40:59 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHN-0001zL-Ir
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:40:58 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-39c503bc770so1642445b6e.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152456; x=1688744456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cHypB5KQwXDl/tfoAPzh+5827/JV1iggeEHEWu+bnZE=;
 b=kIXFK4VR2Ip0lnE17bOR13+yolMMzA6cmwsFLvB01n8cYQmfxVraAFZ5QNo7oBKyhF
 diJrxpspoTJ1gcsfYYHFfn2As5p5bQvxxuJp5nOJUJPAX4yTVEOLfTQQHBG4vmCNttiR
 xWsiTHignSmIOssKUCdHqwZjpViJIU0IoWD3+NUJlGMXHfiLECyAAzDLmUMU9iU3TlpG
 /Rj3QFB3/InytAztEBltO/i/XlDODBkrQwxCLpwd9arvSNadUemJ5yDZc43RyQvJz1so
 Cy9EJ4bW856Cabv2BqdmhyeVHlWzhC/01F5wqFMgxzb/TzzmnXfr9FW+wRA6MesvVTfj
 1wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152456; x=1688744456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cHypB5KQwXDl/tfoAPzh+5827/JV1iggeEHEWu+bnZE=;
 b=O7hjUZDOaH6/5lRbfDQ7sI/HEfG1aM6LK+TugoXkifLmhvyaUp4tD8Z4uirgL8zii7
 eEvMfCDbVVjggup/sAsq9SGtqtozkkzBlkJuFq5bm3E8lAjnQlnCgEygaZaNUFfdDsmc
 Y6sBA/KMfViQ1hKKrCvns3MjkmaSzBIKUc7KSPhg1F4wcMVv3aY8+rhKjaAyE8mK0xVp
 BSVpV2dT07dPcOj7Zx8Ml+FB/Kt8lvmXES4/qQwKtCrrSIpxcODaD1pbEPzmo42meCxH
 XrXRSz1VS74n8IgVmdKEOw+3g5J9/Z8EX7vpovGrFP0D0qYjnTBK008GLtiCxBqn5MpE
 1buQ==
X-Gm-Message-State: AC+VfDzIFhieStCBppoyGtOFTff3awolnO5sMEnV4njI63wppeWOilEw
 JyGTYoNZp1KLpYNk9JdH8klO1FBv905rhzuqyvE=
X-Google-Smtp-Source: ACHHUZ4p8bWcP9iK0zB/n3svtni3TllK1jf03HQApTilwvQBocPrAIKw6swV3gw0UYimI/cUAyT0DA==
X-Received: by 2002:aca:1704:0:b0:39a:bb23:e54c with SMTP id
 j4-20020aca1704000000b0039abb23e54cmr5556044oii.46.1686152456056; 
 Wed, 07 Jun 2023 08:40:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] misc ci fixes
Date: Wed,  7 Jun 2023 08:40:49 -0700
Message-Id: <20230607154054.625513-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:

  Merge tag 'pull-target-arm-20230606' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-06 12:11:34 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-ci-20230607

for you to fetch changes up to dcc28ab603f30df5cc8be1f759b423e94ae7d10f:

  iotests: fix 194: filter out racy postcopy-active event (2023-06-07 08:36:55 -0700)

----------------------------------------------------------------
Fix TCI regressions vs Int128
Fix Arm build vs --disable-tcg
Fix iotest 194.

----------------------------------------------------------------
Richard Henderson (4):
      tcg/tci: Adjust passing of MemOpIdx
      tcg/tci: Adjust call-clobbered regs for int128_t
      target/arm: Only include tcg/oversized-guest.h if CONFIG_TCG
      gitlab: Add cross-arm64-kvm-only

Vladimir Sementsov-Ogievskiy (1):
      iotests: fix 194: filter out racy postcopy-active event

 target/arm/ptw.c             |  5 +++--
 tcg/tci.c                    | 30 +++++++++++++-----------------
 tcg/tci/tcg-target.c.inc     | 30 +++++++++---------------------
 .gitlab-ci.d/crossbuilds.yml |  8 ++++++++
 tests/qemu-iotests/194       |  5 +++++
 tests/qemu-iotests/194.out   |  1 -
 6 files changed, 38 insertions(+), 41 deletions(-)

