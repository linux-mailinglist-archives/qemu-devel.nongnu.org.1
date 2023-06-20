Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE359736641
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWn7-0006AA-2P; Tue, 20 Jun 2023 04:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWn0-00069j-TG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:42 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWmw-000809-Qk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51a20138617so6149201a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249953; x=1689841953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9cfwKNlayoFMCCu0sYxAxgZalGAwrCIJSoCGBT1lAzU=;
 b=umrKPnvAZWIpJ8rGJEd5lxMvkUXiDEgSv+w4/Q6SUZ4zPIBO4HxKpVAs7Nc3iKXC8t
 nhF1v7OnklEmdO+Cv/iEgifv0jz8+VReLnCkd3P1WnlrxOHnP9h4Be/x+Jgns4OgW0El
 PyAvUnQ5ztBmO7Uc0A1aYIcK4lu3fAfHKkUQtHb0S0MMhPOEvL1MPewkmuTbfeRYMGlq
 XcjJMnVxxDXaIM/rSzeyC2zMb5ePYKijgSNBefH8WKWnOJvNzPAupS3+wD9DLehnbK6e
 J/ixkPDfBGJuqwQIlhsReDtK8lG20qjxmd+3APJD6wVN/pozSE+hxz4SGctK47R/cNuG
 o2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249953; x=1689841953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cfwKNlayoFMCCu0sYxAxgZalGAwrCIJSoCGBT1lAzU=;
 b=Ffv0S0dKwJJ/IJDSmiF4Jci0/WfxJOeDgs3II9UNRYY9CN38q1snXcTDqKUfQfedbb
 H9o8JLE7Dx5skfieQQBdoGn7Q83QOkKZMiEteiMRRtS0c+GPw2IPJxD8LeuyIPzwJrps
 jTkJlbCwH/7dmZLEP04RsGtBVuyzoB82+gK4FHXnd8hkhGpFCygMBYsMjhVlW0kuuVnF
 VlynA3wQCnHRkTvod/i1M/2/QeA3Yt2tTBg9SH11IY/2RxiyTdGHVaWJmRHOiK9dStTX
 I8Ukf99LsENgnPWK/5eIGtCpEYhlbJG6YmX9VIlei6KpUAzPzldoNSpoqSEK4IV48tjw
 ZqSw==
X-Gm-Message-State: AC+VfDyttb0ih/O3om8QsVelThydBfFwKnxLm82XK/cVa1ToawQpkOGX
 CvedB1KeheAZ+LMEMMIV34G82+LPA/aSnzY5faHU+Q==
X-Google-Smtp-Source: ACHHUZ4Ca/MEHHlBSV/4BaX2Qj2sdr8O612CbUsqUq8kznOCL6pduwIkW9foHMoG+BAoSwLUWCTlLw==
X-Received: by 2002:a17:907:6ea7:b0:988:9836:3fdb with SMTP id
 sh39-20020a1709076ea700b0098898363fdbmr5814988ejc.11.1687249952909; 
 Tue, 20 Jun 2023 01:32:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a170906a20600b00982362776cbsm956473ejy.118.2023.06.20.01.32.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 01:32:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/i386: Cleanups around kvmclock_create()
Date: Tue, 20 Jun 2023 10:32:26 +0200
Message-Id: <20230620083228.88796-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

After removing the kvmclock_create() stub we restrict
"hw/kvm/clock.h" to x86, the single arch implementing /
using this.

Philippe Mathieu-Daudé (2):
  hw/i386: Remove unuseful kvmclock_create() stub
  hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h'

 {include/hw => hw/i386}/kvm/clock.h | 14 ++------------
 hw/i386/kvm/clock.c                 |  6 ++++--
 hw/i386/microvm.c                   |  6 ++++--
 hw/i386/pc_piix.c                   |  4 ++--
 hw/i386/pc_q35.c                    |  6 ++++--
 5 files changed, 16 insertions(+), 20 deletions(-)
 rename {include/hw => hw/i386}/kvm/clock.h (65%)

-- 
2.38.1


