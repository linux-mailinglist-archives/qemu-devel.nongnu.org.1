Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B174C197
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 10:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIPqM-0006Mt-7r; Sun, 09 Jul 2023 04:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIPqL-0006Mg-2x; Sun, 09 Jul 2023 04:32:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIPqJ-0002lF-LC; Sun, 09 Jul 2023 04:32:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbfcc6daa9so23668355e9.3; 
 Sun, 09 Jul 2023 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688891549; x=1691483549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSdnKhYpUIp0bP5ZZhRyaUcS1d76AmRBUkV23hZro9E=;
 b=bzYBhWwxLDO/8vBzBgfR//pamrUpTU7VmIp4wnAZ8JZDFkEP+Ce53/v5J6IB01P6Vt
 R0OGupUtwQbQYJZpgZLiOxqKFT1KPj7bi5ss6Pe8COPN7ZjZ4owpbNMqFQg2bmzZgTqx
 4dui26LbnhOqX4JxAeCskpo1DdKpntcBiWuq1S1cg5NX4xaT32+RT9hWT+J3D816fTaV
 gxR72zzFJWG23JLpKHPd1do24q1W074cYerFl0Rb37ibJoVWy8b9daw95iFU7FiOrYVg
 mAoAi16uZbMI0Eqs+qvOQwGDbvK0A31Pk9cJcL0RuIfdMkYzBqk9wqtFF5x7EtLnSERx
 ux6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688891549; x=1691483549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSdnKhYpUIp0bP5ZZhRyaUcS1d76AmRBUkV23hZro9E=;
 b=iV6vkyBHsge8Pawun7AmTtJj5CsQJdQcwBVEL+JOuaoNaH8NHcgSscv+Ngse0Qufm4
 UdO/t5SH+hY8/T/oEsSAmJGyM2omQpTxjyj85lnMqZaihTN9M8yWlYjc0e91lv0TKYur
 /+LbNF7+Pjp7zGkKnp/07J2lNqrsso1ZKQ5LuCW28QgPUTwwaY9nrKYYkabOTPeUM3dN
 eVF4vikDZ6ZGlNqz//wVm4WL0LI+rUjRJ5oXC+DdiDA8wSeHv8p4xTS5tUuZFrxh1+pL
 bFmAZ1McX2DGXOtm+eZsyK9SwSZnztg4K12VlcbPbRSj4F1NOqJlGDxAGHp2O8m+nP7x
 fe4g==
X-Gm-Message-State: ABy/qLbnhKAcXnvs2KonIYA8tDAXdGKaQsHo9/mq1IRyStzp8FdqpdXL
 Ow8xxI1XUrLVjgFpS1brBT0=
X-Google-Smtp-Source: APBJJlGH0QpU0YonEt2oH2ykOwlzCuGHvVnJCqpDU6r6TDndycW8p1LV/lkDzbHwHYMgTLPAG8IV0Q==
X-Received: by 2002:a7b:c8c9:0:b0:3fc:8a0:3eaa with SMTP id
 f9-20020a7bc8c9000000b003fc08a03eaamr2506488wml.34.1688891549028; 
 Sun, 09 Jul 2023 01:32:29 -0700 (PDT)
Received: from archlinux.. (dynamic-077-011-082-039.77.11.pool.telefonica.de.
 [77.11.82.39]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d4bd0000000b0031438e42599sm8638082wrt.82.2023.07.09.01.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 01:32:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: f4bug@amsat.org
Cc: alistair@alistair23.me, edgar.iglesias@gmail.com, i.mitsyanko@gmail.com,
 jcd@tribudubois.net, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH-for-5.2? 0/4] hw/arm: Add SD bus QOM alias on the
 machine/soc
Date: Sun,  9 Jul 2023 10:31:57 +0200
Message-ID: <20230709083200.94026-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20201124094941.485767-1-f4bug@amsat.org>
References: <20201124094941.485767-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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

> Easy fix for LP#1895895 suggested by Peter.
>
> As TYPE_ASPEED_SDHCI creates SDHCI inside a controller
> (not a SoC/machine) we don't bother modifying it yet.
>
> Philippe Mathieu-Daudé (4):
>   hw/arm/fsl-imx: Add SD bus QOM alias on the SoC
>   hw/arm/exynos4210: Add SD bus QOM alias on the SoC
>   hw/arm/xlnx-versal: Add SD bus QOM alias on the SoC
>   hw/arm/xilinx_zynq: Add SD bus QOM alias on the machine
>
>  hw/arm/exynos4210.c  | 5 +++++
>  hw/arm/fsl-imx25.c   | 6 ++++++
>  hw/arm/fsl-imx6.c    | 6 ++++++
>  hw/arm/xilinx_zynq.c | 6 ++++++
>  hw/arm/xlnx-versal.c | 5 +++++
>  5 files changed, 28 insertions(+)

Ping

