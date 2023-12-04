Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA93802AA5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 04:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA03k-00059y-2v; Sun, 03 Dec 2023 22:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA03i-00059f-IK
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA03h-0003rD-1u
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701662147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I92/j60TSCBakqaPEVVxZt4pRYRkf7RLD6d2CKY7eKg=;
 b=THAycy8/0tqFWgOtZGV7eSEU1uVSU4z2l8yjncSZl/pZ3CKU1v7O2ZAM2a/aCa0BbxY2og
 uNa5mC7nxYAflfLEigGBgM/alX2lb4eHYqUzZ3r9bioCSyCLfJFzE1FAc5GVuRKK4ZgSFh
 jf7uh+VSZJA0jocKIU3UlJLoGxdThsI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-pfNfcHHJMjmhqMkwddSOZw-1; Sun, 03 Dec 2023 22:55:43 -0500
X-MC-Unique: pfNfcHHJMjmhqMkwddSOZw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6c7c69e4367so3999454b3a.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 19:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701662142; x=1702266942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I92/j60TSCBakqaPEVVxZt4pRYRkf7RLD6d2CKY7eKg=;
 b=clt2dKF+EF9cte9T39Gxe0MILdaVUaySHghZNgue6SWD5pZuI+6FIbIlwmd8xFSjLB
 nTKm5tKUbt2cXjSaITPBCizpu7fFHEVLtnfZ0YKthQs9WV57Yq4Gndv535CxSIf/egTp
 fuqTQobGu7Mez7uIR4bcq2onKjCJIIrKcoDnXY9AH+JMoablew/FgJuBKog35Sz+HOkd
 nOuyv2bLbIxVMr9Izk1ymPCMXu9PxPFdOsM4wrKfmlX3hdRQqwoXHUhgXbNaII3rhUSj
 1nb1QSDCs+/2Wx5v+mPf6bEbHwlxfi1KmD2TZPUQJTnV/dZjDhEqJMyem37nE7EaRs+b
 +k+g==
X-Gm-Message-State: AOJu0Yw1HMXDy84o1ML/yTh4pB4HZmkBCkHwxzvqdMSaQNi/m8MJgbN9
 FvNWuipfxDrPuI8CvN5z7ODUhXmNoF5TQMkQ34+uUoFiYYRz7dSvm7A0iDLBbeXcBHFdO3h7tWT
 40reXDowPbP2tX4A=
X-Received: by 2002:a05:6a20:8f17:b0:18b:480:a0f3 with SMTP id
 b23-20020a056a208f1700b0018b0480a0f3mr1532927pzk.4.1701662142746; 
 Sun, 03 Dec 2023 19:55:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhPF3oPRXbMnAtkDjUbXHkfL5W0i+4xqobScQM6+3X2VUXFr1vLfh6ARsSLBh3Wt2EQ7rX1g==
X-Received: by 2002:a05:6a20:8f17:b0:18b:480:a0f3 with SMTP id
 b23-20020a056a208f1700b0018b0480a0f3mr1532921pzk.4.1701662142460; 
 Sun, 03 Dec 2023 19:55:42 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a170902ea1000b001d0855ce7c8sm2105952plg.252.2023.12.03.19.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 19:55:42 -0800 (PST)
Message-ID: <fb66d460-b995-427e-b5f6-702ce651a06e@redhat.com>
Date: Mon, 4 Dec 2023 13:55:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 2/2] target/arm/kvm: Use generic
 kvm_supports_guest_debug()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20231201143201.40182-1-philmd@linaro.org>
 <20231201143201.40182-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231201143201.40182-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/2/23 00:32, Philippe Mathieu-Daudé wrote:
> Do not open-code the generic kvm_supports_guest_debug().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm64.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


