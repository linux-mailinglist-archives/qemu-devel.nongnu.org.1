Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B60057FA3C3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:56:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7d0m-0000Fq-U9; Mon, 27 Nov 2023 09:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7d0a-0000FQ-75
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:54:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7d0W-0004OZ-OJ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ok7ODJ7YVYqfymtIj1IjRs+ArhTfs+CZht9I7aSV2Bc=;
 b=JxveW/SKU2NfJYNeFhynVKlYGYG7qPCHv49NaaXSzWnAiwhUL7M/5UybKqLvfL2fMLYvby
 85sjZyvrvrYYmScOgSqXSfQ4uwO4XIst17fjYHZGcxYQuju93wIbfYLCrg3r9BBVyom21D
 c3/g5FAOTzFJM6pfb2De4sUY4ozm0iA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-OYMw50hDOSCGXnwxGVBNOw-1; Mon, 27 Nov 2023 09:54:42 -0500
X-MC-Unique: OYMw50hDOSCGXnwxGVBNOw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77d7d7f4bd1so47062885a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096882; x=1701701682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ok7ODJ7YVYqfymtIj1IjRs+ArhTfs+CZht9I7aSV2Bc=;
 b=BALUqcW6Zki9ImHC0Ptpry6LFjQh87Omqw6BnnmeTKroEql0h9zPOsDRzYHW8UQObd
 LPkouq+r10sjOGJn8M6j70OKrk5qOq2q+4t6OOf4M8onjJ8MN73/JlVFcL2rMV+QmrwB
 H+hNe2gKQRWYqHjkb+LT+FfboMCEzi1NuOpzt72FAzxxYwL9H+sJ4kRMZPZOMt+Ws2G7
 TkevuxYerURqSLHZcYa5O9HuGtrLtAXA7z4YBQk5jCw2lN2/yI8Q5BjuVbX1JjeoJAhM
 LFiuG0QnBDVu7+pUrActmLq/KRi5NycgAU7M0dQ1MlPIKprOSzVTaevZLwYGrcXBEbBW
 jqgg==
X-Gm-Message-State: AOJu0YwsOzSLdpOR0JKKyHWWPDv8FT+RdiVrTcBwLkbe1709E6GacC3Y
 xgSQLFLI0hXS2rNK1WBMOLhF5WKpP5yYmgBvc1gsHtEzHDhk6A+EPq2eQ7lvHDiuchLQwq24z79
 TKiczpwP5NHRypvE=
X-Received: by 2002:a05:620a:462c:b0:77d:a5d0:edb3 with SMTP id
 br44-20020a05620a462c00b0077da5d0edb3mr4424396qkb.6.1701096881870; 
 Mon, 27 Nov 2023 06:54:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpf8HKx0YUs3hDeiuTP9N/UiRMKt+eVNtwYyNp0HgYbn9Np19qfaoTCkK57GBkoD4yWqi8gg==
X-Received: by 2002:a05:620a:462c:b0:77d:a5d0:edb3 with SMTP id
 br44-20020a05620a462c00b0077da5d0edb3mr4424373qkb.6.1701096881585; 
 Mon, 27 Nov 2023 06:54:41 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pf18-20020a05620a859200b0077d7cfde46csm3118750qkn.106.2023.11.27.06.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:54:41 -0800 (PST)
Date: Mon, 27 Nov 2023 09:54:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 6/7] tests/qtest/migration: Add a wrapper to print
 test names
Message-ID: <ZWStsHj23pCbuGPP@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 24, 2023 at 01:14:31PM -0300, Fabiano Rosas wrote:
> Our usage of gtest results in us losing the very basic functionality
> of "knowing which test failed". The issue is that gtest only prints
> test names ("paths" in gtest parlance) once the test has finished, but
> we use asserts in the tests and crash gtest itself before it can print
> anything. We also use a final abort when the result of g_test_run is
> not 0.
> 
> Depending on how the test failed/broke we can see the function that
> trigged the abort, which may be representative of the test, but it
> could also just be some generic function.
> 
> We have been relying on the primitive method of looking at the name of
> the previous successful test and then looking at the code to figure
> out which test should have come next.
> 
> Add a wrapper to the test registration that does the job of printing
> the test name before running.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 32 ++++++++++++++++++++++++++++++++
>  tests/qtest/migration-helpers.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index f1106128a9..164e09c299 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -298,3 +298,35 @@ char *resolve_machine_version(const char *alias, const char *var1,
>  
>      return find_common_machine_version(machine_name, var1, var2);
>  }
> +
> +typedef struct {
> +    char *name;
> +    void (*func)(void);
> +} MigrationTest;
> +
> +static void migration_test_destroy(gpointer data)
> +{
> +    MigrationTest *test = (MigrationTest *)data;
> +
> +    g_free(test->name);
> +    g_free(test);
> +}
> +
> +static void migration_test_wrapper(const void *data)
> +{
> +    MigrationTest *test = (MigrationTest *)data;
> +
> +    g_test_message("Running /%s%s", qtest_get_arch(), test->name);

/%s/%s?

> +    test->func();
> +}

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


