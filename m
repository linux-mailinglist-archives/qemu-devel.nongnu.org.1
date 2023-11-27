Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21B7F9865
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TK7-0007J2-Db; Sun, 26 Nov 2023 23:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TK5-0007IF-Mw
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:34:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TK4-0000R0-AE
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=dlvQOul+u0OErR4MRBBe9glyKYax7R3azoT47gZZ11WcoQ6ZhlYqUn8ip1cDzauXADN6/9
 hf9D34hAjYlK28BIBf+LsLYBhL81o+hozDxh71e11Qv96n2yZYdAt0Nalgo5ov8M45HWp5
 GBvVazfOMf4cCFmfxzIO9pUj0M5sbjA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-tsNt5Gb5P4mC-DgaaFtYZw-1; Sun, 26 Nov 2023 23:34:14 -0500
X-MC-Unique: tsNt5Gb5P4mC-DgaaFtYZw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6cb42be51easo4922707b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059653; x=1701664453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZZnkvSfitGisLGL04wWrdlz4T2wKJDLQwGw8KJBvFg=;
 b=RJX2w/yhti46zsz3+lrEmA5A3n6632+dXac2LIIIBjuYkvqGoVSdmOQMz7F1iiYrbL
 7bQMsMLyhkull6yJZcmA/K9AAMhMnknYEd9tRpTxfxJ4Gk/HFeO15MyBl3h3T2Lsp9g/
 O8IlC1RT8bEyTkfYSMiYajur7O0KGtnMgn7h/C0BW3lTguOYetQ8f96j5ivY2xGPOgL5
 HFQRDr41mORNk0fI4uvPjkly7Je2/htVTS2OFxeASAvuzEZoccropzYij3+ExkCYbIhT
 nFBY6Vp5uyl0rl1NuRLRPL2srY3jfLYbr4Hi09AZRC+NT/r+lTfsmnniVuXGZ22gbPYV
 V9qw==
X-Gm-Message-State: AOJu0YzPNl+wNzTssSXfIgtVrcSDb/6B8v8bUdmZgfOALlObIrhdvuS5
 ZZyK4d1HXUtbcahYLdZcBj0fKPAurZUgfIaR1T5n6FQ+Yi8Kxxazt/k+/+YjoJxqSsM6Plcf0NV
 vzxl2uHKNnzXJCME=
X-Received: by 2002:a05:6a00:878c:b0:6cb:cc23:f69f with SMTP id
 hk12-20020a056a00878c00b006cbcc23f69fmr17422042pfb.16.1701059653293; 
 Sun, 26 Nov 2023 20:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn7hdZ+E/aE4weq7s17063RnDCjmmeEWWEbUc0N4T9l5T1MSfytJamK+Z5sEh1GeJyMMfu6g==
X-Received: by 2002:a05:6a00:878c:b0:6cb:cc23:f69f with SMTP id
 hk12-20020a056a00878c00b006cbcc23f69fmr17422028pfb.16.1701059653030; 
 Sun, 26 Nov 2023 20:34:13 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a62e70d000000b006cb8e394574sm6373833pfh.21.2023.11.26.20.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:34:12 -0800 (PST)
Message-ID: <85197b61-e668-4c4b-adcf-d81e183b45b9@redhat.com>
Date: Mon, 27 Nov 2023 15:34:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 15/16] target/arm/kvm: Have kvm_arm_handle_debug
 take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-16-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-16-philmd@linaro.org>
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
>   target/arm/kvm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


