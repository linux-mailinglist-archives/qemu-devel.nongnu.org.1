Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4215A5D66F
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Mar 2025 07:41:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsFlm-0004ib-SS; Wed, 12 Mar 2025 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFlb-0004cS-DY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFlZ-00087T-Mc
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741761632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T0ChVhAUVbQJ6B4OXCdonqcFdzysGDhjpO5W68Gr4zA=;
 b=ZeN8DAXaPNAsgRq3iDB53TX35Ah7HNG7HNAtRqrNyNCaGTEUpZQR67xn2shlZD7T1l+Jb0
 cIBeTQZNG6IjB6n38LHg9gwb66ko2KG7qoHR8ykzQOUEfaQtUjT8nP7bNzgdshHNOg+dUQ
 lj6NgP7GJr6sqSU4SuRyf3TEhYTTNW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-PMsx9XNuPBWTohts81kgfw-1; Wed, 12 Mar 2025 02:40:29 -0400
X-MC-Unique: PMsx9XNuPBWTohts81kgfw-1
X-Mimecast-MFC-AGG-ID: PMsx9XNuPBWTohts81kgfw_1741761628
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so2694678f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741761628; x=1742366428;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0ChVhAUVbQJ6B4OXCdonqcFdzysGDhjpO5W68Gr4zA=;
 b=i3RAANRbe8xh4byKPvgyviRg1OuG4d5NOw2bRYuhyo6agcZrTsMGP7B81i/UvJI/rs
 vXiVB3XpwhC1famI5B+1Hg8mp8nT1qjBeOUfsSjhs5O4IY6uPAg8V62WdfvgtZZwZcdu
 U0mHr0qucU6Lit9+i2Yik8IL2egs+hLu/qRqYKPRqqKqIP6z9AR2wMrnpfoezh7B5U2U
 FBSDEs5k6nffjWHNgKpuW+bAstqyLnV6Z31gueyNsYAxglD/JiNanuR/rMY/5p28GFde
 UUADHxivfIbFJPXcz6crT4NlkULbIptcRhCdbS6cJ1Czr/jXmoC1Pb7NEAkFeco6LrHC
 Sf0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgLvSXEeNfbNT6PGesTqPhVwCtviufJQRbmkvS7GpbdaUAgMTHl+a4IdujFJ33h02Se7pzgRY8DKxt@nongnu.org
X-Gm-Message-State: AOJu0YzpkDb81UiEUslht1D57WGppGiX8AV8jjFIo+fuTaJaDxAFsiMq
 3KgGv9mGrPaJZDHtQ0JTgX/b0IpUI+79QnnYZzuZ+KSnjGFcDmYbhpBOCMvCE2UqlxW+rNRFrlj
 l/wLYp/xnB+lqtFVdpso1DRN/yQ9gMnKClme6VPyV6H2BQtUxOM+i
X-Gm-Gg: ASbGncv51IcRBGoY5DUkLOkvzFp3ZW5ldvkABOceM2wPy4G04FY6nk8WaCNcbVZCBW4
 lGV63IAeiTcpdTptW/rIaUIeSvefB8seLtSJXET5+toVetDC47ru7WplStXGm6tGWZru+VWOV6R
 vbQCAgVKEA7q+kQCs8MclmCGlP3A8pB/WSHSLEHXOPp/mCu9dDpNA8J/l+9xqUtZgWM0901rtvn
 HXtrdb7l5OTexFzsLWNo42j+WZsJj09vvQV5h4Zs7LR/E43g9I7NhsAUqRkHiGZ0zddVBjQBnas
 5l6temmJSDFFlCeAwoJonkRhAx/TLD6f+YFCpbHTJMAQMww=
X-Received: by 2002:a05:6000:4105:b0:391:41c9:7a8d with SMTP id
 ffacd0b85a97d-39141c97c1bmr10201147f8f.54.1741761628466; 
 Tue, 11 Mar 2025 23:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMJYeeRpwMtqzzm3PXpcKddyvBR6ZaMaEgKsETAvhlE9ua6DEYyFaZ50MhziwodL91wY+cPw==
X-Received: by 2002:a05:6000:4105:b0:391:41c9:7a8d with SMTP id
 ffacd0b85a97d-39141c97c1bmr10201137f8f.54.1741761628168; 
 Tue, 11 Mar 2025 23:40:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103035sm19774224f8f.88.2025.03.11.23.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:40:27 -0700 (PDT)
Message-ID: <395ee50d-3e3f-4ef5-8026-6f06ce4172dc@redhat.com>
Date: Wed, 12 Mar 2025 07:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/functional/asset: Fail assert fetch when
 retries are exceeded
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250312051739.938441-1-npiggin@gmail.com>
 <20250312051739.938441-2-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250312051739.938441-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/03/2025 06.17, Nicholas Piggin wrote:
> Currently the fetch code does not fail gracefully when retry limit is
> exceeded, it just falls through the loop with no file, which ends up
> hitting other errors.
> 
> In preparation for adding more cases where a download gets retried,
> add an explicit check for retry limit exceeded.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/functional/qemu_test/asset.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f0730695f09..6a1c92ffbef 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -116,7 +116,10 @@ def fetch(self):
>           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>           tmp_cache_file = self.cache_file.with_suffix(".download")
>   
> -        for retries in range(3):
> +        for retries in range(4):
> +            if retries == 3:
> +                raise Exception("Retries exceeded downloading %s", self.url)
> +
>               try:
>                   with tmp_cache_file.open("xb") as dst:
>                       with urllib.request.urlopen(self.url) as resp:

Reviewed-by: Thomas Huth <thuth@redhat.com>


