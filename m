Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B7740979
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOmn-0006ac-Ld; Wed, 28 Jun 2023 02:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEOmX-0006Yo-T5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEOmV-0003ok-8j
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687934158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApLbAPeLFMfPIpJHv06IrgzzRorF5Ay4H0NYBoNyh48=;
 b=P5WXX8weZuD7IFK67gBrTjOZMIBJtFRvpwqwfYE8bgJ9yeedd9FemXdlNEmD3X9IpcjwvN
 grDO+v726MdgeJBEmq6JbNJV/GT7V7ZPc2UASWwRh21yvkKV5Sxt9cJTSZo9uHVtv7RsTV
 d81jDGYVaezoWQQMm21/wqR02ElIARo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Pj-wmywZNiWun2jBKf5F8g-1; Wed, 28 Jun 2023 02:35:56 -0400
X-MC-Unique: Pj-wmywZNiWun2jBKf5F8g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-262f872fdcdso1528450a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687934155; x=1690526155;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApLbAPeLFMfPIpJHv06IrgzzRorF5Ay4H0NYBoNyh48=;
 b=bS1ofze6kYdjkp8cO6YgpkRZyi2TolSfvrHhp25KXCu86qax1NslBVVDQa4O12qpKn
 7UqoY+YkikGfoT3wG77uzML0Ibt39D2FEz3h0PLIfL7C+OwLCmLsA9cSTA45hZo7KNaE
 sgk2M1xfDebZj+7E+LYkXb5DEu0deDBfc9xqEFBd3xp5rqSLktWWEKTtMDbdWQmF9xXW
 DCdtWOP8A/wHt+enTN1FTL0znFdHgI3rDae0yeHcCScmuuPCMuaj7smUKP8OwAkzEqLw
 dmz9HVxfGydenWtP7A2DIC0pAiSSiWXnmwcpS675TiDbqD1SgD7FAkMzPXZRlpfOHvAr
 Ascg==
X-Gm-Message-State: AC+VfDxQVgVzQ70fM1DPic49yAgHf4j7Dyh7IYWVTlmCZGr52SgX/xkl
 7yRmQpPx+hjxjo+Cl1YZyUqUjyVnxE2z1b7mOSMLyCNxI8ZJ7vomOavD5iV1HeSnEdiPy9qOAvv
 DHW1BOGha02zm7UQ=
X-Received: by 2002:a17:90b:196:b0:262:e439:5013 with SMTP id
 t22-20020a17090b019600b00262e4395013mr6493662pjs.9.1687934155517; 
 Tue, 27 Jun 2023 23:35:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57lCI9w8L75Fsi+cLQRuAOsNLMFp8TbdHdhHEZlaYLahxYVS30iVBYMJQ84TE/A31js/w6lA==
X-Received: by 2002:a17:90b:196:b0:262:e439:5013 with SMTP id
 t22-20020a17090b019600b00262e4395013mr6493646pjs.9.1687934155058; 
 Tue, 27 Jun 2023 23:35:55 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090a2e0900b00261139fd67asm8814179pjd.36.2023.06.27.23.35.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:35:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] acpi/tests/bios-tables-test: make iasl tool handling
 simpler
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230626091206-mutt-send-email-mst@kernel.org>
Date: Wed, 28 Jun 2023 12:05:46 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <585996FE-8415-4ECC-BBB2-1BDA0C3D8E25@redhat.com>
References: <20230522103039.19111-1-anisinha@redhat.com>
 <20230626084401-mutt-send-email-mst@kernel.org>
 <9B31F63A-164A-42EF-9387-1F6A56BC9BEA@redhat.com>
 <20230626091206-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 26-Jun-2023, at 6:49 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Mon, Jun 26, 2023 at 06:33:14PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 26-Jun-2023, at 6:28 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Mon, May 22, 2023 at 04:00:39PM +0530, Ani Sinha wrote:
>>>> Currently the meson based QEMU build process locates the iasl =
binary from the
>>>> current PATH and other locations [1] and uses that to set =
CONFIG_IASL in
>>>> config-host.h header.This is then used at compile time by =
bios-tables-test to
>>>> set iasl path.
>>>>=20
>>>> This has two disadvantages:
>>>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>>>  and rebuild QEMU in order to regenerate the header and pick up the =
found
>>>>  iasl location. One cannot simply use the existing bios-tables-test =
binary
>>>>  because CONFIG_IASL is only set during the QEMU build time by =
meson and
>>>>  then bios-tables-test has to be rebuilt with CONFIG_IASL set in =
order to
>>>>  use iasl.
>>>> - Sometimes, the stock iasl that comes with distributions is simply =
not good
>>>>  enough because it does not support the latest ACPI changes - newly
>>>>  introduced tables or new table attributes etc. In order to test =
ACPI code
>>>>  in QEMU, one has to clone the latest acpica upstream repository =
and
>>>>  rebuild iasl in order to get support for it. In those cases, one =
may want
>>>>  the test to use the iasl binary from a non-standard location.
>>>>=20
>>>> In order to overcome the above two disadvantages, we set a default =
iasl path
>>>> as "/usr/bin/iasl". bios-tables-test also checks for the =
environment variable
>>>> IASL_PATH that can be set by the developer. IASL_PATH passed from =
the
>>>> environment overrides the default path. This way developers can =
point
>>>> IASL_PATH environment variable to a possibly a non-standard custom =
build
>>>> binary and quickly run bios-tables-test without rebuilding. If the =
default
>>>> path of iasl changes, one simply needs to update the default path =
and rebuild
>>>> just the test, not whole QEMU.
>>>>=20
>>>> [1] =
https://mesonbuild.com/Reference-manual_functions.html#find_program
>>>>=20
>>>> CC: alex.bennee@linaro.org
>>>> CC: pbonzini@redhat.com
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>=20
>>> I don't much like environment variables since they are
>>> not discoverable.
>>=20
>> I do have this:
>>=20
>> +                " Set IASL_PATH environment variable to the path of =
iasl binary\n"
>> +                " if iasl is installed somewhere other than %s.\n",
>=20
> You only see this if there's a diff.
>=20
> And then people stick this in their scripts and are scratching their
> heads trying to figure out why is a wrong iasl running.  Or someone
> comes up with a different use for IASL_PATH and they conflict.

OK in that case I think its ok to simply remove the environment variable =
part. If people are going to be changing a header file, they might as =
well change the DEFAULT_IASL_PATH in the test itself where its easier to =
find. What additional complication meson provides is that it uses =
find_program() to find the IASL binary in a list of predefined =
locations. I do not think this additional tie up with meson is worth it =
for the niche iasl use case.
Simple is beautiful.

>=20
>>=20
>>> My preference would be to have
>>> configure output CONFIG_IASL to a new header
>>> (e.g. config-bios-tables-test.h ?)
>>>=20
>>> meson then will be smart enough not to rebuild everything
>>> if you just change this singe flag.
>>>=20
>>>=20
>>>> ---
>>>> meson.build                    | 10 ----------
>>>> meson_options.txt              |  2 --
>>>> scripts/meson-buildoptions.sh  |  2 --
>>>> tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++--------
>>>> 4 files changed, 20 insertions(+), 22 deletions(-)
>>>>=20
>>>> changelog:
>>>> v3: incorporated suggestion from MST. Simplify it even more and
>>>> remove all dependency with meson build system. Set a default iasl
>>>> path which can be overridden by an environment variable.
>>>>=20
>>>> v2:
>>>> addressed comments from v1. CONFIG_IASL is now an environment
>>>> variable and no new environment variable is introduced.
>>>> Top level meson.build now does not set CONFIG_IASL in the
>>>> platform header. References to iasl has been removed from other
>>>> files. Test doc is updated. For example:
>>>>=20
>>>> "to see ASL diff between mismatched files install IASL, set =
CONFIG_IASL environment variable to the path of iasl binary,
>>>> and run 'QTEST_QEMU_BINARY=3D<path to QEMU binary to test> V=3D1 =
./tests/qtest/bios-tables-test' from build directory.
>>>> Alternatively run 'V=3D1 make check-qtest -B' from build dir."
>>>>=20
>>>>=20
>>>> One drawback of this approach is that meson overrides the values
>>>> of environment variables that are passed from the OS command line
>>>> with the values it sets. So if CONFIG_IASL is passed as an
>>>> env variable by the developer while running "make check-qtest" and
>>>> meson finds iasl in the path, meson will override the value the
>>>> developer provided with the one that it found. I have not seen a
>>>> way to check for OS env from meson.build like we do =
os.environ.get()
>>>> in python.
>>>> Other than the above, other cases are tested. In absence of iasl,
>>>> the developer can provide their own CONFIG_IASL and path to a =
custom
>>>> binary and the test picks it up when run from make check-qtest.
>>>> Once iasl is installed, make check-qtest -B will force meson to
>>>> retest iasl path and pass it to the test as an enviroinment.
>>>> When running the test directly, one has to explicitly pass the path
>>>> of iasl in the commnand line as no meson is involved there. There =
is
>>>> no automatic PATH discovery in the test.
>>>>=20
>>>> diff --git a/meson.build b/meson.build
>>>> index 25a4b9f2c1..18c7b669d9 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -179,12 +179,6 @@ if 'dtrace' in get_option('trace_backends')
>>>>  endif
>>>> endif
>>>>=20
>>>> -if get_option('iasl') =3D=3D ''
>>>> -  iasl =3D find_program('iasl', required: false)
>>>> -else
>>>> -  iasl =3D find_program(get_option('iasl'), required: true)
>>>> -endif
>>>> -
>>>> ##################
>>>> # Compiler flags #
>>>> ##################
>>>> @@ -1791,9 +1785,6 @@ foreach k : get_option('trace_backends')
>>>> endforeach
>>>> config_host_data.set_quoted('CONFIG_TRACE_FILE', =
get_option('trace_file'))
>>>> config_host_data.set_quoted('CONFIG_TLS_PRIORITY', =
get_option('tls_priority'))
>>>> -if iasl.found()
>>>> -  config_host_data.set_quoted('CONFIG_IASL', iasl.full_path())
>>>> -endif
>>>> config_host_data.set_quoted('CONFIG_BINDIR', get_option('prefix') / =
get_option('bindir'))
>>>> config_host_data.set_quoted('CONFIG_PREFIX', get_option('prefix'))
>>>> config_host_data.set_quoted('CONFIG_QEMU_CONFDIR', =
get_option('prefix') / qemu_confdir)
>>>> @@ -3761,7 +3752,6 @@ summary_info +=3D {'sphinx-build':      =
sphinx_build}
>>>> if config_host.has_key('HAVE_GDB_BIN')
>>>>  summary_info +=3D {'gdb':             config_host['HAVE_GDB_BIN']}
>>>> endif
>>>> -summary_info +=3D {'iasl':              iasl}
>>>> summary_info +=3D {'genisoimage':       config_host['GENISOIMAGE']}
>>>> if targetos =3D=3D 'windows' and have_ga
>>>>  summary_info +=3D {'wixl':            wixl}
>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>> index d8330a1f71..9149df8004 100644
>>>> --- a/meson_options.txt
>>>> +++ b/meson_options.txt
>>>> @@ -14,8 +14,6 @@ option('smbd', type : 'string', value : '',
>>>>       description: 'Path to smbd for slirp networking')
>>>> option('sphinx_build', type : 'string', value : 'sphinx-build',
>>>>       description: 'Use specified sphinx-build for building =
document')
>>>> -option('iasl', type : 'string', value : '',
>>>> -       description: 'Path to ACPI disassembler')
>>>> option('tls_priority', type : 'string', value : 'NORMAL',
>>>>       description: 'Default TLS protocol/cipher priority string')
>>>> option('default_devices', type : 'boolean', value : true,
>>>> diff --git a/scripts/meson-buildoptions.sh =
b/scripts/meson-buildoptions.sh
>>>> index 2805d1c145..98ca2e53af 100644
>>>> --- a/scripts/meson-buildoptions.sh
>>>> +++ b/scripts/meson-buildoptions.sh
>>>> @@ -48,7 +48,6 @@ meson_options_help() {
>>>>  printf "%s\n" '                           =
dtrace/ftrace/log/nop/simple/syslog/ust)'
>>>>  printf "%s\n" '  --firmwarepath=3DVALUES    search PATH for =
firmware files [share/qemu-'
>>>>  printf "%s\n" '                           firmware]'
>>>> -  printf "%s\n" '  --iasl=3DVALUE             Path to ACPI =
disassembler'
>>>>  printf "%s\n" '  --includedir=3DVALUE       Header file directory =
[include]'
>>>>  printf "%s\n" '  --interp-prefix=3DVALUE    where to find shared =
libraries etc., use %M for'
>>>>  printf "%s\n" '                           cpu name =
[/usr/gnemul/qemu-%M]'
>>>> @@ -304,7 +303,6 @@ _meson_option_parse() {
>>>>    --disable-hexagon-idef-parser) printf "%s" =
-Dhexagon_idef_parser=3Dfalse ;;
>>>>    --enable-hvf) printf "%s" -Dhvf=3Denabled ;;
>>>>    --disable-hvf) printf "%s" -Dhvf=3Ddisabled ;;
>>>> -    --iasl=3D*) quote_sh "-Diasl=3D$2" ;;
>>>>    --enable-iconv) printf "%s" -Diconv=3Denabled ;;
>>>>    --disable-iconv) printf "%s" -Diconv=3Ddisabled ;;
>>>>    --includedir=3D*) quote_sh "-Dincludedir=3D$2" ;;
>>>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>>>> index 7fd88b0e9c..570f2d714d 100644
>>>> --- a/tests/qtest/bios-tables-test.c
>>>> +++ b/tests/qtest/bios-tables-test.c
>>>> @@ -69,6 +69,7 @@
>>>> #define MACHINE_Q35 "q35"
>>>>=20
>>>> #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
>>>> +#define DEFAULT_IASL_PATH "/usr/bin/iasl"
>>>>=20
>>>> #define OEM_ID             "TEST"
>>>> #define OEM_TABLE_ID       "OEM"
>>>> @@ -102,11 +103,7 @@ typedef struct {
>>>>=20
>>>> static char disk[] =3D "tests/acpi-test-disk-XXXXXX";
>>>> static const char *data_dir =3D "tests/data/acpi";
>>>> -#ifdef CONFIG_IASL
>>>> -static const char *iasl =3D CONFIG_IASL;
>>>> -#else
>>>> -static const char *iasl;
>>>> -#endif
>>>> +static const char *iasl =3D DEFAULT_IASL_PATH;
>>>>=20
>>>> static int verbosity_level;
>>>>=20
>>>> @@ -441,6 +438,14 @@ static void test_acpi_asl(test_data *data)
>>>>    test_data exp_data =3D {};
>>>>    gboolean exp_err, err, all_tables_match =3D true;
>>>>=20
>>>> +    if (getenv("IASL_PATH")) {
>>>> +        iasl =3D getenv("IASL_PATH");
>>>> +    }
>>>> +
>>>> +    if (access(iasl, F_OK | X_OK) < 0) {
>>>> +        iasl =3D NULL;
>>>> +    }
>>>> +
>>>>    exp_data.tables =3D load_expected_aml(data);
>>>>    dump_aml_files(data, false);
>>>>    for (i =3D 0; i < data->tables->len; ++i) {
>>>> @@ -473,6 +478,10 @@ static void test_acpi_asl(test_data *data)
>>>>            continue;
>>>>        }
>>>>=20
>>>> +        if (iasl && verbosity_level >=3D 2) {
>>>> +            fprintf(stderr, "Using iasl: %s\n", iasl);
>>>> +        }
>>>> +
>>>>        err =3D load_asl(data->tables, sdt);
>>>>        asl =3D normalize_asl(sdt->asl);
>>>>=20
>>>> @@ -528,9 +537,12 @@ static void test_acpi_asl(test_data *data)
>>>>        g_string_free(exp_asl, true);
>>>>    }
>>>>    if (!iasl && !all_tables_match) {
>>>> -        fprintf(stderr, "to see ASL diff between mismatched files =
install IASL,"
>>>> -                " rebuild QEMU from scratch and re-run tests with =
V=3D1"
>>>> -                " environment variable set");
>>>> +        fprintf(stderr, "to see ASL diff between mismatched files =
install\n"
>>>> +                " IASL & re-run the test with V=3D1 environment =
variable set.\n"
>>>> +                " Set IASL_PATH environment variable to the path =
of iasl binary\n"
>>>> +                " if iasl is installed somewhere other than =
%s.\n",
>>>> +                DEFAULT_IASL_PATH
>>>> +                );
>>>>    }
>>>>    g_assert(all_tables_match);
>>>>=20
>>>> --=20
>>>> 2.39.1


