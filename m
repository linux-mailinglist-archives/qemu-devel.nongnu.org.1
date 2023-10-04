Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8A7B7AE3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxfY-0004ln-2t; Wed, 04 Oct 2023 04:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxfB-0004fz-RO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:55:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxf9-0001uk-Gg
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:55:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4066241289bso17848125e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696409722; x=1697014522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FiCvpEEyOTffHwW13ToQOIh4DwJnaN//d1fVHgrp/7A=;
 b=y2BKwDp+gAPMf3caUjQ5SU10TjLUeemSxvSF5x15ovIlu7CFbsagVt+oKdaw/M/gBt
 M6YJ0hY74V36WGj1Bq02LqV1CvJVdiGh6exD1eLimSBDW/wIsy5Lxni16+VdN4I08fuH
 +yENFEKF1iVbWGzEm0uoWqcRNdI9iJgOUhzlVt7awMMwNw6pMGCN6ksOkqZuL8cNypRH
 YTDalmiZbAASE6at6XxxPZPFzMIA1jJ9X8HSYTo2I5oGMeOTgLOI2xNJKrjJTRVqmsrc
 GfXIgPri6N2c0y5Uc4ui4ELQr1hPTng/rR4s3rnOntAtUdhC4cXjhrJyYO9x+7K3EgzF
 bZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409722; x=1697014522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FiCvpEEyOTffHwW13ToQOIh4DwJnaN//d1fVHgrp/7A=;
 b=sQWA7PHYCdGVhxM5zk82BQa7BegHhFg8OoYFyGTFymE+sCKo1zbtd8PDOAVG0CqlV5
 EbRf4CtARtfIOeP1BvzYhLCvPXWxv2CvFcLx4XxFt3hAoGYVCkk7evfTAW0z5vykf37H
 kp0vSkccxiQ/ooQruPOBy4Qsxp7CQPtiw80TfuUuOeBvzrUfFak/5m2dBfNkGklLBWzx
 lHXdO4kSyqL2I7W0q4ikCxNPssu0BwrOL+uwviD/R4thlWVhbozwe8lsBR3ZkemOx2Yj
 hY3jZHo7mODu3NgSsEki80CiE9x3KsktkxeRABR2VAJuHgM4fYj6divjXkRTO3j3N0UD
 UvgA==
X-Gm-Message-State: AOJu0YyCD1h/LTkOM6OZTVMH2702fC+8POG0C1aLRkZsy8dGulonv43p
 kRhUHXosj2DsdYuwLXn42VVldJ04o9/h3I3tqNk=
X-Google-Smtp-Source: AGHT+IHQK0tbCyDpbZqqPHBYN4VeegAXf2YwFpabMBgh5KHsYZDPE6fiPwoGy7kyX1r6VHk4AgKFvQ==
X-Received: by 2002:a7b:c858:0:b0:404:737a:17d with SMTP id
 c24-20020a7bc858000000b00404737a017dmr1466047wml.9.1696409721801; 
 Wed, 04 Oct 2023 01:55:21 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 hn32-20020a05600ca3a000b004053e9276easm959833wmb.32.2023.10.04.01.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 01:55:21 -0700 (PDT)
Message-ID: <8dfca186-50ea-611d-b833-a4326efc5ae7@linaro.org>
Date: Wed, 4 Oct 2023 10:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] audio/ossaudio: Fix compiler warning with -Wshadow
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
References: <20231004083900.95856-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004083900.95856-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 4/10/23 10:39, Thomas Huth wrote:
> The "err" variable is only used twice in this code, in a very
> local fashion of first assigning it and then checking it in the
> next line. So there is no need to declare this variable a second
> time in the innermost block, we can re-use the variable that is
> declared at the beginning of the function. This fixes the compiler
> warning that occurs with "-Wshadow".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   audio/ossaudio.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


