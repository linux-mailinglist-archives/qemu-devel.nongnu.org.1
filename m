Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1542772A0A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2h8-0006dR-Sg; Mon, 07 Aug 2023 12:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2gR-00066h-EU
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:02:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2gP-0003ic-QN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:02:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so3075083b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691424132; x=1692028932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/GzibByFe99ZzGd4JHwwv6VsBGoYITuYlkj5Bw2SNc=;
 b=yrbJhX87U/J+/NMh67NMGQntfiDu1Zes5SmoobWO9/eW8pslcksQ7NPT+WZEJPdri4
 TigjC7+5fYlR6Wd09Oan/N5T4XpjJX2u9YjaAQTt+PokToe5XFupgkkd9udbAsb/tN37
 WI5tohKNXHLXk69LqsL3W+aOC7/zjQC2P7V4XaoqrPkIwOcmwABRQ3TO69dip6TG0lNJ
 SO1gbiIwKZV5l0EU87KQ7E7Su8kQ9T3mTiOvPtkGf5FwpoJNIum7YNTZPHQD3Oh1RSL2
 vpwl6LrEAA5jS9Yt3FmYPplkCibIE/A3/8IF33rR3zkLo2lKxL9I6uMgWfJ9j7LcwSQk
 +d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424132; x=1692028932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/GzibByFe99ZzGd4JHwwv6VsBGoYITuYlkj5Bw2SNc=;
 b=W8iQmZshm/YNvtlzuTXgZ5+CdIfKpA0vJDHwh5sB75HLMJdHPs3v6NkxyI5uY0Al2t
 03rgNuERBCzJOEP4S9ElofVPm4YBigv7Fv9vCpX+1LpxkpzPLCB1jvUNKhSK1Es1EI2M
 jFYKGg58PTvrIsu9qVM7hvdQnhUgkTwCu1ONiT4shwcGNVuBsVER6Lrj5Z/KXVv3Mp1H
 9jR3n+xCXPIVcY0KVVLw2/yiHic3whipPrW1IgmYONolpiyXZx31v+G+f4Vd96l8imZO
 5DLrpXtKNvqDaJCdRiZm7pv+IyUigHLEzP3c4WsReKAUjRt4ZwdAz+aynPdTA6vRSJe3
 OIUA==
X-Gm-Message-State: AOJu0YzfdEN4X1LdyWUXpmSTTdK1uqyhwYnRFdnZGSwzFgn8zIYK/ZEd
 sSpLZtodW6TsVX1aeJAM99IYhQ==
X-Google-Smtp-Source: AGHT+IE0NGq24E+GqxkMl4WyVkwbZCZSsy+3L6PwoIpcbBwcZGbJwum29IrVsDEM4UBueLodv3vprg==
X-Received: by 2002:a05:6a20:8f1f:b0:132:d09f:1716 with SMTP id
 b31-20020a056a208f1f00b00132d09f1716mr9139528pzk.2.1691424132291; 
 Mon, 07 Aug 2023 09:02:12 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6359836pfb.33.2023.08.07.09.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 09:02:11 -0700 (PDT)
Message-ID: <196a952f-de6f-21be-5f72-0be7dccce317@linaro.org>
Date: Mon, 7 Aug 2023 09:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] configure: fix container_hosts misspellings and
 duplications
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230807092222.467446-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807092222.467446-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:22, Paolo Bonzini wrote:
> container_hosts is matched against $cpu, so it must contain QEMU
> canonical architecture names, not Debian architecture names.
> Also do not set $container_hosts inside the loop, since it is
> already set before.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

