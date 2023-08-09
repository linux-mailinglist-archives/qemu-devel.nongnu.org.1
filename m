Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C778775151
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZiT-0007G5-00; Tue, 08 Aug 2023 23:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZiR-0007Fs-Tm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:18:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZiP-0004Rn-QX
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:18:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6873a30d02eso4344080b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691551108; x=1692155908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMutGbebI1b5ZX2tbfEVJx4IHBCE8xzxWZ7aPyM+OQs=;
 b=DQq9qpo01EkmMXKtvvueg4K3Uiwvrs2SeZ68/dEvT6/YiTHuUqQFAQ7sTM5v3odkjB
 Jno/dj5gsRu0qqO7W4DNLevunLaQALpCjwO1KFrjWN/GUIFboWAjBUGxadN1QOUpt7H5
 TQ+6EoGT+/douK8s9/bKM8EtCNYfUverX2KTt41W+XeX5CUY6ysLufUiXKhyDqdbjy2j
 PzNh4chR9ukNIJsfczn3swX3LOfApxYCfbGxfAkDi0lBenof9bQJ62CgSmYV7eZ+KFXf
 I+Hkq0G0J8iIS3mfhozCS1685aSmbgiDo0BFSQOLlC8mDcJBhWl/vhGDiW/rQHg06ASB
 qvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691551108; x=1692155908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMutGbebI1b5ZX2tbfEVJx4IHBCE8xzxWZ7aPyM+OQs=;
 b=CcyvDa2yRBLHYB4vQ1lRpbsSwBTAgI0DaDYDFAUrPHns6ZNcKaP1GSftpAsDNAkrT5
 Cb6hwEkY0J8Sxa0WL9UP75G6HJGFal4X3Lib0qB2NDrwzUr1TnhE8gVKW3uzWX32oDyM
 OBQhkgK4Mn+o/BXeFXrKgkXxa7Qw6u9UrmtWWY2sxE1Rs9wsVh5wJ50oEgbcJHD+rtte
 j9pxMZBqR3QTRj1of+1V9WN73kHDyY92Bxcv4EtWaATJFctJqpT/vbbqYBExciTCbuU9
 7V+Nsf+n6qpgUH/UwF96uxotacPyF+fkHwCDQa6Pr0jq26bbU29Nmt609gI7X2sLMCSH
 OPjg==
X-Gm-Message-State: AOJu0YwNVVROmTHPmpD1LKNaPtKjKSOa2fgUcf9LIKbl6DvlG0ZfgmeT
 oaYcw/bWRQ68iCyQt1Iff8t3Dw==
X-Google-Smtp-Source: AGHT+IFr6iayJFIrP37HVfDhvXbkH14b2iv485OMa9AZczdI6gswdoFCjAwI2TNm0kcpQtzvrMoO9w==
X-Received: by 2002:a05:6a21:7807:b0:13d:ac08:6b79 with SMTP id
 be7-20020a056a21780700b0013dac086b79mr1135720pzc.60.1691551108335; 
 Tue, 08 Aug 2023 20:18:28 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170902db0600b001b51b3e84cesm9759286plx.166.2023.08.08.20.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:18:27 -0700 (PDT)
Message-ID: <ed909911-c23a-3c3e-7f6e-92244a06ecf9@linaro.org>
Date: Tue, 8 Aug 2023 20:18:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 7/7] tcg/ppc: Use prefixed instructions for
 tcg_out_goto_tb
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, qemu-ppc@nongnu.org
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-8-richard.henderson@linaro.org>
 <CACzsE9qw6QQLPT7uyE+x6LfqMUZo54+CixRZQs-AqP1KoCCMuw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACzsE9qw6QQLPT7uyE+x6LfqMUZo54+CixRZQs-AqP1KoCCMuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 19:56, Jordan Niethe wrote:
> On Tue, Aug 8, 2023 at 1:02 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> When a direct branch is out of range, we can load the destination for
>> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
>> the TranslationBlock for everything larger.
>>
>> This means the patch affects exactly one instruction: B (plus filler),
>> PLA or PLD.  Which means we can update and execute the patch atomically.
> 
> I think the commit message needs to be updated for Nick's changes.

Whoops, yes.


r~

