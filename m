Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C245282CCB1
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 13:29:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOd7L-0000xv-He; Sat, 13 Jan 2024 07:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7I-0000xU-Bh
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:00 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7G-0007nJ-M7
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:00 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso7606317a12.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705148876; x=1705753676; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xrbxaz/4B6lrUVfIcj/awmWGZFHG4TrvF53keG1b1M=;
 b=Ara1IQEwdpl7QWYBLTcMn1y9AkjCh1vOWUjtS7CAmt5QyNyCslzsboM/MjifcgeL2c
 9DOh7rUm17hKvUviAA+ZT6nQZhCLsiM0A73Sin4eQ+XIRa/LA4+66HEKxxD5DPAlwGex
 iL9dKhk/GJ5qDYNrQ1YIK4M6N8PJYP7gqlpLIqQQ+gX1ddhkmajwWy4bivZkjh278879
 nflA+BF6IQiV4oYCzt74GDhwynY/XEY5iWJhQi5ON+iqoxb8K23VfMjtZMWpWofSpXZ0
 CJZFEK9z3Vl76pKZU1610FZkmahSJqQC9i9n53+aqbbnGR58691lNMgXkXxg1ZW+mIW4
 H3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705148876; x=1705753676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4xrbxaz/4B6lrUVfIcj/awmWGZFHG4TrvF53keG1b1M=;
 b=xBKKAiDCEvk4wFOl2VAzxg0GrrIiLEBqsYbVkXA1qT8dHfSJroP/8e7kNE4YQ/mwZX
 9Rjg7qrOZjFaK0DsPyr0X8TEuePYIYVWLOS6RX7yePu0uvwMsKoO0QnILL24CV3734wy
 vYbU7G8kyJrKTO2siI97fLo7W3OcyjokPVgp9wMvbxWIhsWo5LJGCSYaBLKNiz2O6MUn
 7mir89XOa19gEizMaS1mJIDJNq7v/tHPX0X8AyYGhm+7rFA1uKDottJLiQW+JQlbV+df
 MmJilEYDrjIJNsjxHgCx5j/E9eg6hCsCHF/t1wdhPdvii78BChlgymg9Sd2CHhk6WcEL
 CeWg==
X-Gm-Message-State: AOJu0Yxs/nT0GbIzxW+gv6uVfHNutM9EHEp2S6ve8vxQe8EFWwbLN2f9
 cMxlXiEQg7wvxTxN1El6D7vSJ5yhFyZwStg6QN9oyLuFJs+hVw==
X-Google-Smtp-Source: AGHT+IGllXgFaCOSm8py5uFVAsMUjnZuSr6v3oVVmReSbeSveYh9QZM3QKuJv+UN/S97h4C72eHLG83IcUkQYXXRaYw=
X-Received: by 2002:a05:6402:31e6:b0:557:639e:ae21 with SMTP id
 dy6-20020a05640231e600b00557639eae21mr1297053edb.23.1705148876718; Sat, 13
 Jan 2024 04:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
 <20240110234232.4116804-5-nabihestefan@google.com>
In-Reply-To: <20240110234232.4116804-5-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 12:27:23 +0000
Message-ID: <CAFEAcA9Bf-uTsn-B_QYyB-iSu-7opDWVYDQxqMBRTUzOO7y0Pw@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] hw/net: Add NPCMXXX GMAC device
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> This patch implements the basic registers of GMAC device and sets
> registers for networking functionalities.
>
> Tested:
> The following message shows up with the change:
> Broadcom BCM54612E stmmac-0:00: attached PHY driver [Broadcom BCM54612E] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
> stmmaceth f0802000.eth eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>
> Change-Id: If71c6d486b95edcccba109ba454870714d7e0940
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---

This patch doesn't compile at this point in the series, because:

> +static void npcm_gmac_write(void *opaque, hwaddr offset,
> +                              uint64_t v, unsigned size)
> +{
> +    NPCMGMACState *gmac = opaque;

...

> +
> +    gmac_update_irq(gmac);

the function gmac_update_irq() isn't defined until
later in the series.

The easy fix is to squash "include/hw/net: General GMAC Implementation"
(which incidentally still has a commit message subject that
doesn't match its contents) into this one, since it's
not very large.

-- PMM

