Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB0B77003E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtvE-0007j6-0I; Fri, 04 Aug 2023 08:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtv5-0007gC-23
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:28:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtv3-0000AF-KU
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:28:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5231410ab27so1543401a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691152116; x=1691756916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W7NJ2+ZXxG4vhrKwON6hV2Du6fNtD944ipIhEt2qeaw=;
 b=m/fI0B9lwxFwbDfwV6jTLre8Yc9EIu2udrddSRw4mFtfuds82Xj8LMXxV63fIRmRRC
 HOL2AbnXZIX3hFAcLEzRB8aXli76EIzi9vlp5yaG4g2H4jgNwUZRsAZfTD5FFjvWwPMV
 IltRMaMS/ZjHP6tJL3q1wlMpMypvKDvct5ikPS+mE57sxy/wbRwS6rN6ubt3DXUEqT5O
 KKcYvOhqpsLWw0pYxDzkIByBlKQyxosT5MWlHFBUPr4AVpQv34RCPjsjHjNLf13sk0sw
 UXeJ/aqHyOZf69IzXkm3wIMdLyrL9HZ46xmPSacC6tev+ppZev5CP25slc3V43+pdYCG
 hyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691152116; x=1691756916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7NJ2+ZXxG4vhrKwON6hV2Du6fNtD944ipIhEt2qeaw=;
 b=Zr5K8/yNdKeuE04kcSDnGqQEIqGyhEB9g5jc8DKREOr1k3bwp9vGhOqnKpN4kAKotL
 Ub8S4i2bPQb9k9CKp2xVX+xO6bpm6/iOfdwPCS15lCUZsPo+awRHnAbpCo+OIyN5xyPu
 QUFu1bqoMVgWmOjBKnrKK7onw88jgxzV4XXBbj4BMXS/ssl7JFzFyeylq/0KL0Hpb2Xq
 l4DO9WFwk+zWKUVJUhpWzKjv3ZuqWdYrkO5LVd7E35p6Oenez1G3uodEIDDS1vu2JNL/
 nX7imTgKOUQW/9/FAyCtsfEBQjUQIXJTrWuoX2TIjHrpuA4oTuj7XYzP2qrleLmdNiIg
 lVMw==
X-Gm-Message-State: AOJu0YyXZpwTn4mtSVuxsWjKz8vouHFjSysSOdLv+zdyBKyjZzBr5gIE
 ctKm3HT1Y3ayONAtvqDFNUB7X3KZ/N0sdBidGx1gag==
X-Google-Smtp-Source: AGHT+IF36uz6Efo6jP5WVzoUkpl01/WHGTm4nyat5aYHmCtm3kM/2rWOBnJEzN+FDUR+xddb6a6YSV+y3Zsed6q9h4k=
X-Received: by 2002:aa7:ce04:0:b0:523:df1:ba1b with SMTP id
 d4-20020aa7ce04000000b005230df1ba1bmr1495940edv.37.1691152115855; Fri, 04 Aug
 2023 05:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-9-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-9-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:28:24 +0100
Message-ID: <CAFEAcA8r6-vUqNftz3KXU9GMazkd=rSuq_STJLYxpBHRD369TQ@mail.gmail.com>
Subject: Re: [PATCH 08/44] Connect SD controller to BCM2838 GPIO
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 26 Jul 2023 at 15:00, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c         | 52 +++++++++++++++++++++++++++++++++-
>  include/hw/gpio/bcm2838_gpio.h |  6 ++++
>  2 files changed, 57 insertions(+), 1 deletion(-)

Looking at the last three patches, the code for this
device seems very very similar to the existing
bcm2835_gpio device. What exactly are the differences?
It looks like maybe just the number of powerup/down
registers -- could we share the same device model and
give it a new property for "number of PUP_PDN regs" to
avoid duplicating 300+ lines of code ? Or are there
other differences I've missed?

thanks
-- PMM

