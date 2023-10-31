Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B94497DCEC8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:09:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpQo-00005O-Tr; Tue, 31 Oct 2023 10:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpQm-0008Qw-Dq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:09:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpQk-0003Pm-S5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:09:20 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso3985087a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698761357; x=1699366157; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tCy6zYKycowf25avNSeyDM1CyW/gm/wqCwZqBTXuArk=;
 b=JIEsP0BpaIxQoyjHsSpIrhT2FGkRa6H+BHsAdtvfvBXIKRZAIaXSLXXhXDdh33d+KX
 7bdmwoC+0aGjngD1DH93YkOYvXOeeXaXjpBjV8sBNkTCLvWAqhlh+T/WP6aMIQRrQaJ6
 Ed+R7aAyEyxAHspiLII7D2/scEQCYCt5xZ1SUXJZEDCRCWDhTIDkBFFk90F3NWuxVvG6
 d1BlINsdhe1kXVqua4fXp9izRFzZS8BEzz4qS+DA5vZWPWcaEUxz98xvDGxvGQvELhz4
 vIbgQM4hfmN6Z3IYqrw0SPySe8FUeiv+lvodZVFgLxdA0n7QVlzkdwVjDLLXzK/lUPii
 Gozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761357; x=1699366157;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tCy6zYKycowf25avNSeyDM1CyW/gm/wqCwZqBTXuArk=;
 b=NzEc/ZXWPQsEcz0FqvfKm/Yg2TQGLAQ38k+YeK9aaMvAUNoanCcnWJHEPgyGsVZP9G
 siYKKjo1PQ4iAurrfxCAiG6jb0chGRYvLhpM1etGRtkwDj2fOuDZ1erwzQd66RQyPQ8e
 Et1ZDJYes5zyx5aGnSVrUYzw1CKrnTTbLzw/6nbMUJBz8U4e6Z9eLMhx3F6xBUB0AzUo
 LhOyIg7zOYjQ77KZNYGLy7aps/aEXCgaVBdl7X+MC0Nmoudw7E3HcQ2VjwqgQhXlSHTr
 mP19pLSpCybEYMSH6pyKzmcXWdsPtdueFjk8dvZtn5h3nu7GQ/Ovnl2NlY4pAz1CefcQ
 6Trg==
X-Gm-Message-State: AOJu0YwBCFv3NUHlS4I+9VWgOvWAa4/Sg69qTAQKbxPREFDusboiNVz/
 FZj57es6EQ8cysIlf1rUIHhgx80CHJ2FbTpPiXNKX4U1kpDus6rA
X-Google-Smtp-Source: AGHT+IGsZcyK5e98yjAyW/VjFb4A1UW7ewGk0AGD6sHy6wNYidvbPKXVtYTVRv0nHOv6wMyGs2n6JALAgl0slQHbwDg=
X-Received: by 2002:a05:6402:3586:b0:53d:d879:34f3 with SMTP id
 y6-20020a056402358600b0053dd87934f3mr12452566edc.1.1698761356960; Tue, 31 Oct
 2023 07:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230927151205.70930-1-peter.maydell@linaro.org>
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 14:09:06 +0000
Message-ID: <CAFEAcA-JUMX+mdjg_Yzcih4LjF_d1AkR0Q=YcYdz5Fi5GxYx4g@mail.gmail.com>
Subject: Re: [PATCH 0/8] docs/specs: Convert txt files to rST
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 27 Sept 2023 at 16:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries converts most of the remaining .txt files in
> docs/specs to rST format and integrates tem with our documentation.
> (The one remaining .txt file is rocker.txt, which I left to do
> later because at over 1000 lines it is much bigger than these.)
>
> These are mostly simple conversions with not too much effort
> put into the formatting/markup. In a few cases I dropped
> parts of the text already covered elsewhere or made light
> fixes for grammar/spelling; see individual patch commit
> messages for more detail.
>
> thanks
> -- PMM
>
> Peter Maydell (8):
>   docs/specs/vmw_pvscsi-spec: Convert to rST
>   docs/specs/edu: Convert to rST
>   docs/specs/ivshmem-spec: Convert to rST
>   docs/specs/pvpanic: Convert to rST
>   docs/specs/standard-vga: Convert to rST
>   docs/specs/virt-ctlr: Convert to rST
>   docs/specs/vmcoreinfo: Convert to rST
>   docs/specs/vmgenid: Convert to rST

In the absence of further review I'm going to apply these via
target-arm.next, since they're only docs format conversions;
let me know if you'd like more time.

thanks
-- PMM

