Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2735757FCE
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:41:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlsU-0005st-KB; Tue, 18 Jul 2023 10:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLlsS-0005r9-58
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:40:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLlsJ-0000RX-LR
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:40:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e56749750so7904298a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689691226; x=1692283226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bzkQ3YqvFaaiHKpitrSWJ4ZPwcNp7y1iID7UwhF3gKc=;
 b=RRjNXIcW8MIhwGK+R48e6gPLF72bXajPjXyetRVuH/WfZn21n0KYWHEwk14KhqAo6Q
 SvoOUHYjhfscEAjVomRRb+/zulqxWwrfW3bIw+P3c6JScoaB+2AVreO/IXZNHcZK/4GF
 px+7/I9YrR/i0NgvR02Z7zBKGkN5liQ/EFuUs2GamlLc5nSsL4iQeLE/MHeOGopcJWYk
 xDNdVXlrn3qaP3+jNZ45+8P1S9RR37AHxcunYLtrhK29a+3z/7sftKiQr3VxuSxAwBEF
 lz8wUARscs/wdYAlUKqhvS3vOl8oTUSSgIHm/dfvMHgWYKyhC6t3nX3m6Ey7gWr+BryU
 cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689691226; x=1692283226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzkQ3YqvFaaiHKpitrSWJ4ZPwcNp7y1iID7UwhF3gKc=;
 b=hmC2SPlCu3QXGAyJCXgJ6+08L+dpWWgXfu14d1DmT7n4plcJKxaH0G3qCZgr5D99UK
 69kRz41Cap/c8LGRFr8sAF+wPBsiTeXDcTtzR4HQPDA9VNFRw0nj3ImLxTMqRmIaRLX9
 OJ1EaekJn7tw0n6MS5mJk0+yiZm5F0dTWB8Z4qYC2jhDj8PFFvzx+LxFgljSTeUytXRm
 aAG55kZWX6TGZEI2UTqrwXpLrWFquX118KGavDFouf1z2nd/AEHpiioBXNxiI/YtIskW
 GBGVH5hPavOxeILjuNPpqLpHLH6DJ361lvdVV2P9bb8lX0MXdZwzzH6sQRly8tjPpQa+
 igcQ==
X-Gm-Message-State: ABy/qLZSGr3/Ac4BUtPYqRsOnicNCvutyYV1CBfvtIdfXdXR2hUZUXsG
 qo2rDr2PDVd/F2EtevZ81c5EeCP+73LKqD6j5kZ0eA==
X-Google-Smtp-Source: APBJJlGpsUYex7eulEQFZvXt6Jpd1u5eJmPg/9WIPhI5D5h92F7F5q6OLBQBpZtQw1fpnOdSSMBBN5jB9ANKE21f/vc=
X-Received: by 2002:aa7:cf06:0:b0:51d:b246:72e4 with SMTP id
 a6-20020aa7cf06000000b0051db24672e4mr145757edy.5.1689691225940; Tue, 18 Jul
 2023 07:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
In-Reply-To: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2023 15:40:14 +0100
Message-ID: <CAFEAcA9vkyO_kivpSGV7jPW+DCbSD1BNA+SsLixViamXRi61CQ@mail.gmail.com>
Subject: Re: Wrong unpacked structure for epoll_event on qemu-or1k (openrisc
 user-space)
To: Luca Bonissi <qemu@bonslack.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 18 Jul 2023 at 14:03, Luca Bonissi <qemu@bonslack.org> wrote:
>
> The or1k epoll_event structure - unlike other architectures - is packed,
> so we need to define it as packed in qemu-user, otherwise it leads to
> infinite loop due to missing file descriptor in the returned data:

Hi; thanks for this patch. Unfortunately we need patches
to include a Signed-off-by: line that says you're legally
OK with it being contributed to QEMU, or we can't take them.
More info here:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

thanks
-- PMM

