Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BA9DEFE1
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Nov 2024 11:11:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKR8-0004px-0M; Sat, 30 Nov 2024 05:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKR5-0004ka-H0
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKR4-0005At-14
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732961444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UHvMVNKuO1I6o+jsYRslu5zN0lH+mnI15aDAegWUFtM=;
 b=fCSYm8b27q6Rcb6xYl9J87Iun4tR9hiESKiCQhy395j8uOC+rTvdYamgaPtdOlaQNHDWuo
 OcoDjf7r52QpFDAwtnvvbXr+kEG9/gm0GcKikEydyend59r8hym5ZUA3DXTqio/4ukgrdR
 o6XM9CtsK/BBedJyLrj5Wlbu/MPrifE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-izTrMWTDNjqGBTiM28gXJg-1; Sat, 30 Nov 2024 05:10:42 -0500
X-MC-Unique: izTrMWTDNjqGBTiM28gXJg-1
X-Mimecast-MFC-AGG-ID: izTrMWTDNjqGBTiM28gXJg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa53f3b3256so142437266b.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 02:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732961441; x=1733566241;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHvMVNKuO1I6o+jsYRslu5zN0lH+mnI15aDAegWUFtM=;
 b=h2VOO8D1gDFSc9rJUriivxwblvpuuU0G1TBJkOdLcJOAAo51+BAjzYPfk8dN48mWpL
 7Yv7XkI0s8bkjMhEBV2sTr3YaqrIp9tMLNinETCVbewLr7xJEXmVOSqQlOHay99zY+Q7
 NsG6+dR8GNFO93AFyJHYOsKv9AUzd6/hzCZXEQgen2ivApNInscT4o+HvJHLhBGWx40o
 rWqeUrtP2f5V8SetYMSGoZI0wgQo89ebo+URvxDbl4/LwaiO299kMx2LexT7YiRlgrNd
 V7IdEIgo7EG5KVGdjtQvTJ8C4yaW3h0gO/imTlLtTswIJNI8g6GRueZizJXZ+hQFKhEO
 PBTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtyjP/OQGhVv6jpqZJ6ZFkr2recJ1Yuh/TKHdFA//rjhegkNiUsgyxPEFV7QWEY0TMLU9HDlvHIi0i@nongnu.org
X-Gm-Message-State: AOJu0YzX/fAt8ANbJhV/YZoxwneWQS6b7RjZtTBlDgRa4yLCXP20f6CD
 jtBSfvvFx8UGsyDzA7lfkewR2alKE1PLwNeL1N0WtHBQk9hAaFfWWgC2acrOH7EGboSN+a9I1IT
 mVOIgExQ4gDI558UW54tFmjf35W7ubD2W2UUVAAnoTaVxSSF7JN/gIMFnIeCN
X-Gm-Gg: ASbGnctnnyTLljWNFXX6BdzpitimBTL7bUHNnE2G5KKP5DuLEdZ5j8fz5+IzbDTJEFq
 58GzAi/6I/zI27QfXbNyZRr1NuvyFxdTbKcVXBn074O0uNp9AixDQ+F7jVXo44xUk7QW3EoB+JH
 xUEcqQ7nt7MI2wQuDhvO0stAEMWeT57H7HP6yOStUJ5zguvEzwbPHIUi32Nlf27G82T09+5G3UB
 nNjfag7Dsng+M2fNZDVYqVgmOJAvijxWYIUUxmoG4Q2gjpF028coFny25aTtw1UPKqOtohWcDjq
 42cdLQ==
X-Received: by 2002:a17:907:77c9:b0:aa5:2a75:7218 with SMTP id
 a640c23a62f3a-aa580f170edmr1240812166b.14.1732961441395; 
 Sat, 30 Nov 2024 02:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0wVNNLNCMidJ1LHpEopAjHSzFo4NjINF1zyiY/4CsSTzJD3VxZsZ18ueLFNBJSJqbD757Tg==
X-Received: by 2002:a17:907:77c9:b0:aa5:2a75:7218 with SMTP id
 a640c23a62f3a-aa580f170edmr1240808566b.14.1732961440956; 
 Sat, 30 Nov 2024 02:10:40 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996dca00sm266331366b.52.2024.11.30.02.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 02:10:40 -0800 (PST)
Message-ID: <eba18b77-affd-497b-89f2-4abb85cd83fc@redhat.com>
Date: Sat, 30 Nov 2024 11:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] tests/functional: remove pointless with statement
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-5-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> The xorriso command directly writes to 'filename', so the surrounding
> 'with' statement is pointless.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_ppc64_hv.py | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
> index c31432d18d..53bae90401 100755
> --- a/tests/functional/test_ppc64_hv.py
> +++ b/tests/functional/test_ppc64_hv.py
> @@ -72,10 +72,9 @@ def extract_from_iso(self, iso, path):
>           cwd = os.getcwd()
>           os.chdir(self.workdir)
>   
> -        with open(filename, "w") as outfile:
> -            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
> -            subprocess.run(cmd.split(),
> -                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
> +        cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
> +        subprocess.run(cmd.split(),
> +                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
>   
>           os.chmod(filename, 0o600)
>           os.chdir(cwd)

Reviewed-by: Thomas Huth <thuth@redhat.com>


