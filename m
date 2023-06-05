Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D77227E7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Adc-00065h-OC; Mon, 05 Jun 2023 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6AdQ-00062d-Ga
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:52:37 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6AdO-0003gh-R2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:52:36 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f629ccb8ebso1401009e87.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685973153; x=1688565153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t/Asa/J8YBwCgNPQba9W0VDK3C/rkBwSX325yMlRU1Q=;
 b=oFKkQIaRZOCjngo0Q2dk6tm5wVqNIMlqSOb3mKH9dP+79GE3yVS8TijE9ZSnc+WbTl
 4qj4ldkSxqLnhIDS+SedJ0ZKHAs7qwuhhMq+cIEkx9ZIf3c1ZWKyD2BaoLcqVdy7qV5p
 /rgxu0KLqbHMaY8onqC24gczIjUmENSW9Q7glAvMPvTrBh142qXOVUaO/CZYQeOGkqYS
 cWj9CrQQwxkqHw57ivX3fNsi4iZlZ9kOW8DwhDL/PPdJHTOIs1Xex5+tyQPFkNMrpNnk
 jv3M2VQPgmFZv2f2J6oHts9VBTKq5nRrQTWWdf8MbXP2TJi2DTrCh9qkGf8oI1MWjJzT
 hASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685973153; x=1688565153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/Asa/J8YBwCgNPQba9W0VDK3C/rkBwSX325yMlRU1Q=;
 b=CGLPYRr9O3AxzC3U6a3t+gWLHj2Z4omewcDxwVwgDfiiqigt55aul8X75Sz61v98wu
 k/YvBHy29Ms0e+w9bCCeHeoafYA9fcNaK+8CLGcJQxrQXKpc8yxEFYmXvGeQP0D1WuyZ
 ExlYTg4rFiAB9kFHASo8G89is1XCDZ8SUN0GZycR/O+PC5cEkYwqAmYweb9qYzJMzWTA
 c+zPFE+2y9OZJOU1rgQOqVwq05GzvLf/YVM+TeHThrf2O7Mp6/k5Mw+Q05dPurut6VN6
 v1P0+h6RPnJdsv5JzYz0k3zAmxCB9DJ9rWO8CPCaN1sFD6i8I7h978NiJxVM3YSqzH2j
 ding==
X-Gm-Message-State: AC+VfDwog8R3et7UX02Gr0FpzCZonrgzciGbIlsekYph/RoneIG04n/w
 Uf0lmNAgUs9ToBPhXSHCBUsmcyLHYeeucu8/PSPvIA==
X-Google-Smtp-Source: ACHHUZ5EH6OhGjoEqkdDA4C9nWezsMq0ttEOKYDU5BY6o9rsZuAMg/Eb8X43vUPWtqPoeylHuCuRY1Jix+CzOclrG1Q=
X-Received: by 2002:ac2:4a8a:0:b0:4f4:bc9d:ca13 with SMTP id
 l10-20020ac24a8a000000b004f4bc9dca13mr5421865lfp.10.1685973152689; Mon, 05
 Jun 2023 06:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230530210703.6707-1-vikram.garhwal@amd.com>
In-Reply-To: <20230530210703.6707-1-vikram.garhwal@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 14:51:58 +0100
Message-ID: <CAFEAcA_8z+Z0qhej+iRkAka7vpkOOXy1W2-FiyejMPMN7GV8nA@mail.gmail.com>
Subject: Re: [QEMU][PATCH v6 0/4] Introduce Xilinx Versal CANFD
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Tue, 30 May 2023 at 22:12, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
>
> Hi,
> This patch implements CANFD controller for xlnx-versal-virt machine. There are
> two controllers CANFD0@0xFF06_0000 and CANFD1@0xFF07_0000 are connected to the
> machine.
>
> Also, added basic qtests for data exchange between both the controllers in
> various supported configs.

Applied to target-arm.next, thanks.

PS: something weird happened to the threading on this series: only
patches 1 to 3 were threaded under the cover letter:
https://lore.kernel.org/qemu-devel/20230530210703.6707-1-vikram.garhwal@amd.com/
Patch 4 arrived but not threaded correctly:
https://lore.kernel.org/qemu-devel/20230530212259.7111-1-vikram.garhwal@amd.com/

This meant that patchew and other tools didn't handle the patchset correctly.

-- PMM

