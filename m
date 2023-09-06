Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7799793941
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdpK7-0001YY-LP; Wed, 06 Sep 2023 05:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpK3-0001Xa-CA
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:59:43 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpJz-0006AH-0c
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:59:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so539085766b.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693994377; x=1694599177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qUOVwtVP6YwDHF0pvb5c6hLJ0Y67BlgtKxuDWFXJxQ8=;
 b=UQlm1Fy+WKnkuyA4GqG1d4U5moHFKU6mlL+gZjgmi5042Klg/vyZUEVDiowzxuKcGO
 H7dwp/cPicz+lPBGzQ2wx0epa38/piZw2dUpW55kV87hJoR3rWO05WPmKG/CZYgvx4Bc
 OoPynCsa0sljFDcETwoyb7pA6iwnddiLcT73oCXnLd5xsI5uiW/qAuHqYAzYUcJWCvfi
 cWQRdlhknUwFfffVSMlukFVAgFf/3oiL3khMLTNQoZWjJ1HRxPA3FlGZZBb3WEndlfSX
 KzMv/GgpP3Kh1a2DkRoc1l3YRvhq8IKPylgtIvjSIZDUgwoflIj8Dn+lUr8G//799Qgo
 onvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693994377; x=1694599177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUOVwtVP6YwDHF0pvb5c6hLJ0Y67BlgtKxuDWFXJxQ8=;
 b=g/HhiIIGEpwT1wjBsn7vem4aaoEdkevioDeGJw3cgLLyfBgNLHQ+U+EQqpVjX+LiJP
 i1noE5hcmeSguXrkO+6VpkUVBloyZhAED3lhVPtNhAhQOpNMFTAmljmVqhisNBiAi6+F
 QOzAG8l0PhU9NrBIV9GOqOaIl2nTHwHUGwhPi9A/D3hZHFcUhvwx1r4ggMzhfTrrlWuQ
 A4wE556ftuAGd0rTiG7CY3DzLaMY5pU82cu27k0bWpI/XD642pv+ud10cyCfBZQznInf
 1R0kBfoBsAa2b4uR9MI9+S89StJoaplUu6/4MM3dVMKkB8BTQYYC9yAZAy73FjRT/Fcn
 2WCw==
X-Gm-Message-State: AOJu0Yyrpd//tB0+z3J5A5ojZd2u4y+HmxtTiZGJpmek/l4aWCgR04mE
 8qcnX0j/z/YmUl78yh+0rvpifw==
X-Google-Smtp-Source: AGHT+IGtGEEZlrrLes3b5Z+aM2dD916vSWHVA0T4J465YZsvpFvVdFfVo404KoZI5fzMcacxpxhPMA==
X-Received: by 2002:a17:907:762a:b0:9a1:bb8f:17d7 with SMTP id
 jy10-20020a170907762a00b009a1bb8f17d7mr1737330ejc.12.1693994377381; 
 Wed, 06 Sep 2023 02:59:37 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 s19-20020a170906455300b0098e0a937a6asm8806766ejq.69.2023.09.06.02.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 02:59:36 -0700 (PDT)
Message-ID: <024e0d30-7022-1d9b-0bbd-cfb3116f1020@linaro.org>
Date: Wed, 6 Sep 2023 11:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 5/7] vhost-user: hoist "write_sync", "get_features",
 "get_u64"
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-6-lersek@redhat.com>
 <406fe376-b432-db47-9642-04d6254faf37@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <406fe376-b432-db47-9642-04d6254faf37@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 31/8/23 09:20, Laszlo Ersek wrote:
> On 8/30/23 15:40, Laszlo Ersek wrote:
>> In order to avoid a forward-declaration for "vhost_user_write_sync" in a
>> subsequent patch, hoist "vhost_user_write_sync" ->
>> "vhost_user_get_features" -> "vhost_user_get_u64" just above
>> "vhost_set_vring".
>>
>> This is purely code movement -- no observable change.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>> Cc: German Maglione <gmaglione@redhat.com>
>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>      v2:
>>      
>>      - pick up R-b from Stefano
>>      
>>      - rename "vhost_user_write_msg" to "vhost_user_write_sync" (in code and
>>        commit message) [Stefano]
>>
>>   hw/virtio/vhost-user.c | 170 ++++++++++----------
>>   1 file changed, 85 insertions(+), 85 deletions(-)
> 
> Phil reviewed v1:
> 
> http://mid.mail-archive.com/98150923-39ef-7581-6144-8d0ad8d4dd52@linaro.org
> 
> and I would've kept his R-b (similar to Stefano's) across the
> vhost_user_write_msg->vhost_user_write_sync rename in v2; so I'm copying
> it here:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Hope that's OK.

Sure! (same for patch 2/7)

Thanks :)

Phil.

