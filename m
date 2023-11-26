Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0307F96A0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:49:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Orv-0008VP-NX; Sun, 26 Nov 2023 18:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ort-0008Uo-PK
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ors-0003St-Gm
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbnrR726rByRQIiBcu2gh9kRjvyVp2tP/jXqpC6/BNw=;
 b=Q+V+hRVkRBtVdIxN0CTDva42q5q3zeZO95gSDIgi449L2qeX0YqzNC9jMlhZPtTy6AWH5H
 VKYvO/9lBl4WGVHQ5diYABmEIvic1R+2a2GA2lYaOqzWBXrpf/e1XmF38V4cG96IDPafzo
 uRmI45rAdtYJz+mXVinu8WZvkPzJe7c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SAV7XiXwMyW-MVers3q2zg-1; Sun, 26 Nov 2023 18:48:47 -0500
X-MC-Unique: SAV7XiXwMyW-MVers3q2zg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28591135e95so2339486a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042527; x=1701647327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FbnrR726rByRQIiBcu2gh9kRjvyVp2tP/jXqpC6/BNw=;
 b=sf+ZZAhSJZHa0Z/CkGwWWDzEa7+HB+SRgA/h5KGrxh6wZha+I91z31ECWOsZpC7eai
 PNELZPfwUw+168QMNHOF63gQANvMiNaMjqwjUdBD8S6groIhWYvaR2k6L2EN+r5ADduc
 u4AtfV3Hzklm1lqho3Kv4iZ7abDwEvPAcvu4BJ6oJSwk/nGHh1O3UoZ63CJ7i4UIquQa
 FWgeSDkqzI1z2Cy24Ga4nh7q3dG5uc6LOj3L6HmckwUrpdm22KGmQOYkExTbAH08ntuE
 gURL1dp7iFlp5RTOXRy3L4ahDIzHL/s3P3QydGpCnU9yOZj6PLoGK+2A4DgvF7/ilfV/
 6P7g==
X-Gm-Message-State: AOJu0Yw7OtwFuXw3W17RBseEKKSLLtPm0WKug5RYqaJsBF9ljRIR4EAK
 dceBRgoTExeiEYQgfcm09AZzNWloeV9JRXrDMYMsrIgLZA9g0CirehRJp1p1n754Uemc1D+IHHD
 jjKmg1tQhWJ9RBK8=
X-Received: by 2002:a17:90b:1d09:b0:281:d84:a97e with SMTP id
 on9-20020a17090b1d0900b002810d84a97emr13711164pjb.2.1701042526922; 
 Sun, 26 Nov 2023 15:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9XRPBVgjs73Zwg4MSi5qvxkX3rTtoJ2ByFgAuDPv8fAQkTBIXSdhXHlHWNoc7s7zQhZjh0Q==
X-Received: by 2002:a17:90b:1d09:b0:281:d84:a97e with SMTP id
 on9-20020a17090b1d0900b002810d84a97emr13711150pjb.2.1701042526651; 
 Sun, 26 Nov 2023 15:48:46 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170902748700b001c5dea67c26sm6852867pll.233.2023.11.26.15.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:48:46 -0800 (PST)
Message-ID: <39eea212-80da-4e7e-ad43-92070f1af035@redhat.com>
Date: Mon, 27 Nov 2023 10:48:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] target/arm/kvm: Move kvm_arm_copy_hw_debug_data and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-6-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 10 ----------
>   target/arm/kvm.c     | 24 ++++++++++++++++++++++++
>   target/arm/kvm64.c   | 17 -----------------
>   3 files changed, 24 insertions(+), 27 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


