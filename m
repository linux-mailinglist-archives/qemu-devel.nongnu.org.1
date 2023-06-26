Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC573E043
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm1v-0000vi-Nr; Mon, 26 Jun 2023 09:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm1u-0000vZ-0b
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm1s-0004qi-If
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c18VvZClOMxUTCVnLHwr5LCTO0jbgIld5XZeXQeMff0=;
 b=A61f/h52PPKv56ApxIo3n9w2h/umRxFddTOsXJ33djc73afgM9GKXQgZ8hibYaYqqNafVs
 15gVaxBsAfVx2xGKiRXTdtdH5nY69j+oSnrYAE3abLo/wxz0M1RK5c/KcdrNPUFHokRhWW
 SJs6pdqkplHkjWfj15FX01cYcgKcB1k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-L41AESxdNhe2Q3m8btzrtg-1; Mon, 26 Jun 2023 09:13:14 -0400
X-MC-Unique: L41AESxdNhe2Q3m8btzrtg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9715654aba1so365994366b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785172; x=1690377172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c18VvZClOMxUTCVnLHwr5LCTO0jbgIld5XZeXQeMff0=;
 b=AYMU4oWAA9n99TnV+wJR4ksQQkypHCxflUQQMOumS83LtaAVaWZv8RGUp7XRbdLZTs
 6PPoQMDGprrGqitzoBnlcXZJd4jrQryXXWEEA73AeZpwe94y9zYJC0q62x0CTHvlqbPJ
 IZiZawjw6yABr0+aDmEd/ZcWlaJdpLol1hcFvXGLSPPh8BZDZeYOeooR9U0JaYTQ2K7+
 trLS64lTWXn3InmZMaJrbiJ9OyjZFPyN0W7wsi8HvKtflYyna7xfvBC0wbB6CFehfYFJ
 ntC+3/r2WsvDl5aYvQfQByVf2kPhnhMKMHOTF9svVmnS/jwUSRGVRACDNLcc4xGMAZ8Y
 eNfw==
X-Gm-Message-State: AC+VfDxCgom5sxGvniJdK12KxqSYcEs8q3qgE83pSqYgTfR+Dgld/y25
 eOHrI4+2h5wUXsJmh+4oc0H1P706Me0spijniMiy8mMxG9I0b8vs/+3XbpzUzwHNERBYi4NfiQG
 svJjKRzuWs3AAkVe88OqsoXs=
X-Received: by 2002:a17:906:2e8f:b0:991:d883:3df9 with SMTP id
 o15-20020a1709062e8f00b00991d8833df9mr1370028eji.21.1687785172728; 
 Mon, 26 Jun 2023 06:12:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/1m7zs27M2rfieHflqe6lY6vIFsjB3MNbp9yMYjPyl6U2pfbGMhZfzw1jNOGn6ESv4KzoYw==
X-Received: by 2002:a17:906:2e8f:b0:991:d883:3df9 with SMTP id
 o15-20020a1709062e8f00b00991d8833df9mr1370007eji.21.1687785172438; 
 Mon, 26 Jun 2023 06:12:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 kg1-20020a17090776e100b0098e2eaec395sm2179878ejc.130.2023.06.26.06.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:12:51 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:12:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 4/7] target/i386: Add new bit definitions of
 MSR_IA32_ARCH_CAPABILITIES
Message-ID: <20230626151251.4f3083ad@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230616032311.19137-5-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-5-tao1.su@linux.intel.com>
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

On Fri, 16 Jun 2023 11:23:08 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> Currently, bit 13, 14, 15 and 24 of MSR_IA32_ARCH_CAPABILITIES are
> disclosed for fixing security issues, so add those bit definitions
> and feature names.
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 4 ++--
>  target/i386/cpu.h | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7898a4c79a..b5321240c6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1069,10 +1069,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
>              "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
>              "taa-no", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
>              NULL, "fb-clear", NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "pbrsb-no", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>          },
>          .msr = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 64d50acf41..6221b1c0a4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1022,7 +1022,11 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>  #define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
>  #define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
>  #define MSR_ARCH_CAP_TAA_NO             (1U << 8)
> +#define MSR_ARCH_CAP_SBDR_SSDP_NO       (1u << 13)
> +#define MSR_ARCH_CAP_FBSDP_NO           (1u << 14)
> +#define MSR_ARCH_CAP_PSDP_NO            (1u << 15)
>  #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
> +#define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
>  
>  #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
>  


