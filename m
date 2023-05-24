Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6A70F5A0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1myC-0007aR-Us; Wed, 24 May 2023 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1mxr-0007Zc-O3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1mxp-0007WU-Om
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684928852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ly3iq5djIcCqI4krF+Qo/9OZXtKT9eroYAcsgfU1o4Y=;
 b=N7E1Knq3c80+UxAUEi7Sqy7fQiTzAJKW1JRoe/AnEI1iCiuJrD7k+qMD7l/11ZdFkK/L9r
 SXkcWpCCS7/LYJsl1bAJpORJYa5Ov7tRWsBVGGhL4wpipX1/XrvY+TDmfZLEaQvtTkY4bt
 20iaMqSwRzp9Tpi0sUiLUX8F7nu+esk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-gnrBisF_MceyT462NRsk-w-1; Wed, 24 May 2023 07:47:30 -0400
X-MC-Unique: gnrBisF_MceyT462NRsk-w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3094b683f3dso291477f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684928849; x=1687520849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ly3iq5djIcCqI4krF+Qo/9OZXtKT9eroYAcsgfU1o4Y=;
 b=dI+X9k/EqOTpPobQoGFbICaKM9sKKWYGIWKEzCOdAEf0NDlR+8MvGlUQpgHYKaezm7
 N3xOQ70kv/rkahCWSego73NEK4l5THKaw8xNs8FwNl0CY1L7HIIbtuIQHJ+l6aggtSkM
 VVhcqksZKZvYomME84pxpj1ZPpKHt3lk7/GFnXXL37Icl2dfP3cf4GGS5bxN2JtCfYMk
 QpA+7HrbcnVxpFtvxy0R7tz3eEcsxkxNHHNwgZBpBlI5WpIZfKylanQs1dnibctWlA/y
 pNLQ+3swL2kFvS+uVLRw/Bdg4dYudRSVmcd/lbml02vcnIlAB4ffdAY1Yu5ay2z/8qma
 TruA==
X-Gm-Message-State: AC+VfDypnvlvZXVY+i9KvtYNjvJSsI6pWOgIuOYsAhaqZkaKf8APHWQ8
 CpCjzQKEVVllS9zBz+2mN+VHISUwZDj0hDZV3cKf+YzyqzWri9k0nP1p6/8KP8yIM3qNXrSBxcb
 l3VUF+qz4PziaRuo=
X-Received: by 2002:a5d:54ca:0:b0:306:2979:8ab0 with SMTP id
 x10-20020a5d54ca000000b0030629798ab0mr12001654wrv.24.1684928849252; 
 Wed, 24 May 2023 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XQ1EFy+UYRNbXvge5GReEjxEo9G+yFBza1cZT/wV3Kx+LlIT1mD4jwsaccsxxqdxD4rCktg==
X-Received: by 2002:a5d:54ca:0:b0:306:2979:8ab0 with SMTP id
 x10-20020a5d54ca000000b0030629798ab0mr12001640wrv.24.1684928848991; 
 Wed, 24 May 2023 04:47:28 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 t11-20020a05600001cb00b002f9e04459desm14192661wrx.109.2023.05.24.04.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 04:47:28 -0700 (PDT)
Message-ID: <ac22771e-4ccf-7c41-af25-b15c07e7c6a9@redhat.com>
Date: Wed, 24 May 2023 13:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] Add Bochs to list of vga_interfaces
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230524111413.833912-1-marcin.juszkiewicz@linaro.org>
 <20230524111413.833912-3-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524111413.833912-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 24/05/2023 13.14, Marcin Juszkiewicz wrote:
> arm/sbsa-ref uses Bochs-display graphics card and without it being
> present in vga_interfaces "-vga none" argument handling cannot be added.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/pci/pci.c            | 2 ++
>   include/sysemu/sysemu.h | 2 +-
>   softmmu/vl.c            | 6 ++++++
>   3 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


