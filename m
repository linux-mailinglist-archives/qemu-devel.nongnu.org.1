Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C77F984D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:28:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TDs-0003m9-6g; Sun, 26 Nov 2023 23:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TDq-0003lt-OL
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TDp-00087b-Dj
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzPDIBNHl9MOltvsq0mdaA199GFM+p4KPfAkED3jE+o=;
 b=BxY9b3s5PWNLthscGOpW3SKRGWj32qNEJ2Ja14KsM1Dkze+OjSEGXtOswErwcarLB6VaMN
 Iz/UL5seoJPbNUySWlZB3MZ9JkHOBewhuNyJKM0gtEfKmbnMf59wFIgRdFJemxGWHfgHDQ
 hXr4jS/C9Eg9PAEKgkDELKt/upmeK3o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-82VkoJ8ANpC2Hpj53cnM3A-1; Sun, 26 Nov 2023 23:25:53 -0500
X-MC-Unique: 82VkoJ8ANpC2Hpj53cnM3A-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6cd9433dab0so204843b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059152; x=1701663952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzPDIBNHl9MOltvsq0mdaA199GFM+p4KPfAkED3jE+o=;
 b=F1vYvHTm4W+dVy2Brz+E9tggteT/kOvoL1cLSmyCAO5mF+y2ulcqSrHIqUN0IMExgk
 paU4ng50yzX9iLZ0Oa+BdJkR9S/ZiOLZ0VrmoezvHmEo4JgfKT+s7qahkMAPz+SDQXum
 0v/NKAnWPRRLyO9WPsCd6CIvOHEYVP6v8eQjP5q6eZ/8vkpBONUzP5Fxqcpa/ojGLc+y
 T/ObnkRPcCZf6K5PFONv0aZxOqsC1eXWduLNayXszAfHY1L9MocyzseDe27wHSBcbmx9
 KpeGbaFQidHR0Az4OSfjgcNL8kIzwFbxKCt6RXi3q/G6RaB8R8TzSKsGF0GUhA9xClKH
 D6mQ==
X-Gm-Message-State: AOJu0Yzzku1HyfBVtHRDCoA0X6MkJfw7xU8lbVDRjw0eInW/fiwXwGu+
 OAVH+9G7ontE0Ybbfru3WVUHWbptNRCSoAV1yHKySON67DOOnnQcA8m4rULqmFxfiQq0OENlJG2
 jd7FHJLRGv6B8fM8=
X-Received: by 2002:a05:6a00:1954:b0:6cb:a1a7:ebcb with SMTP id
 s20-20020a056a00195400b006cba1a7ebcbmr12097185pfk.24.1701059152470; 
 Sun, 26 Nov 2023 20:25:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7TqBPaWtSSs4ZG1kEaauKKpfqg5/Oebaw7t4bdNhyTq4NWkMHt64BocUMBw9TSsYImE2nsQ==
X-Received: by 2002:a05:6a00:1954:b0:6cb:a1a7:ebcb with SMTP id
 s20-20020a056a00195400b006cba1a7ebcbmr12097178pfk.24.1701059152198; 
 Sun, 26 Nov 2023 20:25:52 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 m22-20020aa78a16000000b00692cb1224casm6337813pfa.183.2023.11.26.20.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:25:51 -0800 (PST)
Message-ID: <e9b5be52-fd68-4152-b7c0-b75772dfded8@redhat.com>
Date: Mon, 27 Nov 2023 15:25:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 10/16] target/arm/kvm: Have kvm_arm_vcpu_init take
 a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-11-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>

Reviewed-by: Gavin Shan <gshan@redhat.com>


