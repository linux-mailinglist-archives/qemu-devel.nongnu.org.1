Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FB737061
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdBB-0004hR-3l; Tue, 20 Jun 2023 11:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdB8-0004hG-Pt
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdB7-00017w-EF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxsHRpCScjNK3qW6Px4WYHxDdiL9eVOnoANNUjIHHk4=;
 b=gwXtgQyYmURC/MKv6uD+epG8O8LDirK9yfPUCcUObCaD3ya5gWfpHRmuiLsZU6XpUsDRrr
 zVoui6Zhvyi6wsdeoEGYK+ES58r9EZ2/mWrW14FAweGtVy/BDozaB4OKNcNDTyLvFTg0pc
 s1OxCLidBlmgL6UE3bepIiCwBXreuoY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-dMbZxJSkN9OUgMyEYWPK7w-1; Tue, 20 Jun 2023 11:21:36 -0400
X-MC-Unique: dMbZxJSkN9OUgMyEYWPK7w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62ff893f03bso11634476d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274489; x=1689866489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxsHRpCScjNK3qW6Px4WYHxDdiL9eVOnoANNUjIHHk4=;
 b=KSlUe+o54oMy+b6QjxmR9q5Uzbe9JNgwlvP0XZxRBPCYs/oNhro9F9DNEyBNMj9pQW
 gM+DTf0cZ5UsYmLt6IVhrJc0iVvWicG+muRrhLMUrAGf7lhH1DwM2mwnEXbqgNKhZ9Jm
 zhx08KpuPYF03iHB2DRE2q39733YfD2VDE+oIZkRKVqRkqOPMU4p0efPFDzJwAn3jV5L
 As0zCiddjlTr39eWMUhF5bUf5foTFk+qtt5aX1Ox0U8F0GPhgryh2WkfMMUjh8sIY/FU
 b4BvKK0ERD/rRj4EeMJ2+hL83daGU8qt7TZbjP0EOojjKrqM4AK5YNQFs3hcq1x0Hfcg
 7aIw==
X-Gm-Message-State: AC+VfDwZPCio9N0C5XTOFedo1G8e636vhwq9ClIsHBKALIZjZEKw3ny+
 0N7Y5Px4Ak3GBG2IG0r7xGCXOnPDjUUMh9pQoWaU7nEqqapvaO7HPAbe46bhjdqMb7G4iaW5D2L
 aNspZBiE1HAID6eM=
X-Received: by 2002:ad4:5c83:0:b0:61b:6b8e:16e0 with SMTP id
 o3-20020ad45c83000000b0061b6b8e16e0mr15600684qvh.1.1687274489321; 
 Tue, 20 Jun 2023 08:21:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gGrwFcr2BRS3CoSo9tLc9fDvAF1dRL3t2uiWb+M6NDUZkV7A+uLcD9zQRWr2HyYDmtSLM2g==
X-Received: by 2002:ad4:5c83:0:b0:61b:6b8e:16e0 with SMTP id
 o3-20020ad45c83000000b0061b6b8e16e0mr15600666qvh.1.1687274489097; 
 Tue, 20 Jun 2023 08:21:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j5-20020a0cf505000000b0062b76c29978sm1381608qvm.6.2023.06.20.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:21:28 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:21:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 11/42] migration-test: Update test_ignore_shared to use
 args
Message-ID: <ZJHD94Moce7KPqzq@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-12-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 09, 2023 at 12:49:12AM +0200, Juan Quintela wrote:
> It missed this treatment:
> 
> commit 11f1a4ce14803f15d59cff42a4cfb7ac50d36bd0
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Mon Nov 29 18:57:51 2021 +0100
> 
>     migration-test: Check for shared memory like for everything else
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

This is still under "#if 0" block.. and the old code doesn't even compile,
but the change looks fine.

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  tests/qtest/migration-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 743aa873e6..7178c8e679 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1597,8 +1597,11 @@ static void test_ignore_shared(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> +    MigrateStart args = {
> +        .use_shmem = true
> +    };
>  
> -    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
> +    if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
>      }
>  
> -- 
> 2.40.1
> 

-- 
Peter Xu


