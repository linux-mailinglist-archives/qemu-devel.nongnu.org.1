Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A9724C9F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6c5i-0007oI-S4; Tue, 06 Jun 2023 15:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6c5h-0007o9-O9
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6c5g-0004r0-25
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686078695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1YwXZOo5YkLZOkv3AzDrPgCZgm7n9MVlCy2E/zUfH4=;
 b=aozf399SsuepQUPSt871lmoTEdrO5HnM5x6pYA/nqz5mqur/SQ7aOIkU05o8YZr0TJB3p+
 t62nkkR5lpHkqi0JUzGY9bAjIsNOlANhu/nM5IEKq51qaOI2igwa54/JAoW6RHKB/0s+r9
 /Hs9W/ElQpI870Wt+2ScTs7dWUQF8fg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-9n5MPOs_OfS_H_6bUkTHTQ-1; Tue, 06 Jun 2023 15:11:33 -0400
X-MC-Unique: 9n5MPOs_OfS_H_6bUkTHTQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a341efd9aso556331166b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078692; x=1688670692;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B1YwXZOo5YkLZOkv3AzDrPgCZgm7n9MVlCy2E/zUfH4=;
 b=N7oAr3VSGDqrSdBLOnKtLXRunYP6m+v8K8fN16zhk91cIMvAeiirGQmzXG+cMgvjdZ
 cWRGdj1EAj1k2052nkFSY1Kp/g8z3uL5yYVHtPEesWUaOU2AU+SQlH3PvUKRfNat6T3v
 2UVC28m4C48kMMhWtGkBaaEXttw9fCDW0/9ydwte6aApdbgGYxAZJt+W94eVzsbF4W6T
 93vIWWpdEo+5vczuFrUBc+QGc+PC11yKsLmw1/PtJbXlieAuHF9GBPvOGWA+NZDMTOqS
 res5qzLR4YpFFglv2tmto9YxSzO0RZF5NMuv1sxy3g4sg4S/jjKAUMoPqEQaVODEmR4q
 b8pw==
X-Gm-Message-State: AC+VfDwO67tS7SNYoXlLYUmya7ET8u1ucOMA6pwL5G9N5tAf3qTIS9Tn
 yd/OMgnulfMtDiKXXfE3eiA/xqVArqhsOiEV3Ai1mbeNzS65AZ4NNltszfH4LBGb4vjhsUaMSQK
 eTbt4luDQ4b6JNrE=
X-Received: by 2002:a17:907:3d86:b0:973:dd61:d427 with SMTP id
 he6-20020a1709073d8600b00973dd61d427mr3884554ejc.66.1686078692558; 
 Tue, 06 Jun 2023 12:11:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4uYVeG/bLAp++TzXnaKnC1FRhPKQwUzBZ9h3djqu0nDeHNOd89baXMQx4z8W9v9gKYgYZ5MA==
X-Received: by 2002:a17:907:3d86:b0:973:dd61:d427 with SMTP id
 he6-20020a1709073d8600b00973dd61d427mr3884538ejc.66.1686078692191; 
 Tue, 06 Jun 2023 12:11:32 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 oz17-20020a170906cd1100b009745edfb7cbsm5923531ejb.45.2023.06.06.12.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:11:31 -0700 (PDT)
Message-ID: <1bfcf2f7-237c-895f-8879-6067ec221cb8@redhat.com>
Date: Tue, 6 Jun 2023 21:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com
References: <20230606162556.58110-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
In-Reply-To: <20230606162556.58110-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 06/06/2023 18.25, Richard Henderson wrote:
> This test consistently fails on Azure cloud build hosts in
> a way that suggests a timing problem in the test itself:
> 
> --- .../194.out
> +++ .../194.out.bad
> @@ -14,7 +14,6 @@
>   {"return": {}}
>   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Gracefully ending the `drive-mirror` job on source...
>   {"return": {}}
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0f1be14cb6..000062483f 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -236,7 +236,7 @@ build-tcg-disabled:
>       - cd tests/qemu-iotests/
>       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
>       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>               208 209 216 218 227 234 246 247 248 250 254 255 257 258

That's fair to remove it: The iotests that are run here were only added here 
because they were tested to succeed on the shared runners - if they were 
running successfull everywhere, we would have added them to the "auto" group 
instead so that they'd run during "make check-block". So if something is 
failing on the private runners now, it's ok to remove them from this list here.

Reviewed-by: Thomas Huth <thuth@redhat.com>


