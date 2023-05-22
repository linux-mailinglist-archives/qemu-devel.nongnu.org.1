Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568E70BCD8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14EQ-0004vu-Fd; Mon, 22 May 2023 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q14EP-0004uw-2e
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:01:41 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q14EN-0001fy-9g
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:01:40 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-50bcb4a81ceso10620258a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684756897; x=1687348897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NoExjJY2ASCuOV/0s+i6E1DsyrLp/ezztyoZ9LE87w=;
 b=JxxtpnGWu11beu+G7LfdviAjQ5WoesmyUlvyYrfSvp8NWIpe1fZkM2bg2YDO2+oDxb
 ytnoMSSbyeSTlXp7eW99AMpW1VNC+mFUMs4WqgIbi6v9KxVvbGs9XaPmJA6yqRqXTJT7
 htupd7ZWAagTOKy4EMkqcMkDWPVmrmdW69YA4raJwuDXWwoi/wfJvQYC2Ke/Wv8KJ7ko
 YVwlggB1V2R3Gjhf+uiaxh0I6+904USeMU9/PFojta/ymrpQLYN414tNK/u+FiIbiglY
 4QR9OXEiivjMhfqDIYkBtSQ59WL08kHs1EZWo0GKnoHRFhWemQ9KA5jxC0Cof8MBzWsi
 rQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684756897; x=1687348897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NoExjJY2ASCuOV/0s+i6E1DsyrLp/ezztyoZ9LE87w=;
 b=CXQPHfIYLAijEuvTHbNU/i6bpEXjDJVpDT8tLSd0LvOhN4TATlWG3uBilruZdutvbA
 sXBntsKMbH2ZWjHe62XT1YzP5zyCNUuD+DeFxmWeiCNQIOjCua0JiQIqty+gQR0NDz0P
 5YveWgdPAk3nIjxzLSiBMns8v6jU7ULcWH4/lqTc3C7UFK3GTOIBizQsW2ndEOBN6P13
 4eactnFdicpN3Zf9EiEmlztizRb9K5IdmRhnONxzKWM/FNzpF8fMWPEvJgzDRYW/pVU3
 dkvgsrX7gub8+vIxxJTY2uZkqEogMzUy6XymMJRSSW1TMHJ1Lcqj/xALa3AvtZZcktGs
 ItDw==
X-Gm-Message-State: AC+VfDyEQOvadiIu1D2Qiz0/daIGPrFycE8e/QfKV26cCFmgdlGQURUB
 eqGzgB2nQuqIvZSYpffEVXydp/nHTWe63wBRgpBfIA==
X-Google-Smtp-Source: ACHHUZ58UBC+iMxugcG/n7Kl01ljjE+nFqx7O1k1t9j+UMwqf3WaZ0jP2S/6rV22mDAdChxh1o2D5vhwHINwTNt8NnQ=
X-Received: by 2002:aa7:cf8f:0:b0:50b:c89f:f381 with SMTP id
 z15-20020aa7cf8f000000b0050bc89ff381mr7851532edx.29.1684756897342; Mon, 22
 May 2023 05:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
 <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
 <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
 <ea63d09bb2d249b282a429ff9d373e4d@auriga.com>
In-Reply-To: <ea63d09bb2d249b282a429ff9d373e4d@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 May 2023 13:01:26 +0100
Message-ID: <CAFEAcA8HMgJ5_WwC6Mc5E61_KN4kqvpW6AE_EyDf-JcrFVQJMg@mail.gmail.com>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: Sergey Kambalin <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 22 May 2023 at 12:42, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Aw, I thought the entire machine should work at the first patch.
>
> Thank you for the detailed clarification! I think I've got the idea. I'll split it up.
>
> Could you please tell me what size is appropriate for a single patch?

The most important things for patch splitting are:
 * everything still has to compile cleanly
 * the contents of a single patch should be a coherent single
   thing that it makes sense to review in one part

If there's something in there that only touches 20 lines of
code but is a coherent single change, it's fine to have that in
its own patch -- small patches are easy to review.

At the upper end, I tend to think a patch is a bit big
at around 200 lines, but for the specific case of "here
is a new device" bigger than that is OK, because it's
just adding new files rather than merging changes into
existing ones.

https://www.qemu.org/docs/master/devel/submitting-a-patch.html
has some other advice on patch submission, if you haven't
read that yet.

thanks
-- PMM

