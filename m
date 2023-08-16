Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5F77ED6C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 00:52:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWPMt-0001os-JI; Wed, 16 Aug 2023 18:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWPMp-0001oP-Ca
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:51:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWPMm-0006ae-04
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:51:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-319779f0347so3084536f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692226310; x=1692831110;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6MUYd5+KMBXNFb2o5hLQZrBYZfNdMH7XXF/h8xqkb0=;
 b=GIdQzQe+3WENAqoJMhpJ0TLwd/d8Vcu6lyo7HwQy1QL2x2DbGxh3ibwYJ6dX47x7hF
 mgPIaETvkQQ4gcUtq6d4vwgUZeD5/VZM3vieULsLxLu6JsKr+blBr/tm5YcJKg/yc2eM
 Eru7YKvBkGmHUg2MThtDe+RoAWHjrh1GeQBs1U5igVcbgnwNDhGYm+cAPb7UgSRpEbgY
 OmqcyVe2UYJ+bkeoRbLkBEeAEfHWGT9TUsY9xp/Cs1fh4Sya1OJtADMw/uL0MSvZXo0i
 H5vpcWbrOF+tvfN2Mj6AKOe8BAN3S4b2B23SwUKKbE2JF/bSg5zIA+A7Z7ozMtOCnWId
 fdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692226310; x=1692831110;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6MUYd5+KMBXNFb2o5hLQZrBYZfNdMH7XXF/h8xqkb0=;
 b=OrjbYyyssZhUnYI6VoU0QvSXGmQjr61SQ1NMujO9NST0wXAJw52qpSLCfn8Bx8vIBN
 9TLHVaIoGWQSIfqXIV6XsacMwimgYFfcniMV7+lSszRbHGc/eE8USWbzQ2dVHBwr8k93
 LiwtcSlv99jBBdjRwfgAeRf/RS4M7m92aqkkM7m1oMcdOF2Lizf/s+56eoAt3gWCwgiK
 5F4+mDHuQwBAyqc019CXGonbHuicp0pOTT6pcIKLWuquHUPVSHmU/WqskKMV3MK+6voM
 C0z5g7l+3usB0CJgGJAXCg3sbe0dxb01CODB0AsiUGXJH6lFm2Y/oSt1MEHplLlZ32wL
 Nm9A==
X-Gm-Message-State: AOJu0YwlgrQUWSoK0R0ItMmMyo7TkkQ/dm8ZWTIxrcgdOXhV5WLt/GNX
 Q1Tsd6uY8RGXYdR5gMCmUHU6Cw==
X-Google-Smtp-Source: AGHT+IGtsxQMZrXnsP9XzgQyviHB7gZUZFnwGjrVX+qB6nOHU7lju8e+jxJ+ZGoU3NibHaFXuX6d3w==
X-Received: by 2002:a5d:4d8d:0:b0:314:4c1d:1c0a with SMTP id
 b13-20020a5d4d8d000000b003144c1d1c0amr3177909wru.46.1692226310183; 
 Wed, 16 Aug 2023 15:51:50 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b003fbe791a0e8sm840838wmb.0.2023.08.16.15.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 15:51:49 -0700 (PDT)
Message-ID: <cbb19b6e-e687-e13a-63da-b1ef90cff4b4@linaro.org>
Date: Thu, 17 Aug 2023 00:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 05/18] linux-user: Use ImageSource in load_symbols
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230816180338.572576-1-richard.henderson@linaro.org>
 <20230816180338.572576-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816180338.572576-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 20:03, Richard Henderson wrote:
> Aside from the section headers, we're unlikely to hit the
> ImageSource cache on guest executables.  But the interface
> for imgsrc_read_* is better.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 87 ++++++++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 39 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


