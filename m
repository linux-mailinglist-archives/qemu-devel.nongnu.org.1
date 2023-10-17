Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD27CBC26
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qseOW-0002Ui-Tv; Tue, 17 Oct 2023 03:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qseOU-0002UZ-Kl
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qseOS-0000h2-Tv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697527291;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=InTtSCbx3E+vpPsDdSqqSou4+Eqo6+5lDhlOatm4yl8=;
 b=gLPbHUhE+yL4fNlK1gxF9bNUztZGPZCtjTj1fzkowP+qkfjh6D+bKlISEdhbwgZgKZNR+x
 zIVkyFETGAUBccGaXn/0a3x0JOMX0UCmSKs8X1ZN/NiuZh3+EGWdPS7h8qhylNtXy9CKLZ
 TRAk3TFyZ7PviLd91aS6osFH9C/hE8w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-cHd0VTc8MKSWnw68seL2xw-1; Tue, 17 Oct 2023 03:21:19 -0400
X-MC-Unique: cHd0VTc8MKSWnw68seL2xw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so1923147f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697527278; x=1698132078;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InTtSCbx3E+vpPsDdSqqSou4+Eqo6+5lDhlOatm4yl8=;
 b=HhVpp0jWxBX8P2v24dZ6hXahy9szloUM2svXp9SNUE9RFqOCDSZcPYTh97ehRxe63d
 ouYdewyiKUn6iVY5WHWl5+9BXd5VfO3rhwnhGwnTyeG5Qj0mQ2lSxyllSXwML3FvhI5X
 9kXkCj8jhAFlfE8hQHcX5gYxUHSxkqkiwst+miliOkbZyOfahrHZCtXtpwg5TsFEOKwa
 XDNjgdKwiCoKMJE/cuhHFoQVyKt861/ptCsdQW5EDmaHpwY4VABvILSbB9Km8fdpqNRY
 z5aEyqQeuwG2MQR4En+4VxwxA38ZStwx9i2gceLEOOGol2uagX9hpgFg/Fwip+U+T8fw
 ZVxQ==
X-Gm-Message-State: AOJu0YxfMf9YSqzh5IIpj4x08St+SuHkLwK4yNtyr095TnS99OHj5NO3
 JzWyfu/zGJ/i6zxU2EmTaZOmHGDXjrQ/h8dafE3+V7nGCd/7Ny7z9t2M3bVgwRgAZiW4dwho7sx
 VePGn7MKCVMG7GP4=
X-Received: by 2002:a05:6000:b0a:b0:329:6d09:61f7 with SMTP id
 dj10-20020a0560000b0a00b003296d0961f7mr1280492wrb.48.1697527278504; 
 Tue, 17 Oct 2023 00:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKAtXSrjX7ElfJvVm3AbqvxSc/6ocnl7eRBdZl5nnZeKLXmX3SHd6YulEgYreVAFgUkojLBA==
X-Received: by 2002:a05:6000:b0a:b0:329:6d09:61f7 with SMTP id
 dj10-20020a0560000b0a00b003296d0961f7mr1280464wrb.48.1697527278084; 
 Tue, 17 Oct 2023 00:21:18 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b6-20020adfee86000000b0032da471c0c1sm1001208wro.7.2023.10.17.00.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 00:21:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fam Zheng <fam@euphon.net>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  John Snow <jsnow@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 11/38] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <87sf6azapv.fsf@suse.de> (Fabiano Rosas's message of "Mon, 16 Oct
 2023 15:25:00 -0300")
References: <20231016100706.2551-1-quintela@redhat.com>
 <20231016100706.2551-12-quintela@redhat.com> <87sf6azapv.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 09:21:16 +0200
Message-ID: <87bkcx3eab.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
D> Juan Quintela <quintela@redhat.com> writes:
>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> Add basic tests for file-based migration.
>>
>> Note that we cannot use test_precopy_common because that routine
>> expects it to be possible to run the migration live. With the file
>> transport there is no live migration because we must wait for the
>> source to finish writing the migration data to the file before the
>> destination can start reading. Add a new migration function
>> specifically to handle the file migration.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <20230712190742.22294-7-farosas@suse.de>

>> +static void file_offset_finish_hook(QTestState *from, QTestState *to,
>> +                                    void *opaque)
>> +{
>> +#if defined(__linux__)
>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>> +    uintptr_t *addr, *p;
>> +    int fd;
>> +
>> +    fd = open(path, O_RDONLY);
>> +    g_assert(fd != -1);
>> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>> +    g_assert(addr != MAP_FAILED);
>> +
>> +    /*
>> +     * Ensure the skipped offset contains zeros and the migration
>> +     * stream starts at the right place.
>> +     */
>> +    p = addr;
>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>> +        g_assert(*p == 0);
>> +        p++;
>> +    }
>> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>
> This truncates to 32-bits, so it breaks on a BE host. We need this:
>
> -->8--
> From ea0c2d1c988add48d9754891a9fc7f6854a9718a Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Mon, 16 Oct 2023 15:21:49 -0300
> Subject: [PATCH] fixup! tests/qtest: migration-test: Add tests for file-based
>  migration
>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index da02b6d692..e1c110537b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1966,7 +1966,7 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>          g_assert(*p == 0);
>          p++;
>      }
> -    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
> +    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>  
>      munmap(addr, size);
>      close(fd);

I am resubmitting with this change.

But I think we need to change this:

>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>> +    uintptr_t *addr, *p;

I think we should change the test so the file is 64 bits on every
architecture.
Then we can cast to void * or uintptr_t as needed.

Later, Juan.


