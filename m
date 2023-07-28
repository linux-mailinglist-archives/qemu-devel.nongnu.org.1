Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0A7676C8
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPT4k-0006Ux-Sb; Fri, 28 Jul 2023 15:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPT4j-0006Uo-PP
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:24:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPT4i-000461-0b
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:24:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso1216687b3a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690572270; x=1691177070;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2CqDLjpVGtdYwJJJ8UR5ZYKjEsUEX566jPirHNo6PE=;
 b=vWI0LY7nJ035Kyex8iX75Jp9ahSEtX/Xbg26zg8PeflCWHafZo5Wew0LHdNk8yIpCI
 rfy1yMosQohGS9WBsXe5Y7KejyrLeiOOka0zT80PSjbpObxDepr372xWCIBzJsn0/lLI
 TLa1ycchFGPC9NEAKDIsdyG53/PvQuwG8j2HIekXGoE8NcJzx2HlSmRw2E0/83nl19+f
 Jjy6s/MHhZjXXiRLd2G+VGwmORhT3vc3Lb8yfd1Idx1a25nf0xGAq4vFrM660MDd/1gw
 g22BVCQlZZlvjcue3/AXS+dAsM2Vb049GnTFAnJHhfnAIRLYHFDhcWJE5KCjhNu1Kxsu
 zo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690572270; x=1691177070;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2CqDLjpVGtdYwJJJ8UR5ZYKjEsUEX566jPirHNo6PE=;
 b=EYELBEBXN1ySf6ncZtk14RaoRXcz6ajOM0g/wwSKd/BhJa7ev9EySWOCBeVY9rIOSp
 xG9oQXSgbhfV4wAUtejPKrQEz+rNrScAqeYTeY2uv5EdKQqN7BGZqFOSCfEMXbNTJsS0
 K0uGJZQp3M1doWsPv8cPi9MN+lfAwDzn5mrO9qUAgSngdTaq9sML3RfwG79RYQ82E8ZY
 p7F6A6MvwLybDSV9/mm77j45PaoOpuLPoyJgdrlh8TSApneHhbp4rruy1Qb+Z53+bIJf
 4sE4ak8GyiVI/4NOQlmt4qkzIHMBYi0uEsj0E5FyP39+U/gcM4i3lwTXVup1UwEcFrDA
 GXdw==
X-Gm-Message-State: ABy/qLY26aq6y6h/ylCQiJT93PwpVSPNMSkR45qkhCOhwn52JtVK3HfC
 I9YXjS3pyIOP/jaan7bRZZVCDw==
X-Google-Smtp-Source: APBJJlE8cKmwD4NkVxgBkARZZ7lFJfE4aDrDnX3iYUJCu2Fa9XymIUeORmMhKEMx773AF5QCdc0/lw==
X-Received: by 2002:a05:6a00:2e91:b0:668:69fa:f791 with SMTP id
 fd17-20020a056a002e9100b0066869faf791mr2989833pfb.3.1690572270434; 
 Fri, 28 Jul 2023 12:24:30 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 n9-20020aa78a49000000b00668652b020bsm3520753pfa.105.2023.07.28.12.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 12:24:30 -0700 (PDT)
Message-ID: <27d4fc25-085c-6bd0-c6bf-441f8c754cba@linaro.org>
Date: Fri, 28 Jul 2023 12:24:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL for-8.1 0/1] NBD patches for 2023-07-28
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20230728145548.1058053-3-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230728145548.1058053-3-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 07:55, Eric Blake wrote:
> The following changes since commit ccdd31267678db9d80578b5f80bbe94141609ef4:
> 
>    Merge tag 'pull-qapi-2023-07-26-v2' of https://repo.or.cz/qemu/armbru into staging (2023-07-26 07:16:19 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-07-28
> 
> for you to fetch changes up to e5b815b0defcc3617f473ba70c3e675ef0ee69c2:
> 
>    qemu-nbd: regression with arguments passing into nbd_client_thread() (2023-07-27 08:33:44 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2023-07-28
> 
> - Denis V. Lunev: Fix regression in 'qemu-nbd -c /dev/nbdN'

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


> 
> ----------------------------------------------------------------
> Denis V. Lunev (1):
>        qemu-nbd: regression with arguments passing into nbd_client_thread()
> 
>   qemu-nbd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> base-commit: ccdd31267678db9d80578b5f80bbe94141609ef4


