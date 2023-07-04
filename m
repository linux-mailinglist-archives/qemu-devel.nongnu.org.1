Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB4746AB3
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaWD-0007IV-Tb; Tue, 04 Jul 2023 03:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaWB-0007IH-Cy
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaW9-0001Wc-O3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688455928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOsK2thkEDBqTS2L3hVTXEEXceZmABhjOxKgXaqd4JE=;
 b=BI9Z3EsLV18SiB5j//AICjGAbPVbP27FR4Zgk84IIQlXZ1qQpOULcJihFvzX131AsMFLVD
 XSuC7KY+pkFmdYRpf4gGkoT4pXGLh0ul2WQ9FtNV26XTrdwgc7ewhzybun9pvB9d/VD+DU
 +jZw98eCFK0NV5hb69Pz0b/tPyDsPTg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Knx_ngqeP_KEcBD1chDVxQ-1; Tue, 04 Jul 2023 03:32:07 -0400
X-MC-Unique: Knx_ngqeP_KEcBD1chDVxQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbdf34184eso4249015e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688455926; x=1691047926;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IOsK2thkEDBqTS2L3hVTXEEXceZmABhjOxKgXaqd4JE=;
 b=G8F4sdA9wxzhm7Rt1/cEikZYN1+rijIM0GvXpuz/3bkEE48OmSo2FKEzE/Dg2YhFd6
 QVwezDJJb7NgudAbvmntFd0VXFIznJzeY16Eb27q0/kbHqGeMQWjA003eYzWtjkp1+sB
 AgGt3UgvvYZrCaDpHqdweTgGBwRJqtlO1TzJHplFzzmtg7mIP5yYfLTLeI1Rnrj6DkMF
 t7zwB0tSp60o569I1zHAqCY7UboYreORtaPdMF/+73ebkZg7v/Jqh7LRVIzU8x+HsnBp
 kTXpJfelmCMvvRdN+e4kvXdMhmqmbh57O/JOh/KekpeYardyWDdN0JN5jq7r4Iet0jbH
 wiUg==
X-Gm-Message-State: AC+VfDxum2sN2RSzUt6jB+LqHYual4CDnOjbVnPDRVwljfIadgQqR8Mz
 n9CXsnglnUCSwWeNBXZewgGTnnwsQG9HyEBAvaEs36+oQBSHcDlakpKg+mxOc0/75RbdXhzzsrp
 k69T7i1786xj1x4Y+rHZNMVo=
X-Received: by 2002:a05:600c:21d6:b0:3fb:b400:8443 with SMTP id
 x22-20020a05600c21d600b003fbb4008443mr9989781wmj.36.1688455926007; 
 Tue, 04 Jul 2023 00:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NsgYRHUHoGytu26YMSMqOjlQu7e3DywGS/NHhT4pZEcWwPotHMscZJsAfXiHs0wNrC2BdPw==
X-Received: by 2002:a05:600c:21d6:b0:3fb:b400:8443 with SMTP id
 x22-20020a05600c21d600b003fbb4008443mr9989764wmj.36.1688455925652; 
 Tue, 04 Jul 2023 00:32:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a7bcd89000000b003fbb5506e54sm15747766wmj.29.2023.07.04.00.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:32:05 -0700 (PDT)
Message-ID: <e53ccd03-1109-7868-4302-6e578aa503c8@redhat.com>
Date: Tue, 4 Jul 2023 09:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/12] linux-user: elfload: Add more initial s390x PSW bits
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> Make the PSW look more similar to the real s390x userspace PSW.
> Except for being there, the newly added bits should not affect the
> userspace code execution.

What's the purpose of this then? Required for follow-up patches?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 6900974c373..7935110bff4 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1635,7 +1635,9 @@ const char *elf_hwcap_str(uint32_t bit)
>   static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
>   {
>       regs->psw.addr = infop->entry;
> -    regs->psw.mask = PSW_MASK_64 | PSW_MASK_32;
> +    regs->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | \
> +                     PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 | \
> +                     PSW_MASK_32;
>       regs->gprs[15] = infop->start_stack;
>   }
>   

-- 
Cheers,

David / dhildenb


