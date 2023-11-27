Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 762697F9857
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:32:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7THf-0005T1-TN; Sun, 26 Nov 2023 23:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7THd-0005SO-SP
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7THc-0000IU-G2
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=InifMiSsi+kUPtxt3NcqsRI7HIJI+yVnXsQ3QEvVZiMAWzyyVU/5+ZrfeQlVxubPB4MgYa
 2FzTnCSzEZEmX6UPU+OwuIEM1yxrQrMPC/g+vN3zuCJ1E7uaxx9SHEHsFmnyiNVlTNtve6
 x7CRbIOHTHlGMenJPgvbCWYvgG13luM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-6ETrrNTIPt2M4C2lqD3YBg-1; Sun, 26 Nov 2023 23:31:42 -0500
X-MC-Unique: 6ETrrNTIPt2M4C2lqD3YBg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6cbb3512511so6462746b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059501; x=1701664301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=PYZr+pHjUu8YmioCLWETsBkgUdJFzapLElJp7nI43enxvjNZ3A+hbDYc5uJIB+6Obl
 gmPKr+Cl+i8Igy2sYf+tkreQBfiZOcNAc8JWisyv2bYkUk5MRGUObLGToDrL5xByvGZv
 uET8YpMyoHmtZm/zOrGCKExKqZ3bgWRdCahAQm8iIekziiPZBcxy7dFv1oJFZhPNzZYF
 g2x8URCf3a7ieZRXwSlcE15MnVbB6cJiMcSSdhryqqgKgRUjwkS4e6MLnUzMvWt1BQE1
 vAJthYK+h4FhIqTTsB9DRwB89k41yLmeFbLglEy9q5eJLW+ijT0yvgPbWO21wjnWB/FO
 6rHA==
X-Gm-Message-State: AOJu0YyztMvU/WTAyA8T9GuI9yfpEcWqyCEtqaZybgzFQEt5CN73ss9Q
 QaQAeluPTnnYA7i1Gj6A0LQ7KWI1jBD6OTDpmBUz5UFGXIx/kk36ible8CpLvzMP+9avJfQ0/0b
 +zJ1xXRcyy3D0oGY=
X-Received: by 2002:aa7:9d09:0:b0:6cd:879d:4c8d with SMTP id
 k9-20020aa79d09000000b006cd879d4c8dmr3649477pfp.7.1701059501070; 
 Sun, 26 Nov 2023 20:31:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP/kduMgGQx0geSS+EQOtj/glFAfN2kuXvmqOVWHVtVjUoV41+GRd8VEDjzPE7wQjFzkkmUQ==
X-Received: by 2002:aa7:9d09:0:b0:6cd:879d:4c8d with SMTP id
 k9-20020aa79d09000000b006cd879d4c8dmr3649467pfp.7.1701059500805; 
 Sun, 26 Nov 2023 20:31:40 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a62e70d000000b006cb8e394574sm6373833pfh.21.2023.11.26.20.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:31:40 -0800 (PST)
Message-ID: <97eadec9-7d10-4bd3-a8fc-cf160f733681@redhat.com>
Date: Mon, 27 Nov 2023 15:31:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 13/16] target/arm/kvm: Have
 kvm_arm_verify_ext_dabt_pending take a ARMCPU arg
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-14-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-14-philmd@linaro.org>
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
>   target/arm/kvm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


