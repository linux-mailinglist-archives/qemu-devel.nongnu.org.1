Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 714527F96B0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:58:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7P0g-0003ZP-K8; Sun, 26 Nov 2023 18:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P0e-0003Yt-KX
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P0d-0004en-8x
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701043074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgt1uPD/vKXQtxtZmQgZEBPVjnXZ9t36A5DIarwoeig=;
 b=KY3Oi/hNpcb3UcItNU8nOKRwlvF0PZVqeU3a8MQVpqe4xPR27iUrkr55OdSJMF0zLYpTHh
 bl23gyo8sRfufTG6i9WFG7hQ0SpPb7//jhe+bI5LV+6CR0RQhbjc9kuDT3JHTagUZPKk9X
 xzRSS0qGxYQXF7CRSWgEO1CGUuUxs/s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-uLmlRg1FPQ207uZRTaBAbg-1; Sun, 26 Nov 2023 18:57:53 -0500
X-MC-Unique: uLmlRg1FPQ207uZRTaBAbg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-285a1530b7dso1645666a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701043071; x=1701647871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgt1uPD/vKXQtxtZmQgZEBPVjnXZ9t36A5DIarwoeig=;
 b=pKaUVRhDkXNTzk41YKJgNZnIYEhGYZG5SSt1dnTTcihWs/I0jH67TXPh5tL1WX4GFq
 ghPPxjCyAYR1qx9CPuB2U/JUoQkS2wKEX4j1961ei74eyOaRvIl04w9pSENZMyne/kCM
 uy6iHWy65llq9tcEMj2QAP1wTfVfX1v7x6jo/tXTxCeMtbF1ZQndtZkmZI9Tr3NBK/Ql
 t1GMlTE9VNvtSDmekEIBljj0bD5m6zU7o7ORNHrzVyn5zUoz98M9IxPclM/jexjoalif
 bBCSm5x8q8aUUcnEfwCuhOYGO9gvSO5Sj/MbiTSvqrfIJdiKTnbxr8tY9VSC9W95DmZc
 vxdg==
X-Gm-Message-State: AOJu0Yxnce116HTZHNDUFbC86rfvKCIAeNzvK/EBTL6UXTnurD0pyo1D
 6dTIgosDVQB9wLEAZ+7K/arNW848hIJfn0YFrvK2obqIfLkuEyEBn/8CkqvGMjPubvGThXKHPpt
 Mg4lbrufyC1s0oF9usvYYKQU=
X-Received: by 2002:a17:902:be12:b0:1c3:1f0c:fb82 with SMTP id
 r18-20020a170902be1200b001c31f0cfb82mr9259376pls.41.1701043071699; 
 Sun, 26 Nov 2023 15:57:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpKBw2W1liFZ//dSauzr6TxPyqAoiGt1hAzxEy69OYtOV/2PJRolvCoPFdc39lGlfC6NY+UA==
X-Received: by 2002:a17:902:be12:b0:1c3:1f0c:fb82 with SMTP id
 r18-20020a170902be1200b001c31f0cfb82mr9259366pls.41.1701043071395; 
 Sun, 26 Nov 2023 15:57:51 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 jb20-20020a170903259400b001c61901ed2esm6956319plb.219.2023.11.26.15.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:57:51 -0800 (PST)
Message-ID: <7ee909ad-f34e-4015-a862-f97f44b8a9a1@redhat.com>
Date: Mon, 27 Nov 2023 10:57:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] target/arm/kvm: Inline kvm_arm_steal_time_supported
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-10-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/23/23 15:42, Richard Henderson wrote:
> This function is only used once, and is quite simple.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 13 -------------
>   target/arm/kvm64.c   |  7 +------
>   2 files changed, 1 insertion(+), 19 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


