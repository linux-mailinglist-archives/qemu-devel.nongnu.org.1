Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9373708D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdML-0004aX-BS; Tue, 20 Jun 2023 11:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdMB-0004Tt-Lq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdM9-0005SV-FT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687275199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoAHD+5AelV7QX2l2WI0Q42Vz9Io14sP8IYRilrh7jg=;
 b=eQTJOJqGoriHEd4BsqtHam+TOqnxJDGGvITrf7mygNJX1qMYkoV4K4zHWjknu6JUXXQrAU
 8XXD66TU2/RIVTMOKCqlWWD8bjRgJu2vbRc5QSO+vfhsho7q7tGKsCdrewYum48BT/5Lco
 f+dhvx4MCXRCmitFeRd7oQzVBesc2nU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-tRrnnALWMYmwrAukfnIpWw-1; Tue, 20 Jun 2023 11:33:07 -0400
X-MC-Unique: tRrnnALWMYmwrAukfnIpWw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-631e9a9e92bso3322326d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275181; x=1689867181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoAHD+5AelV7QX2l2WI0Q42Vz9Io14sP8IYRilrh7jg=;
 b=akPMN2x2DYsZpPabyWMK+Al3l4nC2dryjfSwL3Jle5fw+knuy+yA7de7gukqUqAisW
 S0tkNfL39ZO1cxZdSUaoYbBhmu0ACD2eC19gpYDOmKj27bSXqfcIvqWDD9OsMWabpg69
 Jk08HFqJksxTqkGAZ1yiF5qXZiIm7vQ8eahDUBMzbkOBWy8vF1Y8+cr3OUnp4FpzJ505
 uFUb2fCk681zBPH7WGFhmSES7yTnX6/BMaAO1u2GIRte3xG6PZJc2/u6qre2+QBwzmYb
 UVSaD7ARAVyAOZYIY+N1ti8RiSkX1Jat+z48hESLdNL2Xevx5MTN0pt9dyEW0lxT9i6T
 /hnw==
X-Gm-Message-State: AC+VfDxo1gRtzguGsXEnWbR6ceaVc6D4F8tXj5x/OoU+kJdodKSk6oof
 wdpZx2A5sRmK7nktxKhRgd7+fjUI/dsKzwI2A1mPLCyPZSnByfzIUKL7/+grKcDOtTXFVShT76m
 9pdlaScTWaETiRugwO7lBA9s=
X-Received: by 2002:a05:6214:29cc:b0:62d:fc81:44fc with SMTP id
 gh12-20020a05621429cc00b0062dfc8144fcmr15774407qvb.6.1687275180770; 
 Tue, 20 Jun 2023 08:33:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EQvzOkPyfzBi0kPO0e0yHFDCxvD6ivNgnt7LBCUnobfiLOwIu0ShqItmA3FWEgq6A4cy6TQ==
X-Received: by 2002:a05:6214:29cc:b0:62d:fc81:44fc with SMTP id
 gh12-20020a05621429cc00b0062dfc8144fcmr15774392qvb.6.1687275180537; 
 Tue, 20 Jun 2023 08:33:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z9-20020ad44149000000b0061b5dbf1994sm1303202qvp.146.2023.06.20.08.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:33:00 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:32:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 13/42] migration-test: Check for shared memory like for
 everything else
Message-ID: <ZJHGq847FcrpobuD@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-14-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:14AM +0200, Juan Quintela wrote:
> Makes things easier and cleaner.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index daaf5cd71a..5837060138 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -645,13 +645,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
>  
> -    if (args->use_shmem) {
> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> -            g_test_skip("/dev/shm is not supported");
> -            return -1;
> -        }
> -    }

Maybe assert on: "!args->use_shmem || shm_supported()" here?

Either way:

Reviewed-by: Peter Xu <peterx@redhat.com>

> -
>      got_src_stop = false;
>      got_dst_resume = false;
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> @@ -2639,6 +2632,15 @@ static bool kvm_dirty_ring_supported(void)
>  #endif
>  }
>  
> +static bool shm_supported(void)
> +{
> +    if (g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> +        return true;
> +    }
> +    g_test_message("Skipping test: shared memory not available");
> +    return false;
> +}
> +
>  int main(int argc, char **argv)
>  {
>      bool has_kvm, has_tcg;
> @@ -2768,7 +2770,9 @@ int main(int argc, char **argv)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    qtest_add_func("/migration/ignore_shared", test_ignore_shared);
> +    if (shm_supported()) {
> +        qtest_add_func("/migration/ignore_shared", test_ignore_shared);
> +    }
>  #ifndef _WIN32
>      qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
>  #endif
> -- 
> 2.40.1
> 

-- 
Peter Xu


