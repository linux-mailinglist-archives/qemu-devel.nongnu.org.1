Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA8773538
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 01:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT9yk-0004sm-Ih; Mon, 07 Aug 2023 19:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9ye-0004rm-Gy
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 19:49:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9yb-0002dd-VO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 19:49:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso657627b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691452167; x=1692056967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pu/U9JMpStM78SKfxxAgvIcvr18PuM02p4+IH7EjycQ=;
 b=YeTLZPjC85pdvcK6FYE9fXOF4gkp7hwlCDLD40ut5cPQD7ovBVKCQbTT64ka8HMVi1
 7R/5r32ZHdGNgaQlPWfoBJwoBcqm0nuGCOgwBJJqtZFNG7DHRBT6IWKUOoS6cuX1JBLH
 BLs0uD14jMoHf50mFU0QrYoHR0dCfbG7lkRwWilt0Min2vMX77EtHgvabmTUXsD6WUgp
 36k4odGHMHnnYNypPbKBYG4XiwKqOEQ0ASVF+3A4LaD88ZZPT122cCDseVIMMV7dVwo8
 pHwLhkOEgHWPE6Tzc26fm61u1iZVZrvWOqG6g1je7cLSXhazGYBVOBm37IHLXBTST4eB
 lamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691452167; x=1692056967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu/U9JMpStM78SKfxxAgvIcvr18PuM02p4+IH7EjycQ=;
 b=g6EIwTEWh/qkAF3uBU0zRhbm3eRLokbTrSw19OS31jEmpb/xvQV0Z2pe237vPaTbEp
 Wm+JQfkZQbrsmCPfzkn6L2GuGVbqfCT7Dw+Sj74y+Tfl17BpjGZlk3DbXIvVe4ohcZPL
 4tZQv5YUzXIjdfubXz0CPpFEpQJvnt9ErFGLP8VVxTkWsZafd70/SGP2lDucnO1APBHq
 w3tBjS5NTg9qK5e+EZjXBwwU2pXXCgnpZDhJQYZIl64KIHodjBnqP2ZKdpEFeYlPgJk2
 RKhOoms2jyO0Hdi+i585SPwPIk5zO32kCq/ODJwI35ZckGdOgnr870pw+f+z2vy3w7GP
 yB4g==
X-Gm-Message-State: AOJu0Yx0Iwk7XONfa1EFNx5hKuZRd8MaG6CQS4n+7Yo3kqFHMl9TvwRj
 c6ieNxokt60TmWJNTT1mpipFuA==
X-Google-Smtp-Source: AGHT+IFCFi72J5N7Uw5hXALZInMQKqcsgYV8UoJ7/BgsOZiY1CnyZAJXTN7ResZfZ++5VJhN3xapSA==
X-Received: by 2002:a05:6a00:b4a:b0:66a:48db:8f6a with SMTP id
 p10-20020a056a000b4a00b0066a48db8f6amr13569986pfo.12.1691452167230; 
 Mon, 07 Aug 2023 16:49:27 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b006871dad3e74sm6725267pfn.65.2023.08.07.16.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 16:49:26 -0700 (PDT)
Message-ID: <515b5002-a986-2cc0-a592-1da5ce2e8774@linaro.org>
Date: Mon, 7 Aug 2023 16:49:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH trivial for-8.1 0/3] trivial-patches for 2023-08-07
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <cover.1691405748.git.mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/23 03:56, Michael Tokarev wrote:
> The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:
> 
>    Merge tag 'pull-tcg-20230806-3' of https://gitlab.com/rth7680/qemu into staging (2023-08-06 16:47:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/trivial-patches-pull
> 
> for you to fetch changes up to 6ee960823da8fd780ae9912c4327b7e85e80d846:
> 
>    Fixed incorrect LLONG alignment for openrisc and cris (2023-08-07 13:52:59 +0300)
> 
> ----------------------------------------------------------------
> trivial-patches for 2023-08-07
> 
> there are 3 trivial bugfixes in there, for 8.1

Be more careful to use PULL in the subject.
This nearly got lost.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


