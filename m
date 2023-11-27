Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E97F9853
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:30:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TFL-0004V3-D3; Sun, 26 Nov 2023 23:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TFI-0004UL-TO
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TFH-0008Hp-HF
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTJbdB49WbhT9nfFscdktMnYs7K7t3F10x3+Dyunhh4=;
 b=X7fg8L/DwOC3+BFElPLADfvYIn5nW4dD4AbqsOisFJBpKbsKu5fVZMu0/UNTv1CRqJbGBa
 VIuOXcK0fVXKxhlDXYahE6j8ikRf5gb3Aa1H3JN10GQrwkNhCpSiBsmgOpJAWGxETNOdzl
 783Z7cpQeKWsuZRiHZsMVfZgopxzgNQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-u8sN85TPOPe6XAQOjJ73rg-1; Sun, 26 Nov 2023 23:29:14 -0500
X-MC-Unique: u8sN85TPOPe6XAQOjJ73rg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cf9a581e0fso30643605ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059352; x=1701664152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTJbdB49WbhT9nfFscdktMnYs7K7t3F10x3+Dyunhh4=;
 b=LCefPoSs93JDvjGtQcqhUnpO2rD5lbVGWUMR5nepKP2NKNCXvDlr1k2WXGzsDHQM78
 dUKsWzst1U4lLoAru/B6N3jPsbCK/LKn4CAUYdTA73LqHgVkSzNJJ7LLodKfx8+IX0WN
 WdpI7H0S44pq/Jvqb/cDv77pye98NJvcNVpHeMGuYdKScrJur2RN4/wdyroLPMBIJCCu
 C0Fdg8UrmRJhSVvzEkR1BwcLJ2SiFtiCtnhXixyoAyv8iHE6ZIE9RjwrRoSL2HxytEuU
 /zrYKFx8gRsbw/U2G49+Tfjp/LxY01Zy07biEBVJXUA1F7A4IkA1BR7zHkiPz3+4xwyS
 V8lA==
X-Gm-Message-State: AOJu0YyT4SF6GYN7WlC1e+hv5fP8XtDtSUQehjXfZlC/Jj3t9LAD3Q7z
 uW6MlT/ytx7lGjAlBAOaVfO62UKgOCJ3L52X3RXqvRgMr1UyJJdj/d1x/0hiTIFCFU07vgKiMA4
 /Nkm63PqqNxiOhxM=
X-Received: by 2002:a17:903:1103:b0:1cf:6e3d:d8e7 with SMTP id
 n3-20020a170903110300b001cf6e3dd8e7mr10024128plh.26.1701059352690; 
 Sun, 26 Nov 2023 20:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERZHHf3LS1imT3NzFS6So6tgu6CEywhSiCJc5JsehQXTfkdDQsDnilQIZZdU3hKcUBHkXwAQ==
X-Received: by 2002:a17:903:1103:b0:1cf:6e3d:d8e7 with SMTP id
 n3-20020a170903110300b001cf6e3dd8e7mr10024114plh.26.1701059352408; 
 Sun, 26 Nov 2023 20:29:12 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170902ea9100b001c5fd2a28d3sm7196296plb.28.2023.11.26.20.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:29:12 -0800 (PST)
Message-ID: <68fd2489-4eda-4cc5-abb9-923511475e37@redhat.com>
Date: Mon, 27 Nov 2023 15:29:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 12/16] target/arm/kvm: Have
 kvm_arm_[get|put]_virtual_time take ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-13-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
>   target/arm/kvm.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


