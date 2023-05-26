Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C636B712A7A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2a8F-00062v-Pz; Fri, 26 May 2023 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a89-0005xu-UI
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:17:29 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2a86-0004WR-89
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:17:29 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2553f2706bfso806193a91.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685117845; x=1687709845;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GMafuri7dCSFh4HNZBk0cTONnDo/akLXze2kx2Wxm4U=;
 b=WJ3BXt1waap4+EubpManD4NI0n3ZEfAm3fJBTKdL+Ot/bxAP/USAgFI9m/1N+wwCds
 GMOzzVm5D5/gcqw5VrWdKXzBORFmO0x9OvkeP3zvUIUEPFB/W6j51xga1JOoi1ZgI4YH
 zAH8oTVC7AjEYL9S8ClSLi6LDdjip69gk/2FqXMMDYccF8HNQacDfYXytnjPYn8YMtf6
 EshUMdlY3EDnhA7s95wRVapGr77HEFY4ct6LKechROidhTTw5YZs6ZuHvBB0zAJaAaLP
 ToMiOw5zsZv+BGX6UDMKn2JhCHQGMkKWaQrEyQ8OyXZvjkuBY4BL0C9Y31oBuk9jRrHM
 pxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117845; x=1687709845;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GMafuri7dCSFh4HNZBk0cTONnDo/akLXze2kx2Wxm4U=;
 b=juMEqTPUflazuPrTRyesNkte/D3+zVRi1J3RFhsRGea2ZYRInkkObaCFtGEJJGyryV
 3jJXioRPgd+OUa+p7iO2RamXO+ZVoKRz5GYOx9G0iPJPNNCpF7DLaoU1K10Gy+7rMAnM
 Dk6KorS2x6043GSL/1ttWw324yTdRnsmPPncvgkFdNBT5H+rShxDGOtLmXro9hd9n1Dk
 YmylL6Q91igFSYL2HVUbVg/bWbrIoQwpbqXLLJ1762vRtibib5rLbgi5g2q4ZVsHpqCS
 vyCXnfJ8i4sYMylYzC/KIkIDKAyjk55xFW0bXrOMmBiRtExqABiUFxMzvTaNaX6jHXTv
 tmsg==
X-Gm-Message-State: AC+VfDynXiz6QJ0za4R8GsG/x/oiS5zzP0WESC1y65N3h0jwCt00qJdo
 +vg9BzPRU/G5WIT3Y6XWv0V5Oi7ys8zKMgCQ/iU=
X-Google-Smtp-Source: ACHHUZ4v8PNqvphScAzctHI+hHKvLS3CrlInSjT5X3TMb1RV6ZqyFifceqNYIrlADDjrV7maPcVl8Q==
X-Received: by 2002:a17:90a:694b:b0:252:89bc:1cd9 with SMTP id
 j11-20020a17090a694b00b0025289bc1cd9mr6698598pjm.20.1685117844695; 
 Fri, 26 May 2023 09:17:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a191800b00246cc751c6bsm5130559pjg.46.2023.05.26.09.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 09:17:24 -0700 (PDT)
Message-ID: <a19f028f-e353-e304-a182-80ac6bb168cd@linaro.org>
Date: Fri, 26 May 2023 09:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/15] Improve --without-default-devices testing, fix
 CVE-2023-0330
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230526090840.2225958-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 02:08, Thomas Huth wrote:
> The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:
> 
>    Merge tag 'pull-tcg-20230525' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-05-25 11:11:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-05-26
> 
> for you to fetch changes up to b987718bbb1d0eabf95499b976212dd5f0120d75:
> 
>    hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330) (2023-05-26 09:37:04 +0200)
> 
> ----------------------------------------------------------------
> * Use MachineClass->default_nic in more machines to allow running them
>    without "--nodefaults" in builds that used "--without-default-devices"
> * Improve qtests for such builds
> * Add up-/downsampling qtest
> * Avoid crash if default RAM backend name has been stolen
> * Fix reentrant DMA problem in the lsi53c895a device (CVE-2023-0330)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


