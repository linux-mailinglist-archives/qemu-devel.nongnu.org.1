Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D697D6AFA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 14:15:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvcls-0000qh-IP; Wed, 25 Oct 2023 08:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvclp-0000q6-7C
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 08:13:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvcln-0008S3-KD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 08:13:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so3805702f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698236034; x=1698840834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w5EGazJjI8v0lOq++TCEf6NEqh0hZIe3syCD+tlEmO8=;
 b=gBOYyc0CoUVSJPzawVAHLPROQI0M4vpAUGFawA+ElnG6qndZqgF9LhplcI+5avpSH7
 LjZblbbUCpIllirkQ93XzonhcC1FRW46fWlKOpVfOP53t9cu1AvCHZ3Gr79iQcE5cBsU
 kJSoLa7b2x7WbRn/mkZQTz/0iWzvZfdM/HDagu3Jd+kD0cLPidBA258dnNmCeFVn0RzZ
 QQC8HhzD13YxfmuhI42ouSD+T0gMpzT4PbmDvOnMWEhTISkh2WPdECQ5rCoAAobjPl0A
 85Mu8D8t7HjVK71UKldw1MaTozpw+dZe8T43hfFPWe0FM3ci+RaBbpj8/YX7GT5yFyzs
 cmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698236034; x=1698840834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w5EGazJjI8v0lOq++TCEf6NEqh0hZIe3syCD+tlEmO8=;
 b=TF4wWTfHI1JufCV3TOVbgCe0R3JW9tuvZPbBtfgzeUMswukK2poVAMSG+bkqEROyTX
 d1CzFUSMuxBtZiC9DZ7872whNGDpLYZqGBbWnmgAvHOCcszEcpJpkL/Nm4r4fCAoL4MA
 TSUzzZSFBJaJdZDlFW4i0HezbxRfKYc3qVAlilj4AQDjzK0qRZiVRALOUafi6163KvMc
 1iJBCHsAHK6fZFW7+ZRy+HAnq+kifZLnWp8I96iwqERLq6afVypDLNplz6kQrm3Pb5Hz
 jHa9BTvtwQapiQegku66nRq3HVYNWSLonL1j3Y4VZg8mkBpbkznY99kuA/UXvsoq8i9d
 DpCQ==
X-Gm-Message-State: AOJu0Yze2OdH6/+NHZjaqRpcSjI3orgy8/4NZgWePmeCcKOt9dxHWQGx
 0wUZ0UgOmjobloMUdmbKY2CUag==
X-Google-Smtp-Source: AGHT+IEnE6OqbOHSHYLd5Qt7rhj8uPUk0nxujKtlBmCk1jdvuZdr0EyTCas4oLvzVSK/ns47fo/dEg==
X-Received: by 2002:adf:fdcb:0:b0:32d:aa11:221d with SMTP id
 i11-20020adffdcb000000b0032daa11221dmr9284774wrs.27.1698236033556; 
 Wed, 25 Oct 2023 05:13:53 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 cc17-20020a5d5c11000000b0031c52e81490sm12223814wrb.72.2023.10.25.05.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 05:13:53 -0700 (PDT)
Message-ID: <85e11cd1-cfa1-4410-7938-cf5d120fff95@linaro.org>
Date: Wed, 25 Oct 2023 14:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] util/uuid: Add UUID_STR_LEN definition
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <20231025101245.751559-1-clg@redhat.com>
 <20231025101245.751559-2-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231025101245.751559-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 25/10/23 12:12, Cédric Le Goater wrote:
> qemu_uuid_unparse() includes a trailing NUL when writing the uuid
> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Add a
> define for this size and use it where required.
> 
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/qemu/uuid.h              | 1 +
>   block/parallels-ext.c            | 2 +-
>   block/vdi.c                      | 2 +-
>   hw/core/qdev-properties-system.c | 2 +-
>   hw/hyperv/vmbus.c                | 4 ++--
>   migration/savevm.c               | 4 ++--
>   tests/unit/test-uuid.c           | 2 +-
>   util/uuid.c                      | 2 +-
>   8 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index e24a1099e45f2dfc330a578d3ccbe74f3e52e6c1..4e7afaf1d5bd5d382fefbd6f6275d69cf25e7483 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -79,6 +79,7 @@ typedef struct {
>                    "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
>   
>   #define UUID_FMT_LEN 36
> +#define UUID_STR_LEN (UUID_FMT_LEN + 1)
>   
>   #define UUID_NONE "00000000-0000-0000-0000-000000000000"

After this patch, when do we need UUID_FMT_LEN?
If it is dangerous, better drop it and keep:

#define UUID_STR_LEN (36 + 1)

or

#define UUID_STR_LEN (36 + sizeof('\0'))


