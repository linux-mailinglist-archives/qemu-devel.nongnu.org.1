Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0870EC81
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 06:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1g0h-0000La-C4; Wed, 24 May 2023 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1g0e-0000L5-Ke
 for qemu-devel@nongnu.org; Wed, 24 May 2023 00:22:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1g0c-0006yL-O5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 00:22:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so313940b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684902117; x=1687494117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZh4NyyyBk8B5rLzJKawJuBggrYGxexQpXUHwb3xZNw=;
 b=v6FJCmITcSgjWZLQUn2juQ3r0vTHo5jcd0Xw6aogBrUwtiQ9pOLXWpDguUFsAmVDLN
 bJGn4nR+gqJV/dRpwsK+6yVv//SIuwP/Sk3gsgzgFbAZ2eDaMJp9J0NNth1uUycNYbYB
 fq/C17NUReipBadNPF+pTz9ODGHg29DJKF2J5rYciv6O7iwpVgWtJtrLSdKtvmfMgJAd
 uxTU1ihl0k/6azmFZ8k/aBTYQzyIWFYurTH/rM8+bq/nQgwEUMApUFGJGCcJOS52S5Ms
 XcJnwTdKD+CC8etj6swmGP63IUZQBaHFpubAwWwOEVvAmgWmkPltjR/nDxPr4Kvq9Eor
 BXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684902117; x=1687494117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZh4NyyyBk8B5rLzJKawJuBggrYGxexQpXUHwb3xZNw=;
 b=WhJTMphE9XBIijtDDPesBeYqW7hP+RZB7rv+rA3DeQwooVjMkatn9E4bjmXltx5r/h
 mYZMp0MfFJqoN5i3X9+t0e5FgvAIYnqQVBlWDV5S6iOwJzS6LMcCJa8kYwrU7gIfQPds
 HiZSCiqlNqWpXBTrNrpsW8PUstTOwu8TT8s+8uyv3yVvag2kGg5/Tw5kwE9/hFVXanp9
 GUOpZEeFFNz85m7P2VXE2+Oyqxw1pAu+HGnx96gOJdvRTZ5mRU1OKGetDILaUeR36yUA
 P6UnvfOYEaue3CMV80hFXXtLn2KlXwtN9L2+lyg9hTRnBZd7wZYaYp2Yn7qXSujiFS4/
 V/8Q==
X-Gm-Message-State: AC+VfDx8EMJbbD6o6lCWCNuwG9uzcCZX2oCjIfN7lfg3NpcyANgeJ51O
 c2HS6n1LtIu333ofdeZUmYx8Zw==
X-Google-Smtp-Source: ACHHUZ5J6u/rHRzl9SX0Tx8SG09VaTswdB2eLOg5FN6OByCz167A03wUXwTvC5LWm1flVhRL2LHu9g==
X-Received: by 2002:aa7:88d5:0:b0:64c:b460:c47b with SMTP id
 k21-20020aa788d5000000b0064cb460c47bmr1679804pff.15.1684902116707; 
 Tue, 23 May 2023 21:21:56 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 j18-20020aa78d12000000b0063b7a0b9cc5sm6457884pfe.186.2023.05.23.21.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 21:21:56 -0700 (PDT)
Message-ID: <6bc3fdb9-21af-ca3f-b757-0fea27828c39@daynix.com>
Date: Wed, 24 May 2023 13:21:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/50] Net patches
To: Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
References: <20230523073238.54236-1-jasowang@redhat.com>
 <1d43383e-e13c-0217-b1df-3572826ff87d@tls.msk.ru>
 <CACGkMEssJ8=_ityBAN-T29JwTGDB+=-cbq0pfNqZtOE6-RmjCA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEssJ8=_ityBAN-T29JwTGDB+=-cbq0pfNqZtOE6-RmjCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/24 13:06, Jason Wang wrote:
> On Wed, May 24, 2023 at 3:54 AM Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> 23.05.2023 10:31, Jason Wang wrote:
>>
>>>     https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> I might be wrong but it looks like besides the rtl8139 fix which went
>> to -stable already, and "e1000e: Fix tx/rx counters" change which has
>> been agreed upon before, there are a few other changes which are worth
>> to have in -stable, in 8.0 and some even in 7.2. What do you think,
>> which ones are important for -stable?
> 
> I'm not sure, most fixes are for igb, considering igb is complicated
> and just introduced since 8.0, it should be considered as a technical
> preview somehow. Then I'm not sure whether or not it's worth it to
> backport them. For the rest, it looks like it should be fine to go for
> -stable.
> 
> Akihiko, what's your thoughts? >
> Thanks

I think it is fine to backport all of patches with Fixes: tags as there 
are only five such patches for igb. Namely, they are:
- [PULL 05/50] igb: Fix Rx packet type encoding
- [PULL 06/50] igb: Do not require CTRL.VME for tx VLAN tagging
- [PULL 07/50] igb: Clear IMS bits when committing ICR access
- [PULL 08/50] net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
- [PULL 10/50] igb: Always copy ethernet header

That said, if that looks too many, you may backport only the last two 
patches, which fixes possible out-of-bounds accesses:
- [PULL 08/50] net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
- [PULL 10/50] igb: Always copy ethernet header

The other patches are just behavioral changes which do not corrupt QEMU 
state so they are not that important.

Regards,
Akihiko Odaki

