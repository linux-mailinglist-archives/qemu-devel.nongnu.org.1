Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19960825964
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:49:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoKF-0006dW-1R; Fri, 05 Jan 2024 12:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoKD-0006dN-Cc
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:49:41 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoKB-0007mV-T3
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:49:41 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cd33336b32so10383341fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704476976; x=1705081776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+sXnJtWcjyBLOb2yW1MhZlclOJfsqSSZCQwvR/NIHrA=;
 b=N+MnHX/MO4x3+RFDyu5814V3teR4vZUK9qrnKwjz7Ks3yJz5hdoEugTXNWqegxMrlU
 3ZZiVGqzXaBdGdwWauR80cQhuGT/jb16vmC2r49+Zmhq8MPLsK244HstFNLUDRcUGSyz
 xTewPEfaV5khOkEJUOBh5E9l5utknjRQ/HWVA8IIeINfgrXW+zPEWvrRzLzYyf1zSUWj
 P0mFya+iVBmYAJP0FS4zwNQeoyJD9IsnUqWbPmulhE6tTppWgxSG2wsFQnGes/Mwe/G9
 Gb8QIG5ZEePJxNVHWXOMneoWv/bLPQyE9xqhh+vHSZ3ucYV6ypSwE0d52EuUhvjQ1Vvy
 LBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704476976; x=1705081776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+sXnJtWcjyBLOb2yW1MhZlclOJfsqSSZCQwvR/NIHrA=;
 b=HmZbdNSglSUv/KIpmKJYDZDXQ+nR4x9aqI+IFbCdA1Mv/XV1H69L6LbtrDw32S1Ttf
 XWcy+kXEHiEhU2iyu08LGB+UzFCLOqnEzHC9m0yB30dUBbPQIg/47ha0JWsFeEFvUaok
 MdqLLuN3MfZ5UvP9t3RLuGvMSZPbI/Em0Rj6+ixE3vz4AXV1lCXS40Ji6QzMDyEtWTpT
 sSFUevM9VO2nT255V87j6d0KfjPl8o9ZM6unRgHajWDDtFRTDHbPZUdaRcBxylTjlSIC
 yVWjrDNdw/oWIo9ck6jEXu5dXHcwKT/IxE3s2eiw8lpW2MxgW1VBOrPZmY5uxz+4kzzq
 qENQ==
X-Gm-Message-State: AOJu0YxvFpIhAsChxuSblps+f9lXA4TJofzqNk5vL8XpP3G/47hXJw3p
 mzeqenHXeVcBxeVysf38N9W1eT66pFOQV6Vx17e5LS7G7qabYA==
X-Google-Smtp-Source: AGHT+IH5rG1gUpJoxmAV6+MY9zz3mfIdQY1bsoQxIgXHW1wKcJ5YzP/Tp3xbm2QILBt2fm8BBkHnJGJt5hA98kgvviE=
X-Received: by 2002:a05:651c:1693:b0:2cc:f586:ce9a with SMTP id
 bd19-20020a05651c169300b002ccf586ce9amr1442366ljb.93.1704476976171; Fri, 05
 Jan 2024 09:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20240103172817.2197737-1-sam@rfc1149.net>
In-Reply-To: <20240103172817.2197737-1-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 17:49:25 +0000
Message-ID: <CAFEAcA_yoBEM-6cw5QOTcpO=TH+2=ySFu6=XRkBqGywxAi2SHA@mail.gmail.com>
Subject: Re: [PATCH] docs: use "buses" rather than "busses"
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org, 
 Vikram Garhwal <fnu.vikram@xilinx.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Wed, 3 Jan 2024 at 17:28, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> If "busses" might be encountered as a plural of "bus" (5 instances),
> the correct spelling is "buses" (26 instances). Fixing those 5
> instances makes the doc more consistent.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

Applied to target-arm.next, thanks (since 2 out of 3 of these
are arm related).

-- PMM

