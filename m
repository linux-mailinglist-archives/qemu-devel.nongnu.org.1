Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12373FC08
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7v9-00018j-Pz; Tue, 27 Jun 2023 08:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7v6-00017c-P0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:35:44 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7v3-0007Ia-Sn
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:35:44 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-98dfb3f9af6so515039266b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687869340; x=1690461340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LDusC5fYPzsABGWCU1hmNmySIBrIbdI+94aWrncPMh8=;
 b=gUX6EX3VBZHwlotgbnWvm5aTAQJdTLcphhNpnDGSJX7ECVxcTbibEEc8icLr1M1dZE
 Ll8UznRQ/u4vyaR/Yhqs8Y3FwHgcUd+p/HaKt/bYwZUwl/N5XX4A7Q+TGO78Mrvk+K/i
 BSxe6k9pzDXFJXMFcGl/oQWVdTEnbcTX2VvgbBoplC+TW60UgKjDc3HIUqqN9RSPYu+M
 IxUeivmVPucGEPGNkK6wjywgeiFxOShely+nZ8FW7+DFF0Ui9IKSFEvTHUgP9Bwvw9Rb
 X0gZjjuk5qcUMyMYo+xxCAquGSitOlT+GOwOlBRgkMUzc/whDQ9DzE2ITylWWBQ07pzo
 1TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687869340; x=1690461340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDusC5fYPzsABGWCU1hmNmySIBrIbdI+94aWrncPMh8=;
 b=cWP36xSMb/XVQobIWozbpiA10mD51Vy0GSK3676ZuebvC74OpQXsXa/+MWToo+dHSt
 wfuXhO+vRMVXE59RePDyI1Q/xEqwY4JkxYzqhUmH8F8690tVakxxFAqRVGteRhSRuzPZ
 daXfjaDPDiv57wjvoHvS4DGlmFdJEdX6kd7Od0NzSnXx4wM5uj0vPrr7dp1NMqpmS1Pg
 Z13Hga7noJn9BW9sfJ8RbpdH86HyebAhIH7KXULlBG0T3wLWvsc8rizNd03ccpDe4E4d
 FLECEExN2hFMyODuPdGN2GNH7Dqi6Edg7gpKfo+UHMTeIyVk/jnTi2HMa1OjazrLnp1T
 fjFA==
X-Gm-Message-State: AC+VfDyVdxEZMPutTa8ysczic4XR+1bHIw4XjAmS19aoUrOh5PRDapOz
 K7yepfzpK+J3V8mofnZPAPTp7KQmCzdTRvLFhvgxSA==
X-Google-Smtp-Source: ACHHUZ5Nd6tbQ+YVg7s1yWV0uEyM4ZkDIcAjVl4uhLR0sZ5DQtu/kwv4htQDge4r82UNHE47olzu5TdK8vEMOSZK8kQ=
X-Received: by 2002:a05:6402:5157:b0:51d:a724:48d6 with SMTP id
 n23-20020a056402515700b0051da72448d6mr1628664edd.37.1687869340270; Tue, 27
 Jun 2023 05:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230621103847.447508-1-wangyuquan1236@phytium.com.cn>
In-Reply-To: <20230621103847.447508-1-wangyuquan1236@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:35:29 +0100
Message-ID: <CAFEAcA86sw7aCehmYHogpn=D_kXd0cAohj2_jP3dwwLyNrh_HA@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rad@semihalf.com, pbonzini@redhat.com, marcin.juszkiewicz@linaro.org, 
 quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 21 Jun 2023 at 11:39, Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>
> Please review the change.
>  - sbsa-ref: Replace EHCI with XHCI on sysbus.
>
> This work bumps the platform version directly to 0.3 because
> the addition of ITS will take sbsa-ref to 0.2 version.
>
> Yuquan Wang (1):
>   hw/arm/sbsa-ref: use XHCI to replace EHCI

I'm going to treat the testing/review that happened on previous
versions as sufficiently applicable to this one (since the
patch didn't really change in that aspect) and not wait around
for fresh Tested-by/Reviewed-by tags here.

Since we now have a place in sbsa.rst for noting what
changes between platform versions I added an entry for 0.3:

+0.3
+  The USB controller is an XHCI device, not EHCI

and I tweaked the commit message to explicitly note that
old versions of firmware/kernel continue to work even with
this change.

Applied to target-arm.next, thanks.

-- PMM

