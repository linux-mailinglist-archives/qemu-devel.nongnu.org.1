Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCF70E4DC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Wy1-0003fB-8f; Tue, 23 May 2023 14:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Wxy-0003eJ-CB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Wxw-0007E1-TE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684867356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbkO4TkUp342IBhxzdgblyltTwBSWWdRylYTlmsbJxc=;
 b=RikQiyBpHLTqnT/dLopshYZMixbXViAYo5T9N8wmZkSV6KphB+mJSQHl/7NM64R3NzJEAr
 rb2I9brHJ4BsyJwZkR9ePaMnjbZbdbUz6QrmuV5FrBF0dvvRDoa1Oud4opOwp25DsPkcSH
 wvPZJWjR1DYIKvZY3ATMz+iw2GqY9UI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-1kIQByg_Na21M8u_aJpbIA-1; Tue, 23 May 2023 14:42:34 -0400
X-MC-Unique: 1kIQByg_Na21M8u_aJpbIA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f611d31577so437625e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684867353; x=1687459353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BbkO4TkUp342IBhxzdgblyltTwBSWWdRylYTlmsbJxc=;
 b=AzTqTk0Pq/ota7t4byTjyb6lkGC9s8zawKYe4mpxO4cUge/518VYmvHj9pVAmDMua1
 0rh9dVJYX9/L+fHlV4W2A1hvxCQTl6P6Ak43RikrYg1coPXeEZ2o8SpQkCsISVsLrlnn
 J1vOEU1QPstjQj/UgW7kITfCZIElH/HhOMk5L3OVsG8bnWeojdKMLFHcDDM5NILy7suT
 zbm+5Syw4QEYvTEELsj+CF5ugS61UdPTOB9XQMj5YgWU/fixx74On3iry0awzRQ8QRzM
 m/LuWe8WAQcIS3pDKMLl0o05xIvrHVDQlDWEzdVXeHTvWI9BPUK4WP4PqAs4zD89y43e
 Z9GQ==
X-Gm-Message-State: AC+VfDyA/uQDy/ITgcp/rKFDSZU53lrMrKp7An7kpOlFrlKR0AJrPY29
 rCRc8Jn0G570gsth1wooCYfPFUr2HpdqA2MtvbJQJ9mbjlFUdplSm+dWIULFjJWKEzrnmpbM9HL
 tiAOGjg+NiJm05Mc=
X-Received: by 2002:a5d:518f:0:b0:30a:900b:6bf4 with SMTP id
 k15-20020a5d518f000000b0030a900b6bf4mr5182870wrv.0.1684867353254; 
 Tue, 23 May 2023 11:42:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cMHLHq+CdGZ9YvmY5PtjWsb9itwLs+bOcghC0QIF+kINj71pAEgAs3E2FRUQheoda5eOJgg==
X-Received: by 2002:a5d:518f:0:b0:30a:900b:6bf4 with SMTP id
 k15-20020a5d518f000000b0030a900b6bf4mr5182861wrv.0.1684867352926; 
 Tue, 23 May 2023 11:42:32 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 j15-20020a5d464f000000b003012030a0c6sm11920149wrs.18.2023.05.23.11.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:42:32 -0700 (PDT)
Message-ID: <56635bf3-254e-fe15-ee95-916abd7d2d70@redhat.com>
Date: Tue, 23 May 2023 20:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] hw/arm/Kconfig: sbsa-ref uses Bochs display
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230523172855.679018-1-marcin.juszkiewicz@linaro.org>
 <20230523172855.679018-3-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523172855.679018-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 23/05/2023 19.28, Marcin Juszkiewicz wrote:
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 0f42c556d7..4484de67e8 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -249,6 +249,7 @@ config SBSA_REF
>       select PL061 # GPIO
>       select USB_EHCI_SYSBUS
>       select WDT_SBSA
> +    select BOCHS_DISPLAY
>   
>   config SABRELITE
>       bool

Reviewed-by: Thomas Huth <thuth@redhat.com>


