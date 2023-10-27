Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD427D9747
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLdO-0002jX-TE; Fri, 27 Oct 2023 08:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLdL-0002jH-1w
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:08:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLdE-00040h-LD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:08:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso3105385a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698408483; x=1699013283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zH9tmyrWZkyUTZ5OsK8h2TLdeVdSWvEL8GnYHqnqql4=;
 b=c0a9isgm05RfQs9tRtvJ3QRQnOTHmrR3QkagngdPWOUw8LMXCez38jNHHkIm80JVxB
 eR1tBQzP35t7rGjsJbUg2SUYYJpl2ncPRGLivTF7l2pzA/dKSu1bkXesNDHY5QJnvU2R
 OVv3z7yqErYrBBUi5GHDdUhQn6dhtLRUK4m3iXDcZwV5z3a0nmoYAlvFHGNUOmWfyfoX
 14mtOxeVL+9qUeAnM/i0+ce/b716UtNu/4MgF2D8tLZ/aFHpfzOW/zbzK+wUPZyIFdXn
 gAm79jkD1Hawf5ydCZhMKQ3V2IoVW4Xqh0/dg93/3Qgt6QtkXpvMJ/J3eRnV9DR7hyFt
 JgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698408483; x=1699013283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zH9tmyrWZkyUTZ5OsK8h2TLdeVdSWvEL8GnYHqnqql4=;
 b=KOz2dWbYa3HIfZW9oRJ5h81MtTaDsIk0kD4dJQslJl/tzTejQr8LsE2gWH51R1U2yy
 mL/Ezs2Bv3vU9U/dRnd6Cc7fIF8cGtuvevTtZ/reY1nK37x6i39MzHeX/PChmnQT2Oup
 GU6YyCGmapeLLHH34zUcRTcH1voD29w6YVTJeUdxbe+CjrRcYbP7edhUihMWnIznI2gq
 jr9TcR9V9tEOVjSiVz2bnP/lHI5mWIsln8NU3zNpGUVV5JhWjNm5VsyThvB/D7G07PPC
 NS3RMGwL6Gyo8Vt02bZFHjnqACg1xL7MGfoQImXcnaAO2hfHvCPHkY8jjmTpv8hck0q9
 JMwQ==
X-Gm-Message-State: AOJu0YyXOBrorSjZuwqR9hJDMs0xgICEILBYLmLM1luy0X8GCzEupklc
 /g7HVjmFM5pUf4LNIXvPMlC273RBx7ZWI5y0YzCn4g==
X-Google-Smtp-Source: AGHT+IF7/p+MhJnPyWICtHZqUaium1yd5dGxQjAgFKHE6gk2EN2UqDw9Pxp+6PwGu5XBgefYlOstvD/m06Fd7zsfvgA=
X-Received: by 2002:a50:bb08:0:b0:530:77e6:849f with SMTP id
 y8-20020a50bb08000000b0053077e6849fmr2333178ede.27.1698408482844; Fri, 27 Oct
 2023 05:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231018181259.748819-1-nabihestefan@google.com>
In-Reply-To: <20231018181259.748819-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 13:07:52 +0100
Message-ID: <CAFEAcA8ihe-+c_NHC5BwYuaU7y9NpP=9-1aL2Brf6g+SfK6SMg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 18 Oct 2023 at 19:13, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> [Changes since v3]
> Fixed comments from Hao Wu (wuhaotsh@google.com)
>
> [Changes since v2]
> Fixed bugs related to the RC functionality of the GMAC. Added and
> squashed patches related to that.
> [Changes since v1]
> Fixed some errors in formatting.
> Fixed a merge error that I didn't see in v1.
> Removed Nuvoton 8xx references since that is a separate patch set.
>
> [Original Cover]
> Creates NPI Mailbox Module with data verification for read and write (internal and external),
> wiring to the Nuvoton SoC, and QTests.
>
> Also creates the GMAC Networking Module. Implements read and write functionalities with cooresponding descriptors
> and registers. Also includes QTests for the different functionalities.
>
> Hao Wu (5):
>   hw/misc: Add Nuvoton's PCI Mailbox Module
>   hw/arm: Add PCI mailbox module to Nuvoton SoC
>   hw/misc: Add qtest for NPCM7xx PCI Mailbox
>   hw/net: Add NPCMXXX GMAC device
>   hw/arm: Add GMAC devices to NPCM7XX SoC
>
> Nabih Estefan Diaz (6):
>   tests/qtest: Creating qtest for GMAC Module
>   include/hw/net: Implemented Classes and Masks for GMAC Descriptors
>   hw/net: General GMAC Implementation
>   hw/net: GMAC Rx Implementation
>   hw/net: GMAC Tx Implementation
>   tests/qtest: Adding PCS Module test to GMAC Qtest

Hi; I'm afraid this is going to miss the 8.2 release,
because it is still missing any review from Google
or Nuvoton people.

PS: your patch 4 commit message seems to have got mangled
somehow -- it appears to be multiple commit messages
that have got concatenated. Was this intended to be
more than one patch ?

Also, for patches 1-5 which are by Hao Wu, you should
add your Signed-off-by: after theirs, to indicate that
their patch has come to QEMU via you.

thanks
-- PMM

