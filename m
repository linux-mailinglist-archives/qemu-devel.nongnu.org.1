Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0138A842FC
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 14:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qwA-0004gC-A0; Thu, 10 Apr 2025 08:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qvw-0004Qy-Pv
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qvq-0008Rq-Np
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744287775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=64k9fdmYre+hOjQmj9dgXTIIZxK397U8qhoPtl0OzIw=;
 b=gZeJq/u14NjzFNVqy2wKjddpxO2EkY2/9Q4S6LQm6mNnOsqY6Xm6y7kNzKFeZB+Bg/vjCK
 Rt/G2ey1AnPBJU199zCsAVssa+xS5rPEakRDoSMfR7wh+9K+zBZ2jJkuXvh/43/SigBSvW
 fl7qpWMDfpDScLRWAOD9mSlFtTC1Slc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-qX3FXSUfNPG-tGUyAhwBYA-1; Thu, 10 Apr 2025 08:22:53 -0400
X-MC-Unique: qX3FXSUfNPG-tGUyAhwBYA-1
X-Mimecast-MFC-AGG-ID: qX3FXSUfNPG-tGUyAhwBYA_1744287772
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac3df3f1193so64018866b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287772; x=1744892572;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=64k9fdmYre+hOjQmj9dgXTIIZxK397U8qhoPtl0OzIw=;
 b=uRwJVY4X1Vo6tm9vb7xd4pDphoC7l/98Z10R2dX25u32skn3gHfOp13crjUm5iCCsB
 HY0OUY4vkgIWlXP6pCTl1l1I4qJlRBEXlIlqIPSblLDVl7KDBOZl5Enwqxhq0AdFkMCt
 0jxxX67EvUJ4e5pr8jAUF3smLd3vCcXhmDu91vcu/ZHn2fr6Kk/wtXxZcjP9Man7pF1f
 XZfmGDyapbYacwXP9+1gceWAhrGDW55USJ4jYzSPnt7J/FyAhAmJcCRCYaxv8KCTWtQe
 m05O6tgZGsA16BID3c/Gc0NlHwlCaRQ++yS43afCs8kDqWcrir0m535OViFM2+St1R9y
 SGjg==
X-Gm-Message-State: AOJu0YyDHMQpeHz9iT5RGTcY0vpaf5q5zb6Pw/KY8/GezfEHCvzA423A
 ONMt7a1KY9+zhQ1Njh5AoxMjThWmhsOOQ2I5UKsvUzaURc4qHsdQCkuH4FA8A/Yel9zPdj7PvGV
 dBp0sPlL6fEnvdWH1Xsgs4vV2P5uSM0B/Htu4FSswMM4Yt8H+qLUJ
X-Gm-Gg: ASbGncvww7kNNd9mB4P2OHAeEdA8MZTJom3Ebmqet+u7EYW7AYIg0mbGdpC4K0mMWWk
 5jQ0Jms6bKmZ2WCkNsqJxmZ9xat7UfAgHndvxHagfgyO2uIdwLUtRLG3QK1Sw4+YWAAEe884Y6r
 a0/Iju6QNPHG3szlnso6jJ+gWVCq++japspHhhoVpNIyzmyvJVf1a4uKyaE3h30vYhbtsatA5VR
 AxLqmJ8Lv+ruAxlxMoiE+oTYiPv8jWiwPIpKJSK1x1zSw53eCtaJdcP7I82YVy5i5k8GVQkxJFN
 SXmY9K79CsWF5eQGmQ==
X-Received: by 2002:a17:907:3e9c:b0:aca:a1de:5e62 with SMTP id
 a640c23a62f3a-acac0353c84mr185634966b.42.1744287772400; 
 Thu, 10 Apr 2025 05:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTraD+Ad6m7UWMdw6mznVjV/+/4hHa//ikquclItey9gwF9oYMR1vHQTiIGEPAvXgSCmokew==
X-Received: by 2002:a17:907:3e9c:b0:aca:a1de:5e62 with SMTP id
 a640c23a62f3a-acac0353c84mr185633266b.42.1744287771942; 
 Thu, 10 Apr 2025 05:22:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.103.255])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-acaa1be91a3sm263638766b.44.2025.04.10.05.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 05:22:50 -0700 (PDT)
Message-ID: <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
Date: Thu, 10 Apr 2025 14:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, zhao1.liu@intel.com
Cc: qemu-devel@nongnu.org
References: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/7/25 04:07, Ewan Hai wrote:
> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> The correct value is 0x5b. This mistake occurred because the extended
> model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> model was used.
> 
> This patch corrects the model field.

Hi, please follow commit e0013791b9326945ccd09b5b602437beb322cab8 to 
define a new version of the CPU.

Paolo

> Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b64ceaaba..0dd9788a68 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5503,7 +5503,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>           .level = 0x1F,
>           .vendor = CPUID_VENDOR_ZHAOXIN1,
>           .family = 7,
> -        .model = 11,
> +        .model = 0x5b,
>           .stepping = 3,
>           /* missing: CPUID_HT, CPUID_TM, CPUID_PBE */
>           .features[FEAT_1_EDX] =


