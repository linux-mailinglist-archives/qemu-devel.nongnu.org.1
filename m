Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425608333E3
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 12:32:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR9Yr-0003H9-QS; Sat, 20 Jan 2024 06:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rR9Ym-0003Ed-95
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:30:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rR9Yi-0007q1-7b
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:30:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ea8695be6so634585e9.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705750241; x=1706355041; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vg/FjUFaLDWAcPbbO7PuiLrCEmBzcaZZE7e4JGqAqk=;
 b=aql2LXuRkdQ7H+zOrAxcaWC7kiiBEOsTP5ni62laFSz3rkzV8mrLOG2DW/ya02/qEm
 vz5Mg4YJbN5MtawaOpqHLPnUVZxU4sgdjwCd+abIQ4NxyXTU7e50HcM/QkH6dZb8I4c2
 FMxvmyZ+kovN43yxYDe0WOVp+qmqWc1dB7LA7ZTQXjewPLSKd/KaJROCWOfm7QZkS+tM
 tv+I5k3TSpe49xVHa157adjdOkRyvGRCZclyOjEKpLDrMwLgJgiPC467KSCpcmWW7mGa
 e04rq/LlaOdjBNbU0SWD9jY0C/IBLkWM/LR7/ddP72uGvXG1aZC9Mi+GWSJQ0GjC8TcE
 6ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705750241; x=1706355041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Vg/FjUFaLDWAcPbbO7PuiLrCEmBzcaZZE7e4JGqAqk=;
 b=k74ZaH6FiIJOOYLszkHLHN/F/P4syRacBcGZ1qfIXnUc4S1ImIJHr1ra4nNWHcCo7j
 hGhbOe1k1wsrautc+u//m53kqHSdYatNnMXuEpp/1lPWm/JDnik2iijWIfaaVS9OQdoK
 LVFwBxWtRC2sIrmC8pDk0aWtaQ/GwUtJvX7C0W8daYGF1rpUoY89NUMHOeR1zXPmGn2/
 2zCKSsZL58JESEqdb3Q41qHMlvJmt79GBOk3rUExyuj7AmyAoesUqiB5jVR9UPUMxq/C
 2qp/JXmPHh9OsFVUjDttkf/6XS3xfd5NDeDwGg+gbFZWZhFSPiruGube7YyHqfoDX79h
 MeNw==
X-Gm-Message-State: AOJu0YxdZHPM3SakMPwvho09fSLkntZJxnEWsdrnfdkIYs16CU6b/pdR
 1iXaeSxozBIWNrpbCYP49pXDI6JDNztarq0L7zJQnEYxpoJgEFvL2guyTP9qIe84ukJ35WjcuFs
 gbWJyKCrpHxsB+UiUBlM60YB5vlAXEauGVYfzY+aZf5Ea1E3Z
X-Google-Smtp-Source: AGHT+IHZ6BRma9Vf6jeQqibyGlBeFCIMX2OZKrcyeTpv5r/MBW8Gi4/CwsX6pCUHG2Eyxw4sWletOvOpkel4/zI9UUY=
X-Received: by 2002:a05:600c:138b:b0:40e:a569:3555 with SMTP id
 u11-20020a05600c138b00b0040ea5693555mr382859wmf.35.1705750241158; Sat, 20 Jan
 2024 03:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20240119203303.2230984-1-nabihestefan@google.com>
 <20240119203303.2230984-2-nabihestefan@google.com>
In-Reply-To: <20240119203303.2230984-2-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jan 2024 11:30:08 +0000
Message-ID: <CAFEAcA-6hvj14NokcU1T4t-e0+rkP3eg2Zk+=tmr8SPTqbk+TQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/9] hw/misc: Add Nuvoton's PCI Mailbox Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, 19 Jan 2024 at 20:33, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> The PCI Mailbox Module is a high-bandwidth communcation module
> between a Nuvoton BMC and CPU. It features 16KB RAM that are both
> accessible by the BMC and core CPU. and supports interrupt for
> both sides.
>
> This patch implements the BMC side of the PCI mailbox module.
> Communication with the core CPU is emulated via a chardev and
> will be in a follow-up patch.
>
> Change-Id: Iaca22f81c4526927d437aa367079ed038faf43f2
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>

Can we have a comment or other documentation defining what
the protocol expected on the chardev device is, please?
Without that it's hard to review to see whether the
implementation is doing what it is supposed to.

thanks
-- PMM

