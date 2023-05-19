Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B777091FD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvmO-0005Mi-OV; Fri, 19 May 2023 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmI-0005Lu-1d
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:58 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmA-0006n0-TO
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-953343581a4so455266866b.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684486068; x=1687078068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bvn5Xriozote/4chTmRlmTtpiOBeOtFHfsUtZyWYSfk=;
 b=jTwHeCuvtrrgIvb3gU/u4YfOO+/JzxeA80wwWqNRwzylPuOQcJFvokRGg+GtX+3vG5
 vP5zguAL+3jU7VK7QryuKJVEUXMF2WxuiEPoWxcmhD6PohiQy38RvEbZ2qBp79/h8aRZ
 /3jS+9eSp8Uyv3UaCTplDFcHgR1+tG78PHqwv/QPTQHggOLzIKdQ553uCGa4e8FsDlcb
 i1hG1o4Lk3io5KqAOwFCwSb6Z1tKuMVGSmBe188+BzBdRDtWSWd/amdRVHgTxmRRKXij
 ZbEwiIAaZMXqwQOgSPwgNfFuRF7nnhvpw7LcN0Xd49aQOa3+whnIC9Bx6PX9kE8SFASl
 kmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486068; x=1687078068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvn5Xriozote/4chTmRlmTtpiOBeOtFHfsUtZyWYSfk=;
 b=Z92Uuqv9G1+F8DGWGcRT9hXzv6weBogD73FL3oTRlHaalRWJEJgN0/7Lq55pnojOJo
 MQpDyrKMCtWfz4VgRbY/SK+y0qAShBOf7kFeXAH28uRyqCVqxNDoD/haoUvjT5Pd5Dwr
 8PhNOtEM1fhz62L8W58XLDp/OBKPV5ZjDgn5VrlIQufAgO/5+WBunGF4jqlGdf+DJWPF
 rXiTqZTlninnpmbYR5RotYvMKLbysTpVcMrMxsCXA3kDX0/vHgDm8PW7PNwkh2fh/bkm
 lwU1v2TtQcCtp0d6hvBrKujQxzHltuxaPJu3bH9tItXQOyGTUCYyiOtaFQ8nRAw7j2E7
 mSzQ==
X-Gm-Message-State: AC+VfDx2VbAIm/07MRm7t5c7GewqLhsQmrpxw1uGJ1kzks7F+W1vmQZB
 qmEewhX52M9sbQ2fmp5maAPj1r38Vf0=
X-Google-Smtp-Source: ACHHUZ7f5pXddipaKeaT5WGFkdW6nDlUhkAWYgbZHna5F0si0kUg7gvq2WwhyMNJLHGljJ1i/GYt4g==
X-Received: by 2002:a17:906:7950:b0:94a:845c:3529 with SMTP id
 l16-20020a170906795000b0094a845c3529mr1139351ejo.9.1684486067553; 
 Fri, 19 May 2023 01:47:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-014-126-098.89.14.pool.telefonica.de. [89.14.126.98])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170906078900b0096621340285sm2000893ejc.198.2023.05.19.01.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:47:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] PC: Create RTC controllers in south bridges
Date: Fri, 19 May 2023 10:47:32 +0200
Message-Id: <20230519084734.220480-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series contains two patches originating from the PIIX consolidation se=
ries=0D
[1]. Since the two patches represent general PC code modernization (ICH9 is=
=0D
modernized as well) and since the PIIX consolidation series is still under=
=0D
discussion it made sense to split off these patches.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
=0D
[1] https://lore.kernel.org/qemu-devel/20230518172747-mutt-send-email-mst@k=
ernel.org/=0D
=0D
Bernhard Beschow (2):=0D
  hw/i386/pc: Create RTC controllers in south bridges=0D
  hw/i386/pc: No need for rtc_state to be an out-parameter=0D
=0D
 include/hw/i386/pc.h          |  2 +-=0D
 include/hw/southbridge/ich9.h |  2 ++=0D
 include/hw/southbridge/piix.h |  3 +++=0D
 hw/i386/pc.c                  | 16 +++++++++++++---=0D
 hw/i386/pc_piix.c             | 10 +++++++++-=0D
 hw/i386/pc_q35.c              |  4 +++-=0D
 hw/isa/lpc_ich9.c             |  8 ++++++++=0D
 hw/isa/piix3.c                | 15 +++++++++++++++=0D
 hw/isa/Kconfig                |  2 ++=0D
 9 files changed, 56 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D

