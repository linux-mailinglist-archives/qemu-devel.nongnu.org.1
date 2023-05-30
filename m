Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8D716E9B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45sJ-0007Xx-BN; Tue, 30 May 2023 16:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q45sE-0007Xl-7H
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:23:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q45sC-0002Js-7K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:23:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1197141a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685478192; x=1688070192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRwSUksg9nszQJApX1kjgAVTyu+9IFncfUba/48txXI=;
 b=XUpLVDQAwb+BlFFc4oP+f7lMACsm8Fb2uHSIxQEhLREn9sritCP7GbC5FiVrdWO2an
 TwxdRgHykGDPChWYJhcSdb8zLpzHgaEUxqPGBEUQsd72KeKThJ3CNMaUXfWKeYbaFDQJ
 2SICy93VfRnKcQRt7W/sePsR16nx2qyyvbkoHajhaP+vGswk4ilJWPgoqkuJU8JwNwqn
 xI9AxOWyHke78LWqdcMbkRNCOu6L56aPM4m/3UDM/J0mMkqstYW6ywGKq5xSuxzSu4/e
 aBwuVA5nt7rGO3XUy6ZcJXAYDNFrNbFEruvE7SYwZV92693zf0VsQVd8E8Xy7vqtS3Xi
 sLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685478193; x=1688070193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRwSUksg9nszQJApX1kjgAVTyu+9IFncfUba/48txXI=;
 b=ExeEyRjIzNlJdmX9/R7Z5dsPxOuADaCyx/DwqFlHntaQf2zf5y4wCZLH4QYyVvt/I7
 ZIqeA2TJSHeuoQ2bePFbLmSntMze6nIfHdw6YBdZ6uaUkDzkF3z3Z9Ze2YgjhuQY3UXh
 /8YlZuKIqhCIZpwGFA1h3lS0eXNEGK+iy2JmdemQPnqL0XebLMnGC2f90JY8eXXPnEeP
 6ShKAavqaLlQGo29kMa+rUt7qdg24q4ZpTJXx0+hwYjWSsGIqTJoDeIMQibzVvKnQPcc
 LyU1hWBm9TrcH6WGHdx9fNcHRvf1cgkbpMaFXKJvz5wdxm27h1vMTiZiVCETJUd4JxoR
 6uog==
X-Gm-Message-State: AC+VfDxSFZerQ+lQOdfqXH+71WOMBy1CYKHR5SVBrIdT1RVH4D8crbYz
 y0ccyU5KPRLSVxPtARDw4C6Mxw==
X-Google-Smtp-Source: ACHHUZ7xKGzI4EPKQd4F4uT/udoCjqqOWhyVFHh/PoTBDZq9BcnKo+v459RVpDOdlVHxPEIcOguM/A==
X-Received: by 2002:a17:902:e74c:b0:1ab:267e:2f2d with SMTP id
 p12-20020a170902e74c00b001ab267e2f2dmr4008445plf.48.1685478192659; 
 Tue, 30 May 2023 13:23:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170902654700b001a9581d3ef5sm189197pln.97.2023.05.30.13.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:23:12 -0700 (PDT)
Message-ID: <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
Date: Tue, 30 May 2023 13:23:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] Migration 20230530 patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530182531.6371-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 11:25, Juan Quintela wrote:
> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
> 
>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git tags/migration-20230530-pull-request
> 
> for you to fetch changes up to c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
> 
>    migration/rdma: Check sooner if we are in postcopy for save_page() (2023-05-30 19:23:50 +0200)
> 
> ----------------------------------------------------------------
> Migration 20230530 Pull request (take 2)
> 
> Hi
> 
> Resend last PULL request, this time it compiles when CONFIG_RDMA is
> not configured in.
> 
> [take 1]
> On this PULL request:
> 
> - Set vmstate migration failure right (vladimir)
> - Migration QEMUFileHook removal (juan)
> - Migration Atomic counters (juan)
> 
> Please apply.
> 
> ----------------------------------------------------------------
> 
> Juan Quintela (16):
>    migration: Don't abuse qemu_file transferred for RDMA
>    migration/RDMA: It is accounting for zero/normal pages in two places
>    migration/rdma: Remove QEMUFile parameter when not used
>    migration/rdma: Don't use imaginary transfers
>    migration: Remove unused qemu_file_credit_transfer()
>    migration/rdma: Simplify the function that saves a page
>    migration: Create migrate_rdma()
>    migration/rdma: Unfold ram_control_before_iterate()
>    migration/rdma: Unfold ram_control_after_iterate()
>    migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>    migration/rdma: Unfold hook_ram_load()
>    migration/rdma: Create rdma_control_save_page()
>    qemu-file: Remove QEMUFileHooks
>    migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>    migration/rdma: Remove qemu_ prefix from exported functions
>    migration/rdma: Check sooner if we are in postcopy for save_page()
> 
> Vladimir Sementsov-Ogievskiy (5):
>    runstate: add runstate_get()
>    migration: never fail in global_state_store()
>    runstate: drop unused runstate_store()
>    migration: switch from .vm_was_running to .vm_old_state
>    migration: restore vmstate on migration failure

Appears to introduce multiple avocado failures:

https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286

Test summary:
tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1

https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387

Test summary:
tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1

Also fails QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/migration-test

../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 is not an instance of 
type qio-channel-rdma
qemu-system-aarch64: Not a migration stream
qemu-system-aarch64: load of migration failed: Invalid argument
Broken pipe


r~


