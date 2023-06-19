Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46773521E
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBC8I-0003F1-On; Mon, 19 Jun 2023 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBC8H-0003Es-9r
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:29:13 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBC8F-0000ky-Mb
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:29:13 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b46f5d236dso17961381fa.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687170549; x=1689762549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fZ3xrAPWUmuyygoUMGu33jLRMZx7RPtR3KeMjJcAvHM=;
 b=GXSf6nrXPqFf04qy0Ux0Hog2/AnLi6oTPzyC0osXQCMjjeBr3uy4Zbdatwx9c/wlDn
 2vJTTFFLmMP2SXROjv5FUXQj5Bl4qUbfVod5ay7eLtKsU9o3/Vv1yccB7VyaJSCNTEkz
 fjXZslZUwZjxtGxHjSSuqx8TWlmK/puOxyJnTmtkh6OM5qIVxW9YVAeqnYqbyKoW5EsS
 f2Mj9UTWf0ubIdYhsl8XMQgsrgb1rgzIUbaf8bOSmEcQdxIKqCqTJ85RuZailmn6gDxA
 z+gHQVrNgX/q6s/0uUeynT7BaN7b/WUVAmdEti3PkYuiywb8XPnGYypeadizSLCbsYSZ
 xVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687170549; x=1689762549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZ3xrAPWUmuyygoUMGu33jLRMZx7RPtR3KeMjJcAvHM=;
 b=SkoXtLK4XrqC9lJT1J+kd6V1DSDDv1agO2y9lzMoDGo/fxxqEOgfHaafIEv84ig+OA
 S9SLd7vxXQSqy8BLT3KCNA5QwBnv+DgmE77DTU3OPgijeICwX6zSUCBsoP/cVLHB6ULp
 6MkWl5bbOfB/wIT6Yvma6IkAF8gDa69qTHQ26mVXAQBMvM5xeFmegzJgaqYZ7JYLQVuU
 0z1UXuXFvkwJZWcfl1WKHegtWXKkckf6yhH3JMd94nOyeLIde9oxlRMe+v9L6TrZ1g8+
 GnR+H7LRACV5hcZqXWCvuH7CyQ5b9fgHDNQYYaVpYbMMggi8F6ouyQScpyrukOu65mtV
 ha4g==
X-Gm-Message-State: AC+VfDxwX9W5EHjJTUKyccYesFigC6BNgw/22951yW9iu5Ozq0mr5T80
 7BH71DcCzr8aKhBwN4+AwJFXy8rA4wpc5IitQBypEg==
X-Google-Smtp-Source: ACHHUZ4KL6zdvKBqJWd0RX5iM4N7NYfVUMKDcwx9wuJuAdjoU8vobZJ2Ng/zltRuSpmP14B2kGlNFb/dgYzmWesQhzE=
X-Received: by 2002:a2e:7e0e:0:b0:2b4:49e7:d443 with SMTP id
 z14-20020a2e7e0e000000b002b449e7d443mr4819152ljc.3.1687170549345; Mon, 19 Jun
 2023 03:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
 <A317ED6E-AD4B-475C-A889-0BD4E6A4D1B5@phytium.com.cn>
In-Reply-To: <A317ED6E-AD4B-475C-A889-0BD4E6A4D1B5@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 11:28:58 +0100
Message-ID: <CAFEAcA-sv5R0RTp5z-i70dYj0GM88xVOOQ8ktp4k2adD-BRJQw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Chen Baozi <chenbaozi@phytium.com.cn>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 pbonzini@redhat.com, 
 marcin.juszkiewicz@linaro.org, quic_llindhol@quicinc.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Wed, 7 Jun 2023 at 08:25, Chen Baozi <chenbaozi@phytium.com.cn> wrote:
>
>
> > On Jun 7, 2023, at 10:33, Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> >
> > The current sbsa-ref cannot use EHCI controller which is only
> > able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> > Hence, this uses system bus XHCI to provide a usb controller with
> > 64-bit DMA capablity instead of EHCI.
> >
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn <mailto:chenbaozi@phytium.com.cn>>

Hi; why have you added yourself as a Signed-off-by: here?
Did you do the work jointly with Yuquan? Or did you intend
to provide some other tag (like a reviewed-by or a tested-by?)

thanks
-- PMM

