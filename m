Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8119F076F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 10:15:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1kq-000519-LP; Fri, 13 Dec 2024 04:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1kk-00050k-8H
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1kd-0000GV-2l
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734081261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7M4r6m3BDcicSV3XOR6Pqe/H4dbjo+SlJ/8qD6SV3Y8=;
 b=cwSmzUqPm+4+CSI9gg5aRHZNAfXxFFg0G8y6MMLeoLRlAGEQi8n3NqbbU9Xted8WyS7tmX
 XM0t7EAbi9aFLMK+ZnWC8diPlAhE9YKuvuHGfSC6Be8I322yC5eyF1vzCidZSolL7JJryq
 ZoctJDaZjVpM4gMo52DgkC1u+7fsJOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-LuHVY7vBMb6UAz-PlK13CQ-1; Fri, 13 Dec 2024 04:13:12 -0500
X-MC-Unique: LuHVY7vBMb6UAz-PlK13CQ-1
X-Mimecast-MFC-AGG-ID: LuHVY7vBMb6UAz-PlK13CQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361f371908so13583445e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 01:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734081191; x=1734685991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7M4r6m3BDcicSV3XOR6Pqe/H4dbjo+SlJ/8qD6SV3Y8=;
 b=hjXRFD2S2zWOoOczeFXH6V28phuQ0q2/78mcJJCBJ8v8RASX1WAi95VgWhC9pAkiMM
 4lOpot/89gMB0UtbikWJJJG6sI+WMI6yoIDajT16D3Omd89mKGp0lKgNv7bLBnpqD5Rc
 Nny3VEftNvF2KBtWiE51FM40S7LT/MUUpEwBki5CEn/34/TtWRFpC8c22r5Zb+BwwLFT
 RBzAQlLqLflLwYNbWdqLwKIJ6dI2zOEpoZJ9QG3Ifbie2eaG9J4rqVW6iX9zqxEGxxyo
 VVauWjKaMhbIpWI4fWS4CRiCA4sBeNWwFKgjboGym7kGXoxdnnJdcflXjYMKAHKI6Dmk
 Lsig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP3nt+W3pu6e1hcL540ZPVQRTtJpYX1JDTM5aj2o7Nc0e80FV2esKoqH6GkRonAgsU1Xg9Y2LbOie4@nongnu.org
X-Gm-Message-State: AOJu0YyvRk4E4yLZPU4sF3aXc6VOXSsqia8RC8GB3giQUiIomkM5Iwnh
 V8VF7RRyqbYUcTfUB07EjHZmbk5CPyFXUVMl5JQnFKB9mWA/gtawZv9vXGXtUbA+S+USskIFEf/
 GUqvmxvR8CTLLIKC+1LbeOC2m5Mj6urjMr1nAB0e7Hf2JrZJ7VUW0
X-Gm-Gg: ASbGncuXxZ1Yd0DgqZH9+QJ7AV0jYQCwKuS2HnO3zHlh+7db6jcXVsre8QMbd5CjTZ5
 D6vp4kg+wmIBsVc7pXSbW0PYjZNlgXFMKPIUinr6+I3IzotmbeHnrBRetUupKIquncKt2d2n6vW
 EG8+4meCWHn+1rSQ5gr+0+5v2T9JpnBPFuXhRT51QZCXn56RkQYqkyYn3sOEg0ILZJ4QEl5fSq3
 0YaLI2BmjX51/B/BOV32uL42fk/g6SZeQCSwzL1Jp/9cj7b0l4juCMe4gN2ihvc2ZcmqYLoqm9R
 tf4q9w==
X-Received: by 2002:a05:600c:19cc:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-4362aa1371dmr14788205e9.2.1734081191449; 
 Fri, 13 Dec 2024 01:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgc1Shyn9ZNB/vi09PCMjM6Fp8nbgV1STaAux2r37RDuSI7W5WZPPXphNES99N8h17aZ5SJA==
X-Received: by 2002:a05:600c:19cc:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-4362aa1371dmr14787995e9.2.1734081191110; 
 Fri, 13 Dec 2024 01:13:11 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257178e3sm43291165e9.41.2024.12.13.01.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 01:13:10 -0800 (PST)
Message-ID: <33760109-0d6c-4e67-8164-e8b6ea2b2f90@redhat.com>
Date: Fri, 13 Dec 2024 10:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/31] tests/functional: ignore errors when caching
 assets, except for 404
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-32-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-32-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> We see periodic errors caching assets due to a combination of transient
> networking and server problems. With the previous patch to skip running
> a test when it has missing assets, we can now treat most cache download
> errors as non-fatal.
> 
> Only HTTP 404 is retained as fatal, since it is a strong indicator of
> a fully broken test rather than a transient error.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 39832b2587..f0730695f0 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -15,6 +15,7 @@
>   from time import sleep
>   from pathlib import Path
>   from shutil import copyfileobj
> +from urllib.error import HTTPError
>   
>   
>   # Instances of this class must be declared as class level variables
> @@ -170,7 +171,18 @@ def precache_test(test):
>           for name, asset in vars(test.__class__).items():
>               if name.startswith("ASSET_") and type(asset) == Asset:
>                   log.info("Attempting to cache '%s'" % asset)
> -                asset.fetch()
> +                try:
> +                    asset.fetch()
> +                except HTTPError as e:
> +                    # Treat 404 as fatal, since it is highly likely to
> +                    # indicate a broken test rather than a transient
> +                    # server or networking problem
> +                    if e.code == 404:
> +                        raise
> +
> +                    log.debug(f"HTTP error {e.code} from {asset.url} " +
> +                              "skipping asset precache")
> +
>           log.removeHandler(handler)
>   
>       def precache_suite(suite):

Reviewed-by: Thomas Huth <thuth@redhat.com>


