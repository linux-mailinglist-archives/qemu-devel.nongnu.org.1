Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB17F7363
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:05:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UvQ-0006jt-B2; Fri, 24 Nov 2023 07:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6UvL-0006bZ-85
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6UvJ-0007y7-2v
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700827479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eBNzZF9B5EoGQS4Gocw933h7EYJ+MZzRFH5dERGUGM=;
 b=dloPxFyLZ0Ho/q9Vv8kgiRTtE+P0utp2Je4anhU4vCFZnoAS1LimKu3Nf054iT5hbQIHre
 m1PgtNpvdCGYOiT+0JI1SB0LcqfSvlMFQr0kmla2rSZKF0jXZyD3PKHvReoydVBd8q0Qya
 dNBUoczok9D+az7G3fzCvmFkjIUBt+U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-5trj7cOTOUm9WWRmy8jbBg-1; Fri, 24 Nov 2023 07:04:38 -0500
X-MC-Unique: 5trj7cOTOUm9WWRmy8jbBg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a01783d1ab7so122751166b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827476; x=1701432276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eBNzZF9B5EoGQS4Gocw933h7EYJ+MZzRFH5dERGUGM=;
 b=kAKU8AFnmWEx+1t/Q5WYGwKT2ikluKTIONjb1VWHsTKavma73SKFklVPTrGJ40RL/d
 V7ijHI/KhdaRVxcFH0VDhr0rOu09OK1nlLRzt+NNzk8UcfDpyd/Qh39Vek5RhL1Q4Ock
 nwYWpYAbKRosyQZACVWr178a0/V0B4VPHqtpTLd415I4jsvQNwNLgjwFPsLbOCaAx0fD
 0eevOn17/B59FptoH93bEx5Y/+ht56wyA4EuCRJAnYkAJLj2TK4mXYFIbmZPNqoiJMke
 H7ya4Dn2SKWLqqpai2WreDNF22YguK7SD9+MyGAteyfs9fyNU2z5JTYKjcZjTAgZGMSS
 TAyg==
X-Gm-Message-State: AOJu0YzLeei7F8pJjAf9IiebR6S4yQm4QOudv8sCMg77SFW+nqbuJP8q
 D14YrZekuqWy7783Q1pRQA80BnraOkp5ufV5SFjNNEUQA+mChrLorchCTOOVvl46w9QFLLKsEZZ
 +kSyfjxapa20fKFc=
X-Received: by 2002:a17:906:da0c:b0:a03:1bf0:2b92 with SMTP id
 fi12-20020a170906da0c00b00a031bf02b92mr1890700ejb.41.1700827476357; 
 Fri, 24 Nov 2023 04:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSBqxYKtBtaufB8rg5gzKiMKzPYdQdcQfhPDWu9V7cH9DMzVqqlejvQi64taY7CxuiKbZSbg==
X-Received: by 2002:a17:906:da0c:b0:a03:1bf0:2b92 with SMTP id
 fi12-20020a170906da0c00b00a031bf02b92mr1890678ejb.41.1700827476003; 
 Fri, 24 Nov 2023 04:04:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 n27-20020a170906089b00b009fe0902961bsm1976493eje.23.2023.11.24.04.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 04:04:35 -0800 (PST)
Date: Fri, 24 Nov 2023 13:04:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, David Woodhouse
 <dwmw@amazon.co.uk>, Stefano Stabellini <sstabellini@kernel.org>, Julien
 Grall <julien@xen.org>, Oleksandr Tyshchenko
 <Oleksandr_Tyshchenko@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 5/6] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Message-ID: <20231124130434.057951b6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231121221023.419901-6-volodymyr_babchuk@epam.com>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-6-volodymyr_babchuk@epam.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Tue, 21 Nov 2023 22:10:28 +0000
Volodymyr Babchuk <Volodymyr_Babchuk@epam.com> wrote:

Probably typo in 'subj'

   mc->max_cpus

is limit on maximum supported vCPUs and it shouldn't be set
by xen_arm_init()

patch itself though does the right thing by setting it
in xen_arm_machine_class_init()

Also below explanation, while valid is not the reason for
increasing mc->max_cpus.

Reason could be as simple as 
   'increase max vCPU limit for FOO machine to XXX'

otherwise machine creation would be aborted early by generic code
with error '...'
see machine_parse_smp_config()


> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The number of vCPUs used for the IOREQ configuration (machine->smp.cpus)
> should really match the system value as for each vCPU we setup a dedicated
> evtchn for the communication with Xen at the runtime. This is needed
> for the IOREQ to be properly configured and work if the involved domain
> has more than one vCPU assigned.
> 
> Set the number of current supported guest vCPUs here (128) which is
> defined in public header arch-arm.h. And the toolstack should then
> pass max_vcpus using "-smp" arg.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  hw/arm/xen_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index a5631529d0..b9c3ae14b6 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -231,7 +231,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>      mc->desc = "Xen Para-virtualized PC";
>      mc->init = xen_arm_init;
> -    mc->max_cpus = 1;
> +    mc->max_cpus = GUEST_MAX_VCPUS;
>      mc->default_machine_opts = "accel=xen";
>      /* Set explicitly here to make sure that real ram_size is passed */
>      mc->default_ram_size = 0;


