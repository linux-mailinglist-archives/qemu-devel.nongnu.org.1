Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593D737F19
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuMa-0001bP-BH; Wed, 21 Jun 2023 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuMW-0001b2-Na
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBuMV-00013u-0O
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687340569;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hOGeLcSvPsA0mfBzjhKfS6Mj93Fprkqf7wVdizZVIQE=;
 b=Kb30U9FCnJlKa7jvUkK9h88VYzu6QbUtC6cq9PiqlZ5GhVUgEVXyKiEWIbQSBbNld+KFJC
 q7Q17AxLsx1LnFQojGKkLgUd0eL8vAIwV/p3KtVyppbPo8S2ky9i9mzvJiBqAR69C5co/E
 C1Ao3fYw3a6Mi0QMyItvbG/uK4BKYHY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-ZQkWuKl5OBmhIp2F-g9xXQ-1; Wed, 21 Jun 2023 05:42:48 -0400
X-MC-Unique: ZQkWuKl5OBmhIp2F-g9xXQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f8fa2ef407so22006865e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687340567; x=1689932567;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOGeLcSvPsA0mfBzjhKfS6Mj93Fprkqf7wVdizZVIQE=;
 b=CpJdDBqEwwvuCXVgLbEi4zefs8Kqau87mqPZgjgNlv84SIrhhlZY5MsWO9bJb0OEYw
 7xz03o3G9N0ROHtjaW0EERZyN+hVXG4Bpmn/CPCwS2cNsphGIkHfCfWduTJd1evplc7O
 iHCWg4UwDxGdHqJWMcKly3L5QXLGHLvCVRdzS8F1PQKVN1XGvkJ5hwMzr6uTM2k0cv39
 c2eIdzSG+1WkZvOzw4uSayWztDUqgSgnZsHWb6O0RdQQ6Mfu058HyrStVKy9JtD/sh5D
 p2uTAU7ckH1ATu/wk6DvwGJ/HgamwTtODm92OKkTJjuqPP393YUrvk9yZMCE0XaT6znb
 yrvQ==
X-Gm-Message-State: AC+VfDzuex6wCJssFIXsnToEm/VKwykPdGgk6Tt/PAy1CjRd21GvOQzm
 /Spf0lFYFCTnrV0ZOLSFY9EsJr8ClQClvq7P8qK2o02YVLGLIhjLzo1+NgcvKs93Lol+cwjcgSc
 QeWM2dCAtK791k/U=
X-Received: by 2002:a7b:ce12:0:b0:3f9:b9d6:8af6 with SMTP id
 m18-20020a7bce12000000b003f9b9d68af6mr2311434wmc.25.1687340566985; 
 Wed, 21 Jun 2023 02:42:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59SKRwi6bOC7eN6n7WHHyw8ZcLB+5RSz35KUu+TuyvCAJDNy0zQUkeSWOkARFFOUEZQwH3WQ==
X-Received: by 2002:a7b:ce12:0:b0:3f9:b9d6:8af6 with SMTP id
 m18-20020a7bce12000000b003f9b9d68af6mr2311418wmc.25.1687340566669; 
 Wed, 21 Jun 2023 02:42:46 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 s14-20020a7bc38e000000b003f801c12c58sm4478562wmj.43.2023.06.21.02.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 02:42:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 03/42] migration-test: simplify shmem_opts handling
In-Reply-To: <ZJG/jqmk1hHwzXpJ@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 11:02:38 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-4-quintela@redhat.com> <ZJG/jqmk1hHwzXpJ@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 11:42:45 +0200
Message-ID: <87pm5pb17u.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jun 09, 2023 at 12:49:04AM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 73b2f01427..95ccc9bce7 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -681,9 +681,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>              "-object memory-backend-file,id=mem0,size=%s"
>>              ",mem-path=%s,share=on -numa node,memdev=mem0",
>>              memory_size, shmem_path);
>> -    } else {
>> -        shmem_path = NULL;
>> -        shmem_opts = g_strdup("");
>>      }
>>  
>>      cmd_source = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
>> @@ -696,7 +693,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                   machine_opts ? " -machine " : "",
>>                                   machine_opts ? machine_opts : "",
>>                                   memory_size, tmpfs,
>> -                                 arch_source, shmem_opts,
>> +                                 arch_source,
>> +                                 shmem_opts ? shmem_opts : "",
>>                                   args->opts_source ? args->opts_source : "",
>>                                   ignore_stderr ? ignore_stderr : "");
>>  
>> @@ -718,7 +716,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                   machine_opts ? " -machine " : "",
>>                                   machine_opts ? machine_opts : "",
>>                                   memory_size, tmpfs, uri,
>> -                                 arch_target, shmem_opts,
>> +                                 arch_target,
>> +                                 shmem_opts ? shmem_opts : "",
>
> Isn't this adding duplications instead?

I don't follow.

> Meanwhile, shmem_opts right now is auto-free.  If we do this we don't need
> it to be auto-free anymore..

We need.
It can still be from g_strdup_printf().

What this patch change is that it will never be (again) "".

It is going to be NULL or a real string, like all the other options.
The real string is generated, so it needs to be auto_free.

Later, Juan.

>>                                   args->opts_target ? args->opts_target : "",
>>                                   ignore_stderr ? ignore_stderr : "");
>>      *to = qtest_init(cmd_target);
>> -- 
>> 2.40.1
>> 


