Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F07032D8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyayZ-0001NJ-Ja; Mon, 15 May 2023 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyayK-0001DU-QL
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:22:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyayG-0005Mk-Fw
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:22:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f49bf0223cso60505175e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684167767; x=1686759767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2xCB1djwk5bNebMYptpkXZFGzFfrwIlQDsZOv1rSzM=;
 b=Fynbv1TW1V/sSLOkusz6vkcybNd8jLPfd9VBEcQY5y04irqPGQ3YhCrFaBCZdQ91pO
 AI18PXCtzRF/1IdDv+6TOkrPc0qMw4LvtfSnGLx9MXiUG5yxE5EPD/nONz1JVs5ZHPHX
 YNeDlheBrsa/UPAA4h9abgUi1G8ats64UkaxVjAVVpvSED4Nvl23pxPmTtApvR+Gdxbr
 dq93fio+TyfyaxX36u0fkno401V9cNXayl/GpvCnbNpdN29gx0lVxqz6liAjTvfqvLd8
 1vp58XtkZiokhhSHopvuMHPzW6WOCpOkfHzT0tO1cMq/ehmhvEGonaKpFfDkfJRL7XeO
 yAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684167767; x=1686759767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2xCB1djwk5bNebMYptpkXZFGzFfrwIlQDsZOv1rSzM=;
 b=SyEqcIOiMqZ/mSFFl/H3jGS0f2wzdKGWG2OZ1IllCox29TPMj1X+wRceKY8fbf4CwU
 e1QQqR6x2TaM1SSqu5fkG19NswPq7S6m2jXVMFs1h9Fst9aookeDGS57dpqnc3tcohSD
 D1MN5a91zm9UHTL2tp5ocjFXJpw89VNQZ+CRn9vpYEDQVT8xEc9PWXsEp5XXHFdlU0ly
 V3+PhyKT38iIls89PE3jRD9V7MsC1csyhqEyNGhCBi47ELUDY9wKUEImdfMWUrg5nmg4
 ehh5wGK1Lq+2TRcHmk3gfjY8Dnlg859ym51AU4WzMLTayR8vv899s2mZoDXcLtX3zHUH
 +yPw==
X-Gm-Message-State: AC+VfDw2ml9AptbhMCdQJQeFXDBGd/evioZ4SlrWbAohKfognkLCjlXr
 QUJzofY+w92Fql8XPtCbPkt7fmrqJuhe+iVb6JM=
X-Google-Smtp-Source: ACHHUZ69gFpJqokmND9Fk6ZxmIahGZ6uCXvI/6zfM2An/xCOYR2HCTBDBRqqlG2SNv25kU5dHGmzMw==
X-Received: by 2002:adf:f3c9:0:b0:306:3319:e432 with SMTP id
 g9-20020adff3c9000000b003063319e432mr23858142wrp.18.1684167766737; 
 Mon, 15 May 2023 09:22:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adffd4c000000b003063176ef09sm278203wrs.6.2023.05.15.09.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 09:22:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 0/3] docs/interop: Convert QMP related txt docs to rst
Date: Mon, 15 May 2023 17:22:42 +0100
Message-Id: <20230515162245.3964307-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This patchset deals with a couple of the old .txt files
that are still hanging around in docs/interop: qmp-spec.txt
and qmp-intro.txt. Patch 1 converts qmp-spec to rST and
integrates it into the manual. Patch 2 takes the only
interesting parts of qmp-intro.txt (the example command
lines) and puts those into qemu-options.hx so we can
delete the old .txt file.

v1->v2 changes:
 * some trivial tweaks suggested by Eric
 * all patches have been reviewed
v2->v3 changes:
 * patch 1: fix up references elsewhere to qmp-spec.txt
 * patch 2: new: updates an error description text

Still needing review:
 * patch 2
 * bits of patch 1 which update the qmp-spec.txt refs,
   though I felt they were minor enough that I retained
   Eric's Reviewed-by: tag

thanks
-- PMM


Peter Maydell (3):
  docs/interop: Convert qmp-spec.txt to rST
  docs/interop/qmp-spec: Update error description for parsing errors
  docs/interop: Delete qmp-intro.txt

 docs/devel/qapi-code-gen.rst                |   3 +-
 docs/interop/index.rst                      |   1 +
 docs/interop/qmp-intro.txt                  |  88 -----
 docs/interop/{qmp-spec.txt => qmp-spec.rst} | 337 +++++++++++---------
 qapi/control.json                           |   4 +-
 qapi/qapi-schema.json                       |   3 +-
 qobject/json-lexer.c                        |   2 +-
 python/qemu/qmp/models.py                   |   8 +-
 python/qemu/qmp/qmp_client.py               |   4 +-
 qemu-options.hx                             |  28 +-
 10 files changed, 221 insertions(+), 257 deletions(-)
 delete mode 100644 docs/interop/qmp-intro.txt
 rename docs/interop/{qmp-spec.txt => qmp-spec.rst} (55%)

-- 
2.34.1


