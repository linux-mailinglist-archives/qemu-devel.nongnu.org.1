Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882273F7C2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4OA-0000Kv-B2; Tue, 27 Jun 2023 04:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4O7-0000KQ-KL
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4O6-0006Xr-0Q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687855765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5mVdOoeYXIvQeqbhxL1c/b6l61NRusvAL31vzLjCrw=;
 b=LIvKN7Bt7A8c7y+s2qhtwZ0CgEAbeIdmNNFN2wKNRltGSPzkvwJinBcij2DukxzjtHSa6G
 Te/EjMkWty48SRzH2NMbRl/r1CPBPEYP/nh9YO8ZwtIrWN0EVpGuyhjkCqE6lo7r8MoVtl
 AciVKwegJ9oadMsUgWS11fCULQ76zHI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-ZWn-6NTIPB-_xeZp5oSDEw-1; Tue, 27 Jun 2023 04:49:21 -0400
X-MC-Unique: ZWn-6NTIPB-_xeZp5oSDEw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98890dda439so276767266b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687855760; x=1690447760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5mVdOoeYXIvQeqbhxL1c/b6l61NRusvAL31vzLjCrw=;
 b=h0MDcPCVHKhj/4ejiApdhcQ8JjRuAEFbAfGgFkHOnudHLh+3W7QWLmwJSEtHopewzs
 UShsSEW8rtFyrfpRuWUXvDFCefbAR+VzfWv1HRPLDwr99vQXZxf4tCHqnEFeikLJA0xn
 HmX14KwD3BAJ2OvPPTyCT3Tv2OnQsohcFDppIBgbwLFa2CaJ6wfXqsIDJuEuvxvI1FLU
 ySRLigWqG8Zr9j9BYR9K13/oVhCpO9S4U86pk+Q9FgZx3DQmBM4cRbjKSf5vz0uUXb20
 uWD92jzBIY/lOFD1SmkwMU95owPKpoPv/RLyjAJ0buXWyRq4GpfuiG1lacbJkXg1DPBQ
 ZA/g==
X-Gm-Message-State: AC+VfDzo9eg33QJT4iQuKowEWujHxMd1RDcHO7ezGC0KqTpzh6NqPmED
 Tfmoi+0PWi+hkzRIlZykyay+w0b5hpSB9o/8jS16SncL5/TSFmVGcfJLj+mlRnlvXqxDrteDoAb
 6/ssU2gm5dyzs/dU=
X-Received: by 2002:a17:907:928a:b0:988:c3f9:3ad6 with SMTP id
 bw10-20020a170907928a00b00988c3f93ad6mr20752240ejc.42.1687855760633; 
 Tue, 27 Jun 2023 01:49:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79FDqTtWaRk+iADYA1vt7+EaBjyKJNJeqPQG9GENxQuOsQ6bextc8mbf6qY/ocaKEBxEWg8g==
X-Received: by 2002:a17:907:928a:b0:988:c3f9:3ad6 with SMTP id
 bw10-20020a170907928a00b00988c3f93ad6mr20752227ejc.42.1687855760315; 
 Tue, 27 Jun 2023 01:49:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r18-20020a170906c29200b0098d295d5908sm4236718ejz.46.2023.06.27.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:49:19 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:49:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 6/7] target/i386: Add new CPU model EmeraldRapids
Message-ID: <20230627104918.1a2152c6@imammedo.users.ipa.redhat.com>
In-Reply-To: <c18ebbaf-0ea8-3cd5-9fb8-6e63add59fba@intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-7-tao1.su@linux.intel.com>
 <20230626145610.64405831@imammedo.users.ipa.redhat.com>
 <c18ebbaf-0ea8-3cd5-9fb8-6e63add59fba@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 27 Jun 2023 13:54:23 +0800
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 6/26/2023 8:56 PM, Igor Mammedov wrote:
> > On Fri, 16 Jun 2023 11:23:10 +0800
> > Tao Su<tao1.su@linux.intel.com>  wrote:
> >   
> >> From: Qian Wen<qian.wen@intel.com>
> >>
> >> Emerald Rapids (EMR) is the next generation of Xeon server processor
> >> after Sapphire Rapids (SPR).
> >>
> >> Currently, regarding the feature set that can be exposed to guest, there
> >> isn't any one new comparing with SPR cpu model, except that EMR has a
> >> different model number.
> >>
> >> Though it's practicable to define EMR as an alias of a new version of
> >> SPR by only updating the model number and model name, it loses the
> >> flexibility when new version of EMR cpu model are needed for adding new
> >> features (that hasn't virtalized/supported by KVM yet).  
> > Which begs a question, why do we need EMR model (or alias) at all
> > if it's the same as SPR at the moment.
> > 
> > Make new features supported 1st and only then introduce a new CPU model.
> >   
> 
> Even if no new feature (that can be virtualized and exposed to guest) in 
> EMR compared to SPR in the end, I think it still makes sense to provide 
> a dedicated EMR CPU model in QEMU. Because
> 1) User will know EMR, Intel's next generation of Xeon after SRP, is 
> supported by QEMU, via -cpu ?/ -cpu help;

I don't see any benefits in misleading user by showing EMR model which is
nothing else but SPR one.
On negative side you would increase maintenance burden by introducing
extra versions of CPU model later. Which by itself is abusing versioning,
mainly used for fixing CPU bugs, by using it for adding new features.

> 2) It's convenient for user to create an EMR VM. People may not care 
> that much what the difference between "-cpu SapphireRapids" with "-cpu 
> EmeraldRapids", while they do want to create an VM which shows the CPU 
> is EmeraldRapids.
>
My guess would be is that you need guest to show EMR for developing EMR
features/guest bringup, in that case do it in your fork, and once
support is actually ready publish completed patches for it.

To exaggerate you reasoning further, we should create CPU models for
all future planned Intel/AMD CPU as a one of currently existing in
QEMU right now and then sometime in future implement features that
actually make those models what they should be.

It's downright confusing for user, so I'd object to this approach.


