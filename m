Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71887F96C5
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:22:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PO6-00051i-3T; Sun, 26 Nov 2023 19:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PO4-00051Q-1R
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PO2-0008T9-8A
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fA0o2VESFjsdjK04i05/gj7t5CH+OeM5G9UGaLDt9+Q=;
 b=O1s0iZ+wbnwx3GHVPKGD8cTEvGlWVAzDhpZpMtWsmaQi2I9kNR53v4/kbleqph6bcTfAns
 JKQA7fu/RDK+kwvF6TlWwwQzrV2uq0X0cirwD9du4lsidrnLLgAa+NB3fnb7bEsjhr5lUF
 bjDKPJWcT61BSjkaHMclsEY1PxPiq20=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-EdNKNrjmNHWzvy7qjjqQ-w-1; Sun, 26 Nov 2023 19:22:03 -0500
X-MC-Unique: EdNKNrjmNHWzvy7qjjqQ-w-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c1c48d7226so5102011a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044522; x=1701649322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fA0o2VESFjsdjK04i05/gj7t5CH+OeM5G9UGaLDt9+Q=;
 b=S903wpB3V3nBDuYiw8+Z8cVY5PbPZZFDTAvt0OfHKqX7koVW8NOnb62EVJDKXwGZMR
 2QLK2p5pvVx695J4jjxvXvpUZUW2vRDe+PHVhSq5CpuweENgCfusbzVm0qm+EEY+UtkD
 0QYam6YgNUhbhjEai0ThI+iCVv+XgsfSnoZmHoqLMEHn96R6zTCstmRdVHSHh43As0Dm
 IA2s2T+0VshTcPUmEu5gMS9XHrTHl2mhngwTjZsyqvz+OLPrLwf9nhnRbmbGa7gbcwYG
 aY/qbsm4NyQ6Muh0GeibMrYuA1L5LdTRs7/LUd+i+K8DbW1Poe0tD1oXvZlH9MVWzeXn
 psxQ==
X-Gm-Message-State: AOJu0YynNIIfnmXf+NkKplQRT0hUJSPlRj29JwdsLmHrzXqWCC9PctEa
 PDsWEPCigvIBFyLJLcnm7gjt4xVzHOMXwnPOj21fBmAXhbfdJOd4NMbQ0YF8uWyl/ZuCXrUn0Gb
 RfN98sfCxMAb0Xdv7idbmBGw=
X-Received: by 2002:a05:6a21:3288:b0:18c:1872:476b with SMTP id
 yt8-20020a056a21328800b0018c1872476bmr11586612pzb.48.1701044522289; 
 Sun, 26 Nov 2023 16:22:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYJ5atkX737dNSXCsKFgXTC7ZIhW26dzgpLoq5176kYLRUmCjbcVMtw3MRStP6X9b8TCKf4g==
X-Received: by 2002:a05:6a21:3288:b0:18c:1872:476b with SMTP id
 yt8-20020a056a21328800b0018c1872476bmr11586607pzb.48.1701044522028; 
 Sun, 26 Nov 2023 16:22:02 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ob14-20020a17090b390e00b00285a17f9da1sm2901511pjb.43.2023.11.26.16.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:22:01 -0800 (PST)
Message-ID: <cefc3b13-4291-43d0-a666-ba18008340a0@redhat.com>
Date: Mon, 27 Nov 2023 11:21:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-19-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-19-richard.henderson@linaro.org>
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

On 11/23/23 15:42, Richard Henderson wrote:
> There is no need to do this in kvm_arch_init_vcpu per vcpu.
> Inline kvm_arm_init_serror_injection rather than keep separate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     | 13 ++++---------
>   2 files changed, 4 insertions(+), 17 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


