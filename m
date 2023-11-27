Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB27F985F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:33:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TJD-0006Hx-8S; Sun, 26 Nov 2023 23:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TJB-0006EK-7r
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TJ9-0000NJ-4e
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHPnN7jOaxBckPN1TMsb7lbSpEfJL8WREqjjpAz2omM=;
 b=MCaUDmX58HU3cIzhxa5tcOmrcw9fLNs4VOEXt609aFavJgIjwgfXKZH8qKhPHMT+cCzQ4q
 sTPHmQa6cMnCjzRq6Bg7jkHbZJ8y09Iy5Z4w1RixmwufvUMqBnr03miuOvZUnnTqOvt5aB
 gAjmuOI7etI4t3etjQLuwY+UJwyt0po=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Km2-hoA-PamWiwGW0dA2Ew-1; Sun, 26 Nov 2023 23:33:17 -0500
X-MC-Unique: Km2-hoA-PamWiwGW0dA2Ew-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5cf4696e202so18542337b3.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059596; x=1701664396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHPnN7jOaxBckPN1TMsb7lbSpEfJL8WREqjjpAz2omM=;
 b=Z8mn8n95ST5a3Cg/4M1HDwSuXS24Fg9D2rNeoMKYU9aYR+WpsM/0faeg5g6AZMmUHT
 ZEcXsoGkmigF7d+STdGKN8GnTQ0cUrbJN/6G6n2SW+dlkIfgzTC/sSRQ+1plgczq9Fsc
 QNDk/PqMYIInQES3rVNMxNkI3ELxFjU91OZgiHiuwR4zzJAYkPrBO1UV++kaouZx77Sw
 x6ZnQUnpHOKubHv33rpndjp/NKdimKLtV4F3peYTHECR1eJ8b89VN54sV80/lC/4JKBs
 J//QuiE/sJCgfAjaRGrtDPxW0DW54DPL0rG6WcPvz4/hrSYx9ogUO1H8bpv/PXj7Z9zX
 JoKg==
X-Gm-Message-State: AOJu0Yxmei4vAy6heUbJw/xloDAudQCr7pPWHqkC75GL46bZ7C9QPSnh
 ys4GpxqCdaGZmLu6hzfy1rIiuAf8symcm73zI43cGKGkbHsiJbEUhK0ZniXM3iLfRTjA++Q7Cky
 92LSxUSRud2nQr4U=
X-Received: by 2002:a05:690c:886:b0:5cf:2d42:a61a with SMTP id
 cd6-20020a05690c088600b005cf2d42a61amr5226727ywb.29.1701059596676; 
 Sun, 26 Nov 2023 20:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExAiSMqRjB50PeEjSiH9Pkz4G359la5QiMaObaf5fX0Jc1yzEkfIjWDDVfzCTQ8714OJhDDA==
X-Received: by 2002:a05:690c:886:b0:5cf:2d42:a61a with SMTP id
 cd6-20020a05690c088600b005cf2d42a61amr5226712ywb.29.1701059596383; 
 Sun, 26 Nov 2023 20:33:16 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a62e70d000000b006cb8e394574sm6373833pfh.21.2023.11.26.20.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:33:16 -0800 (PST)
Message-ID: <6d71859f-e519-4afa-881a-f1db8ec8ca90@redhat.com>
Date: Mon, 27 Nov 2023 15:33:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 14/16] target/arm/kvm: Have
 kvm_arm_handle_dabt_nisv take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-15-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-15-philmd@linaro.org>
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

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


