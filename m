Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35487718657
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Nkd-0000da-6p; Wed, 31 May 2023 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4NkY-0000dE-QZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:28:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4NkX-0008E4-8Q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:28:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so2311132a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685546910; x=1688138910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KIcLj7EkGs6KAt2JC7AbOLpJYtKq2JKggaI9q8lYma0=;
 b=UQ4whnL0GJOwEeRAZjx3s+aXdHN+P8YVmeccEZ0RiISHAQpq9jSKrgae3MOjyg3Vuh
 VfxLP6IvGqkypNPxsOwEml5rLpIx8Wlxv5+TkiA/dy6Uf9EFUStPyZemWUsMdgWNOhLJ
 iaxIUwCDzzXcvo2Sb5cTx4llA1OCwGJSnc3d5fxhWYh7SimE1veGvUizU+dLHkyl0FRP
 bV2T6Q3YBdJKi+jWPxJYNFqvnY/dVk45RgujohBcwHw2IkY0TSPTBfh8so6M1ZnXDqXa
 2Xov1++xwfqgx3U3f0FhT2neBREfCKeGYlNzb8rZfH1QaX/Lr4OTOKN/cBMuL+Q9ro9G
 /png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685546910; x=1688138910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KIcLj7EkGs6KAt2JC7AbOLpJYtKq2JKggaI9q8lYma0=;
 b=DJ5q7w+3Wi3DxLGysDgLPWE+4YDuFsLH5JWinUV3EM5YHHJ4mpN9+2cFc34GpUJZDx
 rnqVn2KoP6eErr5KNAearwviPHx10wPWMkXfEj6PDBfuhNplrp3H/l/m3okrCjHb52ni
 E61ratPv3hb1SewTWSeyDXIKMACOV/0qBkxrlk6qiRwuDQovfnOACxR8mI4PZVa4am4o
 AqjzzTmCtAAU86kIAwz0MqV/ghjLGNL6EONCvIrVPptq4ZtrtSK4GreaDdumnIJ/g/x8
 1alz3IdobV6kt+VXoLRmjQnBZLuI7GcKVvPeplFRPldlDTDBg2bcR1h6wrK6aDuwWCTw
 cJZw==
X-Gm-Message-State: AC+VfDzwm7xDer35QobY+u2uD48MBEza/oHiKthCleFxNMeW0z6Hhnyy
 eDcNa62KweKg1gsbsRBIEmkgpJyuLXRbugA2puxNKg==
X-Google-Smtp-Source: ACHHUZ72ZhL+886hqFDNvCXqHzEq2R7Gd4DlzLuDdp7YO7E7hjW//hQbWS+CI6uQbUs0IUxXGI4RN6fr6iAR+RhT1+U=
X-Received: by 2002:a05:6402:5107:b0:514:9311:e83a with SMTP id
 m7-20020a056402510700b005149311e83amr6533557edd.8.1685546909775; Wed, 31 May
 2023 08:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
In-Reply-To: <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 May 2023 16:27:59 +0100
Message-ID: <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Graeme Gregory <graeme@xora.org.uk>
Cc: wangyuquan1236@phytium.com.cn, quic_llindhol@quicinc.com, 
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 31 May 2023 at 15:58, Graeme Gregory <graeme@xora.org.uk> wrote:
>
> On Wed, May 31, 2023 at 03:02:29PM +0800, wangyuquan1236@phytium.com.cn wrote:
> > From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> >
> > The current sbsa-ref cannot use EHCI controller which is only
> > able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
> > Hence, this uses XHCI to provide a usb controller with 64-bit
> > DMA capablity instead of EHCI.
> >
>
> Should this be below 4G?

It would be pretty disruptive to try to rearrange the memory
map to put RAM below 4GB at this point, though in theory it's
possible I guess. (I have a vague recollection that there was
some reason the RAM was all put above 4GB, but can't find
anything about that in my email archives. Perhaps Leif remembers?)

> Also has EHCI never worked, or has it worked in some modes and so this
> change should be versioned?

AIUI, EHCI has never worked and can never have worked, because
this board's RAM is all above 4G and the QEMU EHCI controller
implementation only allows DMA descriptors with 32-bit addresses.

Looking back at the archives, it seems we discussed XHCI vs
EHCI when the sbsa-ref board went in, and the conclusion was
that XHCI would be better. But there wasn't a sysbus XHCI device
at that point, so we ended up committing the sbsa-ref board
with EHCI and a plan to switch to XHCI when the sysbus-xhci
device was done, which we then forgot about:
https://mail.gnu.org/archive/html/qemu-arm/2018-11/msg00638.html

thanks
-- PMM

