Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7C7B6D0B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhGc-0007CY-S4; Tue, 03 Oct 2023 11:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnhGb-0007CQ-GO
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:24:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnhGZ-0000UH-9g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:24:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32488a22810so1019028f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696346693; x=1696951493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4UohCEILUXcsi59L1jVbN2hJ+0fPCI3i/rZ/YvQ93s=;
 b=wA6xuscCa4/RFCsv28zZdl8QGf7QULMD7HUcH5lIEgZxV+PqrzT7JbDCia9LWGQzwV
 LdgC7gb2vJTdny/KFZ5XUmIj62hssm6xPqgQMDrLrmpxMTIDW8saK2wHv/DlyWzIKpiE
 tGvTMKfU7Xg7L8sCSUYUpS8eaLVqXnC/TWcUp/vEaYBxRW31FKWDYxFJFYur2fFmNFAc
 9vEzH0QH8WDEmcDUb0XxhuFzp+1DoCMiHkzFJckVdG7lKNnc/4NompMdjNd390r1jTvO
 NT4K+CnB0LMUvT81yPxNRCrNd5vDa5a6zXnrRel5jgScNp8vYut7e/b+IQL2W+BaPb7h
 MYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696346693; x=1696951493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4UohCEILUXcsi59L1jVbN2hJ+0fPCI3i/rZ/YvQ93s=;
 b=XSSL9bkxsDqjF4ufSuCiaWAFlMWImATkqJnMiJ2kLh3B3++vGp4GVsT2ZlAReic1NW
 Qqh5CXUDgdmztKgym7eNzuD1tGnoPC3IPzmfjndOJ7MrBoQ3QS6I09DySAboceYYyoWU
 af+thT5eEdGFNxDUayPh46oMeUhquW+jwPl5Z3R18iQ23dgYP2hRizx49Y+nlg9rYBma
 5TQYxZsYPkHpTykC4TPlBzYoHiMjo2/ipSHaGDQj2iITaOlB55aOer1hoDzY0drhLYmn
 MpslXRJyZ0myrK/Iob1Ws6ikk0ZAVmI+0iXLgBO05YKfNvHFFiiLHfZN9cCW1K8bkHvR
 7yUw==
X-Gm-Message-State: AOJu0YyTcdF2CL72dcRMe6eGturKnrUfR5fEDZGT5GBJFx3dlxng3uJ2
 aZz0I5nj2k9vTXmymWnKaOGj9Q==
X-Google-Smtp-Source: AGHT+IHx6vjspqMZn1MQ4YG/PRSjSl+lAEQO8bVjFV2EmuQXooPdLZeCO/g/DE4aAGgi5hHYMJ9tCQ==
X-Received: by 2002:a05:6000:1f04:b0:327:ffef:ba51 with SMTP id
 bv4-20020a0560001f0400b00327ffefba51mr194537wrb.49.1696346693188; 
 Tue, 03 Oct 2023 08:24:53 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 x2-20020a5d4442000000b003179b3fd837sm1811968wrr.33.2023.10.03.08.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:24:52 -0700 (PDT)
Message-ID: <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
Date: Tue, 3 Oct 2023 17:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003141932.2367-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Fabiano,

[+Alex & Daniel]

On 3/10/23 16:19, Fabiano Rosas wrote:
> We have strict rules around migration compatibility between different
> QEMU versions but not a single test that validates the migration state
> between different binaries.
> 
> Add some infrastructure to allow running the migration tests with two
> different QEMU binaries as migration source and destination.
> 
> The code now recognizes two new environment variables QTEST_QEMU_SRC
> and QTEST_QEMU_DST. Only one of the two is expected to be used along
> with the existing QTEST_QEMU_BINARY, which will automatically be used
> for the other side of migration.
> 
> Usage:
> QTEST_QEMU_DST=./build-8.2.0/qemu-system-x86_64 \
> QTEST_QEMU_BINARY=../build-8.1.0/qemu-system-x86_64 \
> ./tests/qtest/migration-test

I like it as a first step, but I'd rather run $QTEST_QEMU_SRC
directly from a docker image, i.e.:

$ docker run -it opensuse/leap
# zypper update -y && zypper install -y qemu-x86
$ docker run opensuse/leap qemu-system-x86_64 ...

> This code also works for when debugging with GDB to pass the same
> binary, but different GDB options for src and dst.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/migration-helpers.c | 168 ++++++++++++++++++++++++++++++++
>   tests/qtest/migration-helpers.h |   3 +
>   tests/qtest/migration-test.c    |  52 ++++++++--
>   3 files changed, 216 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index be00c52d00..e84360c3b3 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -12,6 +12,8 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
> +#include "qapi/qmp/qstring.h"
>   
>   #include "migration-helpers.h"
>   
> @@ -180,3 +182,169 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>       g_assert(qdict_get_bool(rsp_return, "running"));
>       qobject_unref(rsp_return);
>   }
> +
> +static char *query_pkg_version(QTestState *who)
> +{
> +    QDict *rsp;
> +    char *pkg;
> +
> +    rsp = qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-version' }");
> +    g_assert(rsp);
> +
> +    pkg = g_strdup(qdict_get_str(rsp, "package"));
> +    qobject_unref(rsp);
> +
> +    return pkg;
> +}
> +
> +static QList *query_machines(void)
> +{
> +    QDict *response;
> +    QList *list;
> +    QTestState *qts;
> +
> +    qts = qtest_init("-machine none");
> +    response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
> +    g_assert(response);
> +    list = qdict_get_qlist(response, "return");
> +    g_assert(list);
> +
> +    qtest_quit(qts);
> +    return list;
> +}
> +
> +static char *get_default_machine(QList *list)
> +{
> +    QDict *info;
> +    QListEntry *entry;
> +    QString *qstr;
> +    char *name = NULL;
> +
> +    QLIST_FOREACH_ENTRY(list, entry) {
> +        info = qobject_to(QDict, qlist_entry_obj(entry));
> +        g_assert(info);
> +
> +        if (qdict_get(info, "is-default")) {
> +            qstr = qobject_to(QString, qdict_get(info, "name"));
> +            g_assert(qstr);
> +            name = g_strdup(qstring_get_str(qstr));
> +            break;
> +        }
> +    }
> +
> +    g_assert(name);
> +    return name;
> +}
> +
> +static bool search_default_machine(QList *list, const char *theirs)
> +{
> +    QDict *info;
> +    QListEntry *entry;
> +    QString *qstr;
> +
> +    if (!theirs) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH_ENTRY(list, entry) {
> +        info = qobject_to(QDict, qlist_entry_obj(entry));
> +        g_assert(info);
> +
> +        qstr = qobject_to(QString, qdict_get(info, "name"));
> +        g_assert(qstr);
> +
> +        if (g_str_equal(qstring_get_str(qstr), theirs)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/*
> + * We need to ensure that both QEMU instances set via the QTEST_QEMU_*
> + * vars will use the same machine type. Use a custom query_machines
> + * function because the generic one in libqtest has a cache that would
> + * return the same machines for both binaries.
> + */
> +char *find_common_machine_type(const char *bin)
> +{
> +    QList *m1, *m2;
> +    g_autofree char *def1 = NULL;
> +    g_autofree char *def2 = NULL;
> +    const char *qemu_bin = getenv("QTEST_QEMU_BINARY");
> +
> +    m1 = query_machines();
> +
> +    g_setenv("QTEST_QEMU_BINARY", bin, true);
> +    m2 = query_machines();
> +    g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
> +
> +    def1 = get_default_machine(m1);
> +    def2 = get_default_machine(m2);
> +
> +    if (g_str_equal(def1, def2)) {
> +        /* either can be used */
> +        return g_strdup(def1);
> +    }
> +
> +    if (search_default_machine(m1, def2)) {
> +        return g_strdup(def2);
> +    }
> +
> +    if (search_default_machine(m2, def1)) {
> +        return g_strdup(def1);
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +/*
> + * Init a guest for migration tests using an alternate QEMU binary for
> + * either the source or destination, depending on @var. The other
> + * binary should be set as usual via QTEST_QEMU_BINARY.
> + *
> + * Expected values:
> + *   QTEST_QEMU_SRC
> + *   QTEST_QEMU_DST
> + *
> + * Warning: The generic parts of qtest could be using
> + * QTEST_QEMU_BINARY to query for properties before we reach the
> + * migration code. If the alternate binary is too dissimilar that
> + * could cause issues.
> + */
> +static QTestState *init_vm(const char *extra_args, const char *var)
> +{
> +    const char *alt_bin = getenv(var);
> +    const char *qemu_bin = getenv("QTEST_QEMU_BINARY");
> +    g_autofree char *pkg = NULL;
> +    bool src = !!strstr(var, "SRC");
> +    QTestState *qts;
> +
> +    if (alt_bin) {
> +        g_setenv("QTEST_QEMU_BINARY", alt_bin, true);
> +    }
> +
> +    qts = qtest_init(extra_args);
> +    pkg = query_pkg_version(qts);
> +
> +    g_test_message("Using %s (%s) as migration %s",
> +                   alt_bin ? alt_bin : qemu_bin,
> +                   pkg,
> +                   src ? "source" : "destination");
> +
> +    if (alt_bin) {
> +        /* restore the original */
> +        g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
> +    }
> +    return qts;
> +}
> +
> +QTestState *mig_init_src(const char *extra_args)
> +{
> +    return init_vm(extra_args, "QTEST_QEMU_SRC");
> +}
> +
> +QTestState *mig_init_dst(const char *extra_args)
> +{
> +    return init_vm(extra_args, "QTEST_QEMU_DST");
> +}
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 009e250e90..aabdbc7507 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -33,4 +33,7 @@ void wait_for_migration_complete(QTestState *who);
>   
>   void wait_for_migration_fail(QTestState *from, bool allow_active);
>   
> +QTestState *mig_init_src(const char *extra_args);
> +QTestState *mig_init_dst(const char *extra_args);
> +char *find_common_machine_type(const char *bin);
>   #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 1b43df5ca7..60f0b15417 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -45,6 +45,7 @@ unsigned end_address;
>   static bool uffd_feature_thread_id;
>   static bool got_src_stop;
>   static bool got_dst_resume;
> +static char *common_machine_type;
>   
>   /*
>    * An initial 3 MB offset is used as that corresponds
> @@ -712,6 +713,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       g_autofree char *shmem_path = NULL;
>       const char *arch = qtest_get_arch();
>       const char *memory_size;
> +    g_autofree char *machine = NULL;
>   
>       if (args->use_shmem) {
>           if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> @@ -723,18 +725,30 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       got_src_stop = false;
>       got_dst_resume = false;
>       bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> +
>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>           /* the assembled x86 boot sector should be exactly one sector large */
>           assert(sizeof(x86_bootsect) == 512);
>           init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
>           memory_size = "150M";
> -        arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
> +
> +        if (common_machine_type) {
> +            machine = g_strdup_printf("-machine %s", common_machine_type);
> +        }
> +
> +        arch_opts = g_strdup_printf("%s -drive file=%s,format=raw",
> +                                    machine, bootpath);
>           start_address = X86_TEST_MEM_START;
>           end_address = X86_TEST_MEM_END;
>       } else if (g_str_equal(arch, "s390x")) {
>           init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
>           memory_size = "128M";
> -        arch_opts = g_strdup_printf("-bios %s", bootpath);
> +
> +        if (common_machine_type) {
> +            machine = g_strdup_printf("-machine %s", common_machine_type);
> +        }
> +
> +        arch_opts = g_strdup_printf("%s -bios %s", machine, bootpath);
>           start_address = S390_TEST_MEM_START;
>           end_address = S390_TEST_MEM_END;
>       } else if (strcmp(arch, "ppc64") == 0) {
> @@ -745,12 +759,24 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                         "'nvramrc=hex .\" _\" begin %x %x "
>                                         "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>                                         "until'", end_address, start_address);
> -        arch_opts = g_strdup("-nodefaults -machine vsmt=8");
> +
> +        if (common_machine_type) {
> +            machine = g_strdup_printf("%s,", common_machine_type);
> +        }
> +
> +        arch_opts = g_strdup_printf("-nodefaults -machine %svsmt=8", machine);
>       } else if (strcmp(arch, "aarch64") == 0) {
>           init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
>           memory_size = "150M";
> -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
> -                                    "-kernel %s", bootpath);
> +
> +        if (common_machine_type) {
> +            machine = g_strdup_printf("%s", common_machine_type);
> +        } else {
> +            machine = g_strdup("virt");
> +        }
> +
> +        arch_opts = g_strdup_printf("-machine %s,gic-version=max -cpu max "
> +                                    "-kernel %s", machine, bootpath);
>           start_address = ARM_TEST_MEM_START;
>           end_address = ARM_TEST_MEM_END;
>   
> @@ -799,7 +825,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                    args->opts_source ? args->opts_source : "",
>                                    ignore_stderr);
>       if (!args->only_target) {
> -        *from = qtest_init(cmd_source);
> +        *from = mig_init_src(cmd_source);
>           qtest_qmp_set_event_callback(*from,
>                                        migrate_watch_for_stop,
>                                        &got_src_stop);
> @@ -819,7 +845,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                    shmem_opts,
>                                    args->opts_target ? args->opts_target : "",
>                                    ignore_stderr);
> -    *to = qtest_init(cmd_target);
> +    *to = mig_init_dst(cmd_target);
>       qtest_qmp_set_event_callback(*to,
>                                    migrate_watch_for_resume,
>                                    &got_dst_resume);
> @@ -2769,6 +2795,8 @@ int main(int argc, char **argv)
>       const char *arch;
>       g_autoptr(GError) err = NULL;
>       int ret;
> +    const char *qemu_src = getenv("QTEST_QEMU_SRC");
> +    const char *qemu_dst = getenv("QTEST_QEMU_DST");
>   
>       g_test_init(&argc, &argv, NULL);
>   
> @@ -2780,6 +2808,16 @@ int main(int argc, char **argv)
>           return 0;
>       }
>   
> +    if (qemu_src || qemu_dst) {
> +        if (qemu_src && qemu_dst) {
> +            g_test_message("Only one of QTEST_QEMU_SRC, QTEST_QEMU_DST is allowed.");
> +            exit(1);
> +        }
> +        common_machine_type = find_common_machine_type(qemu_src ? qemu_src : qemu_dst);
> +        g_test_message("Using two different QEMU binaries. Common machine type: %s",
> +                       common_machine_type);
> +    }
> +
>       has_uffd = ufd_version_check();
>       arch = qtest_get_arch();
>   


