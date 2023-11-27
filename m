Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB77F9825
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:08:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7SuT-0003dK-Fb; Sun, 26 Nov 2023 23:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7SuP-0003cY-Vm
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7SuM-0004f7-CA
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701058061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOi5ccQjIN+8+wBdKqclzhUw5sb2VuINIekNHHuIl1I=;
 b=dKnmJSXyes823TfATwR0WRtgmKZYtmNUrcr9xB0oLZzWV1xVZii1TLUbEmacP+OC4wFXYw
 2DxwQnDK9ebjgHHVvPkzV3AR8gKE/U8g58H6mRZjntEybiLycgq6mOZ4Hv4CIsqWz5tQ6C
 7mA9aJMHvBbYLXOQ4FNLPk0Ws2YIoj4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-J3Ws77ydPliPDrdbQDljKg-1; Sun, 26 Nov 2023 23:07:39 -0500
X-MC-Unique: J3Ws77ydPliPDrdbQDljKg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5b7fb057153so5075293a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701058053; x=1701662853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOi5ccQjIN+8+wBdKqclzhUw5sb2VuINIekNHHuIl1I=;
 b=F21fIDhwX9egAGTEvulQd7s7L59D9hym7azzTRZ258+gV0Vft5wf8bHhL11V9DxLkH
 cWde0qLErYHXMCAyiYnyQOOj0ysWcLiqC/Oqu5YPqxZi6MMUfpIgo2ex1VuppMWbRvje
 nNyH3rPLjASY5PhomA6maevF5UAijig9GPwlACWIIxSFbgKqHYCNkIaY7d540e+ZGDjX
 vlnYzVYzF9Ae4FMUKi1a74eBrvB6+7LGDzmhk35OzCQ5YoWFS3YeZgMEpUTRirnbc3sF
 LZPG5Ihk8TIHWjn/M9ulOHvqoPWYnP7zDXLsr7Uz9cycR1kJNUSv4i480P/5TqIIzdOZ
 9iSw==
X-Gm-Message-State: AOJu0Yxubw5VzOYRiuoBYSG0yROMrw5T/oJDVDPD+QileEbGTwMvTBdQ
 DNU7A/bsvJcZ7cfYQErXQH1ttyt0TaZ5/H0DbXdw5PMnmZqvn2V+PSVs9/wqP8kdsfIMBJR3jDL
 I+SPHtHX8UO+cokA=
X-Received: by 2002:a17:903:244a:b0:1cf:c5db:937b with SMTP id
 l10-20020a170903244a00b001cfc5db937bmr4165717pls.48.1701058053724; 
 Sun, 26 Nov 2023 20:07:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZK7Av/oWrQ1aHTNBng5X3UsNOGXA30E0ptW5ZlFWWcYgduTkddUD9Y/7/tYVmYpU3MYg/JQ==
X-Received: by 2002:a17:903:244a:b0:1cf:c5db:937b with SMTP id
 l10-20020a170903244a00b001cfc5db937bmr4165699pls.48.1701058053473; 
 Sun, 26 Nov 2023 20:07:33 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a170902728e00b001cfd2c76338sm489163pll.197.2023.11.26.20.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:07:33 -0800 (PST)
Message-ID: <215ac168-2717-499c-91b3-a2fb01e636f5@redhat.com>
Date: Mon, 27 Nov 2023 15:07:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/16] target/arm/kvm: Have kvm_arm_sve_set_vls
 take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-5-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-5-philmd@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>   target/arm/kvm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


