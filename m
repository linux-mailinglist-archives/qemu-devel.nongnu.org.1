Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD7AA029A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 08:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eAl-0006YG-0Z; Tue, 29 Apr 2025 02:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9eAX-0006TY-H2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9eAT-0005GC-6C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745907007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5xJPjrjF/KZShGOSmzTx2BjvUMZUBKe5Z9sEC4Qcg40=;
 b=gJlVi/K5U63LQfb7v5U49SXe+ZBFzWVSTNdhY/u8O+47ZLE29XhN7AAHsaIbrhyfDjB7BF
 x1N3i2ZqU1DWGMVTF3mZ9NbvzUFeyXH1YIwNfAz15bMLdgG02vWwxI2Ws6i4t0DFRLKbQf
 i7+iPwacveVNWeHZvjLKZvJnQGegbWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-yMbhq0UXMgqHOZxoCwFERQ-1; Tue, 29 Apr 2025 02:10:05 -0400
X-MC-Unique: yMbhq0UXMgqHOZxoCwFERQ-1
X-Mimecast-MFC-AGG-ID: yMbhq0UXMgqHOZxoCwFERQ_1745907004
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so39811045e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907004; x=1746511804;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xJPjrjF/KZShGOSmzTx2BjvUMZUBKe5Z9sEC4Qcg40=;
 b=vGXmMkgIQt61jwcjn4nEueP2KPZIt7ykqzvAyr6EeVaarskPUCeSGUT7aBjxt85rO8
 xI0OLPuUxOaaFdvAu4cEyOej9SWVOmsuiI9UYiPRND6RGiVHO1kdsenugkEwkMnL5xkh
 ICc8qUE2oMgU9e30ulFTZTREp+zC4glrusGYbrZoemPqEzWlqIyV7gmVqj5SBZDysk6F
 Y2MSpg9hmjkDMH640X73Lf+6qMWOZUZaRz2YR+Y4fNYUqpOVFBnSdhslBRKvbWrthtRN
 ZTZOxdsOTemsE6al+rZvpyngCMiaqx7P+kowSGo8Zd2hQzZJRqO9vtT4RFCng5TfFNWH
 n3LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKBmaBpeQdlfZ3iBZ2mMMIRcPNd162OF0CzW/7nRogKYUJ7RHQ8UnOUr/kgLKfw7YnlWXV8LVH4PSX@nongnu.org
X-Gm-Message-State: AOJu0Yw6tMSiLEumYvqc80AZn+92yi7vvX6AJD85Jfey7oUJUgtYtivf
 6QRvEll44KrWYP/zpRXkr8GH33BrfY7sp8p81IF2buhvyzb+ty5f2J3+M2v5Em/Qo+Y0OyWf4Ba
 mXoyu3Ye+WD/Cjjvv9H6rmZaeEAeNkMlINBERf1l+H2F+2jQ8uT1a
X-Gm-Gg: ASbGncuMVY2x33Tg0XoF7LfPkt5FJ0ms1n90B8pa943kN3gr2c3x5Ehfjx+665lRoNc
 TGMZv/Roij1aUzVsECLCionrfeyGl815kici2TiNahV9IYGsGAXsn3gEODxqfJhOr1dFJSMsUW5
 oNbEXNd7VEO6Bqy4EZXW0Gh83G8fwqCZe91fGVzJzgRWlcX6SaI6mk0Jox1uatBpOolzPxkqGfC
 GfgbK9V+g6MNe5GrasnPOwDzD7jICZk1AUbWKu5A+fL2ACc5vmI4olVZfaHLhZXaI8vqHTrp+eZ
 JJ0cgpfQ4N2gQTu6S6A97wF+kd+QneKqDlEFyOLyqKW94n8LPw==
X-Received: by 2002:a05:600c:3d05:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-441ad3b96e3mr10214315e9.14.1745907004209; 
 Mon, 28 Apr 2025 23:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzjxbVePNI/0L3sDmcjF8OcnwvtMHhqnOIYE7xylACnnTM2+KkMI2w9pUFYhcXHW8nXr47g==
X-Received: by 2002:a05:600c:3d05:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-441ad3b96e3mr10213945e9.14.1745907003718; 
 Mon, 28 Apr 2025 23:10:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac27dsm178512855e9.22.2025.04.28.23.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:10:03 -0700 (PDT)
Message-ID: <9efdd5d7-c552-451f-a32c-fae2bc6553ce@redhat.com>
Date: Tue, 29 Apr 2025 08:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] pc-bios: Add AST27x0 vBootrom
To: Jamin Lin <jamin_lin@aspeedtech.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Hao Wu <wuhaotsh@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Igor Mammedov <imammedo@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20250429015938.74359-1-jamin_lin@aspeedtech.com>
 <20250429015938.74359-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250429015938.74359-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

Hello Jamin,

On 4/29/25 03:59, Jamin Lin wrote:
> The boot ROM is a minimal implementation designed to load an AST27x0 boot image.
> Its source code is available at:
> https://github.com/google/vbootrom
> Commit id: d6e3386709b3e49322a94ffadc2aaab9944ab77b
> Build Information:
> ```
> Build Date : Apr 29 2025 01:23:18
> FW Version : git-d6e3386
> ```
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   MAINTAINERS                 |   1 +
>   pc-bios/README              |   6 ++++++
>   pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15552 bytes
>   pc-bios/meson.build         |   1 +
>   4 files changed, 8 insertions(+)
>   create mode 100644 pc-bios/ast27x0_bootrom.bin

[ ... ]
  
> index 34d6616c32..83998f6071 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -84,6 +84,7 @@ blobs = [
>     'npcm8xx_bootrom.bin',
>     'vof.bin',
>     'vof-nvram.bin',
> +  'ast27x0_bootrom.bin',

I think this list should be kept in alphabetic order. Could you resend
please ?

Thanks,

C.




>   ]
>   
>   dtc = find_program('dtc', required: false)


