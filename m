Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317570BA50
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q134b-0000Vz-Rz; Mon, 22 May 2023 06:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q134S-0000Tn-SY
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q134O-0001wQ-N1
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684752432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsAX0PXEa5YFuxA/HXEmI+P52T1W7tVx0SoBsNEQsdw=;
 b=fk5mjDE1E2TBopmeTjZDrcgzEqiWvIwREsvw/FkKXuK2weIcSV0anEcPYOo3Yz2wm1zBdE
 YKOX5xVPgjUP/iI1VAEIjxbhbW0bI4rRg4bp41lFzN07TVRP15k+Khzyn57wB8znvWlVRS
 70mPyRGrrOZ4SQC78hO+Gw/OSd0Azhk=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-a_ErT9TGOp268sfigl5PCA-1; Mon, 22 May 2023 06:47:10 -0400
X-MC-Unique: a_ErT9TGOp268sfigl5PCA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-43934a79432so286090137.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684752430; x=1687344430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsAX0PXEa5YFuxA/HXEmI+P52T1W7tVx0SoBsNEQsdw=;
 b=AMuhOOjWnlFK0HIi00yyTQdxWG7ib7GGoZ0li7vBhMOOYE1Wa7nwes+c5bW1s8dK3A
 X8FyXWO60VDsb8ueAht77UVVEz3X1E38KYgwjBPUcaki+TGDvO/+r4k4VU+NkNDm2NJj
 63N3wynkzUxWxJN4l9Kxvwwrki1z20/t/u1YGq4GyJD5CCBQ6l9WgfrTF6jU0KqjWWHY
 IXGM4X3U6yo0FQidmXR0MfnIp9iVwWLlhPl3Bt4dxdZhVK071SV6n3h+1IfQqP3G6f8V
 dYiP3eygLcd8AcM8YIpMaP0zJL0qRbh9JNMdaJEzuBF2m7owBdiYeGPLEDSJERTBC2FW
 xPhg==
X-Gm-Message-State: AC+VfDxs2UiOfor9pCvbrvAJrn3+Icz/2Al/FPSl5Le1xukuUMKonPwg
 qhLq3i89tYmYR+NKtUVU9Yahb4CG2KtjGQ9Xx9ZK+jL98Sw+jeH5+lP1minWQeIY87jF1AaHqgR
 QC747NAkZQ5O9n5A6vfyZO7GRlS09kS8=
X-Received: by 2002:a05:6102:3562:b0:439:3ceb:8026 with SMTP id
 bh2-20020a056102356200b004393ceb8026mr1746680vsb.14.1684752430287; 
 Mon, 22 May 2023 03:47:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rkNRlGmOsUq8eTleveOjdFBro5FF4Umaq0Cte413TQZ1CvFBuK7DY1mt9sQUbg/fCYmAqTrWgWQEccF5DVEo=
X-Received: by 2002:a05:6102:3562:b0:439:3ceb:8026 with SMTP id
 bh2-20020a056102356200b004393ceb8026mr1746672vsb.14.1684752429899; Mon, 22
 May 2023 03:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230522103039.19111-1-anisinha@redhat.com>
In-Reply-To: <20230522103039.19111-1-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 May 2023 12:46:58 +0200
Message-ID: <CABgObfZ25gEE5Z+u7ky6TPoogU7nb1M66Mp=Sp_UfohyGxmt2A@mail.gmail.com>
Subject: Re: [PATCH v3] acpi/tests/bios-tables-test: make iasl tool handling
 simpler
To: Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001e735605fc45fe8d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--0000000000001e735605fc45fe8d
Content-Type: text/plain; charset="UTF-8"

Il lun 22 mag 2023, 12:30 Ani Sinha <anisinha@redhat.com> ha scritto:

> Currently the meson based QEMU build process locates the iasl binary from
> the
> current PATH and other locations [1] and uses that to set CONFIG_IASL in
> config-host.h header.This is then used at compile time by bios-tables-test
> to
> set iasl path.
>
> This has two disadvantages:
>  - If iasl was not previously installed in the PATH, one has to install
> iasl
>    and rebuild QEMU in order to regenerate the header and pick up the found
>    iasl location. One cannot simply use the existing bios-tables-test
> binary
>    because CONFIG_IASL is only set during the QEMU build time by meson and
>    then bios-tables-test has to be rebuilt with CONFIG_IASL set in order to
>    use iasl.
>  - Sometimes, the stock iasl that comes with distributions is simply not
> good
>    enough because it does not support the latest ACPI changes - newly
>    introduced tables or new table attributes etc. In order to test ACPI
> code
>    in QEMU, one has to clone the latest acpica upstream repository and
>    rebuild iasl in order to get support for it. In those cases, one may
> want
>    the test to use the iasl binary from a non-standard location.
>
> In order to overcome the above two disadvantages, we set a default iasl
> path
> as "/usr/bin/iasl". bios-tables-test also checks for the environment
> variable
> IASL_PATH that can be set by the developer. IASL_PATH passed from the
> environment overrides the default path. This way developers can point
> IASL_PATH environment variable to a possibly a non-standard custom build
> binary and quickly run bios-tables-test without rebuilding. If the default
> path of iasl changes, one simply needs to update the default path and
> rebuild
> just the test, not whole QEMU.
>

Since this is only for build time and our only supported Windows
environment is msys, I guess this is good enough.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


> [1] https://mesonbuild.com/Reference-manual_functions.html#find_program
>
> CC: alex.bennee@linaro.org
> CC: pbonzini@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  meson.build                    | 10 ----------
>  meson_options.txt              |  2 --
>  scripts/meson-buildoptions.sh  |  2 --
>  tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++--------
>  4 files changed, 20 insertions(+), 22 deletions(-)
>
> changelog:
> v3: incorporated suggestion from MST. Simplify it even more and
> remove all dependency with meson build system. Set a default iasl
> path which can be overridden by an environment variable.
>
> v2:
> addressed comments from v1. CONFIG_IASL is now an environment
> variable and no new environment variable is introduced.
> Top level meson.build now does not set CONFIG_IASL in the
> platform header. References to iasl has been removed from other
> files. Test doc is updated. For example:
>
> "to see ASL diff between mismatched files install IASL, set CONFIG_IASL
> environment variable to the path of iasl binary,
>  and run 'QTEST_QEMU_BINARY=<path to QEMU binary to test> V=1
> ./tests/qtest/bios-tables-test' from build directory.
>  Alternatively run 'V=1 make check-qtest -B' from build dir."
>
>
> One drawback of this approach is that meson overrides the values
> of environment variables that are passed from the OS command line
> with the values it sets. So if CONFIG_IASL is passed as an
> env variable by the developer while running "make check-qtest" and
> meson finds iasl in the path, meson will override the value the
> developer provided with the one that it found. I have not seen a
> way to check for OS env from meson.build like we do os.environ.get()
> in python.
> Other than the above, other cases are tested. In absence of iasl,
> the developer can provide their own CONFIG_IASL and path to a custom
> binary and the test picks it up when run from make check-qtest.
> Once iasl is installed, make check-qtest -B will force meson to
> retest iasl path and pass it to the test as an enviroinment.
> When running the test directly, one has to explicitly pass the path
> of iasl in the commnand line as no meson is involved there. There is
> no automatic PATH discovery in the test.
>
> diff --git a/meson.build b/meson.build
> index 25a4b9f2c1..18c7b669d9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -179,12 +179,6 @@ if 'dtrace' in get_option('trace_backends')
>    endif
>  endif
>
> -if get_option('iasl') == ''
> -  iasl = find_program('iasl', required: false)
> -else
> -  iasl = find_program(get_option('iasl'), required: true)
> -endif
> -
>  ##################
>  # Compiler flags #
>  ##################
> @@ -1791,9 +1785,6 @@ foreach k : get_option('trace_backends')
>  endforeach
>  config_host_data.set_quoted('CONFIG_TRACE_FILE', get_option('trace_file'))
>  config_host_data.set_quoted('CONFIG_TLS_PRIORITY',
> get_option('tls_priority'))
> -if iasl.found()
> -  config_host_data.set_quoted('CONFIG_IASL', iasl.full_path())
> -endif
>  config_host_data.set_quoted('CONFIG_BINDIR', get_option('prefix') /
> get_option('bindir'))
>  config_host_data.set_quoted('CONFIG_PREFIX', get_option('prefix'))
>  config_host_data.set_quoted('CONFIG_QEMU_CONFDIR', get_option('prefix') /
> qemu_confdir)
> @@ -3761,7 +3752,6 @@ summary_info += {'sphinx-build':      sphinx_build}
>  if config_host.has_key('HAVE_GDB_BIN')
>    summary_info += {'gdb':             config_host['HAVE_GDB_BIN']}
>  endif
> -summary_info += {'iasl':              iasl}
>  summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
>  if targetos == 'windows' and have_ga
>    summary_info += {'wixl':            wixl}
> diff --git a/meson_options.txt b/meson_options.txt
> index d8330a1f71..9149df8004 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -14,8 +14,6 @@ option('smbd', type : 'string', value : '',
>         description: 'Path to smbd for slirp networking')
>  option('sphinx_build', type : 'string', value : 'sphinx-build',
>         description: 'Use specified sphinx-build for building document')
> -option('iasl', type : 'string', value : '',
> -       description: 'Path to ACPI disassembler')
>  option('tls_priority', type : 'string', value : 'NORMAL',
>         description: 'Default TLS protocol/cipher priority string')
>  option('default_devices', type : 'boolean', value : true,
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 2805d1c145..98ca2e53af 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -48,7 +48,6 @@ meson_options_help() {
>    printf "%s\n" '
>  dtrace/ftrace/log/nop/simple/syslog/ust)'
>    printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware
> files [share/qemu-'
>    printf "%s\n" '                           firmware]'
> -  printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>    printf "%s\n" '  --includedir=VALUE       Header file directory
> [include]'
>    printf "%s\n" '  --interp-prefix=VALUE    where to find shared
> libraries etc., use %M for'
>    printf "%s\n" '                           cpu name
> [/usr/gnemul/qemu-%M]'
> @@ -304,7 +303,6 @@ _meson_option_parse() {
>      --disable-hexagon-idef-parser) printf "%s"
> -Dhexagon_idef_parser=false ;;
>      --enable-hvf) printf "%s" -Dhvf=enabled ;;
>      --disable-hvf) printf "%s" -Dhvf=disabled ;;
> -    --iasl=*) quote_sh "-Diasl=$2" ;;
>      --enable-iconv) printf "%s" -Diconv=enabled ;;
>      --disable-iconv) printf "%s" -Diconv=disabled ;;
>      --includedir=*) quote_sh "-Dincludedir=$2" ;;
> diff --git a/tests/qtest/bios-tables-test.c
> b/tests/qtest/bios-tables-test.c
> index 7fd88b0e9c..570f2d714d 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -69,6 +69,7 @@
>  #define MACHINE_Q35 "q35"
>
>  #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
> +#define DEFAULT_IASL_PATH "/usr/bin/iasl"
>
>  #define OEM_ID             "TEST"
>  #define OEM_TABLE_ID       "OEM"
> @@ -102,11 +103,7 @@ typedef struct {
>
>  static char disk[] = "tests/acpi-test-disk-XXXXXX";
>  static const char *data_dir = "tests/data/acpi";
> -#ifdef CONFIG_IASL
> -static const char *iasl = CONFIG_IASL;
> -#else
> -static const char *iasl;
> -#endif
> +static const char *iasl = DEFAULT_IASL_PATH;
>
>  static int verbosity_level;
>
> @@ -441,6 +438,14 @@ static void test_acpi_asl(test_data *data)
>      test_data exp_data = {};
>      gboolean exp_err, err, all_tables_match = true;
>
> +    if (getenv("IASL_PATH")) {
> +        iasl = getenv("IASL_PATH");
> +    }
> +
> +    if (access(iasl, F_OK | X_OK) < 0) {
> +        iasl = NULL;
> +    }
> +
>      exp_data.tables = load_expected_aml(data);
>      dump_aml_files(data, false);
>      for (i = 0; i < data->tables->len; ++i) {
> @@ -473,6 +478,10 @@ static void test_acpi_asl(test_data *data)
>              continue;
>          }
>
> +        if (iasl && verbosity_level >= 2) {
> +            fprintf(stderr, "Using iasl: %s\n", iasl);
> +        }
> +
>          err = load_asl(data->tables, sdt);
>          asl = normalize_asl(sdt->asl);
>
> @@ -528,9 +537,12 @@ static void test_acpi_asl(test_data *data)
>          g_string_free(exp_asl, true);
>      }
>      if (!iasl && !all_tables_match) {
> -        fprintf(stderr, "to see ASL diff between mismatched files install
> IASL,"
> -                " rebuild QEMU from scratch and re-run tests with V=1"
> -                " environment variable set");
> +        fprintf(stderr, "to see ASL diff between mismatched files
> install\n"
> +                " IASL & re-run the test with V=1 environment variable
> set.\n"
> +                " Set IASL_PATH environment variable to the path of iasl
> binary\n"
> +                " if iasl is installed somewhere other than %s.\n",
> +                DEFAULT_IASL_PATH
> +                );
>      }
>      g_assert(all_tables_match);
>
> --
> 2.39.1
>
>

--0000000000001e735605fc45fe8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 22 mag 2023, 12:30 Ani Sinha &lt;<a href=3D"mai=
lto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; ha scritto:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Currently the meson based QEMU build process =
locates the iasl binary from the<br>
current PATH and other locations [1] and uses that to set CONFIG_IASL in<br=
>
config-host.h header.This is then used at compile time by bios-tables-test =
to<br>
set iasl path.<br>
<br>
This has two disadvantages:<br>
=C2=A0- If iasl was not previously installed in the PATH, one has to instal=
l iasl<br>
=C2=A0 =C2=A0and rebuild QEMU in order to regenerate the header and pick up=
 the found<br>
=C2=A0 =C2=A0iasl location. One cannot simply use the existing bios-tables-=
test binary<br>
=C2=A0 =C2=A0because CONFIG_IASL is only set during the QEMU build time by =
meson and<br>
=C2=A0 =C2=A0then bios-tables-test has to be rebuilt with CONFIG_IASL set i=
n order to<br>
=C2=A0 =C2=A0use iasl.<br>
=C2=A0- Sometimes, the stock iasl that comes with distributions is simply n=
ot good<br>
=C2=A0 =C2=A0enough because it does not support the latest ACPI changes - n=
ewly<br>
=C2=A0 =C2=A0introduced tables or new table attributes etc. In order to tes=
t ACPI code<br>
=C2=A0 =C2=A0in QEMU, one has to clone the latest acpica upstream repositor=
y and<br>
=C2=A0 =C2=A0rebuild iasl in order to get support for it. In those cases, o=
ne may want<br>
=C2=A0 =C2=A0the test to use the iasl binary from a non-standard location.<=
br>
<br>
In order to overcome the above two disadvantages, we set a default iasl pat=
h<br>
as &quot;/usr/bin/iasl&quot;. bios-tables-test also checks for the environm=
ent variable<br>
IASL_PATH that can be set by the developer. IASL_PATH passed from the<br>
environment overrides the default path. This way developers can point<br>
IASL_PATH environment variable to a possibly a non-standard custom build<br=
>
binary and quickly run bios-tables-test without rebuilding. If the default<=
br>
path of iasl changes, one simply needs to update the default path and rebui=
ld<br>
just the test, not whole QEMU.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Since this is only for build time and our onl=
y supported Windows environment is msys, I guess this is good enough.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Acked-by: Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
[1] <a href=3D"https://mesonbuild.com/Reference-manual_functions.html#find_=
program" rel=3D"noreferrer noreferrer" target=3D"_blank">https://mesonbuild=
.com/Reference-manual_functions.html#find_program</a><br>
<br>
CC: <a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank" rel=3D"nore=
ferrer">alex.bennee@linaro.org</a><br>
CC: <a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">pbonzini@redhat.com</a><br>
Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 10 ----------<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 --<br>
=C2=A0scripts/meson-buildoptions.sh=C2=A0 |=C2=A0 2 --<br>
=C2=A0tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++--------<br>
=C2=A04 files changed, 20 insertions(+), 22 deletions(-)<br>
<br>
changelog:<br>
v3: incorporated suggestion from MST. Simplify it even more and<br>
remove all dependency with meson build system. Set a default iasl<br>
path which can be overridden by an environment variable.<br>
<br>
v2:<br>
addressed comments from v1. CONFIG_IASL is now an environment<br>
variable and no new environment variable is introduced.<br>
Top level meson.build now does not set CONFIG_IASL in the<br>
platform header. References to iasl has been removed from other<br>
files. Test doc is updated. For example:<br>
<br>
&quot;to see ASL diff between mismatched files install IASL, set CONFIG_IAS=
L environment variable to the path of iasl binary,<br>
=C2=A0and run &#39;QTEST_QEMU_BINARY=3D&lt;path to QEMU binary to test&gt; =
V=3D1 ./tests/qtest/bios-tables-test&#39; from build directory.<br>
=C2=A0Alternatively run &#39;V=3D1 make check-qtest -B&#39; from build dir.=
&quot;<br>
<br>
<br>
One drawback of this approach is that meson overrides the values<br>
of environment variables that are passed from the OS command line<br>
with the values it sets. So if CONFIG_IASL is passed as an<br>
env variable by the developer while running &quot;make check-qtest&quot; an=
d<br>
meson finds iasl in the path, meson will override the value the<br>
developer provided with the one that it found. I have not seen a<br>
way to check for OS env from meson.build like we do os.environ.get()<br>
in python.<br>
Other than the above, other cases are tested. In absence of iasl,<br>
the developer can provide their own CONFIG_IASL and path to a custom<br>
binary and the test picks it up when run from make check-qtest.<br>
Once iasl is installed, make check-qtest -B will force meson to<br>
retest iasl path and pass it to the test as an enviroinment.<br>
When running the test directly, one has to explicitly pass the path<br>
of iasl in the commnand line as no meson is involved there. There is<br>
no automatic PATH discovery in the test.<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 25a4b9f2c1..18c7b669d9 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -179,12 +179,6 @@ if &#39;dtrace&#39; in get_option(&#39;trace_backends&=
#39;)<br>
=C2=A0 =C2=A0endif<br>
=C2=A0endif<br>
<br>
-if get_option(&#39;iasl&#39;) =3D=3D &#39;&#39;<br>
-=C2=A0 iasl =3D find_program(&#39;iasl&#39;, required: false)<br>
-else<br>
-=C2=A0 iasl =3D find_program(get_option(&#39;iasl&#39;), required: true)<b=
r>
-endif<br>
-<br>
=C2=A0##################<br>
=C2=A0# Compiler flags #<br>
=C2=A0##################<br>
@@ -1791,9 +1785,6 @@ foreach k : get_option(&#39;trace_backends&#39;)<br>
=C2=A0endforeach<br>
=C2=A0config_host_data.set_quoted(&#39;CONFIG_TRACE_FILE&#39;, get_option(&=
#39;trace_file&#39;))<br>
=C2=A0config_host_data.set_quoted(&#39;CONFIG_TLS_PRIORITY&#39;, get_option=
(&#39;tls_priority&#39;))<br>
-if iasl.found()<br>
-=C2=A0 config_host_data.set_quoted(&#39;CONFIG_IASL&#39;, iasl.full_path()=
)<br>
-endif<br>
=C2=A0config_host_data.set_quoted(&#39;CONFIG_BINDIR&#39;, get_option(&#39;=
prefix&#39;) / get_option(&#39;bindir&#39;))<br>
=C2=A0config_host_data.set_quoted(&#39;CONFIG_PREFIX&#39;, get_option(&#39;=
prefix&#39;))<br>
=C2=A0config_host_data.set_quoted(&#39;CONFIG_QEMU_CONFDIR&#39;, get_option=
(&#39;prefix&#39;) / qemu_confdir)<br>
@@ -3761,7 +3752,6 @@ summary_info +=3D {&#39;sphinx-build&#39;:=C2=A0 =C2=
=A0 =C2=A0 sphinx_build}<br>
=C2=A0if config_host.has_key(&#39;HAVE_GDB_BIN&#39;)<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;gdb&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0config_host[&#39;HAVE_GDB_BIN&#39;]}<br>
=C2=A0endif<br>
-summary_info +=3D {&#39;iasl&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 iasl}<br>
=C2=A0summary_info +=3D {&#39;genisoimage&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onfig_host[&#39;GENISOIMAGE&#39;]}<br>
=C2=A0if targetos =3D=3D &#39;windows&#39; and have_ga<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;wixl&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 wixl}<br>
diff --git a/meson_options.txt b/meson_options.txt<br>
index d8330a1f71..9149df8004 100644<br>
--- a/meson_options.txt<br>
+++ b/meson_options.txt<br>
@@ -14,8 +14,6 @@ option(&#39;smbd&#39;, type : &#39;string&#39;, value : &=
#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Path to smbd for slirp networ=
king&#39;)<br>
=C2=A0option(&#39;sphinx_build&#39;, type : &#39;string&#39;, value : &#39;=
sphinx-build&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Use specified sphinx-build fo=
r building document&#39;)<br>
-option(&#39;iasl&#39;, type : &#39;string&#39;, value : &#39;&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;Path to ACPI disassembler&#39=
;)<br>
=C2=A0option(&#39;tls_priority&#39;, type : &#39;string&#39;, value : &#39;=
NORMAL&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Default TLS protocol/cipher p=
riority string&#39;)<br>
=C2=A0option(&#39;default_devices&#39;, type : &#39;boolean&#39;, value : t=
rue,<br>
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh<=
br>
index 2805d1c145..98ca2e53af 100644<br>
--- a/scripts/meson-buildoptions.sh<br>
+++ b/scripts/meson-buildoptions.sh<br>
@@ -48,7 +48,6 @@ meson_options_help() {<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dtrace/ft=
race/log/nop/simple/syslog/ust)&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --firmwarepath=3DVALUES=C2=
=A0 =C2=A0 search PATH for firmware files [share/qemu-&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0firmware]=
&#39;<br>
-=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --iasl=3DVALUE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Path to ACPI disassembler&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --includedir=3DVALUE=C2=A0=
 =C2=A0 =C2=A0 =C2=A0Header file directory [include]&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --interp-prefix=3DVALUE=C2=
=A0 =C2=A0 where to find shared libraries etc., use %M for&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu name =
[/usr/gnemul/qemu-%M]&#39;<br>
@@ -304,7 +303,6 @@ _meson_option_parse() {<br>
=C2=A0 =C2=A0 =C2=A0--disable-hexagon-idef-parser) printf &quot;%s&quot; -D=
hexagon_idef_parser=3Dfalse ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-hvf) printf &quot;%s&quot; -Dhvf=3Denabled ;;<=
br>
=C2=A0 =C2=A0 =C2=A0--disable-hvf) printf &quot;%s&quot; -Dhvf=3Ddisabled ;=
;<br>
-=C2=A0 =C2=A0 --iasl=3D*) quote_sh &quot;-Diasl=3D$2&quot; ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-iconv) printf &quot;%s&quot; -Diconv=3Denabled=
 ;;<br>
=C2=A0 =C2=A0 =C2=A0--disable-iconv) printf &quot;%s&quot; -Diconv=3Ddisabl=
ed ;;<br>
=C2=A0 =C2=A0 =C2=A0--includedir=3D*) quote_sh &quot;-Dincludedir=3D$2&quot=
; ;;<br>
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c<br>
index 7fd88b0e9c..570f2d714d 100644<br>
--- a/tests/qtest/bios-tables-test.c<br>
+++ b/tests/qtest/bios-tables-test.c<br>
@@ -69,6 +69,7 @@<br>
=C2=A0#define MACHINE_Q35 &quot;q35&quot;<br>
<br>
=C2=A0#define ACPI_REBUILD_EXPECTED_AML &quot;TEST_ACPI_REBUILD_AML&quot;<b=
r>
+#define DEFAULT_IASL_PATH &quot;/usr/bin/iasl&quot;<br>
<br>
=C2=A0#define OEM_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;T=
EST&quot;<br>
=C2=A0#define OEM_TABLE_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;OEM&quot;<br>
@@ -102,11 +103,7 @@ typedef struct {<br>
<br>
=C2=A0static char disk[] =3D &quot;tests/acpi-test-disk-XXXXXX&quot;;<br>
=C2=A0static const char *data_dir =3D &quot;tests/data/acpi&quot;;<br>
-#ifdef CONFIG_IASL<br>
-static const char *iasl =3D CONFIG_IASL;<br>
-#else<br>
-static const char *iasl;<br>
-#endif<br>
+static const char *iasl =3D DEFAULT_IASL_PATH;<br>
<br>
=C2=A0static int verbosity_level;<br>
<br>
@@ -441,6 +438,14 @@ static void test_acpi_asl(test_data *data)<br>
=C2=A0 =C2=A0 =C2=A0test_data exp_data =3D {};<br>
=C2=A0 =C2=A0 =C2=A0gboolean exp_err, err, all_tables_match =3D true;<br>
<br>
+=C2=A0 =C2=A0 if (getenv(&quot;IASL_PATH&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iasl =3D getenv(&quot;IASL_PATH&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (access(iasl, F_OK | X_OK) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iasl =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0exp_data.tables =3D load_expected_aml(data);<br>
=C2=A0 =C2=A0 =C2=A0dump_aml_files(data, false);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; data-&gt;tables-&gt;len; ++i) {<br=
>
@@ -473,6 +478,10 @@ static void test_acpi_asl(test_data *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iasl &amp;&amp; verbosity_level &gt;=3D 2)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Using iasl=
: %s\n&quot;, iasl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D load_asl(data-&gt;tables, sdt);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asl =3D normalize_asl(sdt-&gt;asl);<br>
<br>
@@ -528,9 +537,12 @@ static void test_acpi_asl(test_data *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_string_free(exp_asl, true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (!iasl &amp;&amp; !all_tables_match) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;to see ASL diff between =
mismatched files install IASL,&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; rebuild QEM=
U from scratch and re-run tests with V=3D1&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; environment=
 variable set&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;to see ASL diff between =
mismatched files install\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; IASL &amp; =
re-run the test with V=3D1 environment variable set.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; Set IASL_PA=
TH environment variable to the path of iasl binary\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; if iasl is =
installed somewhere other than %s.\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFAULT_IASL_PATH<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_assert(all_tables_match);<br>
<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div></div></div>

--0000000000001e735605fc45fe8d--


