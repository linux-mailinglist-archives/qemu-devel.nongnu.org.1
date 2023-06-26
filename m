Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC1373DFE9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlnX-0002QQ-Eu; Mon, 26 Jun 2023 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlnV-0002Pt-3L
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlnS-0002DX-SO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687784302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1CrqlVyHqoxfQogYbSh4QT/MBCETXvngk5+xBEWQWNc=;
 b=gkISaAeFvKYSePyCAHA1S4slWBDm1YxZ8pCHEO6e8sTe9foJOJQiN0GZkiaUIo5utRqLIn
 L5LbFShBWmcugRUAHbYtKYQLNVxGoEvE2JQQAbxPsAnXg/vij2lyt7gYwZEptMyHwwqyUD
 DgnRsZ4xxk8CjpaLINqKS8zdLbKDQU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-ZFgkhrrGNFatF_S_Xea6RA-1; Mon, 26 Jun 2023 08:58:20 -0400
X-MC-Unique: ZFgkhrrGNFatF_S_Xea6RA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so19229755e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687784299; x=1690376299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CrqlVyHqoxfQogYbSh4QT/MBCETXvngk5+xBEWQWNc=;
 b=RIoTe/fsNe6aNMvvVCYs8TylAYIFyp/VPU2rGKN1CnlLJrPJz9Jl2JSi4498YdT7Y9
 YJBQCQip92bi2QrTf5pdnigS0DxyjYsgrKXTJCIeYmVDGcLGW09EljLpjX6uCYScsBe2
 zSMJddUIT/f145sDY8461Vt3NwZdqJYdbmpv/KSKkNo74/RMd9pNUH/q8/9QtY31APvw
 3Gtk1PFspIVzg4k8QO4JMWTeV5L4/CPxRQ6PULjK8HttIn9hF26vTt8Gd9Lpti+KnLs4
 ZzaqZ8xcsku2DblBr4hJVBlEPnkX13Vv1pjOJCXmUfeLabNRJQwzyM7ur+2yVMiAcNXq
 00/w==
X-Gm-Message-State: AC+VfDx02fnXBuxMJfvZ91mtCAfyIu84v49BD56Eu1yEu5qaHUApyYl9
 dFpIjJnd/Q9wfUhNC8ABPOYiVCY7JwAJornWkkChDNoJnUhR2/tyycf5KzKGsexTXPzuj6MkZEe
 eajIXDYgPGqEbLFY=
X-Received: by 2002:a1c:f70f:0:b0:3f7:2a1d:1b05 with SMTP id
 v15-20020a1cf70f000000b003f72a1d1b05mr25591153wmh.14.1687784299541; 
 Mon, 26 Jun 2023 05:58:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uQqMTpbrz+7bMqJ51WtFnsBni5VYETuBk9xng3BsU8DLm3TMtxeuY5gVMp7TBSFEdYDYKhA==
X-Received: by 2002:a1c:f70f:0:b0:3f7:2a1d:1b05 with SMTP id
 v15-20020a1cf70f000000b003f72a1d1b05mr25591137wmh.14.1687784299117; 
 Mon, 26 Jun 2023 05:58:19 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 l25-20020a1c7919000000b003f9b29ba838sm7628671wme.35.2023.06.26.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:58:18 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:58:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] acpi/tests/bios-tables-test: make iasl tool handling
 simpler
Message-ID: <20230626084401-mutt-send-email-mst@kernel.org>
References: <20230522103039.19111-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522103039.19111-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, May 22, 2023 at 04:00:39PM +0530, Ani Sinha wrote:
> Currently the meson based QEMU build process locates the iasl binary from the
> current PATH and other locations [1] and uses that to set CONFIG_IASL in
> config-host.h header.This is then used at compile time by bios-tables-test to
> set iasl path.
> 
> This has two disadvantages:
>  - If iasl was not previously installed in the PATH, one has to install iasl
>    and rebuild QEMU in order to regenerate the header and pick up the found
>    iasl location. One cannot simply use the existing bios-tables-test binary
>    because CONFIG_IASL is only set during the QEMU build time by meson and
>    then bios-tables-test has to be rebuilt with CONFIG_IASL set in order to
>    use iasl.
>  - Sometimes, the stock iasl that comes with distributions is simply not good
>    enough because it does not support the latest ACPI changes - newly
>    introduced tables or new table attributes etc. In order to test ACPI code
>    in QEMU, one has to clone the latest acpica upstream repository and
>    rebuild iasl in order to get support for it. In those cases, one may want
>    the test to use the iasl binary from a non-standard location.
> 
> In order to overcome the above two disadvantages, we set a default iasl path
> as "/usr/bin/iasl". bios-tables-test also checks for the environment variable
> IASL_PATH that can be set by the developer. IASL_PATH passed from the
> environment overrides the default path. This way developers can point
> IASL_PATH environment variable to a possibly a non-standard custom build
> binary and quickly run bios-tables-test without rebuilding. If the default
> path of iasl changes, one simply needs to update the default path and rebuild
> just the test, not whole QEMU.
> 
> [1] https://mesonbuild.com/Reference-manual_functions.html#find_program
> 
> CC: alex.bennee@linaro.org
> CC: pbonzini@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

I don't much like environment variables since they are
not discoverable. My preference would be to have
configure output CONFIG_IASL to a new header
(e.g. config-bios-tables-test.h ?)

meson then will be smart enough not to rebuild everything
if you just change this singe flag.


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
> "to see ASL diff between mismatched files install IASL, set CONFIG_IASL environment variable to the path of iasl binary,
>  and run 'QTEST_QEMU_BINARY=<path to QEMU binary to test> V=1 ./tests/qtest/bios-tables-test' from build directory.
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
>  config_host_data.set_quoted('CONFIG_TLS_PRIORITY', get_option('tls_priority'))
> -if iasl.found()
> -  config_host_data.set_quoted('CONFIG_IASL', iasl.full_path())
> -endif
>  config_host_data.set_quoted('CONFIG_BINDIR', get_option('prefix') / get_option('bindir'))
>  config_host_data.set_quoted('CONFIG_PREFIX', get_option('prefix'))
>  config_host_data.set_quoted('CONFIG_QEMU_CONFDIR', get_option('prefix') / qemu_confdir)
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
>    printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
>    printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
>    printf "%s\n" '                           firmware]'
> -  printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>    printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
>    printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
>    printf "%s\n" '                           cpu name [/usr/gnemul/qemu-%M]'
> @@ -304,7 +303,6 @@ _meson_option_parse() {
>      --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
>      --enable-hvf) printf "%s" -Dhvf=enabled ;;
>      --disable-hvf) printf "%s" -Dhvf=disabled ;;
> -    --iasl=*) quote_sh "-Diasl=$2" ;;
>      --enable-iconv) printf "%s" -Diconv=enabled ;;
>      --disable-iconv) printf "%s" -Diconv=disabled ;;
>      --includedir=*) quote_sh "-Dincludedir=$2" ;;
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
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
> -        fprintf(stderr, "to see ASL diff between mismatched files install IASL,"
> -                " rebuild QEMU from scratch and re-run tests with V=1"
> -                " environment variable set");
> +        fprintf(stderr, "to see ASL diff between mismatched files install\n"
> +                " IASL & re-run the test with V=1 environment variable set.\n"
> +                " Set IASL_PATH environment variable to the path of iasl binary\n"
> +                " if iasl is installed somewhere other than %s.\n",
> +                DEFAULT_IASL_PATH
> +                );
>      }
>      g_assert(all_tables_match);
>  
> -- 
> 2.39.1


