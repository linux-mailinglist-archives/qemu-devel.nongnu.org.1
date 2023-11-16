Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF97EE524
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:26:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fBB-0001AF-CU; Thu, 16 Nov 2023 11:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3fB8-00016E-AJ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:25:18 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3fB6-00033V-7w
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:25:17 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1475199a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700151911; x=1700756711; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bkbUHelvEVfyi281Puw91VQq2VTw+7wRvwEQdRJirao=;
 b=KiB8HKsujsFA+WpMbhIxv5pQqMO6bYLzOm3+PnUs/TECknZRZhLsKlihObAfRzb4Rq
 YM+v+4JjAwI3N8Eto+mvK8rmDOOKYXLBsNgjRsyH6ct1ePwa5UFGgzohgoyWXYdUHsbb
 XtXXAklhCypMvP+huuZKTGtSUCK/ngRi01R2DK46uYNfN+USrcZ4EKe+BOqgJQv5UpFO
 FxHqbBBlkZ1FTSbUqU0pZbkzCi1zJEOqUEvgiVq+T5hwQBWaNxEITnxTr+UVog1zPNTK
 4NybzFQLsvOjypsc0H9Pj/uhFziibwCv1ShKyrfE6FuX4Lyiox9VP3LUKcvjxooNCaWE
 RqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700151911; x=1700756711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkbUHelvEVfyi281Puw91VQq2VTw+7wRvwEQdRJirao=;
 b=iq3R4Fo7Y8+bk2CAAl8jqp3+N/0W/hqJh9QtQrmLr3pKeDE+Xqoy9TMdutIj4Uzhlt
 +YswGtxFeGH+uoORStBGdGeKWyx08hTOOiTcM8BYuVY8VPfd4txOVEL3V7y7QPw419RX
 +SPGknOvR3ggLa52VYRf0culP5L80NbFOt+W5it/DyI31T8/H9T5TkQlFGAU8p+ThcKC
 ffcF2tTBuyF1vtjwfobTVEWSPsXA4AFT37U2D4P9lCa9HLufcq0P2YQJ3pRnCUUvNhex
 v4k79VIA+YtiyaQt6nb6fYZJg+v6RGeL8vVdu0Wc98488Tj5wi00SCWZmth7D2oOeQ+O
 kpKA==
X-Gm-Message-State: AOJu0Ywb/jJdMJTeqmSV29276OvTTvivhiSrhTxAXXG3/jRo6vruF/ja
 5wQL7xwim+Bw7Cjw0JA9Gp5BTnLRxXzGT/BW9b4sfQ==
X-Google-Smtp-Source: AGHT+IGjROsfyGeAC6BJyZ2QZhDhllWxmamZMwiaOMCvUe/GPhVTlCw4G/6fg2fiQg0Ouc/ssaGNeH3kWnIyLnlacXQ=
X-Received: by 2002:aa7:c759:0:b0:543:5a91:a8b2 with SMTP id
 c25-20020aa7c759000000b005435a91a8b2mr12902665eds.19.1700151911080; Thu, 16
 Nov 2023 08:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-4-nabihestefan@google.com>
 <KL1PR03MB7744A70A81045E5DC49C8191DBB2A@KL1PR03MB7744.apcprd03.prod.outlook.com>
 <CAFEAcA_9HT=tccyTu9RffMxq7Cm5GEanM+OcSxfkpbnJW2m6hQ@mail.gmail.com>
 <KL1PR03MB7744B774223D04CF466EC2BEDBB1A@KL1PR03MB7744.apcprd03.prod.outlook.com>
In-Reply-To: <KL1PR03MB7744B774223D04CF466EC2BEDBB1A@KL1PR03MB7744.apcprd03.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 16:24:58 +0000
Message-ID: <CAFEAcA98TjKa7tK+dgp7d0R4BcYv+s-jo+AwTn0L2RFYZkm09A@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox
To: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
Cc: Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, 
 "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, 
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>, 
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 15 Nov 2023 at 01:35, KFTING@nuvoton.com <KFTING@nuvoton.com> wrote:
> Peter Maydell wrote:
> On Tue, 14 Nov 2023 at 01:24, KFTING@nuvoton.com <KFTING@nuvoton.com> wrote:
> > Signed-off-by: Tyrone Ting <kfting@nuvoton.com>
>
> Hi; can you clarify what you mean with this Signed-off-by: tag?
> Generally we use those where either you're the author of the code or else when you're taking somebody else's patch and including it in work you are sending to the list, and it doesn't seem like either of those are the case here.

> Thank you for your comments. In the email thread " [PATCH v4 00/11] Implementation of NPI Mailbox and GMAC Networking Module",
> it says " Hi; I'm afraid this is going to miss the 8.2 release, because it is still missing any review from Google or Nuvoton people."
>
> Is it okay to post "Acked by:" or "Reviewed by:" by someone from Nuvoton?

If you've reviewed the code and believe it to be good (i.e.,
it doesn't need any changes), then, yes, by all means please
post your Reviewed-by tag. Anybody who has done the work of
code review on a patch can send in a Reviewed-by tag to say
they've done it.

If you've reviewed the code and think there's something
that needs to be changed or that you have a question about
that, you can reply to the patch to say so.

We basically follow the same process here that the Linux
kernel does; you can read about the various tags here:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

The meaning of "Acked-by:" is a little more disputed;
personally I use that for "I haven't reviewed this code,
but as a maintainer of the subsystem I don't object to it".

thanks
-- PMM

