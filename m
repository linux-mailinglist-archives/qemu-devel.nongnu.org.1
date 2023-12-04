Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB7802AFC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:47:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0qw-0006Ql-De; Sun, 03 Dec 2023 23:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0qu-0006Pw-OC
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0qt-00009S-A7
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQySVAv1RTwMbmKzuI7FV3R4Quklar5p0TTt3MosBJY=;
 b=Dl3RxjwhjcB38B8FwwbvMkJnr3xAeollBGHkElCjgYkxRlkkWm4A/zlkpfYrhWVCe/fzTh
 zMp0cMn82G9XgmiM/GsH15Usph3wltqdhL4jUiXMUKTM2GHAUmOhbCBXBs0SBVRadorC17
 RPsl3WTPOfoV2v3uORXpValCyhmNWAA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Eg1HjoDrMb-lmrFPeL5JMg-1; Sun, 03 Dec 2023 23:46:35 -0500
X-MC-Unique: Eg1HjoDrMb-lmrFPeL5JMg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-286c066f67bso100579a91.3
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665194; x=1702269994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQySVAv1RTwMbmKzuI7FV3R4Quklar5p0TTt3MosBJY=;
 b=JR1z1g9q/hhXUbrqzp/ecUqzoZEi1Wuix58yHlFTlPGdskPislZfsfoRNSVUkD2X3d
 W55pnrh15BJMrrsKUAz2qZQKR7TX+EjeU6WPAV/ezA2lrA+Hs+6rHPHhtYHpTt7A8t47
 7rI2x9+8QFlaMlY+yu8HkFvIA08RqgxX0EKFt71sljyetJpU04SoggW3m3IidGCu0REL
 SCssfQ4n0vk1A+tYI/+fgFkLlx+ZHiuO/9zbmn2Z51mD6wQ/4ldLzw5E+OYnno/x8ETp
 KcmVS+YpdwsFyKeJrh3LK3SAyWV+8P8HQlpf3ncSiq9zmX8JKtpKuQ9aj8jN/SqGPPzN
 cwOA==
X-Gm-Message-State: AOJu0Yyfm6Q3jyA7o3a5rtGvl6g6NfI03j+mh7ZBmPcfnBxgInodLgvO
 MX1EBJ+Ak5B9/956eDYxi3UwmPU2PQg4eM647A1exjJZv3xq4pTDv0qA+YxqpS2MXByCjRNd10K
 9T0hCjGKIoM9/yvU=
X-Received: by 2002:a17:902:f54d:b0:1d0:6ffd:8342 with SMTP id
 h13-20020a170902f54d00b001d06ffd8342mr902044plf.77.1701665194549; 
 Sun, 03 Dec 2023 20:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW9PwwjZBpYYE5rnRY9haburvUdamP+jb7IJRQn3eW26a85cCmtTWz2Oz0X1bGCphVOxaF2Q==
X-Received: by 2002:a17:902:f54d:b0:1d0:6ffd:8342 with SMTP id
 h13-20020a170902f54d00b001d06ffd8342mr902027plf.77.1701665194301; 
 Sun, 03 Dec 2023 20:46:34 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:46:34 -0800 (PST)
Message-ID: <cf94943e-d4f4-4a18-a779-32476833d518@redhat.com>
Date: Mon, 4 Dec 2023 14:46:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 05/25] memory: Simplify
 memory_region_init_ram_from_fd() calls
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-6-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-6-philmd@linaro.org>
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
> @@
> -   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
>      if (
> -       errp
> +       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


