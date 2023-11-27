Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2F7F96BF
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:18:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PJd-0002kD-Nj; Sun, 26 Nov 2023 19:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PJc-0002ix-1y
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PJa-0007ox-4g
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIrDtKWLp27JenwO0XHwGY8rObXNUmaetAoeUhPuVb8=;
 b=K+eupT9HmvLDHtUthBS6P7zQ0FDSqHDR0zruZT4ipsiz7wwmtmDdUgQCKn7EFxSiZ+ECTe
 39+X93Zzs000bt0dDbrSFFziCfnDTPXB4cadXLZSt3sTYSlo4vK3mruPQFP17ojD+EHAEM
 Tp9f7g/+GdUBUJGQns4bA6n+h6yhZD8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-uD1OlDFGOX6W5zNeRAYgKQ-1; Sun, 26 Nov 2023 19:17:28 -0500
X-MC-Unique: uD1OlDFGOX6W5zNeRAYgKQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cfa392a13eso26768465ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044247; x=1701649047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIrDtKWLp27JenwO0XHwGY8rObXNUmaetAoeUhPuVb8=;
 b=IvwWNNUVO93gG5GbHzToTTtLbKtl4JeEYAFQ8UsvyJc3pW/6qWjtZ49JhnFok6O48o
 ahIrQRVPQeXVMVBQOHNDk5yQBv9pocrNhIeivRDifox+/LfOXzyIhkzC3t9dtP6dMyNS
 nBmOVA5xtDLXdwxZMP0CWt4sPhVPfB/BrHwdh4NfW9Em1h32H6GWBU58A+RyKnGZyL0C
 VdM4kDIO+Og0MIGBAubMZvqDgvsUmk64Mdd6FJLV0qHpX4G1+1TDxGfWv5hHX30uYCoS
 QlRx2BpoNHKqS7KKyKfSzehSvDLaUl3PbApf7E3gJB6V+GNpJNYMVBh/UDWhbSucNW2h
 4aSA==
X-Gm-Message-State: AOJu0YwfBBi1WuedVeDjxA0/q1n4pbwadCOA+Jiw3C2LtSYSaYxQFvUB
 ycuBSkBYFV1RJeVQjmvpkaKf+19xUkem5woadVen6XBsDTvufaKs6s4mEEbazpem/Jv8kPbroe7
 ozNB6x300QWyGzws=
X-Received: by 2002:a17:902:6b09:b0:1cc:2456:c17a with SMTP id
 o9-20020a1709026b0900b001cc2456c17amr8086753plk.33.1701044246748; 
 Sun, 26 Nov 2023 16:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6QUU3O4kDJAXcRe3T4wUcnSeLB/2/raDIo6tzJKGYhKACNEdyPvtjPo9c/A2vIbTOzP5o+A==
X-Received: by 2002:a17:902:6b09:b0:1cc:2456:c17a with SMTP id
 o9-20020a1709026b0900b001cc2456c17amr8086744plk.33.1701044246468; 
 Sun, 26 Nov 2023 16:17:26 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ik3-20020a170902ab0300b001cfc67d46efsm1386073plb.191.2023.11.26.16.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:17:26 -0800 (PST)
Message-ID: <13704541-c175-425e-a475-731621f9e938@redhat.com>
Date: Mon, 27 Nov 2023 11:17:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] target/arm/kvm: Unexport kvm_arm_vcpu_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-16-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
>   target/arm/kvm_arm.h | 12 ------------
>   target/arm/kvm.c     | 12 +++++++++++-
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


