Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D583B826946
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMknX-0001nY-8f; Mon, 08 Jan 2024 03:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMkn7-0001CX-1i
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMkn4-0008Pr-RJ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704701721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+ja5RPdaE9rdiSKUeazhmMAuLMsk9d7G6eC+Cm956c=;
 b=Fx6bDONLevwZ+/mUfzTZa0AIiMa7Ja7dJ4rAmV2bD38N8kUP//48ZYXMNI5+8b1UwzkPeu
 dq5BzG2VaE5hbCK+TYWcca866XyO+x6nvxOYC9N6F1qsFtsoRYWs/z8SJUAEaIz7Iql1uT
 XBSG5Tj1louEgAJuUUT56bgJxCAQFho=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-HWLCv_gpMiGMnnyL4H4rJQ-1; Mon, 08 Jan 2024 03:15:19 -0500
X-MC-Unique: HWLCv_gpMiGMnnyL4H4rJQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d44a50ab19so3197655ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704701718; x=1705306518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+ja5RPdaE9rdiSKUeazhmMAuLMsk9d7G6eC+Cm956c=;
 b=eXHNbgKdFTNrjvPrn/g+60TPw2meuaBuwT9qFJdN2O2ecHJbYcBXRiO7UJyeD5RceE
 T6C3CC2kyfpb3VJTllaccuIUn9oeBw4UXgchHY6r0T0fZIUYxW2IaTO+F+9i4aFfopUA
 NhmFwPN7baXz1Gca3XXvzlmSBGomNNa1SXPqRu2yrvGpZSrxz/cg95sCgseQ7hFSoR+F
 +KpgUiVkNa8HX21uvBuAq+Iw397AZaEqaGqIxeAoihVyvxMIRluRMTLQbQThYv1nxvXS
 neNMiOMQbAlg8QcfyZygnAEv8pQlpp5EdbZ3Oz33MryjlF5i9TvKdSB9dyd9i3fRkSA2
 1mGw==
X-Gm-Message-State: AOJu0Yxh16dzII91Z4QCnCepwUMyyzFa7UgrWyUCC+M8flSOb3hJktIq
 5ih2qQHy1CoegM9pF+SnhKWWnptCfQGc9ft3hRBISEiBHceypn9/1XhwlFTkVXKTQa+HJrYHoOk
 3+UGxjrq5YEGxeon541I7ICM=
X-Received: by 2002:a17:902:8682:b0:1d4:e308:d6fb with SMTP id
 g2-20020a170902868200b001d4e308d6fbmr7265959plo.5.1704701718683; 
 Mon, 08 Jan 2024 00:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJfB/w179cck+LNHw7jLr/PTZMTIt+kM2z1Tg8Img+iIa6K9wseGB2VwCCZ6dDepOTbGi+1w==
X-Received: by 2002:a17:902:8682:b0:1d4:e308:d6fb with SMTP id
 g2-20020a170902868200b001d4e308d6fbmr7265947plo.5.1704701718364; 
 Mon, 08 Jan 2024 00:15:18 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t4-20020a170902a5c400b001d3e6f58e5esm5622574plq.6.2024.01.08.00.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 00:15:17 -0800 (PST)
Date: Mon, 8 Jan 2024 16:15:09 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZZuvDREDrQ07HsGs@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105180449.11562-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 05, 2024 at 03:04:49PM -0300, Fabiano Rosas wrote:
> [This patch is not necessary anymore after 8.2 has been released]
> 
> Add the 'since' annotations to recently added tests and adapt the
> postcopy test to use the older "uri" API when needed.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

You marked this as not-for-merge.  Would something like this still be
useful in the future?  IIUC it's a matter of whether we'd still want to
test those old binaries.

> ---
>  tests/qtest/migration-test.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 001470238b..599f51f978 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1338,14 +1338,21 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      migrate_ensure_non_converge(from);
>  
>      migrate_prepare_for_dirty_mem(from);
> -    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> -                             "  'arguments': { "
> -                             "      'channels': [ { 'channel-type': 'main',"
> -                             "      'addr': { 'transport': 'socket',"
> -                             "                'type': 'inet',"
> -                             "                'host': '127.0.0.1',"
> -                             "                'port': '0' } } ] } }");
>  
> +    /* New syntax was introduced in 8.2 */
> +    if (migration_vercmp(to, "8.2") < 0) {
> +        qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> +                                 "  'arguments': { "
> +                                 "      'uri': 'tcp:127.0.0.1:0' } }");
> +    } else {
> +        qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> +                                 "  'arguments': { "
> +                                 "      'channels': [ { 'channel-type': 'main',"
> +                                 "      'addr': { 'transport': 'socket',"
> +                                 "                'type': 'inet',"
> +                                 "                'host': '127.0.0.1',"
> +                                 "                'port': '0' } } ] } }");
> +    }
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> @@ -1603,6 +1610,9 @@ static void test_postcopy_recovery_double_fail(void)
>  {
>      MigrateCommon args = {
>          .postcopy_recovery_test_fail = true,
> +        .start = {
> +            .since = "8.2",
> +        },
>      };
>  
>      test_postcopy_recovery_common(&args);
> @@ -1665,6 +1675,7 @@ static void test_analyze_script(void)
>  {
>      MigrateStart args = {
>          .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
> +        .since = "8.2",
>      };
>      QTestState *from, *to;
>      g_autofree char *uri = NULL;
> @@ -2090,6 +2101,9 @@ static void test_precopy_file(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> +        .start = {
> +            .since = "8.2"
> +        },
>      };
>  
>      test_file_common(&args, true);
> @@ -2134,6 +2148,9 @@ static void test_precopy_file_offset(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .finish_hook = file_offset_finish_hook,
> +        .start = {
> +            .since = "8.2"
> +        },
>      };
>  
>      test_file_common(&args, false);
> @@ -2148,6 +2165,9 @@ static void test_precopy_file_offset_bad(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .result = MIG_TEST_QMP_ERROR,
> +        .start = {
> +            .since = "8.2"
> +        },
>      };
>  
>      test_file_common(&args, false);
> -- 
> 2.35.3
> 

-- 
Peter Xu


