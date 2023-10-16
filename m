Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680367CB027
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQlY-0006gP-RV; Mon, 16 Oct 2023 12:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQlX-0006c0-0Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQlV-00061r-Af
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697474904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZKCcHTisSOd8tU05g/K5DaFqAFFyopsJNZDP8Kxz88=;
 b=RBY6CffnZFlIrw9k1gntJ+hFPsfMOzrhCy7OgatRYZA1yJyld+IzHYh89NolMArR2GETB6
 4YFLe7t1s9DuIWQ2kj/2Jd/ylj5OrKZT9NUVBZuQpxbkSP57bI2Falh9FQdswyMNT+32zZ
 WOmJPjE5BwaUmj5sh9eto+xq9YkNsTs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-aa7sNMDLN0y6HncTtUd6Ew-1; Mon, 16 Oct 2023 12:48:12 -0400
X-MC-Unique: aa7sNMDLN0y6HncTtUd6Ew-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65623d0075aso11198406d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474892; x=1698079692;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZKCcHTisSOd8tU05g/K5DaFqAFFyopsJNZDP8Kxz88=;
 b=rI9FDheqjKWMQ/hln31x1jjCwGk3RiDLeVvennX9k2I7KjqvbWzlGMV29PadF1CgzZ
 1o/kQBdTtBX+JX7Kji8AWCpo+W2DDcebsWP5Kdvkm2WaMhXvRlUx49sKMVVAog5dPdEM
 p11k9Cc3sPKFNkIxmzVw3JLn6k3TxpMuvdyrpjpwata5WMSFEfAoVLTz5LsF1AdYiIuP
 UQJhxKec3pbtwJx4iKb18yzTFf2ase7ZNShSsKWl3FD6hOGWRlF+Uu7bSPzF6DyJI5qu
 1IXGzUAyARslp1vVMgD1cjDwbkJUMYYjrUuuxM85bA7BqOwL58WexTpSGDgAgYBkjqvk
 NMgA==
X-Gm-Message-State: AOJu0Yzt3r3EFuUw/+1CyeWzfwb6P+Ocp7EnebH6+XLLQJ7Y77HmNDoJ
 a5BCZC2VcFiqY6Joh+oikzZ3mMyqeXX7LhPHgOnhTLzL5ploI+cgZBTJyWPYS9UWuPkHD2IcGvM
 cJDw5xEQCCSroObg=
X-Received: by 2002:a05:6214:c3:b0:66d:264c:450f with SMTP id
 f3-20020a05621400c300b0066d264c450fmr43433qvs.0.1697474891935; 
 Mon, 16 Oct 2023 09:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8p0I3Nv1lvT5F5Qsho7KfC2lSr4vhvSxiIW8YJHkekX9eXA+MeC9M+Jzndhq8mcbz/Pd9Jw==
X-Received: by 2002:a05:6214:c3:b0:66d:264c:450f with SMTP id
 f3-20020a05621400c300b0066d264c450fmr43417qvs.0.1697474891602; 
 Mon, 16 Oct 2023 09:48:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t5-20020a05620a004500b007678973eaa1sm3135999qkt.127.2023.10.16.09.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 09:48:11 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:48:09 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Message-ID: <ZS1pSeL3hj4/73lk@x1n>
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013150839.867164-3-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 13, 2023 at 03:08:39PM +0000, “William Roche wrote:
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 5e95c496bb..e8db6380c1 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> -            kvm_hwpoison_page_add(ram_addr);
>              /*
>               * If this is a BUS_MCEERR_AR, we know we have been called
>               * synchronously from the vCPU thread, so we can easily
> @@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               * called synchronously from the vCPU thread, or a bit
>               * later from the main thread, so doing the injection of
>               * the error would be more complicated.
> +             * In this case, BUS_MCEERR_AO errors are unknown from the
> +             * guest, and we will prevent migration as long as this
> +             * poisoned page hasn't generated a BUS_MCEERR_AR error
> +             * that the guest takes into account.
>               */
> +            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));

I'm curious why ARM doesn't forward this event to guest even if it's AO.
X86 does it, and makes more sense to me.  Not familiar with arm, do you
know the reason?

I think this patch needs review from ARM and/or KVM side.  Do you want to
have the 1st patch merged, or rather wait for the whole set?

Another thing to mention: feel free to look at a recent addition of ioctl
from userfault, where it can inject poisoned ptes:

https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com

I'm wondering if that'll be helpful to qemu too, where we can migrate
hwpoison_page_list and enforce the poisoning on dest.  Then even for AO
when accessed by guest it'll generated another MCE on dest.

>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
>                  if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {

-- 
Peter Xu


