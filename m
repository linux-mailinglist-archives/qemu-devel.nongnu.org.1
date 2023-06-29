Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D88742F92
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 23:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEzK6-0001TC-Os; Thu, 29 Jun 2023 17:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEzK4-0001Sq-Rw
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEzK2-0003Ta-9v
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688074620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KAoRtRN4x2tLTBIVvDJ6ZPllx3WAr5q8A0nQqw9Cwg=;
 b=iCxZff1yLXqFRnKxIIxkL6xfNXq8PbCTzm/hPy2knegQtXWejT8MIUoB/NMLNDpUzlYd7B
 0V1/bhtZAoKgXsX6o5b4eH8XaYtdXzApwPCZOfbBkohK7xF4D1BG9rmkaasTHypFfRps72
 lv2FNAqLOztlsXdkkPGEN8Kk5uWbaA8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-mwvZj-NOPLGSCJDwfKp_cQ-1; Thu, 29 Jun 2023 17:36:58 -0400
X-MC-Unique: mwvZj-NOPLGSCJDwfKp_cQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso23788085a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 14:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688074618; x=1690666618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KAoRtRN4x2tLTBIVvDJ6ZPllx3WAr5q8A0nQqw9Cwg=;
 b=cAnKoWgzNt4OMLT5l36Rv1njSO4o/t3ybL/qQIwQRVR1WttMP1vNZ+bvbqqE0oFYyg
 gukHhG9cRIvT8tsY5lLidPprDhWCt/Ps/4+ZO8ziglfezY1nZgeWoZRHwMNZ3dDMxmoT
 xQSpr+i1dPMajk2WyCFZeyko+/Uu/dNZVtCXEMKn9Ktme9GdPEOBFhMwATGs1tA72bBg
 R50gtk58B+H+pvKASSbQpJIsOM5nPyb9fcZXqsHXmLFCdRDBgwgSoqGaAwIxXCrqpEl1
 LciupSlIijRwhNUAhyPn7NM322YrUhMqKYW/w3iBx2MQMQNXM03A7JAI9idR4laxD2QW
 cxgw==
X-Gm-Message-State: AC+VfDzzv23Zma21qTomT0qB+JeQroS7gHrgB6+Y7lnbIwcWnM8sCdjU
 XqptVivZ1uaqJ8JcXzPS2XW9LrcfMTZLC5kxtn62D9DswMQr1ykX6OEWc4PSG5ddZYYasRvT0bQ
 KPEi0oDNiDwvyX6Q=
X-Received: by 2002:a05:620a:1a8c:b0:767:3ea3:2ac8 with SMTP id
 bl12-20020a05620a1a8c00b007673ea32ac8mr698631qkb.1.1688074618015; 
 Thu, 29 Jun 2023 14:36:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Nf0csswWjjUStGqEy6IUt1DIV9KhqVjc9o8sUB6tJU6pEhR5mzJjbJjfCmr8MfZ6dn5Dnew==
X-Received: by 2002:a05:620a:1a8c:b0:767:3ea3:2ac8 with SMTP id
 bl12-20020a05620a1a8c00b007673ea32ac8mr698613qkb.1.1688074617691; 
 Thu, 29 Jun 2023 14:36:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05620a13b500b0075ecdc937ffsm3842957qki.41.2023.06.29.14.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 14:36:57 -0700 (PDT)
Date: Thu, 29 Jun 2023 17:36:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZJ35d0yqB5YD+8IH@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628165542.17214-7-farosas@suse.de>
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

On Wed, Jun 28, 2023 at 01:55:42PM -0300, Fabiano Rosas wrote:
> Add basic tests for file-based migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 104 +++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index acb778a8cd..b3019f54de 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -52,6 +52,10 @@ static bool got_dst_resume;
>   */
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
> +#define QEMU_VM_FILE_MAGIC 0x5145564d
> +#define FILE_TEST_FILENAME "migfile"
> +#define FILE_TEST_OFFSET 0x1000
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -763,6 +767,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      cleanup("migsocket");
>      cleanup("src_serial");
>      cleanup("dest_serial");
> +    cleanup(FILE_TEST_FILENAME);
>  }
>  
>  #ifdef CONFIG_GNUTLS
> @@ -1460,11 +1465,28 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> +            /*
> +             * For file based migration the target must begin its
> +             * migration after the source has finished.
> +             */
> +            if (strstr(connect_uri, "file:")) {
> +                migrate_incoming_qmp(to, connect_uri, "{}");
> +            }
> +
>              if (!got_src_stop) {
>                  qtest_qmp_eventwait(from, "STOP");
>              }
>          } else {
>              wait_for_migration_complete(from);
> +
> +            /*
> +             * For file based migration the target must begin its
> +             * migration after the source has finished.
> +             */
> +            if (strstr(connect_uri, "file:")) {
> +                migrate_incoming_qmp(to, connect_uri, "{}");
> +            }
> +
>              /*
>               * Must wait for dst to finish reading all incoming
>               * data on the socket before issuing 'cont' otherwise
> @@ -1682,6 +1704,78 @@ static void test_precopy_unix_compress_nowait(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_precopy_file(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +#if defined(__linux__)
> +static void file_offset_finish_hook(QTestState *from, QTestState *to, void *opaque)
> +{
> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
> +    uintptr_t *addr, *p;
> +    int fd;
> +
> +    fd = open(path, O_RDONLY);
> +    g_assert(fd != -1);
> +    addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);

Not something that matters a lot, but RO mapping a file with private is a
bit weird.  Maybe just use MAP_SHARED?

> +    g_assert(addr != MAP_FAILED);
> +
> +    /*
> +     * Ensure the skipped offset contains zeros and the migration
> +     * stream starts at the right place.
> +     */
> +    p = addr;
> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> +        g_assert(*p == 0);
> +        p++;
> +    }
> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
> +
> +    munmap(addr, size);
> +    close(fd);
> +}
> +
> +static void test_precopy_file_offset(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
> +                                           FILE_TEST_FILENAME,
> +                                           FILE_TEST_OFFSET);

Is it intended to also only run this test with linux?  IIUC it should also
work for others. Maybe only file_offset_finish_hook() is optional?  Or am i
wrong?

> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .finish_hook = file_offset_finish_hook,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +#endif
> +
> +static void test_precopy_file_offset_bad(void)
> +{
> +    /* using a value not supported by qemu_strtosz() */
> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",
> +                                           tmpfs);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .error_str = g_strdup(
> +            "file URI has bad offset 0x20M: Unknown error -22"),

"Unknown error" may imply that in Steve's patch the errno is inverted..

Shall we not rely on the string in the test?  It might be too strict, I
worry, because error strings should be defined for human readers, and we
may not want some e.g. grammar / trivial change to break a test.

> +        .result = MIG_TEST_QMP_ERROR,
> +    };
> +
> +    test_precopy_common(&args);
> +    g_free(args.error_str);
> +}
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -2704,6 +2798,16 @@ int main(int argc, char **argv)
>          qtest_add_func("/migration/precopy/unix/compress/nowait",
>                         test_precopy_unix_compress_nowait);
>      }
> +
> +    qtest_add_func("/migration/precopy/file",
> +                   test_precopy_file);
> +#if defined(__linux__)
> +    qtest_add_func("/migration/precopy/file/offset",
> +                   test_precopy_file_offset);
> +#endif
> +    qtest_add_func("/migration/precopy/file/offset/bad",
> +                   test_precopy_file_offset_bad);
> +
>  #ifdef CONFIG_GNUTLS
>      qtest_add_func("/migration/precopy/unix/tls/psk",
>                     test_precopy_unix_tls_psk);
> -- 
> 2.35.3
> 

-- 
Peter Xu


