Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AE73F739
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE44z-0003en-3B; Tue, 27 Jun 2023 04:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE44w-0003eW-Nl
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE44v-0000Vh-B4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687854576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeqsP/brBKhrE+ocxnW3pdGoVSRZRSoAzIjjXyd7D4I=;
 b=M5tYT3HE4VFa2ssi6ELRiPEqIb2QnxcUn45QQnd7c6deWteNi/lM7dt8S4WnXJN7EKCG8U
 /ewKfd6mspYxKidxtrcq4NnsRoazHEkVIPQ7TwJ2Y6sRF5gWMwyI0ypALSlcEg7oHsrdwX
 gq6FQQzDBStq6cRp7iqEatsmctyNrV8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-zQTfkFn3NjeWeNK_k2WTVA-1; Tue, 27 Jun 2023 04:29:34 -0400
X-MC-Unique: zQTfkFn3NjeWeNK_k2WTVA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-988643252e0so315802566b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687854573; x=1690446573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeqsP/brBKhrE+ocxnW3pdGoVSRZRSoAzIjjXyd7D4I=;
 b=f+faKtCjzUDTA08ye6ZkJonztoTwYbn+/yByTClLSKGFQGGOwA6dIP0kCVmh5MF0nY
 itv47qSPNqXkgYpSV0Lw/w9itnjZeVFSb/GTva7caZZjhLXjG7/+gIAKH2j4CQ0Uh3qx
 +6Fxy3/bf70XR2Pceo4I/URZJoKcHy9w1nx8hNoVH3JFxvPGZjrcDkKYUzLBOPo8IrqC
 C3Rwikz/CCecPFPYNMkUAdHwk9wivrSYLRPLXB9rEA5Ku1qYAZ5mUDYQUA0kw6+Ho5by
 ziP03WbaBxT20QEnMvKP4NV2Qi63xuf7nycyleW4bEZKvUI7ywDXFcUSJcMhXeNhLrnV
 hrLA==
X-Gm-Message-State: AC+VfDyP24ES978AVU0b/D0IQoSLEUGx3g5gJ3bwxVBNbTgtIS+dlWLl
 9ySwJPT7esENiTLJuOp5fjGJT4tLP465Hcjyf86pvXOqHYlSqZ/ZSzKyrzujPuRF96q7VPQhuPL
 77stm3J8R//1rCkM=
X-Received: by 2002:a17:906:55d4:b0:98e:a451:fac3 with SMTP id
 z20-20020a17090655d400b0098ea451fac3mr4557557ejp.42.1687854573782; 
 Tue, 27 Jun 2023 01:29:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Od/OW6GvzU/WG3o/l3dbP8MLeSJnbQBSb1SazMc62rt2acTI0RuGZJre0GO8F2Rm7izZyhw==
X-Received: by 2002:a17:906:55d4:b0:98e:a451:fac3 with SMTP id
 z20-20020a17090655d400b0098ea451fac3mr4557550ejp.42.1687854573480; 
 Tue, 27 Jun 2023 01:29:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f11-20020a170906084b00b00991e019207esm1665678ejd.55.2023.06.27.01.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:29:32 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:29:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 5/7] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Message-ID: <20230627102932.2a822b84@imammedo.users.ipa.redhat.com>
In-Reply-To: <f4b9bb58-a7d6-a02f-a307-450f3e630b3a@intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-6-tao1.su@linux.intel.com>
 <20230626151530.24524700@imammedo.users.ipa.redhat.com>
 <f4b9bb58-a7d6-a02f-a307-450f3e630b3a@intel.com>
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

On Tue, 27 Jun 2023 14:10:17 +0800
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 6/26/2023 9:15 PM, Igor Mammedov wrote:
> > On Fri, 16 Jun 2023 11:23:09 +0800
> > Tao Su <tao1.su@linux.intel.com> wrote:
> >   
> >> From: Lei Wang <lei4.wang@intel.com>
> >>
> >> Latest stepping (8) of SapphireRapids has bit 13, 14 and 15 of
> >> MSR_IA32_ARCH_CAPABILITIES enabled, which are related to some security
> >> fixes.
> >>
> >> Add version 2 of SapphireRapids CPU model with those bits enabled also.  
> > 
> > don't we need to update stepping value to 8 as well?  
> 
> No need.
> 
> The commit message is misleading. There 3 bits and some other bits in 
> MSR_IA32_ARCH_CAPABILITIES are not tied to CPU stepping. Instead, they 
> are enumerated with newer microcode.

It that case fix commit message please.

> 
> >>
> >> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> >> ---
> >>   target/i386/cpu.c | 13 +++++++++++--
> >>   1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index b5321240c6..f84fd20bb1 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -3854,8 +3854,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
> >>           .model_id = "Intel Xeon Processor (SapphireRapids)",
> >>           .versions = (X86CPUVersionDefinition[]) {
> >>               { .version = 1 },
> >> -            { /* end of list */ },
> >> -        },
> >> +            {
> >> +                .version = 2,
> >> +                .props = (PropValue[]) {
> >> +                    { "sbdr-ssdp-no", "on" },
> >> +                    { "fbsdp-no", "on" },
> >> +                    { "psdp-no", "on" },
> >> +                    { /* end of list */ }
> >> +                }
> >> +            },
> >> +            { /* end of list */ }
> >> +        }
> >>       },
> >>       {
> >>           .name = "Denverton",  
> >   
> 


