Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B8373B53E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCe0s-0000DI-T3; Fri, 23 Jun 2023 06:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCe0r-0000Ct-Ae
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:27:33 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCe0p-00018a-D3
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:27:33 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f955def3a5so536263e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687516049; x=1690108049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+uhIURa+W72BPO2EEf96ntY30qeTAcxropPwLHBkvmk=;
 b=V9oHB79HcaQ1KsE7neNNaQ0BixUh95zF2PHhJ+R6hk420ubXrKjPyTDORGLRhGxcmM
 ntC3MFT6wccp5pHediPpS11ZI0+XH80EXXWTcfAROc6h5HFmBdfnTWGZV2nlIf56P2L+
 q12Z+GWPMV62MREnsN3fKTUbpk1Yq3ZWoZBLCDrYJ1FY8v3QmYUwln+obcKYdb49miRq
 sKgemHOVRVi+9rHmrNrgBCs2TRJPBmV0W00eu8PLCNi47QhFzzcft3VpkdpZGUm93wnJ
 4upL8hiiDGz+DpCi1pLEyDnzIGkBg0YG7m5bFDadH+OXKa6DCfmbRq6MR+tSv6o44pu9
 7gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687516049; x=1690108049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+uhIURa+W72BPO2EEf96ntY30qeTAcxropPwLHBkvmk=;
 b=NTj8187rHZqs0vnWqPOcaUNfKiJI5aNtr9KYYsHBXXNmIQEFshqKOsnrq0LBPF0xM0
 FE3wWaBl3qDV61zzxy6huZHRnVnV11CAJM7B/+d9WRpioxqF2/fTgcC7EAkipY6Bgjhh
 Gi7HDp0usXrwLpvlaUO+xGydPP9pCN7B9QPql6qX9tN356XVRRyvAuFbefEVQyJ2r5AS
 /25c0BdI+FXp9QGWmWziM/m3fO2853Hf8aHtYMy+1Ols31SFIMnLnHUTW5LrOatyXAk1
 xOx9j3VI1wkifwyKrRZJ+i+abvf00kuWlQvOXhnxsya5jdBwv+byRBxHOLlQ/Z1Dhl6H
 GOOQ==
X-Gm-Message-State: AC+VfDxruvm664IFKQ06XiyOqYrGl7N1peNBEB97sZYJQch0gr4MpGFF
 zs5UcDystplnBq9R6eHJ0EwYDIGQaaymHNusmipg7g==
X-Google-Smtp-Source: ACHHUZ7u/YsbOdZk6tU/kXaeJonndsYeC98S1Rsm0BUeqGX52pWc4uMJXQmK1kBOCMnat0voOpX7XzVbMDPpHfWO9so=
X-Received: by 2002:a05:6512:39c4:b0:4f9:5a0c:85b8 with SMTP id
 k4-20020a05651239c400b004f95a0c85b8mr5433051lfu.36.1687516049374; Fri, 23 Jun
 2023 03:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230619140216.402530-1-richard.henderson@linaro.org>
In-Reply-To: <20230619140216.402530-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 11:27:18 +0100
Message-ID: <CAFEAcA8baKHuwE9Rhagv69aSQu22GPvhkUf0j9dFB_zrVqRmvw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Restructure has_vfp_d32 test
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Mon, 19 Jun 2023 at 15:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> One cannot test for feature aa32_simd_r32 without first
> testing if AArch32 mode is supported at all.  This leads to
>
> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
>
> for Apple M1 cpus.
>
> We already have a check for ARMv8-A never setting vfp-d32 true,
> so restructure the code so that AArch64 avoids the test entirely.
>
> Reported-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to target-arm.next, thanks.

(We can change the check in the "provide 'neon' property" code
as a separate patch.)

-- PMM

