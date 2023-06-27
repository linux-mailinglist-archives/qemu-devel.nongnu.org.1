Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A154873F724
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE43V-0002zN-9u; Tue, 27 Jun 2023 04:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE43T-0002z9-Gq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE43R-0000G1-S0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687854485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaxriD1wMKs7jG2C1Yg/WaZMQedWls7gERTmwR4gzv0=;
 b=J1aZrn/fXyVWsHxxyo2txElEmV4b1needD+/2AlveMGAO3Zjy+bJMbqFyhSSPnYcRxI2x8
 wdizuaSxlzSFkZUpXqGPKq1NUi1RJE6+/fusIv/3Mldwpvrcu+QSwEIPmsdpMSQLyzQX7p
 9rOYJfmyuCL9v2NKK/9I47ueQSzfR40=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-XF0qeKYRMGKDTIYcaoisFg-1; Tue, 27 Jun 2023 04:28:03 -0400
X-MC-Unique: XF0qeKYRMGKDTIYcaoisFg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9835bf83157so274305366b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687854482; x=1690446482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaxriD1wMKs7jG2C1Yg/WaZMQedWls7gERTmwR4gzv0=;
 b=BPZvTE3gEQDhGNHkAAMOJOYREmfHM5QzFL+CnmJSwC4ayX9MJ5eNa2WT4NKNzhWKSD
 GQjJUuL7RCB3s2IZctskRrX6R9mPjRGooWGBRx8dcgXEqhRq9mzGy57D2h1u8nIzldn9
 if/DK2EDjl1HD9hxnvBJreHG6WCNNjsNjKSTxqGug1Gi8kHUWdHdY6ESb/y/rmpBxKyO
 hp2Wdm+UN0oO7+wXEdAFQUn/FOIMfoqqBEHyGEtILHS+bMtYS2RIjg+QH+FJPnX/qD2A
 zt0E63MEXwzRvs5jOU9JBRy+ipdddbTTcaetACEuXIPbmP19khm+DjCcfocWFg6Zit/2
 rU4g==
X-Gm-Message-State: AC+VfDwWFSk35ujZCGuL5rZ0CuyA8Aif9nTJtJ7Dmoct+CctsT6g3HKJ
 o0JpxxWIV0nxxCMix/8Cfg4OA0txh0HL2ztThb1hDd6IBDulmYDvgYVIAvFPsL7eP5In8c9c6bH
 4s5uHw6aXVAwXiR0=
X-Received: by 2002:a17:906:ef0e:b0:978:adad:fe18 with SMTP id
 f14-20020a170906ef0e00b00978adadfe18mr25237635ejs.21.1687854481882; 
 Tue, 27 Jun 2023 01:28:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oVjHKM+y7QZ+vCj4jRWiqskMevxzi14KcWzfhAp+EO7YL1Nw8gXKbrxzdjHTvS7+eKN3E0g==
X-Received: by 2002:a17:906:ef0e:b0:978:adad:fe18 with SMTP id
 f14-20020a170906ef0e00b00978adadfe18mr25237619ejs.21.1687854481616; 
 Tue, 27 Jun 2023 01:28:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ox27-20020a170907101b00b00988e81e1638sm4285934ejb.92.2023.06.27.01.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:28:01 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:28:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 1/7] target/i386: Add FEAT_7_1_EDX to adjust feature level
Message-ID: <20230627102800.25333ca8@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZJplJ+feTMppRWt3@linux.bj.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-2-tao1.su@linux.intel.com>
 <20230626143915.34d5712b@imammedo.users.ipa.redhat.com>
 <ZJplJ+feTMppRWt3@linux.bj.intel.com>
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

On Tue, 27 Jun 2023 12:27:19 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> On Mon, Jun 26, 2023 at 02:39:15PM +0200, Igor Mammedov wrote:
> > On Fri, 16 Jun 2023 11:23:05 +0800
> > Tao Su <tao1.su@linux.intel.com> wrote:
> >   
> > > Considering the case of FEAT_7_1_EAX being 0 and FEAT_7_1_EDX being
> > > non-zero,  
> > Can you clarify when/why that happens?  
> 
> When start a VM on GraniteRapids using '-cpu host', we can see two leafs CPUID_7_0
> and CPUID_7_1 in VM, because both CPUID_7_1_EAX and CPUID_7_1_EDX have non-zero value:
> 0x00000007 0x01: eax=0x00201c30 edx=0x00004000
> 
> But if we minus all FEAT_7_1_EAX features using
> '-cpu host,-avx-vnni,-avx512-bf16,-fzrm,-fsrs,-fsrc,-amx-fp16', we can't get CPUID_7_1
> leaf even though CPUID_7_1_EDX has non-zero value, so it is necessary to update
> cpuid_level_func7 by CPUID_7_1_EDX.

Pls, explain that in commit message.
 
> Thanks,
> Tao
> 
> >   
> > > guest may report wrong maximum number sub-leaves in leaf
> > > 07H. So add FEAT_7_1_EDX to adjust feature level.
> > > 
> > > Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID
> > > enumeration")
> > > 
> > > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > >  target/i386/cpu.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 1242bd541a..e8a70c35d2 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -6778,6 +6778,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
> > > +        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);  
> > 
> >   
> 


