Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71973E015
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlsY-0004bw-63; Mon, 26 Jun 2023 09:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDlsW-0004aZ-HW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDlsV-00037o-0h
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687784613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+RU+QPMTya6mZlsM4fOL9s/KYkYqxCrCrM/V7BRIGE=;
 b=atFDVJjPJylC91sNXRlYjaYnYbvXKs3FsPiKqQaO6T0BqlM9pH9zdzLwintdXsmY6dsv53
 78PYbVuJpTk6sDnhXDUAFEs4DQ+5mS6izmkmamTyALd5X3GYoo1/35gTuZZy+X0Wx+PdNw
 aUVF/1UxD9mgqII0Oc/qQcDz3cpjeJ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Iarw1cpjPkWh8r9SMdHQZQ-1; Mon, 26 Jun 2023 09:03:31 -0400
X-MC-Unique: Iarw1cpjPkWh8r9SMdHQZQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98277fac2a1so236310766b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687784594; x=1690376594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+RU+QPMTya6mZlsM4fOL9s/KYkYqxCrCrM/V7BRIGE=;
 b=AZortqRYJa26dD+52Q/N/LIPw5fTgeSyydZAWzxhsHewnFtRzLooKeO+SU56BP+avH
 ZWuRwn8MdUk8AgexffRNZp1IDQqj9bsuBOQ8Lg23X7aJoVQCBlTbzVS44dUFZWPC3n7P
 dTE96T6wz1iMZ3h3RYv8vGkVTxe3v3R+86tqpj6AgleU43Ra+RwgIKZlP9KViHn/K7du
 WvjkC/ISBsrIIVwzTQwKiIqBQsrJEZ41NSjJIw4caE87eiYu2ler0BKEmUJHX8EYHu5g
 FkRI3ALmgIRt/NZvb6wumX1h+FtIIvBmY8SUwDFgSICDHjUstyTU0zij+1kYZakFDsS8
 2rQw==
X-Gm-Message-State: AC+VfDxJ+o4do4euH3mmxbIdyxd4484kM1SyQGVBJmFDIG2l64kmqRkz
 Iy3/4oi6AcgYuL6VlHuu4vnZWtIf/c6uNm8Gavrg/LjtpbGa+NR8T4vdBuGh5nu8wyo/hMNQShh
 OiC0i/3cu9BSRSspuAWoutVQ=
X-Received: by 2002:a17:906:d965:b0:98d:9d91:a063 with SMTP id
 rp5-20020a170906d96500b0098d9d91a063mr6575934ejb.9.1687784594062; 
 Mon, 26 Jun 2023 06:03:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NhED+3b5oXEiFwXO2Djl3P4W4ZYX8jRMB2chgNNm7PGMu7vb8ZzIu2ijDOvQ6SSR6u4njOA==
X-Received: by 2002:a17:906:d965:b0:98d:9d91:a063 with SMTP id
 rp5-20020a170906d96500b0098d9d91a063mr6575912ejb.9.1687784593562; 
 Mon, 26 Jun 2023 06:03:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 oz39-20020a170906cd2700b00988b2050f47sm3235667ejb.20.2023.06.26.06.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:03:13 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:03:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 3/7] target/i386: Allow MCDT_NO if host supports
Message-ID: <20230626150312.5edefe7b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230616032311.19137-4-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-4-tao1.su@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Jun 2023 11:23:07 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> MCDT_NO bit indicates HW contains the security fix and doesn't need to
> be mitigated to avoid data-dependent behaviour for certain instructions.
> It needs no hypervisor support. Treat it as supported regardless of what
> KVM reports.
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/kvm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index de531842f6..4defd8b479 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -432,6 +432,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          uint32_t eax;
>          host_cpuid(7, 1, &eax, &unused, &unused, &unused);
>          ret |= eax & (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC);
> +    } else if (function == 7 && index == 2 && reg == R_EDX) {

> +        /* Not new instructions, just an optimization.  */
comment doesn't make much sense to me, just drop it or
describe what MCDT_NO is/mitigates.

> +        uint32_t edx;
> +        host_cpuid(7, 2, &unused, &unused, &unused, &edx);
> +        ret |= edx & CPUID_7_2_EDX_MCDT_NO;
>      } else if (function == 0xd && index == 0 &&
>                 (reg == R_EAX || reg == R_EDX)) {
>          /*


