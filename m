Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FD273CC28
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7Ga-0005dk-4N; Sat, 24 Jun 2023 13:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7GS-0005ca-Lu
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7GQ-000656-Uy
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3129c55e1d1so2107435f8f.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628493; x=1690220493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JIxHWMClVl6mvpALDoBK231PZeNGUQgT3foMweSwl8=;
 b=d9EPiTdMBS6ezt21TafvsYW1DcHw6rx3bSyGYk02qijZjSVC1xbJv7hrNc8Bln/+KY
 da9/C7KLlpChs5ekpkEMTLt+8/tTn69sMDTvOr77GosenaKuMVoIqanEcBIaB+x8/IYa
 sMX5xiZvQgUwCoIYnw0wLy0I8qTh5UNWS2TKXn7vV66wpwVU6Arg9AwvuzGbtx5f2Fr1
 NS187HJhnsPP5z7lKj2H5zJ9WFDNB74ee+CLe5qo2TrqCpMy25BW2hi6t3sBgrl2wrMY
 3O1uqpNOR6dT7+pTrezI8H96sgMZeN+qygKbA8KQdg//j8BnqU62WE8Pxxa1LGwOWpQ1
 C2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628493; x=1690220493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JIxHWMClVl6mvpALDoBK231PZeNGUQgT3foMweSwl8=;
 b=XdaahoBo4s5drDW8pStGBiFFW5Gf6qsUT5gwwWBznYheM9VyEHFFFGC1I2x+t4o5+J
 F/SRv8QFJDpcrVYsshFySgyXmIOXhGYTYPLglkICvOiHS74JhNeOK1zrdEe4jJdBlWrW
 PnttM3E2DJy+HyXCoYNI44li1yNxts6jJth/BVBwz2ym7SfTwXr8qTyRJBy93HeO1GHL
 Ag0T3u2TlRA6x9QCscNkPntJrlWUXiZbdjh63wCuLofV2IidlHZyOOpPhdYnAQY8xh3b
 0Ng7VwSpFS3L6CbABDEgF4VYCbqUWCtf4umonYJADzxhHJE6ju4P6AEp2wbGvndwS/Il
 5d0A==
X-Gm-Message-State: AC+VfDxgCwSVwZK196qjMmud/p7k/AoOC24T6XJHk/ww4RkGjK8zJR8c
 BRFZ+oELcyZKtPqmVmhvqwsDMaQVtZd6t8nFpzw=
X-Google-Smtp-Source: ACHHUZ4gIjgAKb4rVFXLZjiJdVzXvPynrHKyrgCEdSr0allCKh8ZZswCbWqoo+JLTWwg5/zBqsSxag==
X-Received: by 2002:a5d:5344:0:b0:313:df09:ad04 with SMTP id
 t4-20020a5d5344000000b00313df09ad04mr2110290wrv.57.1687628493050; 
 Sat, 24 Jun 2023 10:41:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a5d6407000000b0030fcf3d75c4sm2609804wru.45.2023.06.24.10.41.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:41:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 01/16] MAINTAINERS: Update Roman Bolshakov email address
Date: Sat, 24 Jun 2023 19:41:06 +0200
Message-Id: <20230624174121.11508-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

r.bolshakov@yadro.com is bouncing: Update Roman's email address
using one found somewhere on the Internet; this way he can Ack-by.

(Reorder Taylor's line to keep the section sorted alphabetically).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 .mailmap    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f323cd2eb..1da135b0c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,14 +497,14 @@ F: target/arm/hvf/
 
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
 
 HVF
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
diff --git a/.mailmap b/.mailmap
index b57da4827e..64ef9f4de6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,9 +76,10 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
-- 
2.38.1


