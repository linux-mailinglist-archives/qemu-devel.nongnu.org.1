Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB328D85BC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 17:05:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9FZ-0000DJ-DG; Mon, 03 Jun 2024 11:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE9FX-00006N-Ia
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE9FU-0003FF-UR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717427122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hA6ftzxHdKMZLCLQY+6UEb8ZUZegzXdS1i4vrQDxWds=;
 b=RJS4Xcdqxrqi+5PLQRAyMnFEdTNcwaTr1ItgFgF99AncVWSfVpkoL94Yc0nsAwbA4oHF4x
 G98XTYyDjbp0ZQflH0ArnWjS1U+CH/TkDHr9N+3SUVkmp0RW9SpA7ZLRBOHkTG2Q32MVgT
 bRVHE+QKB1AoDz6eqwG52O5TJdjj2oU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-UpSCSQjLMhaLFRMfw7Xadw-1; Mon, 03 Jun 2024 11:05:16 -0400
X-MC-Unique: UpSCSQjLMhaLFRMfw7Xadw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43fe0f3bfd6so45753081cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427115; x=1718031915;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hA6ftzxHdKMZLCLQY+6UEb8ZUZegzXdS1i4vrQDxWds=;
 b=tcG4U/3RU0oIvxS0Rwva+SrRaTx3e3t/4mR6hexdRO5PW4HbgYJKZfo2xt/hycBeYT
 UwIm4CpzlRFjyvACpQTi+h2xAU0WLeZmZwTNm1NGCyruHR6fHVR2aTcj5MdGRQrBOWgU
 B0D3XjoHyfjR15MpDPYVDjY2izkQzmp6tzTfAsqmi4rdQtNwHmFHp8jFzrP2Y4Isz2sQ
 flTjK1rT7aCTz/fArZPI/gFSv4HlVyYw8UwvNulGWZKprv6P9ezSA5Bgv2zKeZ/WoyMz
 IF+f1iYabisgWnOoC/UU9KJlrNQYhh9j61VgzIfd+7gRMnH7nr3qNoUjKlDp5nvNx7HY
 DCRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlLO3oDNo63Bh4rfRdJUJQlTsNpkdgaVHtFUkA1DjcqPndOVgQmuogu6Nf8XTPQDASkwwUr55+dSy5hvDw66H6cCVZ8DA=
X-Gm-Message-State: AOJu0YzlkLFcKf9jVHyBjSXKD1/53TCx3CakE9La0dg80OJP73lUmA6T
 Ma1sNhUu7K3Bd/nmHVqvcvvDYO5nDa8PxOizhkjkXsaHDwHGyGQ1R9vzy6qzo0YrYrt8a8CcREo
 vnbbsHF2Epb0APTVVNA7WrIyUZM6bbIlRpATRIDgEh/TQ/yXrtGzNB7ERjPEJ
X-Received: by 2002:a05:622a:1a0d:b0:43d:fa59:6461 with SMTP id
 d75a77b69052e-43ff525ae2bmr104549681cf.39.1717427114539; 
 Mon, 03 Jun 2024 08:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWa8FuppfZkfDJY/Zr6BePL23vtDD/2jpyJaldtbQ2hfKlPjYllv3qesvb+XHc/6lVclfD6A==
X-Received: by 2002:a05:622a:1a0d:b0:43d:fa59:6461 with SMTP id
 d75a77b69052e-43ff525ae2bmr104549191cf.39.1717427113920; 
 Mon, 03 Jun 2024 08:05:13 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff2467e1csm40555151cf.75.2024.06.03.08.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:05:13 -0700 (PDT)
Message-ID: <686611a9-8f8e-46b4-9072-51edbdda6622@redhat.com>
Date: Mon, 3 Jun 2024 17:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] update-linux-headers: import linux/kvm_para.h header
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com
References: <20240603131141.834241-1-pbonzini@redhat.com>
 <20240603131141.834241-5-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240603131141.834241-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 03/06/2024 15.11, Paolo Bonzini wrote:
> Right now QEMU is importing arch/x86/include/uapi/asm/kvm_para.h
> because it includes definitions for kvmclock and for KVM CPUID
> bits.  However, other definitions for KVM hypercall values and return
> codes are included in include/uapi/linux/kvm_para.h and they will be
> used by SEV-SNP.
> 
> To ensure that it is possible to include both <linux/kvm_para.h> and
> "standard-headers/asm-x86/kvm_para.h" without conflicts, include
> linux/kvm_para.h as a portable header too, and forward linux-headers/
> files to those in include/standard-headers.  Note that <linux/kvm_para.h>
> will include architecture-specific definitions as well, but
> "standard-headers/linux/kvm_para.h" will not because it can be used in
> architecture-independent files.
> 
> This could easily be extended to other architectures, but right now
> they do not need any symbol in their specific kvm_para.h files.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/standard-headers/linux/kvm_para.h | 38 +++++++++++++++++++++++
>   linux-headers/asm-x86/kvm_para.h          |  1 +
>   linux-headers/linux/kvm_para.h            |  2 ++
>   scripts/update-linux-headers.sh           | 22 ++++++++++++-
>   4 files changed, 62 insertions(+), 1 deletion(-)
>   create mode 100644 include/standard-headers/linux/kvm_para.h
>   create mode 100644 linux-headers/asm-x86/kvm_para.h
>   create mode 100644 linux-headers/linux/kvm_para.h

Reviewed-by: Thomas Huth <thuth@redhat.com>



