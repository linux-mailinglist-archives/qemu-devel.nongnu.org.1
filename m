Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D337C7263E2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6urq-00030v-AZ; Wed, 07 Jun 2023 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6urn-0002qE-KA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6url-00056D-BP
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686150868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gw8TWM/xB2dBTkYwDJmVvsBnPO1XV5aSAp2VNfU9Cc4=;
 b=OTuZA+I8RKeeMGoRZoHyqhaVlsPTEIboO7JfIom1HQmiYNAmGqd1y/lGyx6/Z1xoPJt/CC
 GxxUKsklDk0PRVudv3LPpYcj5w8/x8r+hXhlF35tKpjIkp2YypsnUuNiCLntzVEe/JlU8j
 DuD2dVnTHDNKfP+UTqqaC1L8Lhs0A+k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-2OrtFNwqPBeDO_DJYnttlg-1; Wed, 07 Jun 2023 11:14:26 -0400
X-MC-Unique: 2OrtFNwqPBeDO_DJYnttlg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-516302ba604so1093731a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686150864; x=1688742864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gw8TWM/xB2dBTkYwDJmVvsBnPO1XV5aSAp2VNfU9Cc4=;
 b=iWbmOdG9stS1WGvcC4Cd9/w83gWTvCWr/n9OOs7HUCx4e0lqhQwUgxNHRwcByLBfp5
 /1VqbyIb72+wzlzI2u2WKmJ4rqDy1WLpOdSeqxT32V1x5glk8rUqoNBCAd2d2QIr2h7g
 0FctkgMERMgb1mggR6s4FpyugrDkqGxrHW3NqLJq9nhjEhH4v6mBwgTx5ilvf+Nft4ob
 oBv4Dk13SWpps2FUzOqCsmWXaIJqvtrRi3/Fe4LQbHMc0hOEkzIp/95TSeSD5y7LlEfl
 uVzeVCFjNLsf81tvhg9V/CBediEi2WZdyjhfdeX57MSfw5gip/1Q0HY636Ultnbgnhw7
 ojpg==
X-Gm-Message-State: AC+VfDxvDoSfX+jJ7mkiG8hqj2a0ZBTfYR9U7F+O3cEIy+rk+MSbjiHp
 5qar4m1t+JEvlsTb5UWxRCnwDb443mqfPLa63nJm8O8H/VQP/MiHFq87GboIo6iYwkEsULtqMfM
 6iMPZU4qfIH5khZA=
X-Received: by 2002:a05:6402:618:b0:516:416b:f736 with SMTP id
 n24-20020a056402061800b00516416bf736mr4267824edv.35.1686150864710; 
 Wed, 07 Jun 2023 08:14:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pyHqAez4uHFNiH0NGFUfWGQAhvuCMnu7SSlTd/SLID14JkV659TkT4uS8m30uEfYA3uE+/Q==
X-Received: by 2002:a05:6402:618:b0:516:416b:f736 with SMTP id
 n24-20020a056402061800b00516416bf736mr4267816edv.35.1686150864456; 
 Wed, 07 Jun 2023 08:14:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d740:9017:191d:265b:b68c:4fa4?
 (p200300cfd7409017191d265bb68c4fa4.dip0.t-ipconnect.de.
 [2003:cf:d740:9017:191d:265b:b68c:4fa4])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a056402150300b00514b99afa57sm6489986edw.44.2023.06.07.08.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 08:14:23 -0700 (PDT)
Message-ID: <fcd7669d-92ec-fd24-1485-e746c2e358c7@redhat.com>
Date: Wed, 7 Jun 2023 17:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 05/17] parallels: Out of image offset in BAT leads to image
 inflation
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-6-hreitz@redhat.com>
 <a6dca05c-aebf-fe39-6cfa-cd626475865e@tls.msk.ru>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <a6dca05c-aebf-fe39-6cfa-cd626475865e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07.06.23 08:51, Michael Tokarev wrote:
> 05.06.2023 18:45, Hanna Czenczek wrote:
>> From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>
>> data_end field in BDRVParallelsState is set to the biggest offset 
>> present
>> in BAT. If this offset is outside of the image, any further write will
>> create the cluster at this offset and/or the image will be truncated to
>> this offset on close. This is definitely not correct.
>>
>> Raise an error in parallels_open() if data_end points outside the image
>> and it is not a check (let the check to repaire the image). Set data_end
>> to the end of the cluster with the last correct offset.
>
> Hi!
>
> This, and a few other parallels changes in this series:
>
>  parallels: Out of image offset in BAT leads to image inflation
>  parallels: Fix high_off calculation in parallels_co_check()
>  parallels: Fix image_end_offset and data_end after out-of-image check
>  parallels: Fix statistics calculation (?)
>
> Should these be applied to -stable too, or is it not important?

Personally, I don’t think they need to be in stable; but I’ll leave the 
final judgment to Alexander.

Hanna


