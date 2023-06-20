Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02420736FBA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBctx-0005Gj-GV; Tue, 20 Jun 2023 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBctu-0005AR-Q9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBctm-0004OC-Ou
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tsUYuK4U9SfU5Zbs82EMJXCV2g42Ze4O7HVR8wBEv4M=;
 b=YHWaiFkHiqQ3668TAJfxEaO/hPfwNex+yYZ12vp+YIKeAjFJ1x/lgSxL62S8DwBlnUQSsC
 tlk6ZE9uKsWtfOPWS3qC8MbgxgRk0wNPPqe8ViWLkGYVTvoAH2etymozvjXzEp3o5+vyJT
 hgCo/Z1yxMNYCHq41erxiMkD6+/6sLQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-iXRKzvWHPH-FTAkByidD_A-1; Tue, 20 Jun 2023 11:02:56 -0400
X-MC-Unique: iXRKzvWHPH-FTAkByidD_A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62ff893f03bso11593626d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273360; x=1689865360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsUYuK4U9SfU5Zbs82EMJXCV2g42Ze4O7HVR8wBEv4M=;
 b=QVtU2XChJv63nZ9VO4b2cWNFGMvi577MFYqQmzIAHc+MwHEAPtVpMbmzx6vNWHmn/f
 cwdMjE6c4QCCWMbsoBp9ynLlXzIohUUYmoL6QEUWNRbElU+L0H2bHIW6aSWzIXsygySH
 NUnGi7m95VNILVJcLzVi7/mAWXgLdQfbo5UGaCwUvX3eEXgC7YonFbarBsJw8v/FxVbU
 liK1jFyZiJayz8sa2h3F5rrzztiogYojRDjeL3zCSgQ77l5wjmVRKQ8FsPShwv4ww9eD
 ecWRhV/rOgMXopnOCmygnxGv1sLcexIkjz1uptYwIPj6i2wWyzxzaiAO6E2fJhfCPEF3
 vSFQ==
X-Gm-Message-State: AC+VfDyqOf7EXkz41eodJGmVeyx/36+On93R9hwAywR5K8yUoQSwu0f7
 0hB8nnGicRUWAWSeFHUkLKMYTNRL7W0PoeknvuNwK3f4m1gRIexZH1+F67YieWRuQq9O8Ge+6Kl
 qPVRjBz1FCk14GJE=
X-Received: by 2002:a05:6214:4111:b0:62a:cc88:1d44 with SMTP id
 kc17-20020a056214411100b0062acc881d44mr15538257qvb.4.1687273360627; 
 Tue, 20 Jun 2023 08:02:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6V7uyCjsYewb5UtTWnCqfBn5GUflC53XiTKDCeWj6JaYr0GzaMcSWBrWeWeYrkOsiGhtrk8w==
X-Received: by 2002:a05:6214:4111:b0:62a:cc88:1d44 with SMTP id
 kc17-20020a056214411100b0062acc881d44mr15538227qvb.4.1687273360229; 
 Tue, 20 Jun 2023 08:02:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d22-20020a0caa16000000b00631eaf8b9e5sm1305814qvb.138.2023.06.20.08.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:02:39 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:02:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 03/42] migration-test: simplify shmem_opts handling
Message-ID: <ZJG/jqmk1hHwzXpJ@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-4-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 09, 2023 at 12:49:04AM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 73b2f01427..95ccc9bce7 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -681,9 +681,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>              "-object memory-backend-file,id=mem0,size=%s"
>              ",mem-path=%s,share=on -numa node,memdev=mem0",
>              memory_size, shmem_path);
> -    } else {
> -        shmem_path = NULL;
> -        shmem_opts = g_strdup("");
>      }
>  
>      cmd_source = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
> @@ -696,7 +693,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   machine_opts ? " -machine " : "",
>                                   machine_opts ? machine_opts : "",
>                                   memory_size, tmpfs,
> -                                 arch_source, shmem_opts,
> +                                 arch_source,
> +                                 shmem_opts ? shmem_opts : "",
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr ? ignore_stderr : "");
>  
> @@ -718,7 +716,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   machine_opts ? " -machine " : "",
>                                   machine_opts ? machine_opts : "",
>                                   memory_size, tmpfs, uri,
> -                                 arch_target, shmem_opts,
> +                                 arch_target,
> +                                 shmem_opts ? shmem_opts : "",

Isn't this adding duplications instead?

Meanwhile, shmem_opts right now is auto-free.  If we do this we don't need
it to be auto-free anymore..

>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr ? ignore_stderr : "");
>      *to = qtest_init(cmd_target);
> -- 
> 2.40.1
> 

-- 
Peter Xu


