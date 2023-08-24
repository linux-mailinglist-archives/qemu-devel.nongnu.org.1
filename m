Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B38786C9F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 12:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ7LD-0006Y4-EX; Thu, 24 Aug 2023 06:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7L5-0006X2-SB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:13:21 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7L3-0004y6-1w
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:13:19 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4ff88239785so10138715e87.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692871995; x=1693476795;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/cY+H7y5+TIxMQbUkzqLPvcvmlCU/5P9XbZwTCsOoxs=;
 b=BK/5+tnSwTJizTXwOpZNQvitS6p7/psGt2n4rVRNg5MPPHsNt6IvgqcK+htudjRI9I
 h2nAuHH6vXo5kSXPG3fZ/pJ8Xbj1V/RX947zuLSdf981ER7tshYtS7EXobciHGHEXzxH
 UbdyDaqVQ6xFbmLsRsCljwdwIDCI9O/tqS1RrFXr9koqmdbxHqfb/+Y8+4sur95vmDh0
 bsXSh/TXNmjoxbGBIms2/Rw2MH0/1wGQR/0mmwWS2SEPz81boaED+9pVw9xnl0L5UP+G
 2AtC/fwXXB51kIc9InA+LbTw/mWnCKe6etGcG17TR8EZ10nLZGgXcLeDl26MesSoRIDL
 O8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692871995; x=1693476795;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/cY+H7y5+TIxMQbUkzqLPvcvmlCU/5P9XbZwTCsOoxs=;
 b=c+nemaI0M5FuKP0D34vdthb/UtjIPS753L4Mr5icOINgpoJYT5EV05kLYywg1gWcDh
 mFGRLS3w2+utAomoGEUFnc7f2aKhU63HLzCyPpcCtzvGE0hndVVz+Op6jgvW15p8lMM9
 9/IA9hkRgexYyQYP+A9dijjuQU9vFF3tPq0b9KYz+xyaB0QQLp+32EuhOfCe0oF8th5/
 Iie98f+AHvlQcYMFJwm2BZcFlZMneRbrhg+eumoJVYPWNDEQkQQUGK2tLmsp/LA3vtSg
 G7eOGNzMrPXItqFlabNPTpDWQCgzEPPhSt9fy0dRgb2xmMkHh5ZCXo31172M25YBmNJ2
 nEIA==
X-Gm-Message-State: AOJu0YzSIYc12ieqJtmVD9Gt225twYiP1sk1JW+0a7akBGHsg5wxucl6
 JJV0/TYXD1VWB1Z+/zh0AH/l5BTpaAlWN8IfTtU=
X-Google-Smtp-Source: AGHT+IEi8PLPD2gNi291Ovo3OhZ0hTDxJ/3zjuWqmTkKpCgU9zeL3WPHCWMzUFVAh3YxUrh41X7FfA==
X-Received: by 2002:ac2:4c82:0:b0:4fb:7675:1ff9 with SMTP id
 d2-20020ac24c82000000b004fb76751ff9mr8865055lfl.9.1692871995156; 
 Thu, 24 Aug 2023 03:13:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b00317e6f06e22sm21880620wrx.77.2023.08.24.03.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 03:13:14 -0700 (PDT)
Message-ID: <69438c7a-2b93-321b-b10c-bf9c3f42dc5c@linaro.org>
Date: Thu, 24 Aug 2023 12:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 18/24] audio: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-17-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823065335.1919380-17-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 08:53, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   audio/mixeng.h            | 2 +-
>   hw/audio/fmopl.c          | 8 ++++----
>   hw/audio/fmopl.h          | 2 +-
>   hw/audio/gusemu_hal.c     | 4 ++--
>   hw/audio/intel-hda-defs.h | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


