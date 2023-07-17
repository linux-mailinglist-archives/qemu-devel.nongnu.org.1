Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D5756013
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:07:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLL8D-0007Ga-AK; Mon, 17 Jul 2023 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLL87-0007GC-LP
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:07:01 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLL82-00035s-OP
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:06:59 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fdb3f66fd6so2558288e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689588413; x=1692180413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXioWKpL1zjv4no09PxR4pj9jStifUansD0PqqrGhlI=;
 b=ACsK8U3rK1UvG3rqTMzVNLiHQqrYu4Y5z1v+WToKTZ8MkFcjW3dMak8H1Z8vOYSDpn
 /va/DV0mUoDuJxbbnFoVCf65P+k28MJwHMrkW2ogCs3MsHTidsQho7b9REgOiO7ZYd8X
 p06wZemuRvxDPNAsuShS9GbY/KnycfZb/oNU1Dm2GWNEacXyCHZxbaRDdqg0/zAs6zLi
 BsHMm8DA8YLZ1sfJESGN68jwBMYbnB5H6FRJb1MCuNvYPWgmlyubC4kPlaPjQpWThHkX
 3JgXyAXV3xG42y9rpgEV4D6SyQ9pDIJfnXVXVGyO9mShCcbs30UfB0fL0RCrTIHhqhOo
 bNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689588413; x=1692180413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXioWKpL1zjv4no09PxR4pj9jStifUansD0PqqrGhlI=;
 b=hjEAXBFF1/VpCVKrLcW+P406DZKonI1Mu9rH7yamdAb5Iu67nul+PkYIf9XB2MEvwm
 fkhFaN3cdcyzxWV8SG+Fnf4jNS0IWr/no6anPty556aoJsLP+WjZWjVP4VqZ7Fn21Pll
 lc/hNebrqMM+yC+sp1G7mf61F90nrVwynTzYsN8Fst064yB3S8i7+jlS1Z71dvxT8+oO
 vggLXGdnaoFtvdjiS9dm2pRZxb3G3z3qJQ8q9FvEVPTvZWoM0qUUZSmhAJk0vlNynxZS
 1BLK8BDjzFrvQMsoLTMEM2dT7GdFDGy38BNX0aLqoQXtWgDyxqhSTcLg9BW/DiY1FCbx
 wulQ==
X-Gm-Message-State: ABy/qLZbBtLAQO5cMbO2jYuSRnhJmv3OryF6x10t6nRSofBuFdv0Pvn8
 8agulUuU/SlEfVkmJ1e2XRr5tpymDLGwTVHaezvLMw==
X-Google-Smtp-Source: APBJJlE8gSDf83AkJbRpXMlGd+Tc2irorlPqG++mkgj6fjIA6jfMzgG6XhOroE5pmZ5V4XhKVOknC8fxlcnQBYd0tkA=
X-Received: by 2002:ac2:4e89:0:b0:4fb:9341:9921 with SMTP id
 o9-20020ac24e89000000b004fb93419921mr6484794lfr.52.1689588412717; Mon, 17 Jul
 2023 03:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230426211607.2054776-1-tong.ho@amd.com>
In-Reply-To: <20230426211607.2054776-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 11:06:41 +0100
Message-ID: <CAFEAcA9m0E9AQr=KaaeyLE8o=YQWO25uEq3su-mQ4+Td4wBxow@mail.gmail.com>
Subject: Re: [PATCH] hw/nvram: Avoid unnecessary Xilinx eFuse backstore write
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.comi, frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Wed, 26 Apr 2023 at 22:16, Tong Ho <tong.ho@amd.com> wrote:
>
> Add a check in the bit-set operation to write the backstore
> only if the affected bit is 0 before.
>
> With this in place, there will be no need for callers to
> do the checking in order to avoid unnecessary writes.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

