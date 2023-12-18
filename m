Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 791538179C9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFISX-0002Ca-Vz; Mon, 18 Dec 2023 13:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFISS-0002Ba-LI
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:35:16 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rFISL-000596-G6
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:35:13 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a236456fee1so127087566b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1702924502; x=1703529302; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMX4mVkKj7xepL9fVXQtIYJhy/UK0o+utm+Ypy0Qum8=;
 b=OhO8Qz5MxusEyZ1MdDMcG60oEdaeZI6zh5NhNQBRaJvI1XMhaBzqh/ULe3ktoGUHc9
 sWvv0oaRu6Z7t8xEIPrAY8O8a1ZUkSL2FTarYg1LsfskG4UB4AEvu0ucP8/WNiteBGv/
 2Q/BJHuXddgfZlsA13lAHat2axia27FKQSoaMXZmfEKf1LbPPSwOV5vkktNbb94uOlGG
 iTI+DyIy2Ex1R20Hz6s4lNOiHVEJlsdEjNmEIU6uR2VvesSVzN8ZIo0PkN+8kY33fCXA
 R3Am5djqo5i/K0L1S8IlhWmfBbv8fksghpEkRY2fpDvVjcl0isv8beKWxu3PxeC94wfk
 5XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702924502; x=1703529302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMX4mVkKj7xepL9fVXQtIYJhy/UK0o+utm+Ypy0Qum8=;
 b=XPFFygIJRWR1Uib+fr7vnjRzbQlyxTaNU8R2Aq8lFNS4JoZs4nASJ7NfO4Or0LuBXS
 16ErrlYKgvRM0X3dMhFce/GStlI5gMgP7haykeFrVgx2Sne6VXRf397UQ5+PS2egFjti
 HkOw/X82gKyKS/UWPj2BfmCly80S5VpX1U2pgjmbqRjtmVqomJkUGyFdZ7jSX10PaK12
 EGj3fKcpPiAsbcVuXJpoohTT0/rdzSnYx8PvJRVfyK2s4TQWb/n8/1wfWHnoWNT1xyTi
 luKAuEDCIR2NQP4wcy8J8ZYwM+fbTa5LO2gEt/Vb58fJewU4daERhEUxmYKGGZdwvBO5
 Kr8A==
X-Gm-Message-State: AOJu0YwqWDLzMBAed4FUHxcTf6kVReqE93KLV4xkOgvCabyLygu5Cbrc
 p5STVMwYSNgf4wF5o6Y4wtBel+HU3DURzNNVlqd4Wwbr6EYIY74seLQ=
X-Google-Smtp-Source: AGHT+IEqguYZBUVGxey9k5ldW5egtG/0bOtplaqDFzHldQSO3xOXb3CMGAi27L9rheqP7FuhLxbwW0TETm5CDjSzsVg=
X-Received: by 2002:a17:906:2245:b0:a1f:a518:9a67 with SMTP id
 5-20020a170906224500b00a1fa5189a67mr6272287ejr.116.1702924502037; Mon, 18 Dec
 2023 10:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-13-hao.xiang@bytedance.com> <87wmtkle2h.fsf@suse.de>
In-Reply-To: <87wmtkle2h.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 18 Dec 2023 10:34:50 -0800
Message-ID: <CAAYibXgQpK_tR-eHGz+BxBA43RyuzTec9Y-rYW8oiN+x23g0XQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 12/20] migration/multifd: Add new
 migration option for multifd DSA offloading.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Dec 11, 2023 at 11:44=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wr=
ote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Intel DSA offloading is an optional feature that turns on if
> > proper hardware and software stack is available. To turn on
> > DSA offloading in multifd live migration:
> >
> > multifd-dsa-accel=3D"[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pat=
hX]"
> >
> > This feature is turned off by default.
>
> This patch breaks make check:
>
>  43/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-hmp               ERR=
OR           0.52s
>  79/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test         ERR=
OR           3.59s
> 167/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-cmd-test ERROR        =
   3.68s
>
> Make sure you run make check before posting. Ideally also run the series
> through the Gitlab CI on your personal fork.

* I think I accidentally deleted some code in meson-buildoptions.sh.
Reverted those now.
* I also found a bug in how I handle the string in migration options. Fixed=
 now.
* make check is passing now. Fix will be in the next patchset.

69/818 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-hmp
                   OK              4.22s   9 subtests passed
37/818 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
                   OK             60.16s   16 subtests passed
607/818 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-cmd-test
                    OK              8.23s   65 subtests passed

Ok:                 747
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            71
Timeout:            0

>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  migration/migration-hmp-cmds.c |  8 ++++++++
> >  migration/options.c            | 28 ++++++++++++++++++++++++++++
> >  migration/options.h            |  1 +
> >  qapi/migration.json            | 17 ++++++++++++++---
> >  scripts/meson-buildoptions.sh  |  6 +++---
> >  5 files changed, 54 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-c=
mds.c
> > index 86ae832176..d9451744dd 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -353,6 +353,9 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
> >          monitor_printf(mon, "%s: '%s'\n",
> >              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> >              params->tls_authz);
> > +        monitor_printf(mon, "%s: %s\n",
>
> Use '%s' here.

Fixed. Will be in the next version.

>
> > +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACC=
EL),
> > +            params->multifd_dsa_accel);
> >
> >          if (params->has_block_bitmap_mapping) {
> >              const BitmapMigrationNodeAliasList *bmnal;
> > @@ -615,6 +618,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
> >          p->has_block_incremental =3D true;
> >          visit_type_bool(v, param, &p->block_incremental, &err);
> >          break;
> > +    case MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL:
> > +        p->multifd_dsa_accel =3D g_new0(StrOrNull, 1);
> > +        p->multifd_dsa_accel->type =3D QTYPE_QSTRING;
> > +        visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
> > +        break;
> >      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
> >          p->has_multifd_channels =3D true;
> >          visit_type_uint8(v, param, &p->multifd_channels, &err);
> > diff --git a/migration/options.c b/migration/options.c
> > index 97d121d4d7..6e424b5d63 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -179,6 +179,8 @@ Property migration_properties[] =3D {
> >      DEFINE_PROP_MIG_MODE("mode", MigrationState,
> >                        parameters.mode,
> >                        MIG_MODE_NORMAL),
> > +    DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
> > +                       parameters.multifd_dsa_accel),
> >
> >      /* Migration capabilities */
> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > @@ -901,6 +903,13 @@ const char *migrate_tls_creds(void)
> >      return s->parameters.tls_creds;
> >  }
> >
> > +const char *migrate_multifd_dsa_accel(void)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    return s->parameters.multifd_dsa_accel;
> > +}
> > +
> >  const char *migrate_tls_hostname(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > @@ -1025,6 +1034,7 @@ MigrationParameters *qmp_query_migrate_parameters=
(Error **errp)
> >      params->vcpu_dirty_limit =3D s->parameters.vcpu_dirty_limit;
> >      params->has_mode =3D true;
> >      params->mode =3D s->parameters.mode;
> > +    params->multifd_dsa_accel =3D s->parameters.multifd_dsa_accel;
> >
> >      return params;
> >  }
> > @@ -1033,6 +1043,7 @@ void migrate_params_init(MigrationParameters *par=
ams)
> >  {
> >      params->tls_hostname =3D g_strdup("");
> >      params->tls_creds =3D g_strdup("");
> > +    params->multifd_dsa_accel =3D g_strdup("");
> >
> >      /* Set has_* up only for parameter checks */
> >      params->has_compress_level =3D true;
> > @@ -1362,6 +1373,11 @@ static void migrate_params_test_apply(MigrateSet=
Parameters *params,
> >      if (params->has_mode) {
> >          dest->mode =3D params->mode;
> >      }
> > +
> > +    if (params->multifd_dsa_accel) {
> > +        assert(params->multifd_dsa_accel->type =3D=3D QTYPE_QSTRING);
> > +        dest->multifd_dsa_accel =3D params->multifd_dsa_accel->u.s;
> > +    }
> >  }
> >
> >  static void migrate_params_apply(MigrateSetParameters *params, Error *=
*errp)
> > @@ -1506,6 +1522,12 @@ static void migrate_params_apply(MigrateSetParam=
eters *params, Error **errp)
> >      if (params->has_mode) {
> >          s->parameters.mode =3D params->mode;
> >      }
> > +
> > +    if (params->multifd_dsa_accel) {
> > +        g_free(s->parameters.multifd_dsa_accel);
> > +        assert(params->multifd_dsa_accel->type =3D=3D QTYPE_QSTRING);
> > +        s->parameters.multifd_dsa_accel =3D g_strdup(params->multifd_d=
sa_accel->u.s);
> > +    }
> >  }
> >
> >  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **=
errp)
> > @@ -1531,6 +1553,12 @@ void qmp_migrate_set_parameters(MigrateSetParame=
ters *params, Error **errp)
> >          params->tls_authz->type =3D QTYPE_QSTRING;
> >          params->tls_authz->u.s =3D strdup("");
> >      }
> > +    if (params->multifd_dsa_accel
> > +        && params->multifd_dsa_accel->type =3D=3D QTYPE_QNULL) {
> > +        qobject_unref(params->multifd_dsa_accel->u.n);
> > +        params->multifd_dsa_accel->type =3D QTYPE_QSTRING;
> > +        params->multifd_dsa_accel->u.s =3D strdup("");
> > +    }
> >
> >      migrate_params_test_apply(params, &tmp);
> >
> > diff --git a/migration/options.h b/migration/options.h
> > index c901eb57c6..56100961a9 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -94,6 +94,7 @@ const char *migrate_tls_authz(void);
> >  const char *migrate_tls_creds(void);
> >  const char *migrate_tls_hostname(void);
> >  uint64_t migrate_xbzrle_cache_size(void);
> > +const char *migrate_multifd_dsa_accel(void);
> >
> >  /* parameters setters */
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 9783289bfc..a8e3b66d6f 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -879,6 +879,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> > +#                     certain memory operations. (since 8.2)
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -902,7 +905,7 @@
> >             'cpu-throttle-initial', 'cpu-throttle-increment',
> >             'cpu-throttle-tailslow',
> >             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> > -           'avail-switchover-bandwidth', 'downtime-limit',
> > +           'avail-switchover-bandwidth', 'downtime-limit', 'multifd-ds=
a-accel',
> >             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] =
},
> >             { 'name': 'block-incremental', 'features': [ 'deprecated' ]=
 },
> >             'multifd-channels',
> > @@ -1067,6 +1070,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> > +#                     certain memory operations. (since 8.2)
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -1120,7 +1126,8 @@
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> >                                              'features': [ 'unstable' ]=
 },
> >              '*vcpu-dirty-limit': 'uint64',
> > -            '*mode': 'MigMode'} }
> > +            '*mode': 'MigMode',
> > +            '*multifd-dsa-accel': 'StrOrNull'} }
> >
> >  ##
> >  # @migrate-set-parameters:
> > @@ -1295,6 +1302,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> > +#                     certain memory operations. (since 8.2)
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -1345,7 +1355,8 @@
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> >                                              'features': [ 'unstable' ]=
 },
> >              '*vcpu-dirty-limit': 'uint64',
> > -            '*mode': 'MigMode'} }
> > +            '*mode': 'MigMode',
> > +            '*multifd-dsa-accel': 'str'} }
> >
> >  ##
> >  # @query-migrate-parameters:
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions=
.sh
> > index bf139e3fb4..35222ab63e 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -32,6 +32,7 @@ meson_options_help() {
> >    printf "%s\n" '  --enable-debug-stack-usage'
> >    printf "%s\n" '                           measure coroutine stack us=
age'
> >    printf "%s\n" '  --enable-debug-tcg       TCG debugging'
> > +  printf "%s\n" '  --enable-enqcmd          MENQCMD optimizations'
> >    printf "%s\n" '  --enable-fdt[=3DCHOICE]    Whether and how to find =
the libfdt library'
> >    printf "%s\n" '                           (choices: auto/disabled/en=
abled/internal/system)'
> >    printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
> > @@ -93,7 +94,6 @@ meson_options_help() {
> >    printf "%s\n" '  avx2            AVX2 optimizations'
> >    printf "%s\n" '  avx512bw        AVX512BW optimizations'
> >    printf "%s\n" '  avx512f         AVX512F optimizations'
> > -  printf "%s\n" '  enqcmd          ENQCMD optimizations'
> >    printf "%s\n" '  blkio           libblkio block device driver'
> >    printf "%s\n" '  bochs           bochs image format support'
> >    printf "%s\n" '  bpf             eBPF support'
> > @@ -241,8 +241,6 @@ _meson_option_parse() {
> >      --disable-avx512bw) printf "%s" -Davx512bw=3Ddisabled ;;
> >      --enable-avx512f) printf "%s" -Davx512f=3Denabled ;;
> >      --disable-avx512f) printf "%s" -Davx512f=3Ddisabled ;;
> > -    --enable-enqcmd) printf "%s" -Denqcmd=3Dtrue ;;
> > -    --disable-enqcmd) printf "%s" -Denqcmd=3Dfalse ;;
> >      --enable-gcov) printf "%s" -Db_coverage=3Dtrue ;;
> >      --disable-gcov) printf "%s" -Db_coverage=3Dfalse ;;
> >      --enable-lto) printf "%s" -Db_lto=3Dtrue ;;
> > @@ -309,6 +307,8 @@ _meson_option_parse() {
> >      --disable-docs) printf "%s" -Ddocs=3Ddisabled ;;
> >      --enable-dsound) printf "%s" -Ddsound=3Denabled ;;
> >      --disable-dsound) printf "%s" -Ddsound=3Ddisabled ;;
> > +    --enable-enqcmd) printf "%s" -Denqcmd=3Dtrue ;;
> > +    --disable-enqcmd) printf "%s" -Denqcmd=3Dfalse ;;
> >      --enable-fdt) printf "%s" -Dfdt=3Denabled ;;
> >      --disable-fdt) printf "%s" -Dfdt=3Ddisabled ;;
> >      --enable-fdt=3D*) quote_sh "-Dfdt=3D$2" ;;

