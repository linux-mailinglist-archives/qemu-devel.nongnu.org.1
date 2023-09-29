Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15C7B2D0C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 09:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7xN-0002mW-PI; Fri, 29 Sep 2023 03:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agpr123@gmail.com>) id 1qm7xL-0002mL-68
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:30:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agpr123@gmail.com>) id 1qm7xB-0003uw-VL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:30:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso1898474066b.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695972623; x=1696577423; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:mime-version:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WLWhoPDf7qQcAqSxvYssVygljzvknd3CTo6HvpaPDI=;
 b=Xl5wFI7hEjIwZzY1T63qcwKtznO1qBMOmyj1uMUWVp9QvitQtNAXyIgxCK47Ek3LD4
 vEsrXDaYxq7SieJR0ErkQAgPkuSCsC61/bnV0yMpegSIggGsvWB3ELpakPC4qOicg6zV
 ZLiCIwGKdq70tpD38ntLQ/0MyF8uVCzcCjQvuJy7M4P9HRYkxzsxamQJySx+UYNxFwsB
 k1d+XWEeWQc86PjdVTlbyD75EdQHJUo/RyiDq2We/flFgrpCCwsbcjwP4pascAfe1IIs
 EYSWWQjZws7kOVc9CYgvhe3/UP20zuzcVdqnxS9GyEUplTaXX/Uiuv5D51w1iI/l4Ojy
 RvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695972623; x=1696577423;
 h=to:subject:message-id:date:from:in-reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7WLWhoPDf7qQcAqSxvYssVygljzvknd3CTo6HvpaPDI=;
 b=rhboALetevM7jvAqHhvr3j9twIKUj5R24m5SrEJBLbVWRZjG9rzZ45FyVB78ypbRyg
 gZjaZDKCluvbz6hHJFqtLJqKNVoif3ZpK023tUYO4wXlIDs0X/sLAltkm/K5eJZJ+9wg
 XgNfRDKTZQS7krWM7+IaGImBK1+hmxBj6ZFTUIZabXPtV5dZOooJ7TZQ/xOKEPToqTHC
 kIiYjNBwO3UqE7Kv+8ZEDwEN38sHUoLkiG7KQrTrMoaGmZNF8qgXu0a8KeDz9LrjsR4B
 gf+ckWE5m/X+c75qNpK7/aKh4LBWj9xQiHWlPQrsWx6uyuZJfWciIBO6d0cgzzYLDKJ9
 faXQ==
X-Gm-Message-State: AOJu0YyPiToWk6hEJiDKfl569i2JFjL9XYGXTtri5PpyVE7T2VB1TwpE
 MVMSYds1i1r8aI1xyy0PcUFQ2caC3+5ZrWy++pinfyZsVy0=
X-Google-Smtp-Source: AGHT+IEnKitcgD1/dp7WUvx93JeVr1HGhDNPStKC6lsJi0X6l+VEkl5pw+XmHPp1P6R7LIfr997xqTm1M2n7HUK+OtE=
X-Received: by 2002:a17:907:75c2:b0:9a1:ddb9:6546 with SMTP id
 jl2-20020a17090775c200b009a1ddb96546mr3104697ejc.61.1695972622340; Fri, 29
 Sep 2023 00:30:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mailman.8199.1658851987.1146.qemu-devel@nongnu.org>
From: Prashant V Agarwal <agpr123@gmail.com>
Date: Fri, 29 Sep 2023 13:00:00 +0530
Message-ID: <CALOWxgP890RnUDa4vjnijuy8yh8jKHhDZB3B5eqa-0huY7ZSHQ@mail.gmail.com>
Subject: Re: Qemu-devel Digest, Vol 232, Issue 306
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b41a1906067a6530"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=agpr123@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000b41a1906067a6530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Jul 2022, 10:24 pm , <qemu-devel-request@nongnu.org> wrote:

> Send Qemu-devel mailing list submissions to
>         qemu-devel@nongnu.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.nongnu.org/mailman/listinfo/qemu-devel
> or, via email, send a message with subject or body 'help' to
>         qemu-devel-request@nongnu.org
>
> You can reach the person managing the list at
>         qemu-devel-owner@nongnu.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Qemu-devel digest..."
>
>
> Today's Topics:
>
>    1. [PATCH V9 45/46] migration: notifier error reporting
>       (Steve Sistare)
>    2. [PATCH V9 36/46] chardev: cpr framework (Steve Sistare)
>    3. [PATCH V9 41/46] python/machine: QEMUMachine
>       reopen_qmp_connection (Steve Sistare)
>    4. [PATCH V9 43/46] vl: start on wakeup request (Steve Sistare)
>    5. [PATCH V9 44/46] migration: fix suspended runstate (Steve Sistare)
>    6. [PATCH V9 42/46] tests/avocado: add cpr regression test
>       (Steve Sistare)
>    7. [PATCH V9 46/46] vfio: allow cpr-reboot migration if
>       suspended (Steve Sistare)
>    8. [PATCH V9 23/46] cpr: add exec-mode blockers (Steve Sistare)
>    9. [PATCH V9 09/46] cpr: reboot mode (Steve Sistare)
>   10. [PATCH V9 31/46] vfio-pci: cpr part 1 (fd and dma) (Steve Sistare)
>   11. [PATCH V9 39/46] chardev: cpr for sockets (Steve Sistare)
>   12. [PATCH V9 15/46] migration: cpr-exec-args parameter
>       (Steve Sistare)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 26 Jul 2022 09:10:42 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 45/46] migration: notifier error reporting
> Message-ID:
>         <1658851843-236870-46-git-send-email-steven.sistare@oracle.com>
>
> Provide migration_notifier_set_error(), which allows migration notifiers
> to return an error message indicating they have failed, which halts the
> migration.  The error message is visible in the 'info migrate' command.
>
> No functional change until calls to migration_notifier_set_error are
> added.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h |  3 ++-
>  migration/migration.c    | 31 +++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index d4c2d7d..e5d8c81 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -63,7 +63,8 @@ bool migration_is_active(MigrationState *);
>  void migration_add_notifier(Notifier *notify,
>                              void (*func)(Notifier *notifier, void *data)=
);
>  void migration_remove_notifier(Notifier *notify);
> -void migration_call_notifiers(MigrationState *s);
> +int migration_call_notifiers(MigrationState *s);
> +void migration_notifier_set_error(MigrationState *s, Error *err);
>  bool migration_in_setup(MigrationState *);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 45eebea..d477b58 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1924,6 +1924,8 @@ static void block_cleanup_parameters(MigrationState
> *s)
>
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
> +    bool already_failed;
> +
>      qemu_bh_delete(s->cleanup_bh);
>      s->cleanup_bh =3D NULL;
>
> @@ -1973,7 +1975,15 @@ static void migrate_fd_cleanup(MigrationState *s)
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    migration_call_notifiers(s);
> +
> +    already_failed =3D migration_has_failed(s);
> +    if (migration_call_notifiers(s)) {
> +        if (!already_failed) {
> +            migrate_set_state(&s->state, s->state,
> MIGRATION_STATUS_FAILED);
> +            /* Notify again to recover from this late failure. */
> +            migration_call_notifiers(s);
> +        }
> +    }
>      block_cleanup_parameters(s);
>      cpr_exec();
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -2084,9 +2094,16 @@ void migration_remove_notifier(Notifier *notify)
>      }
>  }
>
> -void migration_call_notifiers(MigrationState *s)
> +int migration_call_notifiers(MigrationState *s)
>  {
>      notifier_list_notify(&migration_state_notifiers, s);
> +    return (s->error !=3D NULL);
> +}
> +
> +void migration_notifier_set_error(MigrationState *s, Error *err)
> +{
> +    migrate_set_error(s, err);
> +    error_report_err(err);
>  }
>
>  bool migration_in_setup(MigrationState *s)
> @@ -3381,7 +3398,9 @@ static int postcopy_start(MigrationState *ms)
>       * spice needs to trigger a transition now
>       */
>      ms->postcopy_after_devices =3D true;
> -    migration_call_notifiers(ms);
> +    if (migration_call_notifiers(ms)) {
> +        goto fail;
> +    }
>
>      ms->downtime =3D  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_s=
top;
>
> @@ -4412,7 +4431,11 @@ void migrate_fd_connect(MigrationState *s, Error
> *error_in)
>          rate_limit =3D s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
>
>          /* Notify before starting migration thread */
> -        migration_call_notifiers(s);
> +        if (migration_call_notifiers(s)) {
> +            migrate_set_state(&s->state, s->state,
> MIGRATION_STATUS_FAILED);
> +            migrate_fd_cleanup(s);
> +            return;
> +        }
>      }
>
>      qemu_file_set_rate_limit(s->to_dst_file, rate_limit);
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 26 Jul 2022 09:10:33 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 36/46] chardev: cpr framework
> Message-ID:
>         <1658851843-236870-37-git-send-email-steven.sistare@oracle.com>
>
> Add QEMU_CHAR_FEATURE_CPR for devices that support cpr-exec by preserving
> an open descriptor across exec.  Add the chardev reopen-on-cpr option for
> devices that should be closed on cpr and reopened after exec.
>
> Enable cpr for a chardev if it has QEMU_CHAR_FEATURE_CPR and reopen-on-cp=
r
> is false.  Allow cpr-save if either QEMU_CHAR_FEATURE_CPR or reopen-on-cp=
r
> is true for all chardevs in the configuration.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  chardev/char.c         | 49
> +++++++++++++++++++++++++++++++++++++++++++++----
>  include/chardev/char.h |  5 +++++
>  qapi/char.json         |  7 ++++++-
>  qemu-options.hx        | 26 ++++++++++++++++++++++----
>  4 files changed, 78 insertions(+), 9 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 0169d8d..01755d7 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -36,6 +36,8 @@
>  #include "qemu/help_option.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> +#include "migration/cpr-state.h"
> +#include "migration/blocker.h"
>  #include "qemu/id.h"
>  #include "qemu/coroutine.h"
>  #include "qemu/yank.h"
> @@ -236,26 +238,55 @@ int qemu_chr_add_client(Chardev *s, int fd)
>  static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
>                             bool *be_opened, Error **errp)
>  {
> +    ERRP_GUARD();
> +    g_autofree char *fdname =3D NULL;
> +
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>      /* Any ChardevCommon member would work */
>      ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> +    bool has_logfile =3D (common && common->has_logfile);
> +    bool has_feature_cpr;
>
> -    if (common && common->has_logfile) {
> +    if (has_logfile) {
>          int flags =3D O_WRONLY;
> +        fdname =3D g_strdup_printf("%s_log", chr->label);
>          if (common->has_logappend &&
>              common->logappend) {
>              flags |=3D O_APPEND;
>          } else {
>              flags |=3D O_TRUNC;
>          }
> -        chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp);
> +        chr->logfd =3D cpr_find_fd(fdname, 0);
> +        if (chr->logfd < 0) {
> +            chr->logfd =3D qemu_create(common->logfile, flags, 0666, err=
p);
> +        }
>          if (chr->logfd < 0) {
>              return;
>          }
>      }
>
> +    chr->reopen_on_cpr =3D (common && common->reopen_on_cpr);
> +
>      if (cc->open) {
>          cc->open(chr, backend, be_opened, errp);
> +        if (*errp) {
> +            return;
> +        }
> +    }
> +
> +    /* Evaluate this after the open method sets the feature */
> +    has_feature_cpr =3D qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_CPR)=
;
> +    chr->cpr_enabled =3D !chr->reopen_on_cpr && has_feature_cpr;
> +
> +    if (!chr->reopen_on_cpr && !has_feature_cpr) {
> +        chr->cpr_blocker =3D NULL;
> +        error_setg(&chr->cpr_blocker,
> +                "chardev %s -> %s does not allow cpr. See reopen-on-cpr.=
",
> +                chr->label, chr->filename);
> +        migrate_add_blockers(&chr->cpr_blocker, errp, MIG_MODE_CPR_EXEC,
> -1);
> +
> +    } else if (chr->cpr_enabled && has_logfile) {
> +        cpr_resave_fd(fdname, 0, chr->logfd);
>      }
>  }
>
> @@ -297,11 +328,16 @@ static void char_finalize(Object *obj)
>      if (chr->be) {
>          chr->be->chr =3D NULL;
>      }
> -    g_free(chr->filename);
> -    g_free(chr->label);
>      if (chr->logfd !=3D -1) {
> +        g_autofree char *fdname =3D g_strdup_printf("%s_log", chr->label=
);
> +        if (chr->cpr_enabled) {
> +            cpr_delete_fd(fdname, 0);
> +        }
>          close(chr->logfd);
>      }
> +    migrate_del_blocker(&chr->cpr_blocker);
> +    g_free(chr->filename);
> +    g_free(chr->label);
>      qemu_mutex_destroy(&chr->chr_write_lock);
>  }
>
> @@ -501,6 +537,8 @@ void qemu_chr_parse_common(QemuOpts *opts,
> ChardevCommon *backend)
>
>      backend->has_logappend =3D true;
>      backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
> +
> +    backend->reopen_on_cpr =3D qemu_opt_get_bool(opts, "reopen-on-cpr",
> false);
>  }
>
>  static const ChardevClass *char_get_class(const char *driver, Error
> **errp)
> @@ -942,6 +980,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "abstract",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "reopen-on-cpr",
> +            .type =3D QEMU_OPT_BOOL,
>  #endif
>          },
>          { /* end of list */ }
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index a319b5f..bbf2560 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -50,6 +50,8 @@ typedef enum {
>      /* Whether the gcontext can be changed after calling
>       * qemu_chr_be_update_read_handlers() */
>      QEMU_CHAR_FEATURE_GCONTEXT,
> +    /* Whether the device supports cpr */
> +    QEMU_CHAR_FEATURE_CPR,
>
>      QEMU_CHAR_FEATURE_LAST,
>  } ChardevFeature;
> @@ -67,6 +69,9 @@ struct Chardev {
>      int be_open;
>      /* used to coordinate the chardev-change special-case: */
>      bool handover_yank_instance;
> +    bool reopen_on_cpr;
> +    bool cpr_enabled;
> +    Error *cpr_blocker;
>      GSource *gsource;
>      GMainContext *gcontext;
>      DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
> diff --git a/qapi/char.json b/qapi/char.json
> index 923dc50..0c3558e 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -204,12 +204,17 @@
>  # @logfile: The name of a logfile to save output
>  # @logappend: true to append instead of truncate
>  #             (default to false to truncate)
> +# @reopen-on-cpr: if true, close device's fd on cpr-save and reopen it
> after
> +#                 cpr-exec. Set this to allow CPR on a device that does
> not
> +#                 support QEMU_CHAR_FEATURE_CPR. defaults to false.
> +#                 since 7.1.
>  #
>  # Since: 2.6
>  ##
>  { 'struct': 'ChardevCommon',
>    'data': { '*logfile': 'str',
> -            '*logappend': 'bool' } }
> +            '*logappend': 'bool',
> +            '*reopen-on-cpr': 'bool' } }
>
>  ##
>  # @ChardevFile:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3ed9270..ea79afa 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3295,43 +3295,57 @@ DEFHEADING(Character device options:)
>
>  DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev help\n"
> -    "-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
> +    "-chardev
> null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off][,reopen=
-on-cpr=3Don|off]\n"
>      "-chardev
> socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4=3Don|off][,ipv6=
=3Don|off][,nodelay=3Don|off]\n"
>      "
>  [,server=3Don|off][,wait=3Don|off][,telnet=3Don|off][,websocket=3Don|off=
][,reconnect=3Dseconds][,mux=3Don|off]\n"
> -    "
>  [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID][,tls-authz=3DID]=
 (tcp)\n"
> +    "
>  [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID][,tls-authz=3DID]=
[,reopen-on-cpr=3Don|off]
> (tcp)\n"
>      "-chardev
> socket,id=3Did,path=3Dpath[,server=3Don|off][,wait=3Don|off][,telnet=3Don=
|off][,websocket=3Don|off][,reconnect=3Dseconds]\n"
> -    "
>  [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off][,abstract=3Don|off=
][,tight=3Don|off]
> (unix)\n"
> +    "
>  [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off][,abstract=3Don|off=
][,tight=3Don|off][,reopen-on-cpr=3Don|off]
> (unix)\n"
>      "-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocalad=
dr]\n"
>      "
>  [,localport=3Dlocalport][,ipv4=3Don|off][,ipv6=3Don|off][,mux=3Don|off]\=
n"
> -    "         [,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,logfile=3DPATH][,logappend=3Don|off][,reopen-on-cpr=3Don=
|off]\n"
>      "-chardev
> msmouse,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dcols][,rows=3Drow=
s]]\n"
>      "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> file,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|=
off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|=
off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #ifdef _WIN32
>      "-chardev
> console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
>      "-chardev
> serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
>  #else
>      "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3DPATH][,logappen=
d=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
>      "-chardev
> braille,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #endif
>  #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
>          || defined(__NetBSD__) || defined(__OpenBSD__) ||
> defined(__DragonFly__)
>      "-chardev
> serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> tty,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|o=
ff]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #endif
>  #if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
>      "-chardev
> parallel,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> parport,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #endif
>  #if defined(CONFIG_SPICE)
>      "-chardev
> spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>      "-chardev
> spiceport,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> +    "         [,reopen-on-cpr=3Don|off]\n"
>  #endif
>      , QEMU_ARCH_ALL
>  )
> @@ -3406,6 +3420,10 @@ The general form of a character device option is:
>      ``logappend`` option controls whether the log file will be truncated
>      or appended to when opened.
>
> +    Every backend supports the ``reopen-on-cpr`` option.  If on, the
> +    devices's descriptor is closed during cpr save, and reopened after
> exec.
> +    This is useful for devices that do not support cpr.
> +
>  The available backends are:
>
>  ``-chardev null,id=3Did``
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 26 Jul 2022 09:10:38 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 41/46] python/machine: QEMUMachine
>         reopen_qmp_connection
> Message-ID:
>         <1658851843-236870-42-git-send-email-steven.sistare@oracle.com>
>
> Provide reopen_qmp_connection() to reopen a closed monitor connection.
> This is needed by cpr, because qemu exec closes the monitor socket.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  python/qemu/machine/machine.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/python/qemu/machine/machine.py
> b/python/qemu/machine/machine.py
> index d05950e..60b934d 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -491,6 +491,15 @@ def _close_qmp_connection(self) -> None:
>          finally:
>              self._qmp_connection =3D None
>
> +    def reopen_qmp_connection(self):
> +        self._close_qmp_connection()
> +        self._qmp_connection =3D QEMUMonitorProtocol(
> +            self._monitor_address,
> +            server=3DTrue,
> +            nickname=3Dself._name
> +        )
> +        self._qmp.accept(self._qmp_timer)
> +
>      def _early_cleanup(self) -> None:
>          """
>          Perform any cleanup that needs to happen before the VM exits.
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 26 Jul 2022 09:10:40 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 43/46] vl: start on wakeup request
> Message-ID:
>         <1658851843-236870-44-git-send-email-steven.sistare@oracle.com>
>
> If qemu starts and loads a VM in the suspended state, then a later wakeup
> request will set the state to running, which is not sufficient to
> initialize
> the vm, as vm_start was never called during this invocation of qemu.  See
> qemu_system_wakeup_request().
>
> Define the start_on_wakeup_requested() hook to cause vm_start() to be
> called
> when processing the wakeup request.  This will be called in a subsequent
> migration patch.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/sysemu/runstate.h |  1 +
>  softmmu/runstate.c        | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index a5f0738..cfcdbf5 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -57,6 +57,7 @@ void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
>  bool qemu_wakeup_suspend_enabled(void);
> +void qemu_system_start_on_wakeup_request(void);
>  void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
>  void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>  void qemu_register_wakeup_notifier(Notifier *notifier);
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index fb86740..c7db5ac 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -338,6 +338,7 @@ void vm_state_notify(bool running, RunState state)
>      }
>  }
>
> +static bool start_on_wakeup_requested;
>  static ShutdownCause reset_requested;
>  static ShutdownCause shutdown_requested;
>  static int shutdown_signal;
> @@ -571,6 +572,11 @@ void qemu_register_suspend_notifier(Notifier
> *notifier)
>      notifier_list_add(&suspend_notifiers, notifier);
>  }
>
> +void qemu_system_start_on_wakeup_request(void)
> +{
> +    start_on_wakeup_requested =3D true;
> +}
> +
>  void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
>  {
>      trace_system_wakeup_request(reason);
> @@ -583,7 +589,14 @@ void qemu_system_wakeup_request(WakeupReason reason,
> Error **errp)
>      if (!(wakeup_reason_mask & (1 << reason))) {
>          return;
>      }
> -    runstate_set(RUN_STATE_RUNNING);
> +
> +    if (start_on_wakeup_requested) {
> +        start_on_wakeup_requested =3D false;
> +        vm_start();
> +    } else {
> +        runstate_set(RUN_STATE_RUNNING);
> +    }
> +
>      wakeup_reason =3D reason;
>      qemu_notify_event();
>  }
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 26 Jul 2022 09:10:41 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 44/46] migration: fix suspended runstate
> Message-ID:
>         <1658851843-236870-45-git-send-email-steven.sistare@oracle.com>
>
> Migration of a guest in the suspended state is broken.  The incoming
> migration code automatically tries to wake the guest, which IMO is
> wrong -- the guest should end migration in the same state it started.
> Further, the wakeup attempt merely sets state to running but does
> not actually start the guest, as vm_start was never called during this
> invocation of qemu.
>
> To fix, leave the guest in the suspended state, but call
> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> when the client sends a system_wakeup command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 11 ++++-------
>  softmmu/runstate.c    |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index e0fc2b8..45eebea 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -568,6 +568,10 @@ static void process_incoming_migration_bh(void
> *opaque)
>          vm_start();
>      } else {
>          runstate_set(global_state_get_runstate());
> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> +            /* Force vm_start to be called later. */
> +            qemu_system_start_on_wakeup_request();
> +        }
>      }
>      /*
>       * This must happen after any state changes since as soon as an
> external
> @@ -3273,7 +3277,6 @@ static int postcopy_start(MigrationState *ms)
>      qemu_mutex_lock_iothread();
>      trace_postcopy_start_set_run();
>
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>      global_state_store();
>      ret =3D vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
>      if (ret < 0) {
> @@ -3484,7 +3487,6 @@ static void migration_completion(MigrationState *s)
>      if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
>          qemu_mutex_lock_iothread();
>          s->downtime_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>          s->vm_was_running =3D runstate_is_running();
>          ret =3D global_state_store();
>
> @@ -4285,11 +4287,6 @@ static void *bg_migration_thread(void *opaque)
>
>      qemu_mutex_lock_iothread();
>
> -    /*
> -     * If VM is currently in suspended state, then, to make a valid
> runstate
> -     * transition in vm_stop_force_state() we need to wakeup it up.
> -     */
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>      s->vm_was_running =3D runstate_is_running();
>
>      if (global_state_store()) {
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index c7db5ac..6ba0a4e 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -154,6 +154,7 @@ static const RunStateTransition
> runstate_transitions_def[] =3D {
>      { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
>      { RUN_STATE_SUSPENDED, RUN_STATE_RUNNING },
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
>
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 26 Jul 2022 09:10:39 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 42/46] tests/avocado: add cpr regression test
> Message-ID:
>         <1658851843-236870-43-git-send-email-steven.sistare@oracle.com>
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  MAINTAINERS          |   1 +
>  tests/avocado/cpr.py | 176
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 tests/avocado/cpr.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b93b0bb..adc1218 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3172,6 +3172,7 @@ F: stubs/cpr-state.c
>  F: include/migration/cpr.h
>  F: migration/cpr.c
>  F: hw/vfio/cpr.c
> +F: tests/avocado/cpr.py
>
>  Record/replay
>  M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> diff --git a/tests/avocado/cpr.py b/tests/avocado/cpr.py
> new file mode 100644
> index 0000000..11e1376
> --- /dev/null
> +++ b/tests/avocado/cpr.py
> @@ -0,0 +1,176 @@
> +# cpr test
> +
> +# Copyright (c) 2021, 2022 Oracle and/or its affiliates.
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +
> +import tempfile
> +from avocado_qemu import QemuSystemTest
> +from avocado.utils import wait
> +
> +class Cpr(QemuSystemTest):
> +    """
> +    :avocado: tags=3Dcpr
> +    """
> +
> +    timeout =3D 5
> +    fast_timeout =3D 1
> +
> +    @staticmethod
> +    def has_status(vm, status, command):
> +        return vm.command(command)['status'] in status
> +
> +    def wait_for_status(self, vm, status, command):
> +        wait.wait_for(self.has_status,
> +                      timeout=3Dself.timeout,
> +                      step=3D0.1,
> +                      args=3D(vm,status,command,))
> +
> +    def wait_for_runstate(self, vm, status):
> +        self.wait_for_status(vm, status, 'query-status')
> +
> +    def wait_for_migration(self, vm, status):
> +        self.wait_for_status(vm, status, 'query-migrate')
> +
> +    def run_and_fail(self, vm, msg):
> +        # Qemu will fail fast, so disable monitor to avoid timeout in
> accept
> +        vm.set_qmp_monitor(False)
> +        vm.launch()
> +        vm.wait(self.timeout)
> +        self.assertRegex(vm.get_log(), msg)
> +
> +    def get_vm_for_restart(self):
> +        return self.get_vm('-nodefaults',
> +                           '-migrate-mode-enable', 'cpr-exec',
> +                           '-object',
> 'memory-backend-memfd,id=3Dpc.ram,size=3D8M',
> +                           '-machine', 'memory-backend=3Dpc.ram')
> +
> +    def do_cpr_exec(self, vmstate_name):
> +        vm =3D self.get_vm_for_restart()
> +        vm.launch()
> +
> +        uri =3D 'file:' + vmstate_name
> +        args =3D vm.full_args + ['-incoming', 'defer']
> +
> +        vm.command('migrate-set-parameters', cpr_exec_args=3Dargs)
> +        vm.command('migrate-set-parameters', mode=3D'cpr-exec')
> +        vm.qmp('migrate', uri=3Duri)
> +
> +        # Cannot poll for migration status, because qemu may call execv
> before
> +        # we see it. Wait for STOP instead.
> +        vm.event_wait(name=3D'STOP', timeout=3Dself.fast_timeout)
> +
> +        # Migrate execs and closes the monitor socket, so reopen it.
> +        vm.reopen_qmp_connection()
> +
> +        self.assertEqual(vm.command('query-status')['status'],
> 'inmigrate')
> +        resp =3D vm.command('migrate-incoming', uri=3Duri)
> +        self.wait_for_migration(vm, ('completed', 'failed'))
> +        self.assertEqual(vm.command('query-migrate')['status'],
> 'completed')
> +
> +        resp =3D vm.command('cont')
> +        vm.event_wait(name=3D'RESUME', timeout=3Dself.fast_timeout)
> +        self.assertEqual(vm.command('query-status')['status'], 'running'=
)
> +
> +    def do_cpr_reboot(self, vmstate_name):
> +        args =3D ['-nodefaults', '-migrate-mode-enable', 'cpr-reboot' ]
> +        old_vm =3D self.get_vm(*args)
> +        old_vm.launch()
> +
> +        uri =3D 'file:' + vmstate_name
> +
> +        old_vm.command('migrate-set-capabilities', capabilities =3D [
> +                       { "capability": "x-ignore-shared", "state": True
> }])
> +        old_vm.command('migrate-set-parameters', mode=3D'cpr-reboot')
> +        old_vm.qmp('migrate', uri=3Duri)
> +        self.wait_for_migration(old_vm, ('completed', 'failed'))
> +        self.assertEqual(old_vm.command('query-migrate')['status'],
> +                         'completed')
> +        self.assertEqual(old_vm.command('query-status')['status'],
> +                         'postmigrate')
> +
> +        args =3D args + ['-incoming', 'defer']
> +        new_vm =3D self.get_vm(*args)
> +        new_vm.launch()
> +        self.assertEqual(new_vm.command('query-status')['status'],
> 'inmigrate')
> +
> +        new_vm.command('migrate-set-capabilities', capabilities =3D [
> +                       { "capability": "x-ignore-shared", "state": True
> }])
> +        new_vm.command('migrate-set-parameters', mode=3D'cpr-reboot')
> +        new_vm.command('migrate-incoming', uri=3Duri)
> +        self.wait_for_migration(new_vm, ('completed', 'failed'))
> +        self.assertEqual(new_vm.command('query-migrate')['status'],
> 'completed')
> +
> +        new_vm.command('cont')
> +        new_vm.event_wait(name=3D'RESUME', timeout=3Dself.fast_timeout)
> +        self.assertEqual(new_vm.command('query-status')['status'],
> 'running')
> +
> +    def test_cpr_exec(self):
> +        """
> +        Verify that cpr restart mode works
> +        """
> +        with tempfile.NamedTemporaryFile() as vmstate_file:
> +            self.do_cpr_exec(vmstate_file.name)
> +
> +    def test_cpr_reboot(self):
> +        """
> +        Verify that cpr reboot mode works
> +        """
> +        with tempfile.NamedTemporaryFile() as vmstate_file:
> +            self.do_cpr_reboot(vmstate_file.name)
> +
> +    def test_cpr_block_cpr_exec(self):
> +        """
> +        Verify that qemu rejects cpr restart mode for volatile memory
> +        """
> +
> +        vm =3D self.get_vm('-nodefaults',
> +                         '-migrate-mode-enable', 'cpr-exec')
> +        vm.launch()
> +        uri=3D'file:/dev/null'
> +        args =3D vm.full_args + ['-S']
> +        resp =3D vm.command('migrate-set-parameters', mode=3D'cpr-exec')
> +        rsp =3D vm.qmp('migrate', uri=3Duri)
> +        vm.qmp('quit')
> +
> +        expect =3D r'Memory region .* is volatile'
> +        self.assertRegex(rsp['error']['desc'], expect)
> +
> +    def test_cpr_block_memfd(self):
> +
> +        """
> +        Verify that qemu complains for only-cpr-capable and volatile
> memory
> +        """
> +        vm =3D self.get_vm('-nodefaults',
> +                         '-migrate-mode-enable', 'cpr-exec',
> +                         '-only-cpr-capable')
> +        self.run_and_fail(vm, r'only-cpr-capable specified.* Memory ')
> +
> +    def test_cpr_block_replay(self):
> +        """
> +        Verify that qemu complains for only-cpr-capable and replay
> +        """
> +        vm =3D self.get_vm_for_restart()
> +        vm.add_args('-only-cpr-capable',
> +                    '-icount', 'shift=3D10,rr=3Drecord,rrfile=3D/dev/nul=
l')
> +        self.run_and_fail(vm, r'only-cpr-capable specified.* replay ')
> +
> +    def test_cpr_block_chardev(self):
> +        """
> +        Verify that qemu complains for only-cpr-capable and unsupported
> chardev
> +        """
> +        vm =3D self.get_vm_for_restart()
> +        vm.add_args('-only-cpr-capable',
> +                    '-chardev', 'vc,id=3Dvc1')
> +        self.run_and_fail(vm, r'only-cpr-capable specified.* vc1 ')
> +
> +    def test_cpr_allow_chardev(self):
> +        """
> +        Verify that qemu allows unsupported chardev with reopen-on-cpr
> +        """
> +        vm =3D self.get_vm_for_restart()
> +        vm.add_args('-only-cpr-capable',
> +                    '-chardev', 'vc,id=3Dvc1,reopen-on-cpr=3Don')
> +        vm.launch()
> +        self.wait_for_runstate(vm, ('running'))
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 7
> Date: Tue, 26 Jul 2022 09:10:43 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 46/46] vfio: allow cpr-reboot migration if
>         suspended
> Message-ID:
>         <1658851843-236870-47-git-send-email-steven.sistare@oracle.com>
>
> The cpr-reboot mode supports vfio devices if the caller first suspends th=
e
> guest, such as by issuing guest-suspend-ram to the qemu guest agent.  The
> guest drivers' suspend methods flush outstanding requests and re-initiali=
ze
> the devices, and thus there is no device state to save and restore.
>
> Relax the vfio blocker, and add a notifier that verifies the guest is
> suspended.  Skip dirty page tracking to avoid ioctl errors.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/vfio/common.c              |  8 ++++++--
>  hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
>  hw/vfio/migration.c           |  3 ++-
>  include/hw/vfio/vfio-common.h |  1 +
>  4 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index de821e1..5b54cbe 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1355,14 +1355,18 @@ static void
> vfio_listener_log_global_start(MemoryListener *listener)
>  {
>      VFIOContainer *container =3D container_of(listener, VFIOContainer,
> listener);
>
> -    vfio_set_dirty_page_tracking(container, true);
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        vfio_set_dirty_page_tracking(container, true);
> +    }
>  }
>
>  static void vfio_listener_log_global_stop(MemoryListener *listener)
>  {
>      VFIOContainer *container =3D container_of(listener, VFIOContainer,
> listener);
>
> -    vfio_set_dirty_page_tracking(container, false);
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        vfio_set_dirty_page_tracking(container, false);
> +    }
>  }
>
>  static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova=
,
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 1f682cb..ef8827c 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -10,6 +10,7 @@
>  #include <linux/vfio.h>
>  #include "hw/vfio/vfio-common.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/runstate.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
>  #include "migration/migration.h"
> @@ -132,8 +133,26 @@ static void vfio_cpr_fail_notifier(Notifier
> *notifier, void *data)
>      }
>  }
>
> +static void vfio_cpr_reboot_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s =3D data;
> +
> +    if (migrate_mode_of(s) =3D=3D MIG_MODE_CPR_REBOOT &&
> +        !migration_has_failed(s) &&
> +        !runstate_check(RUN_STATE_SUSPENDED)) {
> +
> +        Error *err =3D NULL;
> +        error_setg(&err, "VFIO device only supports cpr-reboot for "
> +                         "runstate suspended");
> +        migration_notifier_set_error(s, err);
> +    }
> +}
> +
>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
>  {
> +    migration_add_notifier(&container->cpr_reboot_notifier,
> +                           vfio_cpr_reboot_notifier);
> +
>      container->cpr_blocker =3D NULL;
>      if (!vfio_is_cpr_capable(container, &container->cpr_blocker)) {
>          return migrate_add_blockers(&container->cpr_blocker, errp,
> @@ -148,6 +167,8 @@ int vfio_cpr_register_container(VFIOContainer
> *container, Error **errp)
>
>  void vfio_cpr_unregister_container(VFIOContainer *container)
>  {
> +    migration_remove_notifier(&container->cpr_reboot_notifier);
> +
>      migrate_del_blocker(&container->cpr_blocker);
>
>      vmstate_unregister(NULL, &vfio_container_vmstate, container);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6b0d401..3919941 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -890,7 +890,8 @@ add_blocker:
>                 "VFIO device doesn't support migration");
>      g_free(info);
>
> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> +    return migrate_add_blockers(&vbasedev->migration_blocker, errp,
> +                                MIG_MODE_NORMAL, -1);
>  }
>
>  void vfio_migration_finalize(VFIODevice *vbasedev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index b682645..243376b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -83,6 +83,7 @@ typedef struct VFIOContainer {
>      MemoryListener prereg_listener;
>      Notifier cpr_notifier;
>      Error *cpr_blocker;
> +    Notifier cpr_reboot_notifier;
>      unsigned iommu_type;
>      Error *error;
>      bool initialized;
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 8
> Date: Tue, 26 Jul 2022 09:10:20 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 23/46] cpr: add exec-mode blockers
> Message-ID:
>         <1658851843-236870-24-git-send-email-steven.sistare@oracle.com>
>
> Add blockers for cpr-exec migration mode for devices and options that do
> not support it.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  accel/xen/xen-all.c   | 3 +++
>  migration/migration.c | 5 +++++
>  replay/replay.c       | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 69aa7d0..2896044 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -181,6 +181,9 @@ static int xen_init(MachineState *ms)
>       * opt out of system RAM being allocated by generic code
>       */
>      mc->default_ram_id =3D NULL;
> +
> +    migrate_add_blocker_always("xen does not support cpr exec",
> +                               &error_fatal, MIG_MODE_CPR_EXEC, -1);
>      return 0;
>  }
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1a8a6ff..7b46213 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1348,6 +1348,11 @@ static bool migrate_caps_check(bool *cap_list,
>          }
>      }
>
> +    if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {
> +        return migrate_add_blocker_always("x-colo is not compatible with
> cpr",
> +                                          errp, MIG_MODE_CPR_EXEC, -1);
> +    }
> +
>      return true;
>  }
>
> diff --git a/replay/replay.c b/replay/replay.c
> index 4c396bb..b0194dd 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -19,6 +19,7 @@
>  #include "qemu/option.h"
>  #include "sysemu/cpus.h"
>  #include "qemu/error-report.h"
> +#include "migration/blocker.h"
>
>  /* Current version of the replay mechanism.
>     Increase it when file format changes. */
> @@ -232,6 +233,9 @@ static void replay_enable(const char *fname, int mode=
)
>      const char *fmode =3D NULL;
>      assert(!replay_file);
>
> +    migrate_add_blocker_always("replay is not compatible with cpr",
> +                                &error_fatal, MIG_MODE_CPR_EXEC, -1);
> +
>      switch (mode) {
>      case REPLAY_MODE_RECORD:
>          fmode =3D "wb";
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 9
> Date: Tue, 26 Jul 2022 09:10:06 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 09/46] cpr: reboot mode
> Message-ID:
>         <1658851843-236870-10-git-send-email-steven.sistare@oracle.com>
>
> Add the cpr-reboot migration mode.  Usage:
>   qemu-system-$arch -migrate-mode-enable cpr-reboot ...
>   migrate_set_parameter mode cpr-reboot
>   migrate -d file:<filename>
>   ... poll for runstate postmigrate ...
>   quit
>
>   qemu-system-$arch -migrate-mode-enable cpr-reboot ... -incoming defer
>   migrate_set_parameter mode cpr-reboot
>   migrate_incoming file:<filename>
>
> In this mode, the migrate command saves state to a file, allowing one
> to quit qemu, reboot to an updated kernel, and restart an updated version
> of qemu.  The caller must specify a migration URI that writes to and read=
s
> from a file.  Unlike normal mode, the use of certain local storage option=
s
> does not block the migration, but the caller must not modify guest block
> devices between the quit and restart.  The guest RAM memory-backend must
> be shared, and the @x-ignore-shared migration capability must be set,
> to avoid saving it to the file.  Guest RAM must be non-volatile across
> reboot, such as by backing it with a dax device, but this is not enforced=
.
> The restarted qemu arguments must match those used to initially start qem=
u,
> plus the -incoming option.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 931c492..55f0479 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -572,10 +572,24 @@
>  #
>  # @normal: the original form of migration.
>  #
> +# @cpr-reboot: The migrate command saves state to a file, allowing one t=
o
> +#              quit qemu, reboot to an updated kernel, and restart an
> updated
> +#              version of qemu.  The caller must specify a migration URI
> +#              that writes to and reads from a file.  Unlike normal mode=
,
> +#              the use of certain local storage options does not block t=
he
> +#              migration, but the caller must not modify guest block
> devices
> +#              between the quit and restart.  The guest RAM memory-backe=
nd
> +#              must be shared, and the @x-ignore-shared migration
> capability
> +#              must be set, to avoid saving it to the file.  Guest RAM
> must
> +#              be non-volatile across reboot, such as by backing it with
> +#              a dax device, but this is not enforced.  The restarted qe=
mu
> +#              arguments must match those used to initially start qemu,
> plus
> +#              the -incoming option.
> +#
>  # Since: 7.1
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal' ] }
> +  'data': [ 'normal', 'cpr-reboot' ] }
>
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> --
> 1.8.3.1
>
>
>
>
> ------------------------------
>
> Message: 10
> Date: Tue, 26 Jul 2022 09:10:28 -0700
> From: Steve Sistare <steven.sistare@oracle.com>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
>         <stefanha@redhat.com>, Marc-Andr=C3=A9 Lureau
>         <marcandre.lureau@redhat.com>, Alex Benn=C3=A9e <alex.bennee@lina=
ro.org
> >,
>         "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S.
> Tsirkin"
>         <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
> Alex
>         Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange"
>         <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Marku=
s
>         Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
> Jason
>         Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
>         <zhengchuan@huawei.com>, Steve Sistare <steven.sistare@oracle.com
> >,
>         Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.c=
n
> >,
>         Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daud=
=C3=A9
>         <philippe.mathieu.daude@gmail.com>, Igor Mammedov
>         <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, John
> Snow
>         <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
> Subject: [PATCH V9 31/46] vfio-pci: cpr part 1 (fd and dma)
> Message-ID:
>         <1658851843-236870-32-git-send-email-steven.sistare@oracle.com>
>
> Enable vfio-pci devices to be saved and restored across a cpr-exec of qem=
u.
>
> At vfio creation time, save the value of vfio container, group, and devic=
e
> descriptors in cpr state.
>
> In the container pre_save handler, suspend the use of virtual addresses
> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will
> be remapped at a different VA after exec.  DMA to already-mapped pages
> continues.  Save the msi message area as part of vfio-pci vmstate, save t=
he
> interrupt and notifier eventfd's in cpr state, and clear the close-on-exe=
c
> flag for the vfio descriptors.  The flag is not cleared earlier because
> the descriptors should not persist across miscellaneous fork and exec cal=
ls
> that may be performed during normal operation.
>
> On qemu restart, vfio_realize() finds the saved descriptors, uses the
> descriptors, and notes that the device is being reused.  Device and iommu
> state is already configured, so operations in vfio_realize that would
> modify the configuration are skipped for a reused device, including vfio
> ioctl's and writes to PCI configuration space.  Vfio PCI device reset
> is also suppressed. The result is that vfio_realize constructs qemu
> data structures that reflect the current state of the device.  However,
> the reconstruction is not complete until migrate_incoming is called.
> migrate_incoming loads the msi data, the vfio post_load handler finds
> eventfds in cpr state, rebuilds vector data structures, and attaches the
> interrupts to the new KVM instance.  The container post_load handler then
> invokes the main vfio listener callback, which walks the flattened ranges
> of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the
> kernel of the new VA's.  Lastly, migration resumes the VM.
>
> This functionality is delivered by 3 patches for clarity.  Part 1 handles
> device file descriptors and DMA.  Part 2 adds eventfd and MSI/MSI-X vecto=
r
> support.  Part 3 adds INTX support.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  MAINTAINERS                   |   1 +
>  hw/pci/pci.c                  |  12 ++++
>  hw/vfio/common.c              | 152
> +++++++++++++++++++++++++++++++++++-------
>  hw/vfio/cpr.c                 | 120 +++++++++++++++++++++++++++++++++
>  hw/vfio/meson.build           |   1 +
>  hw/vfio/pci.c                 |  43 ++++++++++++
>  hw/vfio/trace-events          |   1 +
>  include/hw/vfio/vfio-common.h |  11 +++
>  include/migration/vmstate.h   |   2 +
>  9 files changed, 319 insertions(+), 24 deletions(-)
>  create mode 100644 hw/vfio/cpr.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42f6f4a..3af099a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3170,6 +3170,7 @@ F: migration/cpr-state.c
>  F: stubs/cpr-state.c
>  F: include/migration/cpr.h
>  F: migration/cpr.c
> +F: hw/vfio/cpr.c
>
>  Record/replay
>  M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2f450f6..d7f945f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -32,6 +32,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
> +#include "migration/misc.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
> @@ -350,6 +351,17 @@ static void pci_reset_regions(PCIDevice *dev)
>
>  static void pci_do_device_reset(PCIDevice *dev)
>  {
> +    /*
> +     * A PCI device that is resuming for cpr is already configured, so d=
o
> +     * not reset it here when we are called from qemu_system_reset prior
> to
> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It i=
s
> +     * safe to skip this reset for all PCI devices, because cpr load wil=
l
> set
> +     * all fields that would have been set here.
> +     */
> +    if (migrate_mode() =3D=3D MIG_MODE_CPR_EXEC) {
> +        return;
> +    }
> +
>      pci_device_deassert_intx(dev);
>      assert(dev->irq_state =3D=3D 0);
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ace9562..b7b35d4 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -31,6 +31,7 @@
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"
>  #include "hw/hw.h"
> +#include "migration/cpr-state.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/range.h"
> @@ -460,6 +461,8 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size =3D size,
>      };
>
> +    assert(!container->reused);
> +
>      if (iotlb && container->dirty_pages_supported &&
>          vfio_devices_all_running_and_saving(container)) {
>          return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
> @@ -496,12 +499,24 @@ static int vfio_dma_map(VFIOContainer *container,
> hwaddr iova,
>  {
>      struct vfio_iommu_type1_dma_map map =3D {
>          .argsz =3D sizeof(map),
> -        .flags =3D VFIO_DMA_MAP_FLAG_READ,
>          .vaddr =3D (__u64)(uintptr_t)vaddr,
>          .iova =3D iova,
>          .size =3D size,
>      };
>
> +    /*
> +     * Set the new vaddr for any mappings registered during cpr load.
> +     * Reused is cleared thereafter.
> +     */
> +    if (container->reused) {
> +        map.flags =3D VFIO_DMA_MAP_FLAG_VADDR;
> +        if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
> +            goto fail;
> +        }
> +        return 0;
> +    }
> +
> +    map.flags =3D VFIO_DMA_MAP_FLAG_READ;
>      if (!readonly) {
>          map.flags |=3D VFIO_DMA_MAP_FLAG_WRITE;
>      }
> @@ -517,7 +532,9 @@ static int vfio_dma_map(VFIOContainer *container,
> hwaddr iova,
>          return 0;
>      }
>
> -    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
> +fail:
> +    error_report("vfio_dma_map %s (iova %lu, size %ld, va %p): %s",
> +        (container->reused ? "VADDR" : ""), iova, size, vaddr,
> strerror(errno));
>      return -errno;
>  }
>
> @@ -882,6 +899,12 @@ static void vfio_listener_region_add(MemoryListener
> *listener,
>                                       MemoryRegionSection *section)
>  {
>      VFIOContainer *container =3D container_of(listener, VFIOContainer,
> listener);
> +    vfio_container_region_add(container, section);
> +}
> +
> +void vfio_container_region_add(VFIOContainer *container,
> +                               MemoryRegionSection *section)
> +{
>      hwaddr iova, end;
>      Int128 llend, llsize;
>      void *vaddr;
> @@ -1492,6 +1515,12 @@ static void vfio_listener_release(VFIOContainer
> *container)
>      }
>  }
>
> +void vfio_listener_register(VFIOContainer *container)
> +{
> +    container->listener =3D vfio_memory_listener;
> +    memory_listener_register(&container->listener, container->space->as)=
;
> +}
> +
>  static struct vfio_info_cap_header *
>  vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)
>  {
> @@ -1910,6 +1939,22 @@ static int vfio_init_container(VFIOContainer
> *container, int group_fd,
>  {
>      int iommu_type, ret;
>
> +    /*
> +     * If container is reused, just set its type and skip the ioctls, as
> the
> +     * container and group are already configured in the kernel.
> +     * VFIO_TYPE1v2_IOMMU is the only type that supports reuse/cpr.
> +     */
> +    if (container->reused) {
> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION,
> VFIO_TYPE1v2_IOMMU)) {
> +            container->iommu_type =3D VFIO_TYPE1v2_IOMMU;
> +            return 0;
> +        } else {
> +            error_setg(errp, "container was reused but VFIO_TYPE1v2_IOMM=
U
> "
> +                             "is not supported");
> +            return -errno;
> +        }
> +    }
> +
>      iommu_type =3D vfio_get_iommu_type(container, errp);
>      if (iommu_type < 0) {
>          return iommu_type;
> @@ -2014,9 +2059,12 @@ static int vfio_connect_container(VFIOGroup *group=
,
> AddressSpace *as,
>  {
>      VFIOContainer *container;
>      int ret, fd;
> +    bool reused;
>      VFIOAddressSpace *space;
>
>      space =3D vfio_get_address_space(as);
> +    fd =3D cpr_find_fd("vfio_container_for_group", group->groupid);
> +    reused =3D (fd > 0);
>
>      /*
>       * VFIO is currently incompatible with discarding of RAM insofar as
> the
> @@ -2049,27 +2097,47 @@ static int vfio_connect_container(VFIOGroup
> *group, AddressSpace *as,
>       * details once we know which type of IOMMU we are using.
>       */
>
> +    /*
> +     * If the container is reused, then the group is already attached in
> the
> +     * kernel.  If a container with matching fd is found, then update th=
e
> +     * userland group list and return.  If not, then after the loop,
> create
> +     * the container struct and group list.
> +     */
> +
>      QLIST_FOREACH(container, &space->containers, next) {
> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd))=
 {
> -            ret =3D vfio_ram_block_discard_disable(container, true);
> -            if (ret) {
> -                error_setg_errno(errp, -ret,
> -                                 "Cannot set discarding of RAM broken");
> -                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
> -                          &container->fd)) {
> -                    error_report("vfio: error disconnecting group %d fro=
m"
> -                                 " container", group->groupid);
> -                }
> -                return ret;
> +        if (reused) {
> +            if (container->fd !=3D fd) {
> +                continue;
> +            }
> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER,
> &container->fd)) {
> +            continue;
> +        }
> +
> +        ret =3D vfio_ram_block_discard_disable(container, true);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                             "Cannot set discarding of RAM broken");
> +            if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
> +                      &container->fd)) {
> +                error_report("vfio: error disconnecting group %d from"
> +                             " container", group->groupid);
>              }
> -            group->container =3D container;
> -            QLIST_INSERT_HEAD(&container->group_list, group,
> container_next);
> +            goto delete_fd_exit;
> +        }
> +        group->container =3D container;
> +        QLIST_INSERT_HEAD(&container->group_list, group, container_next)=
;
> +        if (!reused) {
>              vfio_kvm_device_add_group(group);
> -            return 0;
> +            cpr_save_fd("vfio_container_for_group", group->groupid,
> +                        container->fd);
>          }
> +        return 0;
> +    }
> +
> +    if (!reused) {
> +        fd =3D qemu_open_old("/dev/vfio/vfio", O_RDWR);
>      }
>
> -    fd =3D qemu_open_old("/dev/vfio/vfio", O_RDWR);
>      if (fd < 0) {
>          error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
>          ret =3D -errno;
> @@ -2087,6 +2155,7 @@ static int vfio_connect_container(VFIOGroup *group,
> AddressSpace *as,
>      container =3D g_malloc0(sizeof(*container));
>      container->space =3D space;
>      container->fd =3D fd;
> +    container->reused =3D reused;
>      container->error =3D NULL;
>      container->dirty_pages_supported =3D false;
>      container->dma_max_mappings =3D 0;
> @@ -2099,10 +2168,15 @@ static int vfio_connect_container(VFIOGroup
> *group, AddressSpace *as,
>          goto free_container_exit;
>      }
>
> +    ret =3D vfio_cpr_register_container(container, errp);
> +    if (ret) {
> +        goto free_container_exit;
> +    }
> +
>      ret =3D vfio_ram_block_discard_disable(container, true);
>      if (ret) {
>          error_setg_errno(errp, -ret, "Cannot set discarding of RAM
> broken");
> -        goto free_container_exit;
> +        goto unregister_container_exit;
>      }
>
>      switch (container->iommu_type) {
> @@ -2213,9 +2287,16 @@ static int vfio_connect_container(VFIOGroup *group=
,
> AddressSpace *as,
>      group->container =3D container;
>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>
> -    container->listener =3D vfio_memory_listener;
> -
> -    memory_listener_register(&container->listener, container->space->as)=
;
> +    /*
> +     * If reused, register the listener later, after all state that may
> +     * affect regions and mapping boundaries has been cpr load'ed.  Late=
r,
> +     * the listener will invoke its callback on each flat section and ca=
ll
> +     * vfio_dma_map to supply the new vaddr, and the calls will match th=
e
> +     * mappings remembered by the kernel.
> +     */
> +    if (!reused) {
> +        vfio_listener_register(container);
> +    }
>
>      if (container->error) {
>          ret =3D -1;
> @@ -2225,6 +2306,7 @@ static int vfio_connect_container(VFIOGroup *group,
> AddressSpace *as,
>      }
>
>      container->initialized =3D true;
> +    cpr_resave_fd("vfio_container_for_group", group->groupid, fd);
>
>      return 0;
>  listener_release_exit:
> @@ -2236,6 +2318,9 @@ listener_release_exit:
>  enable_discards_exit:
>      vfio_ram_block_discard_disable(container, false);
>
> +unregister_container_exit:
> +    vfio_cpr_unregister_container(container);
> +
>  free_container_exit:
>      g_free(container);
>
> @@ -2245,6 +2330,8 @@ close_fd_exit:
>  put_space_exit:
>      vfio_put_address_space(space);
>
> +delete_fd_exit:
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>      return ret;
>  }
>
> @@ -2254,6 +2341,7 @@ static void vfio_disconnect_container(VFIOGroup
> *group)
>
>      QLIST_REMOVE(group, container_next);
>      group->container =3D NULL;
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>
>      /*
>       * Explicitly release the listener first before unset container,
> @@ -2290,6 +2378,7 @@ static void vfio_disconnect_container(VFIOGroup
> *group)
>          }
>
>          trace_vfio_disconnect_container(container->fd);
> +        vfio_cpr_unregister_container(container);
>          close(container->fd);
>          g_free(container);
>
> @@ -2319,7 +2408,12 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpac=
e
> *as, Error **errp)
>      group =3D g_malloc0(sizeof(*group));
>
>      snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
> -    group->fd =3D qemu_open_old(path, O_RDWR);
> +
> +    group->fd =3D cpr_find_fd("vfio_group", groupid);
> +    if (group->fd < 0) {
> +        group->fd =3D qemu_open_old(path, O_RDWR);
> +    }
> +
>      if (group->fd < 0) {
>          error_setg_errno(errp, errno, "failed to open %s", path);
>          goto free_group_exit;
> @@ -2352,7 +2446,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace
> *as, Error **errp)
>      }
>
>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
> -
> +    cpr_resave_fd("vfio_group", groupid, group->fd);
>      return group;
>
>  close_fd_exit:
> @@ -2377,6 +2471,7 @@ void vfio_put_group(VFIOGroup *group)
>      vfio_disconnect_container(group);
>      QLIST_REMOVE(group, next);
>      trace_vfio_put_group(group->fd);
> +    cpr_delete_fd("vfio_group", group->groupid);
>      close(group->fd);
>      g_free(group);
>
> @@ -2390,8 +2485,14 @@ int vfio_get_device(VFIOGroup *group, const char
> *name,
>  {
>      struct vfio_device_info dev_info =3D { .argsz =3D sizeof(dev_info) }=
;
>      int ret, fd;
> +    bool reused;
> +
> +    fd =3D cpr_find_fd(name, 0);
> +    reused =3D (fd >=3D 0);
> +    if (!reused) {
> +        fd =3D ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
> +    }
>
> -    fd =3D ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>      if (fd < 0) {
>          error_setg_errno(errp, errno, "error getting device from group
> %d",
>                           group->groupid);
> @@ -2436,11 +2537,13 @@ int vfio_get_device(VFIOGroup *group, const char
> *name,
>      vbasedev->num_irqs =3D dev_info.num_irqs;
>      vbasedev->num_regions =3D dev_info.num_regions;
>      vbasedev->flags =3D dev_info.flags;
> +    vbasedev->reused =3D reused;
>
>      trace_vfio_get_device(name, dev_info.flags, dev_info.num_regions,
>                            dev_info.num_irqs);
>
>      vbasedev->reset_works =3D !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESE=
T);
> +    cpr_resave_fd(name, 0, fd);
>      return 0;
>  }
>
> @@ -2452,6 +2555,7 @@ void vfio_put_base_device(VFIODevice *vbasedev)
>      QLIST_REMOVE(vbasedev, next);
>      vbasedev->group =3D NULL;
>      trace_vfio_put_base_device(vbasedev->fd);
> +    cpr_delete_fd(vbasedev->name, 0);
>      close(vbasedev->fd);
>  }
>
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> new file mode 100644
> index 0000000..83f7872
> --- /dev/null
> +++ b/hw/vfio/cpr.c
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (c) 2021, 2022 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include "hw/vfio/vfio-common.h"
> +#include "sysemu/kvm.h"
> +#include "qapi/error.h"
> +#include "migration/blocker.h"
> +#include "migration/migration.h"
> +#include "migration/m

--000000000000b41a1906067a6530
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, 26 Jul 2022, 10:24 pm , &lt;<a href=3D"mailto:qem=
u-devel-request@nongnu.org">qemu-devel-request@nongnu.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Send Qemu-devel mailing list submissi=
ons to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:qemu-devel@nongnu.org" target=
=3D"_blank" rel=3D"noreferrer">qemu-devel@nongnu.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.nongnu.org/mailman/lis=
tinfo/qemu-devel" rel=3D"noreferrer noreferrer" target=3D"_blank">https://l=
ists.nongnu.org/mailman/listinfo/qemu-devel</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:qemu-devel-request@nongnu.org=
" target=3D"_blank" rel=3D"noreferrer">qemu-devel-request@nongnu.org</a><br=
>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:qemu-devel-owner@nongnu.org" =
target=3D"_blank" rel=3D"noreferrer">qemu-devel-owner@nongnu.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Qemu-devel digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. [PATCH V9 45/46] migration: notifier error reporting<br>
=C2=A0 =C2=A0 =C2=A0 (Steve Sistare)<br>
=C2=A0 =C2=A02. [PATCH V9 36/46] chardev: cpr framework (Steve Sistare)<br>
=C2=A0 =C2=A03. [PATCH V9 41/46] python/machine: QEMUMachine<br>
=C2=A0 =C2=A0 =C2=A0 reopen_qmp_connection (Steve Sistare)<br>
=C2=A0 =C2=A04. [PATCH V9 43/46] vl: start on wakeup request (Steve Sistare=
)<br>
=C2=A0 =C2=A05. [PATCH V9 44/46] migration: fix suspended runstate (Steve S=
istare)<br>
=C2=A0 =C2=A06. [PATCH V9 42/46] tests/avocado: add cpr regression test<br>
=C2=A0 =C2=A0 =C2=A0 (Steve Sistare)<br>
=C2=A0 =C2=A07. [PATCH V9 46/46] vfio: allow cpr-reboot migration if<br>
=C2=A0 =C2=A0 =C2=A0 suspended (Steve Sistare)<br>
=C2=A0 =C2=A08. [PATCH V9 23/46] cpr: add exec-mode blockers (Steve Sistare=
)<br>
=C2=A0 =C2=A09. [PATCH V9 09/46] cpr: reboot mode (Steve Sistare)<br>
=C2=A0 10. [PATCH V9 31/46] vfio-pci: cpr part 1 (fd and dma) (Steve Sistar=
e)<br>
=C2=A0 11. [PATCH V9 39/46] chardev: cpr for sockets (Steve Sistare)<br>
=C2=A0 12. [PATCH V9 15/46] migration: cpr-exec-args parameter<br>
=C2=A0 =C2=A0 =C2=A0 (Steve Sistare)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 26 Jul 2022 09:10:42 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 45/46] migration: notifier error reporting<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-46-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-46-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Provide migration_notifier_set_error(), which allows migration notifiers<br=
>
to return an error message indicating they have failed, which halts the<br>
migration.=C2=A0 The error message is visible in the &#39;info migrate&#39;=
 command.<br>
<br>
No functional change until calls to migration_notifier_set_error are<br>
added.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0include/migration/misc.h |=C2=A0 3 ++-<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 | 31 +++++++++++++++++++++++++++--=
--<br>
=C2=A02 files changed, 29 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/include/migration/misc.h b/include/migration/misc.h<br>
index d4c2d7d..e5d8c81 100644<br>
--- a/include/migration/misc.h<br>
+++ b/include/migration/misc.h<br>
@@ -63,7 +63,8 @@ bool migration_is_active(MigrationState *);<br>
=C2=A0void migration_add_notifier(Notifier *notify,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*func)(Notifier *notifier, void *data)=
);<br>
=C2=A0void migration_remove_notifier(Notifier *notify);<br>
-void migration_call_notifiers(MigrationState *s);<br>
+int migration_call_notifiers(MigrationState *s);<br>
+void migration_notifier_set_error(MigrationState *s, Error *err);<br>
=C2=A0bool migration_in_setup(MigrationState *);<br>
=C2=A0bool migration_has_finished(MigrationState *);<br>
=C2=A0bool migration_has_failed(MigrationState *);<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 45eebea..d477b58 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -1924,6 +1924,8 @@ static void block_cleanup_parameters(MigrationState *=
s)<br>
<br>
=C2=A0static void migrate_fd_cleanup(MigrationState *s)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 bool already_failed;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qemu_bh_delete(s-&gt;cleanup_bh);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;cleanup_bh =3D NULL;<br>
<br>
@@ -1973,7 +1975,15 @@ static void migrate_fd_cleanup(MigrationState *s)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* It is used on info migrate.=C2=A0 We c=
an&#39;t free it */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report_err(error_copy(s-&gt;error))=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 migration_call_notifiers(s);<br>
+<br>
+=C2=A0 =C2=A0 already_failed =3D migration_has_failed(s);<br>
+=C2=A0 =C2=A0 if (migration_call_notifiers(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!already_failed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;sta=
te, s-&gt;state, MIGRATION_STATUS_FAILED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Notify again to recover from =
this late failure. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_call_notifiers(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0block_cleanup_parameters(s);<br>
=C2=A0 =C2=A0 =C2=A0cpr_exec();<br>
=C2=A0 =C2=A0 =C2=A0yank_unregister_instance(MIGRATION_YANK_INSTANCE);<br>
@@ -2084,9 +2094,16 @@ void migration_remove_notifier(Notifier *notify)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void migration_call_notifiers(MigrationState *s)<br>
+int migration_call_notifiers(MigrationState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0notifier_list_notify(&amp;migration_state_notifiers, s)=
;<br>
+=C2=A0 =C2=A0 return (s-&gt;error !=3D NULL);<br>
+}<br>
+<br>
+void migration_notifier_set_error(MigrationState *s, Error *err)<br>
+{<br>
+=C2=A0 =C2=A0 migrate_set_error(s, err);<br>
+=C2=A0 =C2=A0 error_report_err(err);<br>
=C2=A0}<br>
<br>
=C2=A0bool migration_in_setup(MigrationState *s)<br>
@@ -3381,7 +3398,9 @@ static int postcopy_start(MigrationState *ms)<br>
=C2=A0 =C2=A0 =C2=A0 * spice needs to trigger a transition now<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0ms-&gt;postcopy_after_devices =3D true;<br>
-=C2=A0 =C2=A0 migration_call_notifiers(ms);<br>
+=C2=A0 =C2=A0 if (migration_call_notifiers(ms)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0ms-&gt;downtime =3D=C2=A0 qemu_clock_get_ms(QEMU_CLOCK_=
REALTIME) - time_at_stop;<br>
<br>
@@ -4412,7 +4431,11 @@ void migrate_fd_connect(MigrationState *s, Error *er=
ror_in)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rate_limit =3D s-&gt;parameters.max_bandw=
idth / XFER_LIMIT_RATIO;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Notify before starting migration threa=
d */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_call_notifiers(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migration_call_notifiers(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;sta=
te, s-&gt;state, MIGRATION_STATUS_FAILED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_fd_cleanup(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_file_set_rate_limit(s-&gt;to_dst_file, rate_limit)=
;<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Tue, 26 Jul 2022 09:10:33 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 36/46] chardev: cpr framework<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-37-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-37-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Add QEMU_CHAR_FEATURE_CPR for devices that support cpr-exec by preserving<b=
r>
an open descriptor across exec.=C2=A0 Add the chardev reopen-on-cpr option =
for<br>
devices that should be closed on cpr and reopened after exec.<br>
<br>
Enable cpr for a chardev if it has QEMU_CHAR_FEATURE_CPR and reopen-on-cpr<=
br>
is false.=C2=A0 Allow cpr-save if either QEMU_CHAR_FEATURE_CPR or reopen-on=
-cpr<br>
is true for all chardevs in the configuration.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 49 ++++++++++++++++=
+++++++++++++++++++++++++++++----<br>
=C2=A0include/chardev/char.h |=C2=A0 5 +++++<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++++-<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 +++++++++++++++++++++=
+----<br>
=C2=A04 files changed, 78 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 0169d8d..01755d7 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -36,6 +36,8 @@<br>
=C2=A0#include &quot;qemu/help_option.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
+#include &quot;migration/cpr-state.h&quot;<br>
+#include &quot;migration/blocker.h&quot;<br>
=C2=A0#include &quot;qemu/id.h&quot;<br>
=C2=A0#include &quot;qemu/coroutine.h&quot;<br>
=C2=A0#include &quot;qemu/yank.h&quot;<br>
@@ -236,26 +238,55 @@ int qemu_chr_add_client(Chardev *s, int fd)<br>
=C2=A0static void qemu_char_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+=C2=A0 =C2=A0 g_autofree char *fdname =3D NULL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0/* Any ChardevCommon member would work */<br>
=C2=A0 =C2=A0 =C2=A0ChardevCommon *common =3D backend ? backend-&gt;u.null.=
data : NULL;<br>
+=C2=A0 =C2=A0 bool has_logfile =3D (common &amp;&amp; common-&gt;has_logfi=
le);<br>
+=C2=A0 =C2=A0 bool has_feature_cpr;<br>
<br>
-=C2=A0 =C2=A0 if (common &amp;&amp; common-&gt;has_logfile) {<br>
+=C2=A0 =C2=A0 if (has_logfile) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags =3D O_WRONLY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fdname =3D g_strdup_printf(&quot;%s_log&quot;,=
 chr-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (common-&gt;has_logappend &amp;&amp;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0common-&gt;logappend) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D O_APPEND;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D O_TRUNC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;logfd =3D qemu_create(common-&gt;logfi=
le, flags, 0666, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;logfd =3D cpr_find_fd(fdname, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chr-&gt;logfd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;logfd =3D qemu_create(co=
mmon-&gt;logfile, flags, 0666, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chr-&gt;logfd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 chr-&gt;reopen_on_cpr =3D (common &amp;&amp; common-&gt;reop=
en_on_cpr);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (cc-&gt;open) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;open(chr, backend, be_opened, errp=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Evaluate this after the open method sets the feature */<b=
r>
+=C2=A0 =C2=A0 has_feature_cpr =3D qemu_chr_has_feature(chr, QEMU_CHAR_FEAT=
URE_CPR);<br>
+=C2=A0 =C2=A0 chr-&gt;cpr_enabled =3D !chr-&gt;reopen_on_cpr &amp;&amp; ha=
s_feature_cpr;<br>
+<br>
+=C2=A0 =C2=A0 if (!chr-&gt;reopen_on_cpr &amp;&amp; !has_feature_cpr) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;cpr_blocker =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;chr-&gt;cpr_blocker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;chardev %s -=
&gt; %s does not allow cpr. See reopen-on-cpr.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;label, chr=
-&gt;filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_add_blockers(&amp;chr-&gt;cpr_blocker,=
 errp, MIG_MODE_CPR_EXEC, -1);<br>
+<br>
+=C2=A0 =C2=A0 } else if (chr-&gt;cpr_enabled &amp;&amp; has_logfile) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpr_resave_fd(fdname, 0, chr-&gt;logfd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -297,11 +328,16 @@ static void char_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0if (chr-&gt;be) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr-&gt;be-&gt;chr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0if (chr-&gt;logfd !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *fdname =3D g_strdup_printf(&q=
uot;%s_log&quot;, chr-&gt;label);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chr-&gt;cpr_enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpr_delete_fd(fdname, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(chr-&gt;logfd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 migrate_del_blocker(&amp;chr-&gt;cpr_blocker);<br>
+=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
+=C2=A0 =C2=A0 g_free(chr-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_destroy(&amp;chr-&gt;chr_write_lock);<br>
=C2=A0}<br>
<br>
@@ -501,6 +537,8 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCommo=
n *backend)<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;has_logappend =3D true;<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;logappend =3D qemu_opt_get_bool(opts, &quot=
;logappend&quot;, false);<br>
+<br>
+=C2=A0 =C2=A0 backend-&gt;reopen_on_cpr =3D qemu_opt_get_bool(opts, &quot;=
reopen-on-cpr&quot;, false);<br>
=C2=A0}<br>
<br>
=C2=A0static const ChardevClass *char_get_class(const char *driver, Error *=
*errp)<br>
@@ -942,6 +980,9 @@ QemuOptsList qemu_chardev_opts =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;abstract&qu=
ot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D QEMU_OPT_BOOL,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;reopen-on-cpr&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_BOOL,<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ /* end of list */ }<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index a319b5f..bbf2560 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -50,6 +50,8 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0/* Whether the gcontext can be changed after calling<br=
>
=C2=A0 =C2=A0 =C2=A0 * qemu_chr_be_update_read_handlers() */<br>
=C2=A0 =C2=A0 =C2=A0QEMU_CHAR_FEATURE_GCONTEXT,<br>
+=C2=A0 =C2=A0 /* Whether the device supports cpr */<br>
+=C2=A0 =C2=A0 QEMU_CHAR_FEATURE_CPR,<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMU_CHAR_FEATURE_LAST,<br>
=C2=A0} ChardevFeature;<br>
@@ -67,6 +69,9 @@ struct Chardev {<br>
=C2=A0 =C2=A0 =C2=A0int be_open;<br>
=C2=A0 =C2=A0 =C2=A0/* used to coordinate the chardev-change special-case: =
*/<br>
=C2=A0 =C2=A0 =C2=A0bool handover_yank_instance;<br>
+=C2=A0 =C2=A0 bool reopen_on_cpr;<br>
+=C2=A0 =C2=A0 bool cpr_enabled;<br>
+=C2=A0 =C2=A0 Error *cpr_blocker;<br>
=C2=A0 =C2=A0 =C2=A0GSource *gsource;<br>
=C2=A0 =C2=A0 =C2=A0GMainContext *gcontext;<br>
=C2=A0 =C2=A0 =C2=A0DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index 923dc50..0c3558e 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -204,12 +204,17 @@<br>
=C2=A0# @logfile: The name of a logfile to save output<br>
=C2=A0# @logappend: true to append instead of truncate<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(default to false to=
 truncate)<br>
+# @reopen-on-cpr: if true, close device&#39;s fd on cpr-save and reopen it=
 after<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpr-exec. S=
et this to allow CPR on a device that does not<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0support QEM=
U_CHAR_FEATURE_CPR. defaults to false.<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0since 7.1.<=
br>
=C2=A0#<br>
=C2=A0# Since: 2.6<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;ChardevCommon&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;*logfile&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*logappend&#39;: &#39;bool&=
#39; } }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*logappend&#39;: &#39;bool&=
#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*reopen-on-cpr&#39;: &#39;b=
ool&#39; } }<br>
<br>
=C2=A0##<br>
=C2=A0# @ChardevFile:<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 3ed9270..ea79afa 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -3295,43 +3295,57 @@ DEFHEADING(Character device options:)<br>
<br>
=C2=A0DEF(&quot;chardev&quot;, HAS_ARG, QEMU_OPTION_chardev,<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev help\n&quot;<br>
-=C2=A0 =C2=A0 &quot;-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][=
,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][=
,logappend=3Don|off][,reopen-on-cpr=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev socket,id=3Did[,host=3Dhost],port=3Dport=
[,to=3Dto][,ipv4=3Don|off][,ipv6=3Don|off][,nodelay=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,server=3Don|o=
ff][,wait=3Don|off][,telnet=3Don|off][,websocket=3Don|off][,reconnect=3Dsec=
onds][,mux=3Don|off]\n&quot;<br>
-=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,logfile=3DPATH][,l=
ogappend=3Don|off][,tls-creds=3DID][,tls-authz=3DID] (tcp)\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,logfile=3DPATH][,l=
ogappend=3Don|off][,tls-creds=3DID][,tls-authz=3DID][,reopen-on-cpr=3Don|of=
f] (tcp)\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev socket,id=3Did,path=3Dpath[,server=3Don|=
off][,wait=3Don|off][,telnet=3Don|off][,websocket=3Don|off][,reconnect=3Dse=
conds]\n&quot;<br>
-=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,mux=3Don|off][,log=
file=3DPATH][,logappend=3Don|off][,abstract=3Don|off][,tight=3Don|off] (uni=
x)\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,mux=3Don|off][,log=
file=3DPATH][,logappend=3Don|off][,abstract=3Don|off][,tight=3Don|off][,reo=
pen-on-cpr=3Don|off] (unix)\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,l=
ocaladdr=3Dlocaladdr]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,localport=3Dl=
ocalport][,ipv4=3Don|off][,ipv6=3Don|off][,mux=3Don|off]\n&quot;<br>
-=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,logfile=3DPATH][,l=
ogappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,logfile=3DPATH][,l=
ogappend=3Don|off][,reopen-on-cpr=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev msmouse,id=3Did[,mux=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dhe=
ight]][[,cols=3Dcols][,rows=3Drows]]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,mux=3Don|off]=
[,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=
=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev file,id=3Did,path=3Dpath[,mux=3Don|off][=
,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][=
,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev console,id=3Did[,mux=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off=
][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPA=
TH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Do=
n|off][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#ifdef CONFIG_BRLAPI<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev braille,id=3Did[,mux=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| defined(__NetBSD__) || defined(__OpenB=
SD__) || defined(__DragonFly__)<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off=
][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev tty,id=3Did,path=3Dpath[,mux=3Don|off][,=
logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly=
__)<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev parallel,id=3Did,path=3Dpath[,mux=3Don|o=
ff][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev parport,id=3Did,path=3Dpath[,mux=3Don|of=
f][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#if defined(CONFIG_SPICE)<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev spicevmc,id=3Did,name=3Dname[,debug=3Dde=
bug][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;-chardev spiceport,id=3Did,name=3Dname[,debug=3Dd=
ebug][,logfile=3DPATH][,logappend=3Don|off]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,reopen-on-cpr=3Don=
|off]\n&quot;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0, QEMU_ARCH_ALL<br>
=C2=A0)<br>
@@ -3406,6 +3420,10 @@ The general form of a character device option is:<br=
>
=C2=A0 =C2=A0 =C2=A0``logappend`` option controls whether the log file will=
 be truncated<br>
=C2=A0 =C2=A0 =C2=A0or appended to when opened.<br>
<br>
+=C2=A0 =C2=A0 Every backend supports the ``reopen-on-cpr`` option.=C2=A0 I=
f on, the<br>
+=C2=A0 =C2=A0 devices&#39;s descriptor is closed during cpr save, and reop=
ened after exec.<br>
+=C2=A0 =C2=A0 This is useful for devices that do not support cpr.<br>
+<br>
=C2=A0The available backends are:<br>
<br>
=C2=A0``-chardev null,id=3Did``<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 26 Jul 2022 09:10:38 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 41/46] python/machine: QEMUMachine<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 reopen_qmp_connection<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-42-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-42-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Provide reopen_qmp_connection() to reopen a closed monitor connection.<br>
This is needed by cpr, because qemu exec closes the monitor socket.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0python/qemu/machine/machine.py | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.p=
y<br>
index d05950e..60b934d 100644<br>
--- a/python/qemu/machine/machine.py<br>
+++ b/python/qemu/machine/machine.py<br>
@@ -491,6 +491,15 @@ def _close_qmp_connection(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finally:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._qmp_connection =3D No=
ne<br>
<br>
+=C2=A0 =C2=A0 def reopen_qmp_connection(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._close_qmp_connection()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp_connection =3D QEMUMonitorProtocol(<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._monitor_address,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 server=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nickname=3Dself._name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp.accept(self._qmp_timer)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def _early_cleanup(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Perform any cleanup that needs to happen =
before the VM exits.<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Tue, 26 Jul 2022 09:10:40 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 43/46] vl: start on wakeup request<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-44-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-44-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
If qemu starts and loads a VM in the suspended state, then a later wakeup<b=
r>
request will set the state to running, which is not sufficient to initializ=
e<br>
the vm, as vm_start was never called during this invocation of qemu.=C2=A0 =
See<br>
qemu_system_wakeup_request().<br>
<br>
Define the start_on_wakeup_requested() hook to cause vm_start() to be calle=
d<br>
when processing the wakeup request.=C2=A0 This will be called in a subseque=
nt<br>
migration patch.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0include/sysemu/runstate.h |=C2=A0 1 +<br>
=C2=A0softmmu/runstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++++-<br=
>
=C2=A02 files changed, 15 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h<br>
index a5f0738..cfcdbf5 100644<br>
--- a/include/sysemu/runstate.h<br>
+++ b/include/sysemu/runstate.h<br>
@@ -57,6 +57,7 @@ void qemu_system_reset_request(ShutdownCause reason);<br>
=C2=A0void qemu_system_suspend_request(void);<br>
=C2=A0void qemu_register_suspend_notifier(Notifier *notifier);<br>
=C2=A0bool qemu_wakeup_suspend_enabled(void);<br>
+void qemu_system_start_on_wakeup_request(void);<br>
=C2=A0void qemu_system_wakeup_request(WakeupReason reason, Error **errp);<b=
r>
=C2=A0void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);<br=
>
=C2=A0void qemu_register_wakeup_notifier(Notifier *notifier);<br>
diff --git a/softmmu/runstate.c b/softmmu/runstate.c<br>
index fb86740..c7db5ac 100644<br>
--- a/softmmu/runstate.c<br>
+++ b/softmmu/runstate.c<br>
@@ -338,6 +338,7 @@ void vm_state_notify(bool running, RunState state)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static bool start_on_wakeup_requested;<br>
=C2=A0static ShutdownCause reset_requested;<br>
=C2=A0static ShutdownCause shutdown_requested;<br>
=C2=A0static int shutdown_signal;<br>
@@ -571,6 +572,11 @@ void qemu_register_suspend_notifier(Notifier *notifier=
)<br>
=C2=A0 =C2=A0 =C2=A0notifier_list_add(&amp;suspend_notifiers, notifier);<br=
>
=C2=A0}<br>
<br>
+void qemu_system_start_on_wakeup_request(void)<br>
+{<br>
+=C2=A0 =C2=A0 start_on_wakeup_requested =3D true;<br>
+}<br>
+<br>
=C2=A0void qemu_system_wakeup_request(WakeupReason reason, Error **errp)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0trace_system_wakeup_request(reason);<br>
@@ -583,7 +589,14 @@ void qemu_system_wakeup_request(WakeupReason reason, E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (!(wakeup_reason_mask &amp; (1 &lt;&lt; reason))) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 runstate_set(RUN_STATE_RUNNING);<br>
+<br>
+=C2=A0 =C2=A0 if (start_on_wakeup_requested) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_on_wakeup_requested =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_start();<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runstate_set(RUN_STATE_RUNNING);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0wakeup_reason =3D reason;<br>
=C2=A0 =C2=A0 =C2=A0qemu_notify_event();<br>
=C2=A0}<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Tue, 26 Jul 2022 09:10:41 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 44/46] migration: fix suspended runstate<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-45-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-45-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Migration of a guest in the suspended state is broken.=C2=A0 The incoming<b=
r>
migration code automatically tries to wake the guest, which IMO is<br>
wrong -- the guest should end migration in the same state it started.<br>
Further, the wakeup attempt merely sets state to running but does<br>
not actually start the guest, as vm_start was never called during this<br>
invocation of qemu.<br>
<br>
To fix, leave the guest in the suspended state, but call<br>
qemu_system_start_on_wakeup_request() so the guest is properly resumed<br>
when the client sends a system_wakeup command.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0migration/migration.c | 11 ++++-------<br>
=C2=A0softmmu/runstate.c=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A02 files changed, 5 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index e0fc2b8..45eebea 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -568,6 +568,10 @@ static void process_incoming_migration_bh(void *opaque=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vm_start();<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runstate_set(global_state_get_runstate())=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (runstate_check(RUN_STATE_SUSPENDED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Force vm_start to be called l=
ater. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_start_on_wakeup_requ=
est();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * This must happen after any state changes since as so=
on as an external<br>
@@ -3273,7 +3277,6 @@ static int postcopy_start(MigrationState *ms)<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_iothread();<br>
=C2=A0 =C2=A0 =C2=A0trace_postcopy_start_set_run();<br>
<br>
-=C2=A0 =C2=A0 qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);<=
br>
=C2=A0 =C2=A0 =C2=A0global_state_store();<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);<=
br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
@@ -3484,7 +3487,6 @@ static void migration_completion(MigrationState *s)<b=
r>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;state =3D=3D MIGRATION_STATUS_ACTIVE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_iothread();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;downtime_start =3D qemu_clock_get_m=
s(QEMU_CLOCK_REALTIME);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_wakeup_request(QEMU_WAKEUP_REASON_=
OTHER, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;vm_was_running =3D runstate_is_runn=
ing();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D global_state_store();<br>
<br>
@@ -4285,11 +4287,6 @@ static void *bg_migration_thread(void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_iothread();<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* If VM is currently in suspended state, then, to make=
 a valid runstate<br>
-=C2=A0 =C2=A0 =C2=A0* transition in vm_stop_force_state() we need to wakeu=
p it up.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);<=
br>
=C2=A0 =C2=A0 =C2=A0s-&gt;vm_was_running =3D runstate_is_running();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (global_state_store()) {<br>
diff --git a/softmmu/runstate.c b/softmmu/runstate.c<br>
index c7db5ac..6ba0a4e 100644<br>
--- a/softmmu/runstate.c<br>
+++ b/softmmu/runstate.c<br>
@@ -154,6 +154,7 @@ static const RunStateTransition runstate_transitions_de=
f[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },<br>
=C2=A0 =C2=A0 =C2=A0{ RUN_STATE_SUSPENDED, RUN_STATE_RUNNING },<br>
=C2=A0 =C2=A0 =C2=A0{ RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },<br>
+=C2=A0 =C2=A0 { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },<br>
=C2=A0 =C2=A0 =C2=A0{ RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },<br>
=C2=A0 =C2=A0 =C2=A0{ RUN_STATE_SUSPENDED, RUN_STATE_COLO},<br>
<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 6<br>
Date: Tue, 26 Jul 2022 09:10:39 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 42/46] tests/avocado: add cpr regression test<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-43-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-43-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/avocado/cpr.py | 176 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A02 files changed, 177 insertions(+)<br>
=C2=A0create mode 100644 tests/avocado/cpr.py<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index b93b0bb..adc1218 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3172,6 +3172,7 @@ F: stubs/cpr-state.c<br>
=C2=A0F: include/migration/cpr.h<br>
=C2=A0F: migration/cpr.c<br>
=C2=A0F: hw/vfio/cpr.c<br>
+F: tests/avocado/cpr.py<br>
<br>
=C2=A0Record/replay<br>
=C2=A0M: Pavel Dovgalyuk &lt;<a href=3D"mailto:pavel.dovgaluk@ispras.ru" ta=
rget=3D"_blank" rel=3D"noreferrer">pavel.dovgaluk@ispras.ru</a>&gt;<br>
diff --git a/tests/avocado/cpr.py b/tests/avocado/cpr.py<br>
new file mode 100644<br>
index 0000000..11e1376<br>
--- /dev/null<br>
+++ b/tests/avocado/cpr.py<br>
@@ -0,0 +1,176 @@<br>
+# cpr test<br>
+<br>
+# Copyright (c) 2021, 2022 Oracle and/or its affiliates.<br>
+#<br>
+# This work is licensed under the terms of the GNU GPL, version 2.<br>
+# See the COPYING file in the top-level directory.<br>
+<br>
+import tempfile<br>
+from avocado_qemu import QemuSystemTest<br>
+from avocado.utils import wait<br>
+<br>
+class Cpr(QemuSystemTest):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 :avocado: tags=3Dcpr<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 timeout =3D 5<br>
+=C2=A0 =C2=A0 fast_timeout =3D 1<br>
+<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def has_status(vm, status, command):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vm.command(command)[&#39;status&#39;] i=
n status<br>
+<br>
+=C2=A0 =C2=A0 def wait_for_status(self, vm, status, command):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait.wait_for(self.has_status,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 timeout=3Dself.timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 step=3D0.1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 args=3D(vm,status,command,))<br>
+<br>
+=C2=A0 =C2=A0 def wait_for_runstate(self, vm, status):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_status(vm, status, &#39;query-st=
atus&#39;)<br>
+<br>
+=C2=A0 =C2=A0 def wait_for_migration(self, vm, status):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_status(vm, status, &#39;query-mi=
grate&#39;)<br>
+<br>
+=C2=A0 =C2=A0 def run_and_fail(self, vm, msg):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Qemu will fail fast, so disable monitor to a=
void timeout in accept<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.set_qmp_monitor(False)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.wait(self.timeout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertRegex(vm.get_log(), msg)<br>
+<br>
+=C2=A0 =C2=A0 def get_vm_for_restart(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.get_vm(&#39;-nodefaults&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;-migrate-mode-enable&#39;, &#39;cpr-exec&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;-object&#39;, &#39;memory-backend-memfd,id=3Dp=
c.ram,size=3D8M&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;-machine&#39;, &#39;memory-backend=3Dpc.ram&#3=
9;)<br>
+<br>
+=C2=A0 =C2=A0 def do_cpr_exec(self, vmstate_name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm_for_restart()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &#39;file:&#39; + vmstate_name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D vm.full_args + [&#39;-incoming&#39;, =
&#39;defer&#39;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.command(&#39;migrate-set-parameters&#39;, c=
pr_exec_args=3Dargs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.command(&#39;migrate-set-parameters&#39;, m=
ode=3D&#39;cpr-exec&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.qmp(&#39;migrate&#39;, uri=3Duri)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Cannot poll for migration status, because qe=
mu may call execv before<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # we see it. Wait for STOP instead.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.event_wait(name=3D&#39;STOP&#39;, timeout=
=3Dself.fast_timeout)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Migrate execs and closes the monitor socket,=
 so reopen it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.reopen_qmp_connection()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(vm.command(&#39;query-status&=
#39;)[&#39;status&#39;], &#39;inmigrate&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D vm.command(&#39;migrate-incoming&#39;=
, uri=3Duri)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_migration(vm, (&#39;completed&#3=
9;, &#39;failed&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(vm.command(&#39;query-migrate=
&#39;)[&#39;status&#39;], &#39;completed&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D vm.command(&#39;cont&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.event_wait(name=3D&#39;RESUME&#39;, timeout=
=3Dself.fast_timeout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(vm.command(&#39;query-status&=
#39;)[&#39;status&#39;], &#39;running&#39;)<br>
+<br>
+=C2=A0 =C2=A0 def do_cpr_reboot(self, vmstate_name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D [&#39;-nodefaults&#39;, &#39;-migrate=
-mode-enable&#39;, &#39;cpr-reboot&#39; ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_vm =3D self.get_vm(*args)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &#39;file:&#39; + vmstate_name<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_vm.command(&#39;migrate-set-capabilities&#=
39;, capabilities =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ &quot;capability&quot;: &quot;x-ignore-shared&quot;, &quot;stat=
e&quot;: True }])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_vm.command(&#39;migrate-set-parameters&#39=
;, mode=3D&#39;cpr-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_vm.qmp(&#39;migrate&#39;, uri=3Duri)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_migration(old_vm, (&#39;complete=
d&#39;, &#39;failed&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(old_vm.command(&#39;query-mig=
rate&#39;)[&#39;status&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;completed&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(old_vm.command(&#39;query-sta=
tus&#39;)[&#39;status&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;postmigrate&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D args + [&#39;-incoming&#39;, &#39;def=
er&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm =3D self.get_vm(*args)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(new_vm.command(&#39;query-sta=
tus&#39;)[&#39;status&#39;], &#39;inmigrate&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.command(&#39;migrate-set-capabilities&#=
39;, capabilities =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ &quot;capability&quot;: &quot;x-ignore-shared&quot;, &quot;stat=
e&quot;: True }])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.command(&#39;migrate-set-parameters&#39=
;, mode=3D&#39;cpr-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.command(&#39;migrate-incoming&#39;, uri=
=3Duri)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_migration(new_vm, (&#39;complete=
d&#39;, &#39;failed&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(new_vm.command(&#39;query-mig=
rate&#39;)[&#39;status&#39;], &#39;completed&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.command(&#39;cont&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_vm.event_wait(name=3D&#39;RESUME&#39;, tim=
eout=3Dself.fast_timeout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(new_vm.command(&#39;query-sta=
tus&#39;)[&#39;status&#39;], &#39;running&#39;)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_exec(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that cpr restart mode works<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with tempfile.NamedTemporaryFile() as vmstate_=
file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_cpr_exec(<a href=3D"http=
://vmstate_file.name" rel=3D"noreferrer noreferrer" target=3D"_blank">vmsta=
te_file.name</a>)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_reboot(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that cpr reboot mode works<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with tempfile.NamedTemporaryFile() as vmstate_=
file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_cpr_reboot(<a href=3D"ht=
tp://vmstate_file.name" rel=3D"noreferrer noreferrer" target=3D"_blank">vms=
tate_file.name</a>)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_block_cpr_exec(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that qemu rejects cpr restart mode for =
volatile memory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm(&#39;-nodefaults&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-migrate-mode-enable&#39;, &#39;cpr-exec&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri=3D&#39;file:/dev/null&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D vm.full_args + [&#39;-S&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D vm.command(&#39;migrate-set-parameter=
s&#39;, mode=3D&#39;cpr-exec&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp =3D vm.qmp(&#39;migrate&#39;, uri=3Duri)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.qmp(&#39;quit&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expect =3D r&#39;Memory region .* is volatile&=
#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertRegex(rsp[&#39;error&#39;][&#39;des=
c&#39;], expect)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_block_memfd(self):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that qemu complains for only-cpr-capabl=
e and volatile memory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm(&#39;-nodefaults&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-migrate-mode-enable&#39;, &#39;cpr-exec&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-only-cpr-capable&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_and_fail(vm, r&#39;only-cpr-capable s=
pecified.* Memory &#39;)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_block_replay(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that qemu complains for only-cpr-capabl=
e and replay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm_for_restart()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.add_args(&#39;-only-cpr-capable&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;-icount&#39;, &#39;shift=3D10,rr=3Drecord,rrfile=3D/dev/null&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_and_fail(vm, r&#39;only-cpr-capable s=
pecified.* replay &#39;)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_block_chardev(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that qemu complains for only-cpr-capabl=
e and unsupported chardev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm_for_restart()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.add_args(&#39;-only-cpr-capable&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;-chardev&#39;, &#39;vc,id=3Dvc1&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_and_fail(vm, r&#39;only-cpr-capable s=
pecified.* vc1 &#39;)<br>
+<br>
+=C2=A0 =C2=A0 def test_cpr_allow_chardev(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that qemu allows unsupported chardev wi=
th reopen-on-cpr<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm =3D self.get_vm_for_restart()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.add_args(&#39;-only-cpr-capable&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;-chardev&#39;, &#39;vc,id=3Dvc1,reopen-on-cpr=3Don&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_runstate(vm, (&#39;running&#39;)=
)<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 7<br>
Date: Tue, 26 Jul 2022 09:10:43 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 46/46] vfio: allow cpr-reboot migration if<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 suspended<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-47-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-47-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
The cpr-reboot mode supports vfio devices if the caller first suspends the<=
br>
guest, such as by issuing guest-suspend-ram to the qemu guest agent.=C2=A0 =
The<br>
guest drivers&#39; suspend methods flush outstanding requests and re-initia=
lize<br>
the devices, and thus there is no device state to save and restore.<br>
<br>
Relax the vfio blocker, and add a notifier that verifies the guest is<br>
suspended.=C2=A0 Skip dirty page tracking to avoid ioctl errors.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0hw/vfio/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 8 ++++++--<br>
=C2=A0hw/vfio/cpr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 21 +++++++++++++++++++++<br>
=C2=A0hw/vfio/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3=
 ++-<br>
=C2=A0include/hw/vfio/vfio-common.h |=C2=A0 1 +<br>
=C2=A04 files changed, 30 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/vfio/common.c b/hw/vfio/common.c<br>
index de821e1..5b54cbe 100644<br>
--- a/hw/vfio/common.c<br>
+++ b/hw/vfio/common.c<br>
@@ -1355,14 +1355,18 @@ static void vfio_listener_log_global_start(MemoryLi=
stener *listener)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIOContainer *container =3D container_of(listener, VFI=
OContainer, listener);<br>
<br>
-=C2=A0 =C2=A0 vfio_set_dirty_page_tracking(container, true);<br>
+=C2=A0 =C2=A0 if (!runstate_check(RUN_STATE_SUSPENDED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfio_set_dirty_page_tracking(container, true);=
<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void vfio_listener_log_global_stop(MemoryListener *listener)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIOContainer *container =3D container_of(listener, VFI=
OContainer, listener);<br>
<br>
-=C2=A0 =C2=A0 vfio_set_dirty_page_tracking(container, false);<br>
+=C2=A0 =C2=A0 if (!runstate_check(RUN_STATE_SUSPENDED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfio_set_dirty_page_tracking(container, false)=
;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t i=
ova,<br>
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c<br>
index 1f682cb..ef8827c 100644<br>
--- a/hw/vfio/cpr.c<br>
+++ b/hw/vfio/cpr.c<br>
@@ -10,6 +10,7 @@<br>
=C2=A0#include &lt;linux/vfio.h&gt;<br>
=C2=A0#include &quot;hw/vfio/vfio-common.h&quot;<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
+#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;migration/blocker.h&quot;<br>
=C2=A0#include &quot;migration/migration.h&quot;<br>
@@ -132,8 +133,26 @@ static void vfio_cpr_fail_notifier(Notifier *notifier,=
 void *data)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void vfio_cpr_reboot_notifier(Notifier *notifier, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MigrationState *s =3D data;<br>
+<br>
+=C2=A0 =C2=A0 if (migrate_mode_of(s) =3D=3D MIG_MODE_CPR_REBOOT &amp;&amp;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !migration_has_failed(s) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !runstate_check(RUN_STATE_SUSPENDED)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;VFIO device only su=
pports cpr-reboot for &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;runstate suspended&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_notifier_set_error(s, err);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0int vfio_cpr_register_container(VFIOContainer *container, Error **err=
p)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 migration_add_notifier(&amp;container-&gt;cpr_reboot_notifie=
r,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0vfio_cpr_reboot_notifier);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;cpr_blocker =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0if (!vfio_is_cpr_capable(container, &amp;container-&gt;=
cpr_blocker)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return migrate_add_blockers(&amp;containe=
r-&gt;cpr_blocker, errp,<br>
@@ -148,6 +167,8 @@ int vfio_cpr_register_container(VFIOContainer *containe=
r, Error **errp)<br>
<br>
=C2=A0void vfio_cpr_unregister_container(VFIOContainer *container)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 migration_remove_notifier(&amp;container-&gt;cpr_reboot_noti=
fier);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0migrate_del_blocker(&amp;container-&gt;cpr_blocker);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0vmstate_unregister(NULL, &amp;vfio_container_vmstate, c=
ontainer);<br>
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c<br>
index 6b0d401..3919941 100644<br>
--- a/hw/vfio/migration.c<br>
+++ b/hw/vfio/migration.c<br>
@@ -890,7 +890,8 @@ add_blocker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VFIO device d=
oesn&#39;t support migration&quot;);<br>
=C2=A0 =C2=A0 =C2=A0g_free(info);<br>
<br>
-=C2=A0 =C2=A0 return migrate_add_blocker(&amp;vbasedev-&gt;migration_block=
er, errp);<br>
+=C2=A0 =C2=A0 return migrate_add_blockers(&amp;vbasedev-&gt;migration_bloc=
ker, errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIG_MODE_NORMAL, -1);<br>
=C2=A0}<br>
<br>
=C2=A0void vfio_migration_finalize(VFIODevice *vbasedev)<br>
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h<=
br>
index b682645..243376b 100644<br>
--- a/include/hw/vfio/vfio-common.h<br>
+++ b/include/hw/vfio/vfio-common.h<br>
@@ -83,6 +83,7 @@ typedef struct VFIOContainer {<br>
=C2=A0 =C2=A0 =C2=A0MemoryListener prereg_listener;<br>
=C2=A0 =C2=A0 =C2=A0Notifier cpr_notifier;<br>
=C2=A0 =C2=A0 =C2=A0Error *cpr_blocker;<br>
+=C2=A0 =C2=A0 Notifier cpr_reboot_notifier;<br>
=C2=A0 =C2=A0 =C2=A0unsigned iommu_type;<br>
=C2=A0 =C2=A0 =C2=A0Error *error;<br>
=C2=A0 =C2=A0 =C2=A0bool initialized;<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 8<br>
Date: Tue, 26 Jul 2022 09:10:20 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 23/46] cpr: add exec-mode blockers<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-24-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-24-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Add blockers for cpr-exec migration mode for devices and options that do<br=
>
not support it.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0accel/xen/xen-all.c=C2=A0 =C2=A0| 3 +++<br>
=C2=A0migration/migration.c | 5 +++++<br>
=C2=A0replay/replay.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A03 files changed, 12 insertions(+)<br>
<br>
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c<br>
index 69aa7d0..2896044 100644<br>
--- a/accel/xen/xen-all.c<br>
+++ b/accel/xen/xen-all.c<br>
@@ -181,6 +181,9 @@ static int xen_init(MachineState *ms)<br>
=C2=A0 =C2=A0 =C2=A0 * opt out of system RAM being allocated by generic cod=
e<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 migrate_add_blocker_always(&quot;xen does not support cpr ex=
ec&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal, MIG_MODE_CPR_EXEC, =
-1);<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 1a8a6ff..7b46213 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -1348,6 +1348,11 @@ static bool migrate_caps_check(bool *cap_list,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return migrate_add_blocker_always(&quot;x-colo=
 is not compatible with cpr&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
rrp, MIG_MODE_CPR_EXEC, -1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
diff --git a/replay/replay.c b/replay/replay.c<br>
index 4c396bb..b0194dd 100644<br>
--- a/replay/replay.c<br>
+++ b/replay/replay.c<br>
@@ -19,6 +19,7 @@<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;sysemu/cpus.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;migration/blocker.h&quot;<br>
<br>
=C2=A0/* Current version of the replay mechanism.<br>
=C2=A0 =C2=A0 Increase it when file format changes. */<br>
@@ -232,6 +233,9 @@ static void replay_enable(const char *fname, int mode)<=
br>
=C2=A0 =C2=A0 =C2=A0const char *fmode =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0assert(!replay_file);<br>
<br>
+=C2=A0 =C2=A0 migrate_add_blocker_always(&quot;replay is not compatible wi=
th cpr&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal, MIG_MODE_CPR_EXEC,=
 -1);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0case REPLAY_MODE_RECORD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmode =3D &quot;wb&quot;;<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 9<br>
Date: Tue, 26 Jul 2022 09:10:06 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 09/46] cpr: reboot mode<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-10-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-10-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Add the cpr-reboot migration mode.=C2=A0 Usage:<br>
=C2=A0 qemu-system-$arch -migrate-mode-enable cpr-reboot ...<br>
=C2=A0 migrate_set_parameter mode cpr-reboot<br>
=C2=A0 migrate -d file:&lt;filename&gt;<br>
=C2=A0 ... poll for runstate postmigrate ...<br>
=C2=A0 quit<br>
<br>
=C2=A0 qemu-system-$arch -migrate-mode-enable cpr-reboot ... -incoming defe=
r<br>
=C2=A0 migrate_set_parameter mode cpr-reboot<br>
=C2=A0 migrate_incoming file:&lt;filename&gt;<br>
<br>
In this mode, the migrate command saves state to a file, allowing one<br>
to quit qemu, reboot to an updated kernel, and restart an updated version<b=
r>
of qemu.=C2=A0 The caller must specify a migration URI that writes to and r=
eads<br>
from a file.=C2=A0 Unlike normal mode, the use of certain local storage opt=
ions<br>
does not block the migration, but the caller must not modify guest block<br=
>
devices between the quit and restart.=C2=A0 The guest RAM memory-backend mu=
st<br>
be shared, and the @x-ignore-shared migration capability must be set,<br>
to avoid saving it to the file.=C2=A0 Guest RAM must be non-volatile across=
<br>
reboot, such as by backing it with a dax device, but this is not enforced.<=
br>
The restarted qemu arguments must match those used to initially start qemu,=
<br>
plus the -incoming option.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0qapi/migration.json | 16 +++++++++++++++-<br>
=C2=A01 file changed, 15 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 931c492..55f0479 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -572,10 +572,24 @@<br>
=C2=A0#<br>
=C2=A0# @normal: the original form of migration.<br>
=C2=A0#<br>
+# @cpr-reboot: The migrate command saves state to a file, allowing one to<=
br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 quit qemu, reboot to an =
updated kernel, and restart an updated<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version of qemu.=C2=A0 T=
he caller must specify a migration URI<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that writes to and reads=
 from a file.=C2=A0 Unlike normal mode,<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the use of certain local=
 storage options does not block the<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration, but the calle=
r must not modify guest block devices<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 between the quit and res=
tart.=C2=A0 The guest RAM memory-backend<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 must be shared, and the =
@x-ignore-shared migration capability<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 must be set, to avoid sa=
ving it to the file.=C2=A0 Guest RAM must<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be non-volatile across r=
eboot, such as by backing it with<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a dax device, but this i=
s not enforced.=C2=A0 The restarted qemu<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments must match tho=
se used to initially start qemu, plus<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the -incoming option.<br=
>
+#<br>
=C2=A0# Since: 7.1<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;MigMode&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;normal&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;normal&#39;, &#39;cpr-reboot&#39; ] }<br>
<br>
=C2=A0##<br>
=C2=A0# @BitmapMigrationBitmapAliasTransform:<br>
-- <br>
1.8.3.1<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 10<br>
Date: Tue, 26 Jul 2022 09:10:28 -0700<br>
From: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=
=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;, Stefan Hajnoczi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;, Marc-Andr=C3=
=A9 Lureau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt=
;, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Dr. David Alan Gilbert&quot; &lt;<a href=
=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbe=
rt@redhat.com</a>&gt;, &quot;Michael S. Tsirkin&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mst@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;, Marcel Apfelbaum &lt;<a=
 href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank" rel=3D"norefe=
rrer">marcel.apfelbaum@gmail.com</a>&gt;, Alex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Williamson &lt;<a href=3D"mailto:alex.williamso=
n@redhat.com" target=3D"_blank" rel=3D"noreferrer">alex.williamson@redhat.c=
om</a>&gt;, &quot;Daniel P. Berrange&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;, Juan Quintela=
 &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">quintela@redhat.com</a>&gt;, Markus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;, Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">eblake@redhat.com</a>&gt;, Jason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zeng &lt;<a href=3D"mailto:jason.zeng@linux.int=
el.com" target=3D"_blank" rel=3D"noreferrer">jason.zeng@linux.intel.com</a>=
&gt;, Zheng Chuan<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:zhengchuan@huawei.com" ta=
rget=3D"_blank" rel=3D"noreferrer">zhengchuan@huawei.com</a>&gt;, Steve Sis=
tare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Mark Kanda &lt;<a href=3D"mailto:mark.kanda@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">mark.kanda@oracle.com</a>&gt;=
, Guoyi Tu &lt;<a href=3D"mailto:tugy@chinatelecom.cn" target=3D"_blank" re=
l=3D"noreferrer">tugy@chinatelecom.cn</a>&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.or=
g</a>&gt;, Philippe Mathieu-Daud=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:philippe.mathieu.daude@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">philippe.mathieu.daude@gmail.=
com</a>&gt;, Igor Mammedov<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:imammedo@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;, David Hildenb=
rand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank" rel=3D"noref=
errer">david@redhat.com</a>&gt;, John Snow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;, Peng Liang &lt;<a =
href=3D"mailto:tcx4c70@gmail.com" target=3D"_blank" rel=3D"noreferrer">tcx4=
c70@gmail.com</a>&gt;<br>
Subject: [PATCH V9 31/46] vfio-pci: cpr part 1 (fd and dma)<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:1658851843-236870-32-git-=
send-email-steven.sistare@oracle.com" target=3D"_blank" rel=3D"noreferrer">=
1658851843-236870-32-git-send-email-steven.sistare@oracle.com</a>&gt;<br>
<br>
Enable vfio-pci devices to be saved and restored across a cpr-exec of qemu.=
<br>
<br>
At vfio creation time, save the value of vfio container, group, and device<=
br>
descriptors in cpr state.<br>
<br>
In the container pre_save handler, suspend the use of virtual addresses<br>
in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will<br>
be remapped at a different VA after exec.=C2=A0 DMA to already-mapped pages=
<br>
continues.=C2=A0 Save the msi message area as part of vfio-pci vmstate, sav=
e the<br>
interrupt and notifier eventfd&#39;s in cpr state, and clear the close-on-e=
xec<br>
flag for the vfio descriptors.=C2=A0 The flag is not cleared earlier becaus=
e<br>
the descriptors should not persist across miscellaneous fork and exec calls=
<br>
that may be performed during normal operation.<br>
<br>
On qemu restart, vfio_realize() finds the saved descriptors, uses the<br>
descriptors, and notes that the device is being reused.=C2=A0 Device and io=
mmu<br>
state is already configured, so operations in vfio_realize that would<br>
modify the configuration are skipped for a reused device, including vfio<br=
>
ioctl&#39;s and writes to PCI configuration space.=C2=A0 Vfio PCI device re=
set<br>
is also suppressed. The result is that vfio_realize constructs qemu<br>
data structures that reflect the current state of the device.=C2=A0 However=
,<br>
the reconstruction is not complete until migrate_incoming is called.<br>
migrate_incoming loads the msi data, the vfio post_load handler finds<br>
eventfds in cpr state, rebuilds vector data structures, and attaches the<br=
>
interrupts to the new KVM instance.=C2=A0 The container post_load handler t=
hen<br>
invokes the main vfio listener callback, which walks the flattened ranges<b=
r>
of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the<b=
r>
kernel of the new VA&#39;s.=C2=A0 Lastly, migration resumes the VM.<br>
<br>
This functionality is delivered by 3 patches for clarity.=C2=A0 Part 1 hand=
les<br>
device file descriptors and DMA.=C2=A0 Part 2 adds eventfd and MSI/MSI-X ve=
ctor<br>
support.=C2=A0 Part 3 adds INTX support.<br>
<br>
Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@oracle.co=
m" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&gt;<b=
r>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 12 ++++<br>
=C2=A0hw/vfio/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15=
2 +++++++++++++++++++++++++++++++++++-------<br>
=C2=A0hw/vfio/cpr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 120 +++++++++++++++++++++++++++++++++<br>
=C2=A0hw/vfio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
=C2=A0hw/vfio/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 43 ++++++++++++<br>
=C2=A0hw/vfio/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
1 +<br>
=C2=A0include/hw/vfio/vfio-common.h |=C2=A0 11 +++<br>
=C2=A0include/migration/vmstate.h=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A09 files changed, 319 insertions(+), 24 deletions(-)<br>
=C2=A0create mode 100644 hw/vfio/cpr.c<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 42f6f4a..3af099a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3170,6 +3170,7 @@ F: migration/cpr-state.c<br>
=C2=A0F: stubs/cpr-state.c<br>
=C2=A0F: include/migration/cpr.h<br>
=C2=A0F: migration/cpr.c<br>
+F: hw/vfio/cpr.c<br>
<br>
=C2=A0Record/replay<br>
=C2=A0M: Pavel Dovgalyuk &lt;<a href=3D"mailto:pavel.dovgaluk@ispras.ru" ta=
rget=3D"_blank" rel=3D"noreferrer">pavel.dovgaluk@ispras.ru</a>&gt;<br>
diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
index 2f450f6..d7f945f 100644<br>
--- a/hw/pci/pci.c<br>
+++ b/hw/pci/pci.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties-system.h&quot;<br>
+#include &quot;migration/misc.h&quot;<br>
=C2=A0#include &quot;migration/qemu-file-types.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
@@ -350,6 +351,17 @@ static void pci_reset_regions(PCIDevice *dev)<br>
<br>
=C2=A0static void pci_do_device_reset(PCIDevice *dev)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* A PCI device that is resuming for cpr is already con=
figured, so do<br>
+=C2=A0 =C2=A0 =C2=A0* not reset it here when we are called from qemu_syste=
m_reset prior to<br>
+=C2=A0 =C2=A0 =C2=A0* cpr load, else interrupts may be lost for vfio-pci d=
evices.=C2=A0 It is<br>
+=C2=A0 =C2=A0 =C2=A0* safe to skip this reset for all PCI devices, because=
 cpr load will set<br>
+=C2=A0 =C2=A0 =C2=A0* all fields that would have been set here.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (migrate_mode() =3D=3D MIG_MODE_CPR_EXEC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0pci_device_deassert_intx(dev);<br>
=C2=A0 =C2=A0 =C2=A0assert(dev-&gt;irq_state =3D=3D 0);<br>
<br>
diff --git a/hw/vfio/common.c b/hw/vfio/common.c<br>
index ace9562..b7b35d4 100644<br>
--- a/hw/vfio/common.c<br>
+++ b/hw/vfio/common.c<br>
@@ -31,6 +31,7 @@<br>
=C2=A0#include &quot;exec/memory.h&quot;<br>
=C2=A0#include &quot;exec/ram_addr.h&quot;<br>
=C2=A0#include &quot;hw/hw.h&quot;<br>
+#include &quot;migration/cpr-state.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
=C2=A0#include &quot;qemu/range.h&quot;<br>
@@ -460,6 +461,8 @@ static int vfio_dma_unmap(VFIOContainer *container,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D size,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
+=C2=A0 =C2=A0 assert(!container-&gt;reused);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (iotlb &amp;&amp; container-&gt;dirty_pages_supporte=
d &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfio_devices_all_running_and_saving(conta=
iner)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vfio_dma_unmap_bitmap(container, i=
ova, size, iotlb);<br>
@@ -496,12 +499,24 @@ static int vfio_dma_map(VFIOContainer *container, hwa=
ddr iova,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vfio_iommu_type1_dma_map map =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.argsz =3D sizeof(map),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VFIO_DMA_MAP_FLAG_READ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vaddr =3D (__u64)(uintptr_t)vaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iova =3D iova,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D size,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Set the new vaddr for any mappings registered during=
 cpr load.<br>
+=C2=A0 =C2=A0 =C2=A0* Reused is cleared thereafter.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (container-&gt;reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 map.flags =3D VFIO_DMA_MAP_FLAG_VADDR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(container-&gt;fd, VFIO_IOMMU_MAP_DMA=
, &amp;map)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 map.flags =3D VFIO_DMA_MAP_FLAG_READ;<br>
=C2=A0 =C2=A0 =C2=A0if (!readonly) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0map.flags |=3D VFIO_DMA_MAP_FLAG_WRITE;<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -517,7 +532,9 @@ static int vfio_dma_map(VFIOContainer *container, hwadd=
r iova,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 error_report(&quot;VFIO_MAP_DMA failed: %s&quot;, strerror(e=
rrno));<br>
+fail:<br>
+=C2=A0 =C2=A0 error_report(&quot;vfio_dma_map %s (iova %lu, size %ld, va %=
p): %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (container-&gt;reused ? &quot;VADDR&quot; : &q=
uot;&quot;), iova, size, vaddr, strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0return -errno;<br>
=C2=A0}<br>
<br>
@@ -882,6 +899,12 @@ static void vfio_listener_region_add(MemoryListener *l=
istener,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegionSec=
tion *section)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIOContainer *container =3D container_of(listener, VFI=
OContainer, listener);<br>
+=C2=A0 =C2=A0 vfio_container_region_add(container, section);<br>
+}<br>
+<br>
+void vfio_container_region_add(VFIOContainer *container,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegionSection *section)<br>
+{<br>
=C2=A0 =C2=A0 =C2=A0hwaddr iova, end;<br>
=C2=A0 =C2=A0 =C2=A0Int128 llend, llsize;<br>
=C2=A0 =C2=A0 =C2=A0void *vaddr;<br>
@@ -1492,6 +1515,12 @@ static void vfio_listener_release(VFIOContainer *con=
tainer)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+void vfio_listener_register(VFIOContainer *container)<br>
+{<br>
+=C2=A0 =C2=A0 container-&gt;listener =3D vfio_memory_listener;<br>
+=C2=A0 =C2=A0 memory_listener_register(&amp;container-&gt;listener, contai=
ner-&gt;space-&gt;as);<br>
+}<br>
+<br>
=C2=A0static struct vfio_info_cap_header *<br>
=C2=A0vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)<br>
=C2=A0{<br>
@@ -1910,6 +1939,22 @@ static int vfio_init_container(VFIOContainer *contai=
ner, int group_fd,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int iommu_type, ret;<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If container is reused, just set its type and skip t=
he ioctls, as the<br>
+=C2=A0 =C2=A0 =C2=A0* container and group are already configured in the ke=
rnel.<br>
+=C2=A0 =C2=A0 =C2=A0* VFIO_TYPE1v2_IOMMU is the only type that supports re=
use/cpr.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (container-&gt;reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(container-&gt;fd, VFIO_CHECK_EXTENSI=
ON, VFIO_TYPE1v2_IOMMU)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container-&gt;iommu_type =3D VFI=
O_TYPE1v2_IOMMU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;container=
 was reused but VFIO_TYPE1v2_IOMMU &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;is not supported&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0iommu_type =3D vfio_get_iommu_type(container, errp);<br=
>
=C2=A0 =C2=A0 =C2=A0if (iommu_type &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return iommu_type;<br>
@@ -2014,9 +2059,12 @@ static int vfio_connect_container(VFIOGroup *group, =
AddressSpace *as,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIOContainer *container;<br>
=C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
+=C2=A0 =C2=A0 bool reused;<br>
=C2=A0 =C2=A0 =C2=A0VFIOAddressSpace *space;<br>
<br>
=C2=A0 =C2=A0 =C2=A0space =3D vfio_get_address_space(as);<br>
+=C2=A0 =C2=A0 fd =3D cpr_find_fd(&quot;vfio_container_for_group&quot;, gro=
up-&gt;groupid);<br>
+=C2=A0 =C2=A0 reused =3D (fd &gt; 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * VFIO is currently incompatible with discarding of RA=
M insofar as the<br>
@@ -2049,27 +2097,47 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0 * details once we know which type of IOMMU we are usin=
g.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If the container is reused, then the group is alread=
y attached in the<br>
+=C2=A0 =C2=A0 =C2=A0* kernel.=C2=A0 If a container with matching fd is fou=
nd, then update the<br>
+=C2=A0 =C2=A0 =C2=A0* userland group list and return.=C2=A0 If not, then a=
fter the loop, create<br>
+=C2=A0 =C2=A0 =C2=A0* the container struct and group list.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
=C2=A0 =C2=A0 =C2=A0QLIST_FOREACH(container, &amp;space-&gt;containers, nex=
t) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ioctl(group-&gt;fd, VFIO_GROUP_SET_CONTAI=
NER, &amp;container-&gt;fd)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vfio_ram_block_discard_d=
isable(container, true);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, -ret,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Cannot set discarding of=
 RAM broken&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(group-&g=
t;fd, VFIO_GROUP_UNSET_CONTAINER,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;container-&gt;fd)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;vfio: error disconnecting group %d from&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; container&quot;, group-=
&gt;groupid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (container-&gt;fd !=3D fd) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ioctl(group-&gt;fd, VFIO_GROUP_SET_=
CONTAINER, &amp;container-&gt;fd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vfio_ram_block_discard_disable(contain=
er, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Cannot set discarding of RAM broken&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(group-&gt;fd, VFIO_GRO=
UP_UNSET_CONTAINER,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;container-&gt;fd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot=
;vfio: error disconnecting group %d from&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; container&quot;, group-&gt;groupid);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group-&gt;container =3D containe=
r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIST_INSERT_HEAD(&amp;container=
-&gt;group_list, group, container_next);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto delete_fd_exit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 group-&gt;container =3D container;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIST_INSERT_HEAD(&amp;container-&gt;group_lis=
t, group, container_next);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!reused) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfio_kvm_device_add_group(g=
roup);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpr_save_fd(&quot;vfio_container=
_for_group&quot;, group-&gt;groupid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 container-&gt;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D qemu_open_old(&quot;/dev/vfio/vfio&quot=
;, O_RDWR);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 fd =3D qemu_open_old(&quot;/dev/vfio/vfio&quot;, O_RDWR);<br=
>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;faile=
d to open /dev/vfio/vfio&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -errno;<br>
@@ -2087,6 +2155,7 @@ static int vfio_connect_container(VFIOGroup *group, A=
ddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0container =3D g_malloc0(sizeof(*container));<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;space =3D space;<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;fd =3D fd;<br>
+=C2=A0 =C2=A0 container-&gt;reused =3D reused;<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;error =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;dirty_pages_supported =3D false;<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;dma_max_mappings =3D 0;<br>
@@ -2099,10 +2168,15 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_container_exit;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 ret =3D vfio_cpr_register_container(container, errp);<br>
+=C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto free_container_exit;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vfio_ram_block_discard_disable(container, true)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, -ret, &quot;Cannot=
 set discarding of RAM broken&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto free_container_exit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unregister_container_exit;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (container-&gt;iommu_type) {<br>
@@ -2213,9 +2287,16 @@ static int vfio_connect_container(VFIOGroup *group, =
AddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0group-&gt;container =3D container;<br>
=C2=A0 =C2=A0 =C2=A0QLIST_INSERT_HEAD(&amp;container-&gt;group_list, group,=
 container_next);<br>
<br>
-=C2=A0 =C2=A0 container-&gt;listener =3D vfio_memory_listener;<br>
-<br>
-=C2=A0 =C2=A0 memory_listener_register(&amp;container-&gt;listener, contai=
ner-&gt;space-&gt;as);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If reused, register the listener later, after all st=
ate that may<br>
+=C2=A0 =C2=A0 =C2=A0* affect regions and mapping boundaries has been cpr l=
oad&#39;ed.=C2=A0 Later,<br>
+=C2=A0 =C2=A0 =C2=A0* the listener will invoke its callback on each flat s=
ection and call<br>
+=C2=A0 =C2=A0 =C2=A0* vfio_dma_map to supply the new vaddr, and the calls =
will match the<br>
+=C2=A0 =C2=A0 =C2=A0* mappings remembered by the kernel.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfio_listener_register(container);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (container-&gt;error) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
@@ -2225,6 +2306,7 @@ static int vfio_connect_container(VFIOGroup *group, A=
ddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0container-&gt;initialized =3D true;<br>
+=C2=A0 =C2=A0 cpr_resave_fd(&quot;vfio_container_for_group&quot;, group-&g=
t;groupid, fd);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0listener_release_exit:<br>
@@ -2236,6 +2318,9 @@ listener_release_exit:<br>
=C2=A0enable_discards_exit:<br>
=C2=A0 =C2=A0 =C2=A0vfio_ram_block_discard_disable(container, false);<br>
<br>
+unregister_container_exit:<br>
+=C2=A0 =C2=A0 vfio_cpr_unregister_container(container);<br>
+<br>
=C2=A0free_container_exit:<br>
=C2=A0 =C2=A0 =C2=A0g_free(container);<br>
<br>
@@ -2245,6 +2330,8 @@ close_fd_exit:<br>
=C2=A0put_space_exit:<br>
=C2=A0 =C2=A0 =C2=A0vfio_put_address_space(space);<br>
<br>
+delete_fd_exit:<br>
+=C2=A0 =C2=A0 cpr_delete_fd(&quot;vfio_container_for_group&quot;, group-&g=
t;groupid);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
@@ -2254,6 +2341,7 @@ static void vfio_disconnect_container(VFIOGroup *grou=
p)<br>
<br>
=C2=A0 =C2=A0 =C2=A0QLIST_REMOVE(group, container_next);<br>
=C2=A0 =C2=A0 =C2=A0group-&gt;container =3D NULL;<br>
+=C2=A0 =C2=A0 cpr_delete_fd(&quot;vfio_container_for_group&quot;, group-&g=
t;groupid);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Explicitly release the listener first before unset c=
ontainer,<br>
@@ -2290,6 +2378,7 @@ static void vfio_disconnect_container(VFIOGroup *grou=
p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vfio_disconnect_container(container=
-&gt;fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfio_cpr_unregister_container(container);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(container-&gt;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(container);<br>
<br>
@@ -2319,7 +2408,12 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace =
*as, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0group =3D g_malloc0(sizeof(*group));<br>
<br>
=C2=A0 =C2=A0 =C2=A0snprintf(path, sizeof(path), &quot;/dev/vfio/%d&quot;, =
groupid);<br>
-=C2=A0 =C2=A0 group-&gt;fd =3D qemu_open_old(path, O_RDWR);<br>
+<br>
+=C2=A0 =C2=A0 group-&gt;fd =3D cpr_find_fd(&quot;vfio_group&quot;, groupid=
);<br>
+=C2=A0 =C2=A0 if (group-&gt;fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 group-&gt;fd =3D qemu_open_old(path, O_RDWR);<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (group-&gt;fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;faile=
d to open %s&quot;, path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_group_exit;<br>
@@ -2352,7 +2446,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *=
as, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0QLIST_INSERT_HEAD(&amp;vfio_group_list, group, next);<b=
r>
-<br>
+=C2=A0 =C2=A0 cpr_resave_fd(&quot;vfio_group&quot;, groupid, group-&gt;fd)=
;<br>
=C2=A0 =C2=A0 =C2=A0return group;<br>
<br>
=C2=A0close_fd_exit:<br>
@@ -2377,6 +2471,7 @@ void vfio_put_group(VFIOGroup *group)<br>
=C2=A0 =C2=A0 =C2=A0vfio_disconnect_container(group);<br>
=C2=A0 =C2=A0 =C2=A0QLIST_REMOVE(group, next);<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_put_group(group-&gt;fd);<br>
+=C2=A0 =C2=A0 cpr_delete_fd(&quot;vfio_group&quot;, group-&gt;groupid);<br=
>
=C2=A0 =C2=A0 =C2=A0close(group-&gt;fd);<br>
=C2=A0 =C2=A0 =C2=A0g_free(group);<br>
<br>
@@ -2390,8 +2485,14 @@ int vfio_get_device(VFIOGroup *group, const char *na=
me,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct vfio_device_info dev_info =3D { .argsz =3D sizeo=
f(dev_info) };<br>
=C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
+=C2=A0 =C2=A0 bool reused;<br>
+<br>
+=C2=A0 =C2=A0 fd =3D cpr_find_fd(name, 0);<br>
+=C2=A0 =C2=A0 reused =3D (fd &gt;=3D 0);<br>
+=C2=A0 =C2=A0 if (!reused) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D ioctl(group-&gt;fd, VFIO_GROUP_GET_DEVI=
CE_FD, name);<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 fd =3D ioctl(group-&gt;fd, VFIO_GROUP_GET_DEVICE_FD, name);<=
br>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;error=
 getting device from group %d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 group-&gt;groupid);<br>
@@ -2436,11 +2537,13 @@ int vfio_get_device(VFIOGroup *group, const char *n=
ame,<br>
=C2=A0 =C2=A0 =C2=A0vbasedev-&gt;num_irqs =3D dev_info.num_irqs;<br>
=C2=A0 =C2=A0 =C2=A0vbasedev-&gt;num_regions =3D dev_info.num_regions;<br>
=C2=A0 =C2=A0 =C2=A0vbasedev-&gt;flags =3D dev_info.flags;<br>
+=C2=A0 =C2=A0 vbasedev-&gt;reused =3D reused;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_get_device(name, dev_info.flags, dev_info.nu=
m_regions,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dev_info.num_irqs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0vbasedev-&gt;reset_works =3D !!(dev_info.flags &amp; VF=
IO_DEVICE_FLAGS_RESET);<br>
+=C2=A0 =C2=A0 cpr_resave_fd(name, 0, fd);<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -2452,6 +2555,7 @@ void vfio_put_base_device(VFIODevice *vbasedev)<br>
=C2=A0 =C2=A0 =C2=A0QLIST_REMOVE(vbasedev, next);<br>
=C2=A0 =C2=A0 =C2=A0vbasedev-&gt;group =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_put_base_device(vbasedev-&gt;fd);<br>
+=C2=A0 =C2=A0 cpr_delete_fd(vbasedev-&gt;name, 0);<br>
=C2=A0 =C2=A0 =C2=A0close(vbasedev-&gt;fd);<br>
=C2=A0}<br>
<br>
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c<br>
new file mode 100644<br>
index 0000000..83f7872<br>
--- /dev/null<br>
+++ b/hw/vfio/cpr.c<br>
@@ -0,0 +1,120 @@<br>
+/*<br>
+ * Copyright (c) 2021, 2022 Oracle and/or its affiliates.<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &lt;sys/ioctl.h&gt;<br>
+#include &lt;linux/vfio.h&gt;<br>
+#include &quot;hw/vfio/vfio-common.h&quot;<br>
+#include &quot;sysemu/kvm.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;migration/blocker.h&quot;<br>
+#include &quot;migration/migration.h&quot;<br>
+#include &quot;migration/m</blockquote></div>

--000000000000b41a1906067a6530--

