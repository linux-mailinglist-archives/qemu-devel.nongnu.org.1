Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1475203E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJufp-0001zY-8q; Thu, 13 Jul 2023 07:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJufM-0001xP-0Q
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:39:24 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJufK-0005Lp-7Z
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:39:23 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b701e41cd3so8778141fa.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689248357; x=1691840357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bHuTsab/o2e0GzLe6p+rgYVT0c4HeA2lxQd7Sqvhyqc=;
 b=lHbTDPUAnZjTWDyEc3je1GJ3j+JMvuHnDo5zKwuIi/mRJCjnn5JMIYU7IBNG9hiPuT
 2ZNyaQQ8kZKU8H0Kqs1K9lNCPg5aXuPhXJJJ9B7SFxgqbQkkSyOrvp64/6H0FYJjaB5/
 uqGzkI8k1kEs8/MZDZKeexyaM8/OAECxR4jugjkGBGEu0lUZzSimEQcWPjqhB0EyUbQq
 sDHEChsbIPc9/GAYR9+nwe88KFz7asjactLLN2XoKCWvfL0SePW0Aj7Y5U8u4ogT/SVw
 Vt9vAzXQp4Lmc40W+zwG6/3vAB7swOrQyT7mUGSGl4xSqTWBcHRB4JLeKOE9QxyAV89h
 cprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689248357; x=1691840357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHuTsab/o2e0GzLe6p+rgYVT0c4HeA2lxQd7Sqvhyqc=;
 b=XNQXcBaMH7REHRPx/lecY2CrosL1QXzw1qzsZ9YgOzx1PkIe2oAfXM74cTRB38J/vk
 u+ILV1RYGIIxRAJYzvWhD5NyZlP7jyvIrBqdWOuLaOVFck9tlLxJ9wrCjViC1kKW/q4j
 5v2UxIM8bHtEpFXdc39mYwrYRlZ/8LF24oI6Iv4ir3M/NXuJs4Wdps7dPT0krMQzpUFP
 IlbTICDlRiz5jcYB2rMZ70AKJc1+3HjsHcmKr11quPFzOu532+JrqpIbQXBuSco2Djh1
 w/nssrlzlBR22QaU/jRv1JB6IQPWLGsXyPdp5cDWZJrcNgQQehLKaMNy+XP1K5O7TxxY
 +sKg==
X-Gm-Message-State: ABy/qLaUvKINUycvPtqyBF0BK9+F6NVtsrZ2K+393AImDawsBhDtx/fv
 S6xMeR1eGPFR5zy+m1Cx23oTLFMNIAwaPU8Ww6z+IA==
X-Google-Smtp-Source: APBJJlHCqLqscNduKXQIxw9iXkp9Bctp6usruch5HB1yXOBsKMV726JCcELff4rkCyr8lyS4KzWevTyy40SMalhDD88=
X-Received: by 2002:a05:6512:1327:b0:4f8:5600:9e5e with SMTP id
 x39-20020a056512132700b004f856009e5emr1108853lfu.47.1689248357547; Thu, 13
 Jul 2023 04:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
In-Reply-To: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 12:39:06 +0100
Message-ID: <CAFEAcA_1oRpRKzTYeboxVzkiVErZAgFQRw9sVunXnWUMSf_SOw@mail.gmail.com>
Subject: Re: [PATCH 0/1] hw/arm/sbsa-ref: set 'slots' property of xhci
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rad@semihalf.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, 
 chenbaozi@phytium.com.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Mon, 10 Jul 2023 at 07:38, Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>
> As the default xhci_sysbus just supports only one usb slot, it can not
> meet the working requirement of this bord. Therefore, we extend the
> slots of xhci to 64.
>
> Yuquan Wang (1):
>   hw/arm/sbsa-ref: set 'slots' property of xhci
>
>  hw/arm/sbsa-ref.c | 1 +
>  1 file changed, 1 insertion(+)



Applied to target-arm.next, thanks.

-- PMM

