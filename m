Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F308E7F9829
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:14:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7T0b-0006cj-Pg; Sun, 26 Nov 2023 23:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T0Z-0006bS-DO
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T0X-0005rw-UA
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701058444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55HuZwlTrXr491X1QtFyKDqXPxkmAiZuFkdy/eIPI8k=;
 b=euavnfzyjy4U0sLrND2qcYUPXW9oljr+oX/2ogP+MsBhapaam/6VFo/1OrH5QsGblXL4x1
 MoIYto8jI09XgCkR4FCVOtzj3HV/4Nh4Koe67Qtrrhv0uTz45iLhRCOy8hxJmSdrF0xY9Z
 e48+1lD//YAhtslgdC2Td6OmMRFZrEc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-j0kxJbUPOc2nA0iVXJnE0Q-1; Sun, 26 Nov 2023 23:14:03 -0500
X-MC-Unique: j0kxJbUPOc2nA0iVXJnE0Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2856c8a8efaso3856816a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701058442; x=1701663242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=55HuZwlTrXr491X1QtFyKDqXPxkmAiZuFkdy/eIPI8k=;
 b=E0X8LfF9LOtphxHaXiz+8T9Dh9yubzpVmFeraFMjSuQy1J/JciHVKR43cXvHZVx7ve
 Hq9eb07u4xJecjHVSC/uR+bUGKUI0+6/pCfOKIVLUxVmyWjZWCibYFGD4L0YAZlSR2Re
 +9q5+gOkKFrjdRi/7mS0RP65s5p8g1XCMwqItMKmeFCaNqq3HpgfOkM2q5dlGRgVUX0D
 RLEBhpOQwww0t9vZ/0kZ9AeQOeIDsaTxb0iwyVX8XATztifny/xbqhF1sUTq8AxaWKfU
 BHHx9MHDvt2RG18X0C8ngpbaaVzJ6vbCY4I36dQrtb5nxmdMvqKmtuDwPqdIl4zNQbBy
 tKiA==
X-Gm-Message-State: AOJu0YxvVDyNED3otbpGDfYoYvqpY/RMjnILvHaE9elfJyEXlR9+HNGE
 urxG0NlM753tbLApXi5W07ipVhBiNdlkvvbpPxenTZ6+xKx/stvPcrZdJNVgnsNZsSEUMjPIFce
 2qPF5fDyv5Rh+UeY=
X-Received: by 2002:a17:90b:1e44:b0:285:b019:1505 with SMTP id
 pi4-20020a17090b1e4400b00285b0191505mr4170792pjb.45.1701058441977; 
 Sun, 26 Nov 2023 20:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZiNVDO0nxQJhb5s0jNV0CQb908dp3CHGjr/kwhWr8MLb4KG6gc60KOmx6iC8oEo5/7MYHEw==
X-Received: by 2002:a17:90b:1e44:b0:285:b019:1505 with SMTP id
 pi4-20020a17090b1e4400b00285b0191505mr4170781pjb.45.1701058441675; 
 Sun, 26 Nov 2023 20:14:01 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 102-20020a17090a09ef00b002800e0b4852sm7521850pjo.22.2023.11.26.20.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:14:01 -0800 (PST)
Message-ID: <886ab4a1-02be-4345-8881-0f29f23283c7@redhat.com>
Date: Mon, 27 Nov 2023 15:13:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 06/16] target/arm/kvm: Have
 kvm_arm_set_device_attr take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-7-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-7-philmd@linaro.org>
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
>   target/arm/kvm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


