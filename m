Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCC37370FC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdfd-0000vR-0Q; Tue, 20 Jun 2023 11:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdfa-0000sd-Ni
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdfZ-0004FL-17
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687276404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfT+etxBUB2ey0cqQE8ThqToZPZ6ZoLDDqRPABZNiY8=;
 b=g50e8GeWHG3J8gJAMwivE9UwapMgiKBgEgToqJ8MwzvrP7jtrJmch96jPov7PS0S5+R+NZ
 cJFdJtTZQPXYoCuRb2OH8/wCH/0YXVELuEe9e67PDVCwFmWRFT2mhsqj4eFLOGStkWGHAU
 Tbt2SeJEWdpeze70nJekwUznPrJUJX0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-utnCQSAlOG6Dd3cSMRoJWg-1; Tue, 20 Jun 2023 11:53:21 -0400
X-MC-Unique: utnCQSAlOG6Dd3cSMRoJWg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62dd9986b76so9701096d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276396; x=1689868396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfT+etxBUB2ey0cqQE8ThqToZPZ6ZoLDDqRPABZNiY8=;
 b=M1KF2G6c1S/rYPUMAafdRgoO/vDj3CRxa/2U94z7vWkXk3V0uFGdy59Nv8W/baQhKo
 61wtbA6lrfhcfNf52Rj0lwTKfC0SStCr5Fbop4osgtKQIVF5fgJRk38KU5bom+wqdm3e
 hiA/ClO5J6I2lRegLxYiZijwkAKyab/MJe7TSN80gFjmh98o4qXlCvky3HCjYRETblom
 xr8DzR7gG3h6u/d2YcXKR+OStMsNAPiENA6mkiEttnDZVgJKpxawNrwqLlwY0SLReVl9
 iT2KExWM+mmBEnTd6KOnDCptDfb3BsCHv4updV7hKgcRTxuWKR0Hyk5qKuW+pvZ/7QL0
 NiIQ==
X-Gm-Message-State: AC+VfDxIVWy3ZTc8sE+I0/1H7NCE2+JGGzu6HGSjgQrAUrWk7rr7ZknK
 69ZojFIOTZKKCaBWzI82aA8m/TVwCJ1vL5qG2Mf5B+JipozKYwJ1vW1jjzGkswikqR065xeNfZ5
 w0YV30rtUK1kWfDA=
X-Received: by 2002:a05:6214:2262:b0:625:aa49:c182 with SMTP id
 gs2-20020a056214226200b00625aa49c182mr15480181qvb.6.1687276396547; 
 Tue, 20 Jun 2023 08:53:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+428Uk4C3LIqf9vUxyyYvosizp6nMWagEzdU48WQUGTBbwkDqxgDlrFSHR2HljgPoyUnpBw==
X-Received: by 2002:a05:6214:2262:b0:625:aa49:c182 with SMTP id
 gs2-20020a056214226200b00625aa49c182mr15480163qvb.6.1687276396195; 
 Tue, 20 Jun 2023 08:53:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b12-20020a0cc98c000000b00630044b530esm1369928qvk.83.2023.06.20.08.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:53:15 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:53:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 16/42] migration-test: Create do_migrate()
Message-ID: <ZJHLahb43lc27gIR@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-17-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:17AM +0200, Juan Quintela wrote:
> We called migrate_qmp() in lot of places.  And there are tricks like
> changing tcp address with the right port.
> 
> Only two callers remaining:
> - postcopy resume: It needs to play with the qmp.
> - baddest: We want to do a unvalid URI. For that we need to do it by
>   hand.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 41 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e623c43957..96b495f255 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -528,6 +528,17 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>      qtest_qmp_eventwait(to, "RESUME");
>  }
>  
> +static void do_migrate(QTestState *from, QTestState *to, const gchar *uri)
> +{
> +    if (!uri) {
> +        g_autofree char *tcp_uri =
> +            migrate_get_socket_address(to, "socket-address");
> +        migrate_qmp(from, tcp_uri, "{}");
> +    } else {
> +        migrate_qmp(from, uri, "{}");
> +    }
> +}
> +
>  typedef struct {
>      /*
>       * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
> @@ -1173,7 +1184,7 @@ static void migrate_postcopy_prepare(QTestState **from_ptr,
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to, uri);
>  
>      wait_for_migration_pass(from);
>  
> @@ -1378,6 +1389,9 @@ static void test_baddest(void)
>      QTestState *from, *to;
>  
>      test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args);
> +    /*
> +     * Don't change to do_migrate(). We are using a wrong uri on purpose.
> +     */
>      migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
>      wait_for_migration_fail(from, false);
>      test_migrate_end(from, to, false);
> @@ -1424,14 +1438,7 @@ static void test_precopy_common(MigrateCommon *args)
>          }
>      }
>  
> -    if (!args->connect_uri) {
> -        g_autofree char *local_connect_uri =
> -            migrate_get_socket_address(to, "socket-address");
> -        migrate_qmp(from, local_connect_uri, "{}");
> -    } else {
> -        migrate_qmp(from, args->connect_uri, "{}");
> -    }
> -
> +    do_migrate(from, to, args->connect_uri);
>  
>      if (args->result != MIG_TEST_SUCCEED) {
>          bool allow_active = args->result == MIG_TEST_FAIL;
> @@ -1586,7 +1593,7 @@ static void test_ignore_shared(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to, uri);
>  
>      wait_for_migration_pass(from);
>  
> @@ -1890,7 +1897,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to, uri);
>  
>      if (should_fail) {
>          qtest_set_expected_status(to, EXIT_FAILURE);
> @@ -1991,7 +1998,7 @@ static void test_migrate_auto_converge(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to, uri);
>  
>      /* Wait for throttling begins */
>      percentage = 0;
> @@ -2280,7 +2287,6 @@ static void test_multifd_tcp_cancel(void)
>          .hide_stderr = true,
>      };
>      QTestState *from, *to, *to2;
> -    g_autofree char *uri = NULL;
>  
>      test_migrate_start(&from, &to, "defer", &args);
>  
> @@ -2299,9 +2305,7 @@ static void test_multifd_tcp_cancel(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    uri = migrate_get_socket_address(to, "socket-address");
> -
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to, "127.0.0.1:0");

I think this means migrating to "127.0.0.1:0".  Can this work?

>  
>      wait_for_migration_pass(from);
>  
> @@ -2325,14 +2329,11 @@ static void test_multifd_tcp_cancel(void)
>      qtest_qmp_assert_success(to2, "{ 'execute': 'migrate-incoming',"
>                               "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
>  
> -    g_free(uri);
> -    uri = migrate_get_socket_address(to2, "socket-address");
> -
>      wait_for_migration_status(from, "cancelled", NULL);
>  
>      migrate_ensure_converge(from);
>  
> -    migrate_qmp(from, uri, "{}");
> +    do_migrate(from, to2, "127.0.0.1:0");
>  
>      wait_for_migration_pass(from);
>  
> -- 
> 2.40.1
> 

-- 
Peter Xu


