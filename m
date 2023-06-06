Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48688723EEC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TcN-0008Gs-Sv; Tue, 06 Jun 2023 06:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6TcL-0008GN-OR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6TcK-0003lF-CQ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686046123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpXR7e08qIMgX4nE+VGMRJrIFxZ5Gd1HRSSzMDMpg/4=;
 b=RyHAD13h79dZI9pCsbJGL1pS+foICCgFik06n5mKTcYWOXEdQgr6jCIYBzAfChd2OqFCts
 Z+VOYTvSFgIdNSoSlDVon/7OpVgJsqWlfP4EbLQ7ockNwP4ptXMfKw7ONiH9rguD1HWYOa
 3oDU/3WaJoas08pIuLa/gR0ZN0xdiWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-vUu3wnYHPAiqREn1DCg26A-1; Tue, 06 Jun 2023 06:08:42 -0400
X-MC-Unique: vUu3wnYHPAiqREn1DCg26A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f603fed174so32707165e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686046121; x=1688638121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpXR7e08qIMgX4nE+VGMRJrIFxZ5Gd1HRSSzMDMpg/4=;
 b=EgIWOwmqOwa72yezAhJNG7Ljgl96H4XghyxBQswSKz5ieIO1fAxHRgv5C3Hq8TkZWn
 BOAR7An+vVGZhnsVEB/BnMtFNRnI0QNnkJLgxWjny+pwgOwkkP3KiUVeMyawMVjDRZrm
 3DWLS7tddirnD4XnhZdGepnxZg6DYHjgKpYSfj/z4CrPLwIaeLQ1q008HcCRMar0T30H
 GIgk6178AC7T4wtIYRzKw1jeIoxjeIrZbzXGV7FuoyZQFY793R7ttsW3+SFKLzuIrf+T
 qq4Nd9WWCnmXqMu2p4Hb0V5fSug2UAnkWW7rH03PmBAvDaXpgVxBVoMi03Ry66uZMI4f
 qFHA==
X-Gm-Message-State: AC+VfDyKXH2lH7oEHAjTBaGTKxBRodkT2E86C+VpUb0lWjQqGQm8MES4
 StR017CkvzSIiFFYQwg8GlCdtxqxUyulodxOeKuU74zjMHIvncmaVbqvgYxtJsABb09n9gTcqk5
 ANPULn1QEvdhszOo=
X-Received: by 2002:a05:600c:218b:b0:3f7:cb42:fa28 with SMTP id
 e11-20020a05600c218b00b003f7cb42fa28mr1461616wme.28.1686046121338; 
 Tue, 06 Jun 2023 03:08:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YcfId54x8AJdetY45D8yiODrZQX2LEAwcFKSFUU42MQxxo3rWsxCllV/qt+9BIW5X5oP5+A==
X-Received: by 2002:a05:600c:218b:b0:3f7:cb42:fa28 with SMTP id
 e11-20020a05600c218b00b003f7cb42fa28mr1461613wme.28.1686046121191; 
 Tue, 06 Jun 2023 03:08:41 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 l22-20020a1c7916000000b003f6f6a6e760sm17103004wme.32.2023.06.06.03.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 03:08:40 -0700 (PDT)
Message-ID: <0acc501c-561b-5888-2e04-6aab62971306@redhat.com>
Date: Tue, 6 Jun 2023 12:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: always build network bootloader
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-8-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230605095223.107653-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/06/2023 11.52, Paolo Bonzini wrote:
> In the beginning, the network bootloader was considered experimental and
> thus optional, but it is well established nowadays and configure always
> checks for roms/SLOF before compiling pc-bios/s390-ccw.
> 
> Therefore, it makes sense to always build it together with the other
> part of the s390-ccw bios.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   pc-bios/s390-ccw/Makefile | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 9c5276f8ade..2e8cc015aa0 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -67,12 +67,7 @@ s390-ccw.img: s390-ccw.elf
>   
>   $(OBJECTS): Makefile
>   
> -ifneq ($(wildcard $(SRC_PATH)/../../roms/SLOF/lib/libnet),)
>   include $(SRC_PATH)/netboot.mak
> -else
> -s390-netboot.img:
> -	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
> -endif
>   
>   ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
>   -include $(ALL_OBJS:%.o=%.d)

Reviewed-by: Thomas Huth <thuth@redhat.com>


