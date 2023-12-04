Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80334804067
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 21:51:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAFsz-0004CG-Jh; Mon, 04 Dec 2023 15:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAFsm-00045J-B3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAFsk-0001Cq-DR
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701722972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoDEjGu3NtnvgYwhOZVB0tuERJWwcfO9YvYdmQml6AA=;
 b=fI7OJrDf3JkCjNsNgk/gOSF9/umI8UkfK/2P0OfJBPCb66gUGrCEWDXuC9P4HdZXT4Dy/F
 7h5lBPwpC3m5+6DKJImR5zJNy2lihE0LPGMH5bWPZPgyhv6W7M+VO0s7bUrvrVEmOvg8Ye
 zKqsGmv/7p0iUgjhyoin/IM6P6YrDBY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-agpWL7txMMW1omLZgFZg6A-1; Mon, 04 Dec 2023 15:49:26 -0500
X-MC-Unique: agpWL7txMMW1omLZgFZg6A-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-35d601904dbso6252245ab.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 12:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701722965; x=1702327765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoDEjGu3NtnvgYwhOZVB0tuERJWwcfO9YvYdmQml6AA=;
 b=R65uuHBWWfjaR0prvT4YaBOj7xJjHLgOy62xVWSbsX3zO4srDFRZiWrP9FOoPf33gl
 aSySS61vWPX5uQVuHzoDcThHgw7v+3A/InrWFChNCdpdf3Ej8u8LScnqOs7FyW86Dvhc
 fy/lysL0oXGIMi1pqQwSuElqPHIrLqUM4jDR3YKoaGkVaiGhcYVMJzpQYAhvz7qIsnqC
 ao6ZDpVhXAen3r2VFHj+ZJjvJH738vAr3T9OouUXEppWHm8rFppXwFHbIJuBaaTjyix5
 fObu+GOCZEs5MqrMFsxztxB4WBaB8K8UbyuwFx91uRvox9jZyyTUfKPIoEZbmwvKk3QF
 IKfQ==
X-Gm-Message-State: AOJu0YzNBpcgJgFs1bb1F07rpUSRk6xMEtcC6cgktQyrL0PpDTe2F8aF
 Ya7OBq5Yn5mGTK2jg04tiQjbqBvd1skke+r+WQ38HKQ53Jrz9z9b/VM7s0og8qza3l8AD96qkKG
 GcrC+TxVRGY7mEsc=
X-Received: by 2002:a05:6e02:1d04:b0:35d:7a37:5236 with SMTP id
 i4-20020a056e021d0400b0035d7a375236mr1918028ila.2.1701722965540; 
 Mon, 04 Dec 2023 12:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkynVnG+xbgE1NKhvtjfAN0ykdCTXtf0w0+X2loSFrTcUvIEb07ufvW13G6V8fLfDSDTFpdg==
X-Received: by 2002:a05:6e02:1d04:b0:35d:7a37:5236 with SMTP id
 i4-20020a056e021d0400b0035d7a375236mr1918012ila.2.1701722965240; 
 Mon, 04 Dec 2023 12:49:25 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m18-20020a92c532000000b0035d4ddecb18sm132000ili.60.2023.12.04.12.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 12:49:24 -0800 (PST)
Date: Mon, 4 Dec 2023 15:49:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 11/14] tests/qtest: precopy migration with suspend
Message-ID: <ZW47TYtPP5uLNKsa@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-12-git-send-email-steven.sistare@oracle.com>
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

On Thu, Nov 30, 2023 at 01:37:24PM -0800, Steve Sistare wrote:
> Add a test case to verify that the suspended state is handled correctly
> during live migration precopy.  The test suspends the src, migrates, then
> wakes the dest.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/migration-helpers.c |  3 ++
>  tests/qtest/migration-helpers.h |  2 ++
>  tests/qtest/migration-test.c    | 64 ++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index fd3b94e..37e8e81 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -32,6 +32,9 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>      if (g_str_equal(name, "STOP")) {
>          state->stop_seen = true;
>          return true;
> +    } else if (g_str_equal(name, "SUSPEND")) {
> +        state->suspend_seen = true;
> +        return true;
>      } else if (g_str_equal(name, "RESUME")) {
>          state->resume_seen = true;
>          return true;
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 3d32699..b478549 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -18,6 +18,8 @@
>  typedef struct QTestMigrationState {
>      bool stop_seen;
>      bool resume_seen;
> +    bool suspend_seen;
> +    bool suspend_me;
>  } QTestMigrationState;
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e10d5a4..200f023 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -178,7 +178,7 @@ static void bootfile_delete(void)
>  /*
>   * Wait for some output in the serial output file,
>   * we get an 'A' followed by an endless string of 'B's
> - * but on the destination we won't have the A.
> + * but on the destination we won't have the A (unless we enabled suspend/resume)
>   */
>  static void wait_for_serial(const char *side)
>  {
> @@ -245,6 +245,13 @@ static void wait_for_resume(QTestState *who, QTestMigrationState *state)
>      }
>  }
>  
> +static void wait_for_suspend(QTestState *who, QTestMigrationState *state)
> +{
> +    if (!state->suspend_seen) {
> +        qtest_qmp_eventwait(who, "SUSPEND");
> +    }
> +}
> +
>  /*
>   * It's tricky to use qemu's migration event capability with qtest,
>   * events suddenly appearing confuse the qmp()/hmp() responses.
> @@ -299,7 +306,7 @@ static void wait_for_migration_pass(QTestState *who)
>  {
>      uint64_t pass, prev_pass = 0, changes = 0;
>  
> -    while (changes < 2 && !src_state.stop_seen) {
> +    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
>          usleep(1000);
>          pass = get_migration_pass(who);
>          changes += (pass != prev_pass);
> @@ -595,7 +602,8 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
>      watch_byte = qtest_readb(from, watch_address);
>      do {
>          usleep(1000 * 10);
> -    } while (qtest_readb(from, watch_address) == watch_byte);
> +    } while (qtest_readb(from, watch_address) == watch_byte &&
> +             !src_state.suspend_seen);

This is hackish to me.

AFAIU the guest code won't ever dirty anything after printing the initial
'B'.  IOW, migrate_wait_for_dirty_mem() should not be called for suspend
test at all, I guess, because we know it won't.

>  }
>  
>  
> @@ -771,6 +779,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      dst_state = (QTestMigrationState) { };
>      src_state = (QTestMigrationState) { };
>      bootfile_create(tmpfs, args->suspend_me);
> +    src_state.suspend_me = args->suspend_me;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
> @@ -1730,6 +1739,9 @@ static void test_precopy_common(MigrateCommon *args)
>           * change anything.
>           */
>          if (args->result == MIG_TEST_SUCCEED) {
> +            if (src_state.suspend_me) {
> +                wait_for_suspend(from, &src_state);
> +            }
>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
>              wait_for_stop(from, &src_state);
>              migrate_ensure_converge(from);
> @@ -1777,6 +1789,9 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> +            if (src_state.suspend_me) {
> +                wait_for_suspend(from, &src_state);
> +            }

Here it's pretty much uneasy to follow too, waiting for SUSPEND to come,
even after migration has already completed!

I suspect it never waits, since suspend_seen is normally always already
set (with the above hack, migrate_wait_for_dirty_mem() plays the role of
waiting for SUSPENDED).

>              wait_for_stop(from, &src_state);
>  
>          } else {

IMHO it'll be cleaner to explicitly wait for SUSPENDED when we know
migration is not yet completed.  Then, we know we're migrating with
SUSPENDED.  In summary, perhaps something squashed like this?

====8<====
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 30d4b32a35..65e6692716 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -605,8 +605,7 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
     watch_byte = qtest_readb(from, watch_address);
     do {
         usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte &&
-             !src_state.suspend_seen);
+    } while (qtest_readb(from, watch_address) == watch_byte);
 }
 
 
@@ -1805,7 +1804,12 @@ static void test_precopy_common(MigrateCommon *args)
                 wait_for_migration_pass(from);
                 args->iterations--;
             }
-            migrate_wait_for_dirty_mem(from, to);
+
+            if (src_state.suspend_me) {
+                wait_for_suspend(from, &src_state);
+            } else {
+                migrate_wait_for_dirty_mem(from, to);
+            }
 
             migrate_ensure_converge(from);
 
@@ -1814,10 +1818,6 @@ static void test_precopy_common(MigrateCommon *args)
              * hanging forever if migration didn't converge
              */
             wait_for_migration_complete(from);
-
-            if (src_state.suspend_me) {
-                wait_for_suspend(from, &src_state);
-            }
             wait_for_stop(from, &src_state);
 
         } else {
====8<====

I didn't check the postcopy patch, but I'd expect something similar would
be nice.

Thanks,

-- 
Peter Xu


