Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 658ECBD4DD6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 18:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LCn-0000xg-54; Mon, 13 Oct 2025 12:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8LCi-0000xF-8J
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8LCf-0003Uq-K7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760372114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vLBe8eaqgHJm5zK1AP+gg0w1kfoeTcEHq9np2j69DkE=;
 b=I6gaNnJ7mYpuLF+PwtGhjTqtiHiWPZfcvvVj7ZTrBgl05tiAoDRK06DyLuIm0v5ARgaJcC
 qLqGk8brFXVltLORvWQzL9/ezsqUQbxP7Y3p/A8QGxOCnQ09Xy1LR5AgiEfs6ei2pJ99eN
 mHa8Stf+2qaFiLqD5Uvz/zMy465+mVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-gWK-LL5KNHWPVK0zONSn4Q-1; Mon, 13 Oct 2025 12:15:06 -0400
X-MC-Unique: gWK-LL5KNHWPVK0zONSn4Q-1
X-Mimecast-MFC-AGG-ID: gWK-LL5KNHWPVK0zONSn4Q_1760372105
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e4cb3e4deso16890585e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760372105; x=1760976905;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vLBe8eaqgHJm5zK1AP+gg0w1kfoeTcEHq9np2j69DkE=;
 b=Xy9GGqW0I9EDEg9ROtgxgPsBvH80rFyRr1tqFVwnve4xGe2b4dHWXy2XIXQte+mkzq
 G1kZQAk7uUMwboHmvvxSOeSwVc84w+xIoPaeFPDYU/SKw3kNM2u5wgRxMRwuQaIy55SA
 X0aA06ONMSyfNPLTjrEKNaTtqnzKyjKFtDuEsa0YJm8Oqvil+LQeXF/E0RgAPdXd38+x
 Giqd+/vOS3eKkt8kgXDsMQPFR7s8SRMQM5Y4nZ0we2RUta2icc3flbgza6Ryru3aJYkL
 5vEZkdLrAfx3hOYPuznRMq0IPMa7/9wAn9NDxmHE+ILQx9t7fVRpaMh5JA6O+B7ucKO+
 h+Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo//wgYaa8OnEay59OZbRaR7OFjL//49rCeGpk6GEuxxMta+OwU8UoWiTMm0Zbjxtr6b0Lj+NAtHPG@nongnu.org
X-Gm-Message-State: AOJu0Yya2hCbA6+Hu4sj+3YJxBH/5JQ/JcAdSyfMlT8TXeZn6EiFpuE0
 R6yXx2fQ2CgpMsckjcCfGLYPOvKJU7axeI3uVA2tIPKYqn0tccd7eVd6yXOw2zEjItmLQVOG5ep
 mxY56hNJaW9z9iaqfF6kHq/v5YrdgJUiBczuIFfU0yUweZU4iU1BQ2fu7GHDUkBO1
X-Gm-Gg: ASbGnctVbXqy14/e1fLuzGe0BxKl+OzlYlPo1maSj1wgmEA/EYmVvx2rsYRkF781Ojm
 0EoWYvBHJNVZ+opaXyVBxA9lDtVg3HPAlaLI0T/SrL50w69u/qvo4vHkzfaluWuA+C33wRbbuzA
 y9GDzhk0bQvwd5PXZxIXJfMS0Nxj9rGf/YTb++5ABkOUMmod5dhjqEvt/L3COTd5AFrF//kPa57
 wBfcPMOIeJ9bUjGitM4lrlXn/QtBNqYNgpxiOBcK1/LpPf/aJ7qg63NZPXYLn3dw50qG6cRr2+F
 xsqv7mB/6q8M1/eP3lyu3lDdv7MxnIm7BIQlZkpZnJLiBSVZ0fuhhRVdKTQs6nwLzZjfZMTLq2r
 iAm5T
X-Received: by 2002:a05:6000:2002:b0:3ec:dfe5:17e8 with SMTP id
 ffacd0b85a97d-425829a5aabmr17589406f8f.6.1760372104984; 
 Mon, 13 Oct 2025 09:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELlUrqG4C+hG32lvaUN2jbr5fHa6Ks1yV5+RydGX0kNmdcWW0nFyoxLfgSQtTy3C44CuuOfw==
X-Received: by 2002:a05:6000:2002:b0:3ec:dfe5:17e8 with SMTP id
 ffacd0b85a97d-425829a5aabmr17589383f8f.6.1760372104617; 
 Mon, 13 Oct 2025 09:15:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582abcsm18984824f8f.17.2025.10.13.09.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 09:15:04 -0700 (PDT)
Message-ID: <2151ff2f-e965-47b5-9505-1ba2382f9f45@redhat.com>
Date: Mon, 13 Oct 2025 18:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix access to the T bit of the TSS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251013161152.992880-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251013161152.992880-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/10/2025 18.11, Paolo Bonzini wrote:
> The T bit is bit 0 of the 16-bit word at offset 100 of the TSS.  However,
> accessing it with a 32-bit word is not really correct, because bytes
> 102-103 contain the I/O map base address (relative to the base of the
> TSS) and bits 1-15 are reserved.  In particular, any task switch to a TSS that
> has a nonzero I/O map base address is broken.
> 
> This fixes the eventinj and taskswitch tests in kvm-unit-tests.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ad441b8b791 ("target/i386: implement TSS trap bit", 2025-05-12)
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Closes: https://gitlab.com/qemu-project/qemu/-/issues/3101
Tested-by: Thomas Huth <thuth@redhat.com>


