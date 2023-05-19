Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDF709B62
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q026M-0005KK-U4; Fri, 19 May 2023 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q025p-0005Cn-CT
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q025m-0007N0-T6
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAAQd4d3qAz80iiy40hGesge0Veq1rNCSEeIugXlWE0=;
 b=VoytVy3Y1R5SavVRN+Q3wYt+b3HH1bJhoC/hzNcQ5D4OGWWp2tKnQV97NLNBdX1UA2N2O1
 y8IysntBjIYdAGptQ/okxsuTazl5ewVhxl/EmNtbtBtlJZmmzjAzzyf7nSp+Cuk/4qOdk+
 Jwz1EdqX7agnbiqaa98dy9UkkPKenXU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-3UhZWwW1MV-wNROyp8G4kA-1; Fri, 19 May 2023 11:32:29 -0400
X-MC-Unique: 3UhZWwW1MV-wNROyp8G4kA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so370227666b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510347; x=1687102347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fAAQd4d3qAz80iiy40hGesge0Veq1rNCSEeIugXlWE0=;
 b=FuT46LaW/8jOhdwO91L5Y5zpyQnYjULfh1A9Ke2LYqd6wqfKs7tZpnlIHP/GCYMcMv
 H1jdPsZcW0Cdd/EBZcHtZqYKwqt/wFogxdlIYOep/VRD4GiIGi0tZybYFOFMpHg9rbBF
 0nd9poVHpzeTbkKznxfLNIIooxYyuLEAIcn/0ULeCJbdfFBATMRHtDaTiCMSUgXQjh5s
 DIBamK/e+z5k7UAFakBvkeCBenuirNGBuf2/m9/LYu47xexAsD8I3xuV1M87RKdEvNyc
 UhTeWhlTwuUqT8uNdoc1u6osmOJ3Kt+ErAiSwLHQpNrDIuKFbMqMh9DzLSqbEsBPbxul
 iZrw==
X-Gm-Message-State: AC+VfDwxrR2eM6d2/6oARRDQSgNs4SmxlwJGyRIuFPaJdzXlNc4SKSZl
 5Ehy/EVxLDGJ3qJUxcTkPIet2WJc1scmn0XYtvrtyG+VQSQAo3zZEehKBJAV0IRRZLgt9ViV6Kx
 OkRQfHc0ZCK27mUPpZWTIGZ8=
X-Received: by 2002:a17:906:4784:b0:966:168d:8c9 with SMTP id
 cw4-20020a170906478400b00966168d08c9mr1977383ejc.32.1684510347152; 
 Fri, 19 May 2023 08:32:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uWO0BCjU5xMASbP1zhpFkG5Du+mm3k4r8KSAvAZ7USdxjbqOALdh8KttfjH+sOYJU/CjpnQ==
X-Received: by 2002:a17:906:4784:b0:966:168d:8c9 with SMTP id
 cw4-20020a170906478400b00966168d08c9mr1977360ejc.32.1684510346731; 
 Fri, 19 May 2023 08:32:26 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3?
 (p200300cfd723b0c78fa2ce552d0c5fa3.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3])
 by smtp.gmail.com with ESMTPSA id
 qn6-20020a170907210600b0096637a19dccsm2425996ejb.210.2023.05.19.08.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:32:26 -0700 (PDT)
Message-ID: <9fbc12f3-f2a1-cd9f-be2c-903d367b5f4d@redhat.com>
Date: Fri, 19 May 2023 17:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/19] cutils: Use parse_uint in qemu_strtosz for
 negative rejection
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-18-eblake@redhat.com>
 <7rcpd5t42niowmel4cxzs2xb7qxw42jmumr4e2r6y2tsmf3r5w@dhkruvghfjlx>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <7rcpd5t42niowmel4cxzs2xb7qxw42jmumr4e2r6y2tsmf3r5w@dhkruvghfjlx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12.05.23 21:34, Eric Blake wrote:
> On Thu, May 11, 2023 at 09:10:31PM -0500, Eric Blake wrote:
>> Rather than open-coding two different ways to check for an unwanted
>> negative sign, reuse the same code in both functions.  That way, if we
>> decide down the road to accept "-0" instead of rejecting it, we have
>> fewer places to change.  Also, it means we now get ERANGE instead of
>> EINVAL for negative values in qemu_strtosz, which is reasonable for
>> what it represents.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/unit/test-cutils.c | 7 +++----
>>   util/cutils.c            | 8 ++------
>>   2 files changed, 5 insertions(+), 10 deletions(-)
> Returning ERANGE instead of EINVAL changes the expected output for
> iotests 49 and 178; this needs to be squashed in:
>
> diff --git i/tests/qemu-iotests/049.out w/tests/qemu-iotests/049.out
> index 8719c91b483..34e1b452e6e 100644
> --- i/tests/qemu-iotests/049.out
> +++ w/tests/qemu-iotests/049.out
> @@ -92,13 +92,10 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off comp
>   == 3. Invalid sizes ==
>
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
> -qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
> -qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
> +qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
>
>   qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
> -qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
> -Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
> -and exabytes, respectively.
> +qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
>
>   qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
>   qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
> diff --git i/tests/qemu-iotests/178.out.qcow2 w/tests/qemu-iotests/178.out.qcow2
> index 0d51fe401ec..fe193fd5f4f 100644
> --- i/tests/qemu-iotests/178.out.qcow2
> +++ w/tests/qemu-iotests/178.out.qcow2
> @@ -13,8 +13,7 @@ qemu-img: Invalid option list: ,
>   qemu-img: Invalid parameter 'snapshot.foo'
>   qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
>   qemu-img: --output must be used with human or json as argument.
> -qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
> -qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
> +qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
>   qemu-img: Unknown file format 'foo'
>
>   == Size calculation for a new file (human) ==
> diff --git i/tests/qemu-iotests/178.out.raw w/tests/qemu-iotests/178.out.raw
> index 116241ddef2..445e460fad9 100644
> --- i/tests/qemu-iotests/178.out.raw
> +++ w/tests/qemu-iotests/178.out.raw
> @@ -13,8 +13,7 @@ qemu-img: Invalid option list: ,
>   qemu-img: Invalid parameter 'snapshot.foo'
>   qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
>   qemu-img: --output must be used with human or json as argument.
> -qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
> -qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
> +qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
>   qemu-img: Unknown file format 'foo'
>
>   == Size calculation for a new file (human) ==

With that squashed in:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


