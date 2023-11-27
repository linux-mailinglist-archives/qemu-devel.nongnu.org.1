Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F143F7F9812
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:00:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Sme-0008SC-Ih; Sun, 26 Nov 2023 22:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Smc-0008RT-MA
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 22:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Smb-0003MQ-BB
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 22:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701057580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCO1ba7StEvXUkbZaSH8q8Y/0Tm0SlHov8qnehHodAY=;
 b=hJ9UN7R00hgHi+p5y5UL1LSDBDq00bZg5ckb/Sz6rVO1vqyWPPVIA4ivADz0DAIDeWUmrS
 icuHAbTbr2dsSyN56MeiMU+XENnkQiZa/MUXZvpnGQupVS0xWPpJ4dOXNAreEXDFQv3Vos
 5yahavnWKP/OVYbEumFZ/hZ2PM0Tzs8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-f9lXg-8JP8ymDBaMASiZOQ-1; Sun, 26 Nov 2023 22:59:38 -0500
X-MC-Unique: f9lXg-8JP8ymDBaMASiZOQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c5c8ece6c4so657552a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 19:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701057577; x=1701662377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCO1ba7StEvXUkbZaSH8q8Y/0Tm0SlHov8qnehHodAY=;
 b=r+mFXa8Mj7AM/pCI0jNKNbl6taHPYG/v8zK7PiDgDYR+VdZf8LTrAyjFnIrRQKHuOQ
 Gca12qoFeOJqSFwxfIVn2hf02pMEMjTZHQplF4fA5XkSlhjlH6d9PFzrk2aL+jhxx0lN
 8Vl3wJ5dwGgXezkBzXpEUvcxft/RHy53ImD4LPrT7CzkVP74oBKf1sF/iBKyaLm0DOHg
 azz6BjRF6syaHcv9tr/M35vFKubAmmpUg6j6C7I/4ovKTC5dpRKfYTfOnwZM/TDVSREv
 xJxLaHnBroF5nTFv0gH8hPheD3t9eZmsoLbBgiuRpDjcmauipYZHAzAhAr7v/mrAc3Hl
 biMg==
X-Gm-Message-State: AOJu0Yw5mY8YImjjNroj4TmRW0SWmBL3U3ViOihd3pOZ8DlDLpzPtEJk
 LvCly1LeVqk9LkAFJV4rOkPE9MUeCwEAcFELM6UpHVgTHxkJLHlwJxHn5tuRRn5kKqX8a3tGYjQ
 /ifs1HanjWVqejXk=
X-Received: by 2002:a05:6a20:e308:b0:18b:4e39:835 with SMTP id
 nb8-20020a056a20e30800b0018b4e390835mr10267599pzb.31.1701057577463; 
 Sun, 26 Nov 2023 19:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSttmnDmrI9CXz7zKxiGqoR4wLGsgde4Qlv1qUaaSNmGNmFM1u9eGXR+ZjHfeWDjJsA/4cFg==
X-Received: by 2002:a05:6a20:e308:b0:18b:4e39:835 with SMTP id
 nb8-20020a056a20e30800b0018b4e390835mr10267590pzb.31.1701057577177; 
 Sun, 26 Nov 2023 19:59:37 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 102-20020a17090a09ef00b002800e0b4852sm7502806pjo.22.2023.11.26.19.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 19:59:36 -0800 (PST)
Message-ID: <54e21c86-2ec1-4eb8-9c79-1ae14715beef@redhat.com>
Date: Mon, 27 Nov 2023 14:59:32 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 02/16] target/arm/kvm: Remove unused includes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-3-philmd@linaro.org>
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
> Both MemoryRegion and Error types are forward declared
> in "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


