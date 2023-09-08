Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47404798846
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qec8g-00018r-HF; Fri, 08 Sep 2023 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qec8e-00017u-NH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qec8b-0005nU-K5
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il7ExwLuxMKzNqRBFpg2jRaUCBBeZ3jUQnsXJSF2i2s=;
 b=aZyu3MaiourN92YOFaf8p4s87CbA4RZ1UtdSSpLQqxa1/m6GdiDbyrHlKKTSQZHRHKnOGz
 7sP24ADDb4y3idm/faGuvQ8b8TjyB6nVgC+qLf/9e1SqBXNTkT0Bhk4Ytli/A42ZcgW/9s
 SQMCyv5LO0h6ms+KGKAFtbgicF2FOUM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-00UIMRSKPqeL3M6gIw8PKg-1; Fri, 08 Sep 2023 10:07:03 -0400
X-MC-Unique: 00UIMRSKPqeL3M6gIw8PKg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355cf318so145074166b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182022; x=1694786822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Il7ExwLuxMKzNqRBFpg2jRaUCBBeZ3jUQnsXJSF2i2s=;
 b=BSvAWjMrY3DHCLZ3UhDlSAzQFYsT2DJdHBgEf+ygZRxtHlWKBaT+Rf1LKyfbOUcFI3
 DzQ9f3ZATc84mcYLfjjUBCRpBtsQDb+hRPkVZxWNEa2TCzqQbO0Wf4Y++SboANg0S/7j
 tlIFjpuOvbn9GjJf06Bm+9/IzonB1xGoTARt0+faYGT2WIZ7eun3LM3Pr+yZdg9F3KFX
 0eL1Tfs0yoq8U/MB8qxjalac687sOloGaAkCJO9cxBlzHd3fcbMEX3xLeCUCZhYORXOL
 Uvrcj4xwIGtbFeaJXJlxNcBvrYnrqzX+IJs8bghvuMuXA425Dq0h/2MBeMHoodqLkFE4
 oixA==
X-Gm-Message-State: AOJu0YzTVJ0SH3PSXjgUeKK4VBwMVyxZcdx8aiolVEzQZiHHv9a7At1e
 vlbInwQ2Stc5vj2lgUYxSpk9lTPBHTSz+3/vhIkWPS8k0JpRriXWxZjc/zBbBDQQFm6s8/tiT4A
 bRvkpCCE26rO2Ugg=
X-Received: by 2002:a17:906:197:b0:9a5:7887:ef09 with SMTP id
 23-20020a170906019700b009a57887ef09mr2171359ejb.32.1694182022218; 
 Fri, 08 Sep 2023 07:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe6UFiOp5uCzbnFMCyNSG4IttrXQ6dJxYRxblYQsFiLpy1GOSUu5Po0QeYYoRAi3DEjb6NYw==
X-Received: by 2002:a17:906:197:b0:9a5:7887:ef09 with SMTP id
 23-20020a170906019700b009a57887ef09mr2171344ejb.32.1694182021955; 
 Fri, 08 Sep 2023 07:07:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 k14-20020a1709063e0e00b0098733a40bb7sm1077213eji.155.2023.09.08.07.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:07:00 -0700 (PDT)
Date: Fri, 8 Sep 2023 16:06:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 01/10] target/i386: Add missing feature names in
 FEAT_VMX_EPT_VPID_CAPS
Message-ID: <20230908160659.2b3abe04@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230908124534.25027-2-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-2-twiederh@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  8 Sep 2023 14:45:25 +0200
Tim Wiederhake <twiederh@redhat.com> wrote:

> Add the missing feature names for two bits in the FEAT_VMX_EPT_VPID_CAPS
> cpuid leaf. "vmx-ept-uc" is currently unused, but "vmx-ept-wb" is enabled
> for multiple cpu models.
> 
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 24ee67b42d..7c2c48ac06 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1314,8 +1314,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .feat_names = {
>              "vmx-ept-execonly", NULL, NULL, NULL,
>              NULL, NULL, "vmx-page-walk-4", "vmx-page-walk-5",
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "vmx-ept-uc", NULL, NULL, NULL,
> +            NULL, NULL, "vmx-ept-wb", NULL,
>              "vmx-ept-2mb", "vmx-ept-1gb", NULL, NULL,
>              "vmx-invept", "vmx-eptad", "vmx-ept-advanced-exitinfo", NULL,
>              NULL, "vmx-invept-single-context", "vmx-invept-all-context", NULL,


