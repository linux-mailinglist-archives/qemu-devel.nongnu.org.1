Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6DA56FC0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 18:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqbuu-0007Pn-Kp; Fri, 07 Mar 2025 12:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqbuZ-0007NU-7N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqbuX-0006X7-Ba
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741370100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u9/BlCpLgNgHh+dyWo0KE4R2kh8rn7VKaFiVaVgC+kI=;
 b=Z6qPsEZilgGK5OLnf5A6VN3w02jvFyFDcJnDL/CFA36Ec1PkHggT5opZDybYJEXZWS3G8Y
 rffCmHHUT774CChNtLHblOPQWSAoJDh9J4/YhoYKcTHc6IZrY8Wry7QaLi4CT0aX1iMZpA
 FluhdwhvGSTG88zIFb0/MqmsUB/qWLc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ucHkX5aCOqiaEFPU_yMIcw-1; Fri, 07 Mar 2025 12:54:58 -0500
X-MC-Unique: ucHkX5aCOqiaEFPU_yMIcw-1
X-Mimecast-MFC-AGG-ID: ucHkX5aCOqiaEFPU_yMIcw_1741370098
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso19156065e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 09:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370097; x=1741974897;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u9/BlCpLgNgHh+dyWo0KE4R2kh8rn7VKaFiVaVgC+kI=;
 b=o5Wq87ZeeYCLLXdPJKj/aBhrjRGEtOZwL+cWQ4we+TzF4GJp/MS1sfpk2ElObSbQNI
 GnmO//aIm0RZHPu7tR1lDS1BwkqvuaB27dcr5kNYSa6o6vqvS3cTtplzIirMXQ56L+YK
 bN10ivws1P10HKog0JHkRARbfkqAbyMuvR70f069Msz/hsaST+PPJ/EF3R4bPPE4CU5Z
 mTCFs8wcwt7DDvqKPKrirBjyh9HWCxcWxCuNzIGqLB6AAMq5yk6UJRTI/21bWJVYKWB1
 iPMSTevuY4TBGabd9u5Xga3802Y3qdQBX29+IBPFX3Aw6kD8neYNkFU9vLZ9HJLd5+fi
 Qevg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2PR4Be54DE1w/XR9xsyjiJ3jH+cA1LrRrmvyO5jU3ru2djE6qeCcKH6gpkRu2oA5+qo71LtwDhmD@nongnu.org
X-Gm-Message-State: AOJu0Yy81iHL9DPfgQ6pMr5RBTD1SwfkThqF+2sr5zyCquDhuz7sIgGb
 cq29hYxPz6iyeEbpxDbc/voTJQpb1FT1EIJ9R0CH45tXu7sWGSpGenbzvgWhvuxmhatw6YHHj7F
 JhNiT8LNFj+GyUEn50xMmoOSJCchQKyHigmEfymaxAzrpWVkbYK+e
X-Gm-Gg: ASbGnctbbEQ+C+UKMkU1r35xzZ7Nnr/sBlYN44+JA2gR4vmyFmg0rftrH4UjM28NQbM
 5enciu6khGVFFCXyYNW56T4SqZWs7wJEhIkbtyUbkdY3lAvTgcGHHe9pxJBy8JYHMYTUOQERMoR
 B8+alyjufQmQcbK1WDgK/XR7QgUQb9AUXxNIMBE1CDWsQGCdbU/wd2f4v20GQxTr5y876XROTc+
 7BKaAVAzCjdYTro3albr+S9JGHrLImElRonUzGrJQSIc7Qy9gTFro+hPRl70xmQHQ69mIlQL3vM
 gc/LqjfCxlbWbsAEc0QL+N4bna+URd8eEh6azjFmWsA=
X-Received: by 2002:a05:6000:1842:b0:390:e1e0:1300 with SMTP id
 ffacd0b85a97d-39132d74df0mr4445956f8f.33.1741370097664; 
 Fri, 07 Mar 2025 09:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF17H7ciLyMfoO9fNDT51PkV69I3dAW6OKLCmV6MlJ8rOW5ipYniu17cKA9ZUFXhn1nYqc8vw==
X-Received: by 2002:a05:6000:1842:b0:390:e1e0:1300 with SMTP id
 ffacd0b85a97d-39132d74df0mr4445943f8f.33.1741370097278; 
 Fri, 07 Mar 2025 09:54:57 -0800 (PST)
Received: from [192.168.3.141] (p5b0c614a.dip0.t-ipconnect.de. [91.12.97.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e308dsm6138717f8f.67.2025.03.07.09.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 09:54:56 -0800 (PST)
Message-ID: <defa9d71-1d5f-432d-965d-e15cccf5937b@redhat.com>
Date: Fri, 7 Mar 2025 18:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-7-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250307151543.8156-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 07.03.25 16:15, Philippe Mathieu-Daudé wrote:
> Use qemu_arch_available() to check at runtime if a target
> architecture is built in.
> Register virtio_mem_legacy_guests_properties[] at runtime.
> Code churn in virtio_mem_device_realize() is due to re-indentation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


