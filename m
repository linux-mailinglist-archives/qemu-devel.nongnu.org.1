Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30E7EBAA8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:43:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33zP-00089w-6X; Tue, 14 Nov 2023 19:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33zM-00089j-7w
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:42:40 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33zK-0000cE-Hj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:42:40 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so2895255ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008957; x=1700613757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SccLfpMqTdQaUBI9RGIs7AoXJbRlipkvdFHouTXM09A=;
 b=bBK3S2Bv8h64z+49CmwruHMrdus61Qp3Rz7+adxABPVjPn3kPeJS1o2IqUimY9t3uU
 r9xOLrRMEF7fLb8N5NKkivjv0Ooy+PAym3cCtvG9e2xUWFj0slfAUsCsL8mFP6aP1gBH
 7SuFt5PsBuArWaXbOv6Yej59tSHTJhD4gk/t4hXhlJEQIJtAbSupI+C4SFhxunziP3Ra
 mRrGj8RkiYgY9ggyLJ2uKRv0XSZFMlcl/btVLttwlZxMFHDrdphToUMskgtKXGKqqw2v
 xuqWVrvUelt9K2NfcKIB6aaPjGfF5QIZO9NXtqwjVU/NUmqAu3VLWCX+EtHGq0y/Geqc
 PLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008957; x=1700613757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SccLfpMqTdQaUBI9RGIs7AoXJbRlipkvdFHouTXM09A=;
 b=wHm93lfq50pwX95dtU48sH+Gq16MLacpzXkoKMiyqKG3n9fr+R0rZdLNr47jWDRk5R
 uW1AuJs+q8vjKgcczGO4y4vyK+9hI7D6dtTLzAiny8YO+IDECQLUcHMogHTLwSN5CJQw
 7TwVV5oNPbxnf0W402Dz9EVfm5h1GwjXFIgeAA7yqXx3Oa/7ZWgR1hZlHwkEllo9uhgk
 k25niLYFB0Bh8I2FFf3A+LOhfoK/i48oEKhBBSfNrcgpzS1CPmcLrCdX8hlscFz3A/rd
 kE3p1UkLUrtOebo6pr4cA449VA5H9+Vsa0Uw9FKzhVuCYwVJeYY7jVJnofNKo/n5KBdy
 MdGQ==
X-Gm-Message-State: AOJu0YwqMJ6L6Y/CQAmiimeFwmvjK78524tumVAoAjHoCC+xLyj5n6xq
 bbAPFtiGGlABEZLzFO8iMqoiJfCf5hS9m6OFnRY=
X-Google-Smtp-Source: AGHT+IHF1PSJLySW/XbsFDTBBmWRutPXJu0TqWLpq/FPHM5bBclr9+AsvgA7heun+anN16kiWl3xug==
X-Received: by 2002:a17:902:e547:b0:1cc:2518:ef02 with SMTP id
 n7-20020a170902e54700b001cc2518ef02mr5498550plf.14.1700008956796; 
 Tue, 14 Nov 2023 16:42:36 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 2-20020a630202000000b005b3a91e8a94sm120068pgc.76.2023.11.14.16.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:42:36 -0800 (PST)
Message-ID: <465287d2-46b4-42b6-ad76-b65579fb94e6@linaro.org>
Date: Tue, 14 Nov 2023 16:42:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/31] target/avr: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-10-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-10-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
> avr5-avr-cpu
> avr51-avr-cpu
> avr6-avr-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
> Available CPUs:
>    avr5
>    avr51
>    avr6
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/avr/cpu.c | 15 ---------------
>   target/avr/cpu.h |  2 --
>   2 files changed, 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

