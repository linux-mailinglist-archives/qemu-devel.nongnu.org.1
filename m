Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B8768DAB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQN7y-0004Hv-56; Mon, 31 Jul 2023 03:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQN7w-0004H3-1R
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQN7u-0005et-IK
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690787733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBfpOagrTrr5J584ZsKzPTICJSqpSEt1rQjOESpOFDg=;
 b=QFtB/e+5MItpT+Lg7WoEiQuVqHX0o8SWH/uW73iIWvuJqrchSlkClftce/rxNXapLkpas3
 w/wEUhNfPyqignoilW0VR6vWOvrGXcd64Kj0JuvFMqUOYQDzoGKczlByI9NY3z7cRnrDyT
 W2pz+/ww+4RW3MGY/rOl53EWoiyQ+AA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-pOsq4nGIPsmG2qgMUw4miQ-1; Mon, 31 Jul 2023 03:15:30 -0400
X-MC-Unique: pOsq4nGIPsmG2qgMUw4miQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2684828e793so2578587a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690787730; x=1691392530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBfpOagrTrr5J584ZsKzPTICJSqpSEt1rQjOESpOFDg=;
 b=g5zc4aHJkL5L4zKZXhhIVTuwJ4KiRK5EOODsajfDVlGbb4Prx5LcXt2d1/lv1ckk2Y
 pVBlFphDzv01kU4ccTfJthXr4fUi4fzo4QBPze/ZUaK5JNGTpIY4F51m278gA5snobp6
 dozaPA/7xaiogkGU8pDlM+TgxbcuLJjn3McT2T9h9eOe7MF+Exw1dyiBH5L8VH3C0RJa
 KWDawxJj6y7s41S0C8mL7qVdpVS5iF6dhyeeFqCphYrnsTwlGW8/m+2JNIVjPm9K9H+R
 8X9QC8X/WcxTTWsC7WaQg1cTuZoy31JB2pzR5rPuDN5gZKfPxCDt3Xe2rV1yaT1NW2lU
 6P3Q==
X-Gm-Message-State: ABy/qLbNwonErl9idLntdUEXwgt55mo+nhT8RPKvRb/cNCI/WBWmw/Rq
 8n28/YL/Jy2vVzRTVRBsBxVJXrzVJza3K3day0iuhkNu8TYzbvvFnsgeUv76ppsbMWEBVPtcGSE
 Y6TpbHKWYCNJlS50=
X-Received: by 2002:a17:90a:fd0d:b0:267:f9c4:c0a8 with SMTP id
 cv13-20020a17090afd0d00b00267f9c4c0a8mr7567841pjb.4.1690787729930; 
 Mon, 31 Jul 2023 00:15:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6hfmOHKxfxzg1eIjUW80fC5o6Wzto5PO402pDEoZmV/SRx7UpSShK118LcjAmfk+zNRHOEw==
X-Received: by 2002:a17:90a:fd0d:b0:267:f9c4:c0a8 with SMTP id
 cv13-20020a17090afd0d00b00267f9c4c0a8mr7567830pjb.4.1690787729639; 
 Mon, 31 Jul 2023 00:15:29 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 29-20020a17090a005d00b002612150d958sm7895363pjb.16.2023.07.31.00.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:15:29 -0700 (PDT)
Message-ID: <0b23a5f5-0539-47f5-2cd9-e79c120e1bb8@redhat.com>
Date: Mon, 31 Jul 2023 17:15:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.2 2/2] arm/kvm: convert to kvm_get_one_reg
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230718111404.23479-1-cohuck@redhat.com>
 <20230718111404.23479-3-cohuck@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230718111404.23479-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 7/18/23 21:14, Cornelia Huck wrote:
> We can neaten the code by switching the callers that work on a
> CPUstate to the kvm_get_one_reg function.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c   | 15 +++---------
>   target/arm/kvm64.c | 57 ++++++++++++----------------------------------
>   2 files changed, 18 insertions(+), 54 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin


