Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8EC7BAE15
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 23:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoW92-0004x1-Rv; Thu, 05 Oct 2023 17:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoW90-0004wi-1w
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoW8y-0007Bc-9V
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696542266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUd/rpdpsiIKEFJINVElZ25rzGFmZNi30Uh8lyzPlVE=;
 b=QBni0IuOIFUCxo+Iyo7FHeplaIkw7ibIu3hSHpvgMT9oL3i9zquqXVnO2tO/bp+saYXzxM
 981FMklwKD5cYeAkdageGZ+IuuTknn0t/b4aqSKwMQ7oYDNy7ieFRxU4xFPropR4a/n4c4
 gzvCNPuhqbuDwBsr51qZ8VkjJuVgOrE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-3am4-UwjPaq6zBlm4cD1pQ-1; Thu, 05 Oct 2023 17:44:25 -0400
X-MC-Unique: 3am4-UwjPaq6zBlm4cD1pQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65623d0075aso2615136d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 14:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696542265; x=1697147065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUd/rpdpsiIKEFJINVElZ25rzGFmZNi30Uh8lyzPlVE=;
 b=PVgAVuJFGrlCUtgtz7O09GPLe5AAiApRpAtW949pAsVRDsuD1UYsQz25hnO96CMWME
 izE9+svZ5HsJ2U0KrmtZWBFCSsdhq0y76NLzsEQH7ZOP9YRwcEYdR8yOJopgpnjDGG/8
 ye9oGspjcr7Y+MGQtR3TXYTGjIWmTm1gU3zPK+3G9eU2lT5K5iqNqW4j3sX3TZYe0irD
 KbwtIbSCsnd5aIuJhA7s7oDFVK7/Bi3svKBHpYL7G9XA+vAHo1r/riQIVTwKRH9fnzjc
 JyBiCrZRwRn4DO9qazy7L9WLgnD7m51sBEX62Hlv8hPTKNDIEbUzDKxWF2NhPOpqwFNQ
 LJlA==
X-Gm-Message-State: AOJu0YzrD3GP9ZBo1QDhfHTVMGA/mXsKzgvH06a3KT/PZb9sOn7zrBj9
 lA898m5vCecCnmM6XiMMC87qzd9qxc96GT9mpiUZGnglwM9bF1r8K7ENRa95vrk0fPI69/PRpLV
 u/d1frnXU2PAQ728=
X-Received: by 2002:a05:6214:2dc7:b0:66a:d2c0:911 with SMTP id
 nc7-20020a0562142dc700b0066ad2c00911mr2815176qvb.0.1696542264811; 
 Thu, 05 Oct 2023 14:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/t4PWdOWVvuMz+RF6NGQ01p3zoFCFgiPK1jREHfZPhzpLkxXLMMasOVYYgkPxkn5ASegUw==
X-Received: by 2002:a05:6214:2dc7:b0:66a:d2c0:911 with SMTP id
 nc7-20020a0562142dc700b0066ad2c00911mr2815166qvb.0.1696542264496; 
 Thu, 05 Oct 2023 14:44:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o15-20020a0cf4cf000000b006590d020260sm830754qvm.98.2023.10.05.14.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 14:44:24 -0700 (PDT)
Date: Thu, 5 Oct 2023 17:44:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
Message-ID: <ZR8uMcN5WwA2kC9k@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com>
 <87edi9fbh5.fsf@suse.de> <878r8hfavf.fsf@suse.de>
 <ZR8iwwOeXWI+x9YX@x1n> <875y3kg4hv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y3kg4hv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 05, 2023 at 06:10:20PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Oct 05, 2023 at 10:37:56AM -0300, Fabiano Rosas wrote:
> >> >> +    /*
> >> >> +     * Make sure both QEMU instances will go into RECOVER stage, then test
> >> >> +     * kicking them out using migrate-pause.
> >> >> +     */
> >> >> +    wait_for_postcopy_status(from, "postcopy-recover");
> >> >> +    wait_for_postcopy_status(to, "postcopy-recover");
> >> >
> >> > Is this wait out of place? I think we're trying to resume too fast after
> >> > migrate_recover():
> >> >
> >> > # {
> >> > #     "error": {
> >> > #         "class": "GenericError",
> >> > #         "desc": "Cannot resume if there is no paused migration"
> >> > #     }
> >> > # }
> >> >
> >> 
> >> Ugh, sorry about the long lines:
> >> 
> >> {
> >>     "error": {
> >>         "class": "GenericError",
> >>         "desc": "Cannot resume if there is no paused migration"
> >>     }
> >> }
> >
> > Sorry I didn't get you here.  Could you elaborate your question?
> >
> 
> The test is sometimes failing with the above message.
> 
> But indeed my question doesn't make sense. I forgot migrate_recover
> happens on the destination. Nevermind.
> 
> The bug is still present nonetheless. We're going into migrate_prepare
> in some state other than POSTCOPY_PAUSED.

Oh I see.  Interestingly I cannot reproduce on my host, just like last
time..

What is your setup for running the test?  Anything special?  Here's my
cmdline:

$ cat reproduce.sh 
index=$1
loop=0

while :; do
        echo "Starting loop=$loop..."
        QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/postcopy/recovery/double-failures
        if [[ $? != 0 ]]; then
                echo "index $index REPRODUCED (loop=$loop) !"
                break
        fi
        loop=$(( loop + 1 ))
done

Survives 200+ loops and kept going.

However I think I saw what's wrong here, could you help try below fixup?

Thanks,

===8<===
From 52bd2cd5ddf472e0bb99789dba3660a626382630 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 5 Oct 2023 17:38:42 -0400
Subject: [PATCH] fixup! tests/migration-test: Add a test for postcopy hangs
 during RECOVER

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index fb7a3765e4..1bdae0a579 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1489,9 +1489,8 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
+    wait_for_postcopy_status(to, "postcopy-paused");
+    wait_for_postcopy_status(from, "postcopy-paused");
 
     if (args->postcopy_recovery_test_fail) {
         /*
@@ -1514,9 +1513,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
     migrate_qmp(from, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
-- 
2.41.0

-- 
Peter Xu


