Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117273A1C8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKCX-0002vx-SB; Thu, 22 Jun 2023 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCKCS-0002s8-Aq
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:18:14 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCKCQ-0001Vx-3b
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:18:11 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b45bc83f26so102183171fa.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687439886; x=1690031886;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VGipHjjmNwfO1Cl6XFHPdZqZovXCvex9yRLv6Hjosk=;
 b=fbwPG7Y6WACpBP7u/joNioWDFmPlCxSYQwkpbLLYxFW1LkGSUDwzpzGR/oxJ2uA1Er
 01SIqr9qQ7xZQdhg+LKJZUVt9kd0qzJ+WHOlDopQET17KcV6yFkvxGx7vF0w6tqhc9q9
 8tG0GOu5HbJgguSy2mEMnXE1TbD5jBc3qxOlC+JUES1kaoUcH5YPkM6bFmM1hjT6mHxS
 bzEhc0ZGsNpIfwX3cqcFuC+T5/Baf1h0jALM+bAWPi+SSHtAdoeWncrtQ90qpMPv2Tta
 9vo9Nw9PicM4anjlVNi8r6QEh1V5Tu2IgAd4q3ArhXxHnCFekoM7YJLaPrsDfCD7eijo
 Cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439886; x=1690031886;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VGipHjjmNwfO1Cl6XFHPdZqZovXCvex9yRLv6Hjosk=;
 b=kIvy5m35MvNDq/VD7P0uMXfs/FpKoAsBEE24ohkUpeXaAyjWM+OFRSoNyS5wyXCP02
 fBZ0QJZ63J5MAHqKVXk6ybgsoPB+inWnGatf0Gpn0IN2SLdBtN8O0bTmZInyiZbDEPcJ
 BMXzxOaq/w9S34LkIF6ZhPfb+QShQX/8YUcyLgx2qbg+5FLEBIB3DU0K5W0TXUWo/6z9
 1dhoYQlMtwckzEPzjYNyTlSnXhj2GjKhgvcsvAN0HH6IPmoyW58VbiC8Zt1oOnMmpeOq
 iFQvV6Dy4vEB/4hfG+fYwIStGEMsrF28t9hvm+zFI88xZyKAFjTlFfGCiVKECR04UtM5
 GetA==
X-Gm-Message-State: AC+VfDxEolqo7rY3WzTGZaRb71nF6G5po6e1C6csixQf1/VJDunpTnN5
 FbgZYrJRVJ64ztLUpbvA9T365wEXWOQ0epvhfGHPCLfc
X-Google-Smtp-Source: ACHHUZ5C6djfSbyLepRwQqyU/8m8b6Jc8eIOCuQyRCVzpWyoNfAVPM6gKRw6f9W7vADTUDewvT9XCw==
X-Received: by 2002:a2e:9c51:0:b0:2b4:801b:8421 with SMTP id
 t17-20020a2e9c51000000b002b4801b8421mr7787431ljj.20.1687439884710; 
 Thu, 22 Jun 2023 06:18:04 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.175.141])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a1709060f8500b009888b71c368sm4668303ejj.152.2023.06.22.06.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:18:04 -0700 (PDT)
Message-ID: <2b3c934b-9e27-a32e-2708-fb7da7f33faa@linaro.org>
Date: Thu, 22 Jun 2023 15:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/24] Q800 for 8.1 patches
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230622075544.210899-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 09:55, Laurent Vivier wrote:
> The following changes since commit 67fe6ae41da64368bc4936b196fee2bf61f8c720:
> 
>    Merge tag 'pull-tricore-20230621-1' ofhttps://github.com/bkoppelmann/qemu  into staging (2023-06-21 20:08:48 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/vivier/qemu-m68k.git  tags/q800-for-8.1-pull-request
> 
> for you to fetch changes up to 532009054b45d75a3cf7ba9c31921add669d290d:
> 
>    mac_via: fix rtc command decoding for the PRAM seconds registers (2023-06-22 09:31:18 +0200)
> 
> ----------------------------------------------------------------
> Q800 branch pull request 20230622
> 
> Cleanup to introduce support of MacOS Classic

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


