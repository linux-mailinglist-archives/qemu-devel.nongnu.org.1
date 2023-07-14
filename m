Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D88753216
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCPD-0000FU-DX; Fri, 14 Jul 2023 02:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCPA-0000Ep-Mp
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:35:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCP8-0004Nk-Hb
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:35:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-66f3fc56ef4so1771058b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689316548; x=1691908548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgU3Dx1341zcNp27s5YHQ7zVFLovBBgD5zVq6ML+VlE=;
 b=QuccINKYOMDDa+fE9h4tX9uEX7iOw8HwOxTmX680ODmPtKhq2iMAJyZKIKyILwAOlr
 csPABZ1DNNv323VBNIm0AgKI9nNELbzyCnoMM1yHwNNE8fP8VbZ5L45mo8bpKrgTySCm
 Y5loBCT9S4JstudNskaT5yph9jSJBDgZe3F6khl8v17CX8xNYOXt/ulWcmzNxc7b68Au
 0CKgN5RaxpxgPsV/A0WZhZJxPn8i0k+S/WK6nTfmQ186jSfeIn7999a4Sfu92q/pKcP1
 ok2iLbdotTgFo5ztEa6/vwBVU1SZ6N3lgWzvOvXRfS5qTfUwlcs2/Fos5E4IuSIoW5/q
 Fa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689316548; x=1691908548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rgU3Dx1341zcNp27s5YHQ7zVFLovBBgD5zVq6ML+VlE=;
 b=WQ9G2o1ouYWo8yZtK38r2xSAjwI7kHk7kMP42uYRyo2vKfU4wS52jggJqOYkMLiDZB
 mRIsp37FZh/WWKdXfNgiLbe3+jX9xsXAJqDv0xgJBgmVAlqDCr0vxDe7BYzDVlX/2Oy1
 yqJMzBtjXIpAR8cb6LEHf43RwbbRMeJTU2qIJNNWhIg4yynJBUBLHObdtogPJQekrp9A
 lnQOxy6+yDc2sMDy4YJY4yyt6UqIMjAGjfNby3JmnpfpgsSr13LMEqLIKaYiIvqk4Jpr
 LkN0oTzT0H99E27o9T9CT5DjnVHq1MqF8d99C2CLONkkbAuoTGA9ESvQfKqwHl+wSDxH
 Q6gw==
X-Gm-Message-State: ABy/qLYHerTfBWxqhaKP133y1TqZWGncbYCJ7Y7YcRFY0gR8TyYq3r23
 aex8704BryPjZBVg07R5fN9/tw==
X-Google-Smtp-Source: APBJJlHcxRehX7bjr6NWeBThf6k21n2BoX+nC62cB0CJohr97tTt2wW/by0X/nRqoHps3z/7Rw0IEA==
X-Received: by 2002:a05:6a21:3290:b0:12c:3973:800d with SMTP id
 yt16-20020a056a21329000b0012c3973800dmr2791382pzb.6.1689316548489; 
 Thu, 13 Jul 2023 23:35:48 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a633306000000b0051b460fd90fsm6685682pgz.8.2023.07.13.23.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:35:47 -0700 (PDT)
Message-ID: <25613abf-11e9-f836-3e6e-92eef203af9d@linaro.org>
Date: Fri, 14 Jul 2023 07:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1] Block patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <20230712193658.255676-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230712193658.255676-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/12/23 20:36, Stefan Hajnoczi wrote:
> The following changes since commit 887cba855bb6ff4775256f7968409281350b568c:
> 
>    configure: Fix cross-building for RISCV host (v5) (2023-07-11 17:56:09 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 75dcb4d790bbe5327169fd72b185960ca58e2fa6:
> 
>    virtio-blk: fix host notifier issues during dataplane start/stop (2023-07-12 15:20:32 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> ----------------------------------------------------------------
> 
> Stefan Hajnoczi (1):
>    virtio-blk: fix host notifier issues during dataplane start/stop
> 
>   hw/block/dataplane/virtio-blk.c | 67 +++++++++++++++++++--------------
>   1 file changed, 38 insertions(+), 29 deletions(-)
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


