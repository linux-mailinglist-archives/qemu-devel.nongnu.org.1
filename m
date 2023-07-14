Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9875427F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNQk-0005dM-KM; Fri, 14 Jul 2023 14:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qKNQh-0005ca-FX
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qKNQf-0005uv-RV
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689358926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+ft7m9s37hv9i3QAFyrjiJCCvWdjKRNknZ1AUWG7XE=;
 b=FuKdlqIJtkNwSZW8nqx8szvAuY0Gy3V2uWFY4NpWNaCbJolZvnIQIYSGG9M6aKIKE2qRkJ
 mehXvHytXJNU2HHjN/e/m3MM+3QhFO7Tw91aWHMQRZ007I0pPC3FUPg82Auu+IXsQEfdQC
 KWrn4RhPbijyolHMZA26DWxrh0z7bWg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-31iIOhP7M7qa7payRe6YMQ-1; Fri, 14 Jul 2023 14:22:04 -0400
X-MC-Unique: 31iIOhP7M7qa7payRe6YMQ-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3463fbf2ffeso11411245ab.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689358923; x=1691950923;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+ft7m9s37hv9i3QAFyrjiJCCvWdjKRNknZ1AUWG7XE=;
 b=ACP9eGT5oIIs8FFnmjMDZIWhqwD9HsnTZuxg638KlC/Ve4kvH7vQp8tfvbmRJzZiDN
 Y2o2n13TJBshla8Hj93STD6PjI8xOD2xrkrAzyQ8Y6k0thartDAUJyBYKMq29J2z92vi
 xQIEbsKZoHUVK4YUsFsRXhhtXVq1bRjlR90gYGHWNF2eF9exJHWk0SSqsZi5Renh5tES
 sOqXUwX3lRx7CZGobNNQTAbkf9jIkQ6ZzbQezrdXEoLzv22aOeydWWLoxkIX0hiSKwmq
 2kW6ucX6WnCGV9Dd1QcyHF4hk+XtolUM/6Co1J0TvpH34c2BAFTi9s7PpUEEA3K5o14E
 aLEQ==
X-Gm-Message-State: ABy/qLYd+RjXAhVSmPXlBm1Cyx5IRCO6BzYQ2aNtyGVumpIQORpItVLw
 B1DgkZbBNdc1uG/BZnObfo5e9OwydwJAhomRNS1Jw06Dd0IhXq6HLMTA3zR+yJhxY+KvbSK3VkZ
 d0WBuiTv/J6SYC2g=
X-Received: by 2002:a05:6e02:2183:b0:348:76eb:17d9 with SMTP id
 j3-20020a056e02218300b0034876eb17d9mr54328ila.20.1689358923531; 
 Fri, 14 Jul 2023 11:22:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+0w9kg8R6rQDSIzBI6WAfCQSswo6IbDamOYlunarjP2YlcMklz2+kgrngnGfR7IUUeYZXuA==
X-Received: by 2002:a05:6e02:2183:b0:348:76eb:17d9 with SMTP id
 j3-20020a056e02218300b0034876eb17d9mr54318ila.20.1689358923326; 
 Fri, 14 Jul 2023 11:22:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 g15-20020a05663811cf00b0042b14d9be7bsm2827154jas.22.2023.07.14.11.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 11:22:02 -0700 (PDT)
Date: Fri, 14 Jul 2023 12:22:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] treewide: spelling fixes in comments and some strings
Message-ID: <20230714122201.3b118f40.alex.williamson@redhat.com>
In-Reply-To: <20230714113834.1186117-3-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-3-mjt@tls.msk.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Fri, 14 Jul 2023 14:38:06 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index d8aeee0b7e..12e7790cf6 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -39,7 +39,7 @@ static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
>  void spapr_phb_vfio_reset(DeviceState *qdev)
>  {
>      /*
> -     * The PE might be in frozen state. To reenable the EEH
> +     * The PE might be in frozen state. To re-enable the EEH
>       * functionality on it will clean the frozen state, which
>       * ensures that the contained PCI devices will work properly
>       * after reboot.

This looks like personal preference, I can't actually find a source
that indicates "reenable" is anything other than a valid alternative of
"re-enable".  Thanks,

Alex


