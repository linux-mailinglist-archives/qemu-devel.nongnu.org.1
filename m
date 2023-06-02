Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F5C720C0B
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DXc-0005mt-6B; Fri, 02 Jun 2023 18:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DXX-0005hJ-Oz
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:46:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DXV-00067K-3Q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:46:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so2450810f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685745991; x=1688337991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RB0W/rFI1+KpHKK9ZJ6n4RrXr2vvSt5YP/IKazFl/Mo=;
 b=jx73JvdSoQJX+qvf309ti4ZyJC4NSWPJVSMV821hHNO0EbChVCbJL1FezPNt2avNV+
 SLlPJ2LHty1HBIyqgBtHzH1ZN/nbT2KTICmuU+WdzVGK5C79WGMaPHd8fmPH3FR6uA9g
 FywjEuVp/uQixRkqcXpJzZG4eiVaRM2XsSeg4M6P+8yjs1awu4rryT/0wD0LsA+heFRt
 10XeNADX5sN57L4rPrmyKX/PLqQplt0SP0QjPcgf7+cCL4KoVKlz/rwXzKuoWm8/OOe3
 UZF3opArbn976G8qt2owi4WwKBlfWLBStfihQPTBga8Ak9mPIebgnfe+yc+4V2RebaaT
 ltGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685745991; x=1688337991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RB0W/rFI1+KpHKK9ZJ6n4RrXr2vvSt5YP/IKazFl/Mo=;
 b=AHuIUz7hQpjHEEDtWlAusevx344OFSrK5ThnACxcpVfA68BqG21EsrDpnH0tYT17QX
 cU6rIsi4Uj3Lf6XELUUFRoxWhrqCcY4RhfxCgS4BXbWDJkdZcWK0oy320gvykVgzH+Iv
 +F169U7SFowaGuUe37FE7Tgz5/HI0MaWeyDKbp7hrZG9UZp/0B1KqA70c+NrB+NtWtPO
 ls5tPBwDVkEIyrFPQ/HhRvBIw+xKAL1RPyie4R1zv3b/kAWXVXdk32FGXAb8E41I9Gqy
 np4HJ/P4AxEeGXUdAjrAyxxMfmqxb6LooiXG8esJFkmjPKDiiqH0T3a4MLIeP1HQ+Cme
 J60w==
X-Gm-Message-State: AC+VfDx7x4LtLWZeuYj9cl1R8wPcytRTjFC84uPpIZ9w6Ky7r8sTX+ey
 4MMeS49mYUfys/SfOyY+R46Wf0vkZj1MllFABSk=
X-Google-Smtp-Source: ACHHUZ5v20++wOtYypbz7X0YCBasMgwXlOTzMo3VhWH8gsT6lhAUZLS+Gw/q8tuhYByvLt3MSJrVgg==
X-Received: by 2002:a5d:4c8f:0:b0:306:297b:927f with SMTP id
 z15-20020a5d4c8f000000b00306297b927fmr825902wrs.25.1685745990940; 
 Fri, 02 Jun 2023 15:46:30 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a05600000d000b0030ada01ca78sm2786094wrx.10.2023.06.02.15.46.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:46:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/i386/helper: Minor #ifdef'ry simplifications
Date: Sat,  3 Jun 2023 00:46:26 +0200
Message-Id: <20230602224628.59546-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Not very interesting code shuffle, but this was in
the way of another big cleanup. So sending apart.

BTW this file isn't covered in MAINTAINERS:

  $ ./scripts/get_maintainer.pl -f target/i386/helper.c
  get_maintainer.pl: No maintainers found

Philippe Mathieu-Daudé (2):
  target/i386/helper: Remove do_cpu_sipi() stub for user-mode emulation
  target/i386/helper: Shuffle do_cpu_init()

 target/i386/cpu.h    |  3 ++-
 target/i386/helper.c | 15 ++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.38.1


