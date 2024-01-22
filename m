Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4E83696D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:01:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwjF-0000YP-Kt; Mon, 22 Jan 2024 11:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwjC-0000Y6-17
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:00:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwj8-00043R-St
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:00:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33922d2cb92so2984402f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705939245; x=1706544045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iniAfOoXqxT04dSiQklssAHJuJY2wbVnSImNM+jtfb0=;
 b=rb1AmTAg6BOp49B7QjlgI4IBnZ/Xh8PB7BrU9NVPwS6vj0UKG21Kl7r7V4yOSZqPhX
 MlZ8yJBrXc7W36fpp26m7KBsTP9cUvwt+8b8h9WNQaA/V2FKmOMBw3i/8BceVP1d3AqB
 C+CQCoU62UdgFdQn6kQOu0YXrCrSznKBV7D1FAt8g1NctLxQ/Q5SlADqK4Q5b8y3UTs+
 G8akfMY0DBjOqnUiFFrJhjYHpg/4FObuKuc7ImIZfk322YFgcuUyRklROPnvGTGquvG6
 y4WtqDDgeqWPwb+4Bz472FkTjvrl0UsqTh5XvLsa+UVTQJx4UANopspgPtz/DFGQxTjT
 vd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939245; x=1706544045;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iniAfOoXqxT04dSiQklssAHJuJY2wbVnSImNM+jtfb0=;
 b=p8uYS8SCojhQ+lfpD6q9YoohZZrUHooMAEV2OW0hg2xa/HRkQVHMQOYSXC5Ev8JYhy
 zf3a6IMlWG6JKjoPuuoxSMN29J5mGYIVsjEmsFn9RMZ2bj8ILI1+xV0Se+f68vKhfkTU
 Yway6G5oqDn8Q+9L1cWRczbSoVBqbOOcxJ7AWksiPnP8hE0fMjwZ+6ic4VgaJDLh1EDM
 FgBzZMXHTbmSBp+7bO8iPapewzqJzQoxLsahHyfCTzBQXds4drc8wFIAvldEX4ZNTSQr
 hFkM7QKiJI60ApnGj87WG26fzufSe8qy5cQJ2IX8oD1e6mb46MgzDcQAhesdJbJc8z3P
 /q1A==
X-Gm-Message-State: AOJu0YyNwpdKZRpaSMH1bWyt9+HaX7WLrvig4Z97sU9V0iaLTuxN12Ip
 kA2PhxPjKxfD9f8RCPWykLFnZE5cKbPNVTDNcpdANZJL/M7gMdrd4EfGrHG3ZS0=
X-Google-Smtp-Source: AGHT+IFaSidQvt3SW3z2gsVNaUndaIo5yJFvbVR7Vd3Zbt14mXJRLERiDdW9GRnPH/f2PKD/6J0wDA==
X-Received: by 2002:a05:6000:1191:b0:337:c409:717d with SMTP id
 g17-20020a056000119100b00337c409717dmr1221731wrx.159.1705939244902; 
 Mon, 22 Jan 2024 08:00:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e11-20020a5d594b000000b003392bbeeed3sm5763265wri.47.2024.01.22.08.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:00:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 175A05F794;
 Mon, 22 Jan 2024 16:00:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 2/3] tests/tcg: Factor out gdbstub test functions
In-Reply-To: <20240116003551.75168-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 16 Jan 2024 01:31:41 +0100")
References: <20240116003551.75168-1-iii@linux.ibm.com>
 <20240116003551.75168-3-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 16:00:44 +0000
Message-ID: <87v87lmk7n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Both the report() function as well as the initial gdbstub test sequence
> are copy-pasted into ~10 files with slight modifications. This
> indicates that they are indeed generic, so factor them out. While
> at it, add a few newlines to make the formatting closer to PEP-8.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/guest-debug/run-test.py                 |  7 ++-
>  tests/guest-debug/test_gdbstub.py             | 58 +++++++++++++++++++
>  tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +----------
>  tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +----------
>  tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++-------------
>  tests/tcg/multiarch/gdbstub/memory.py         | 41 +------------
>  tests/tcg/multiarch/gdbstub/registers.py      | 41 ++-----------
>  tests/tcg/multiarch/gdbstub/sha1.py           | 40 ++-----------
>  .../multiarch/gdbstub/test-proc-mappings.py   | 39 +------------
>  .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +-----------
>  .../gdbstub/test-thread-breakpoint.py         | 37 +-----------
>  tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +-------------
>  tests/tcg/s390x/gdbstub/test-svc.py           | 39 +------------
>  13 files changed, 98 insertions(+), 397 deletions(-)
>  create mode 100644 tests/guest-debug/test_gdbstub.py
>
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index b13b27d4b19..368ff8a8903 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -97,7 +97,12 @@ def log(output, msg):
>      sleep(1)
>      log(output, "GDB CMD: %s" % (gdb_cmd))
>=20=20
> -    result =3D subprocess.call(gdb_cmd, shell=3DTrue, stdout=3Doutput, s=
tderr=3Dstderr)
> +    gdb_env =3D dict(os.environ)
> +    gdb_pythonpath =3D gdb_env.get("PYTHONPATH", "").split(os.pathsep)
> +    gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
> +    gdb_env["PYTHONPATH"] =3D os.pathsep.join(gdb_pythonpath)
> +    result =3D subprocess.call(gdb_cmd, shell=3DTrue, stdout=3Doutput, s=
tderr=3Dstderr,
> +                             env=3Dgdb_env)
>=20=20
>      # A result of greater than 128 indicates a fatal signal (likely a
>      # crash due to gdb internal failure). That's a problem for GDB and
> diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_g=
dbstub.py
> new file mode 100644
> index 00000000000..a71cdaa915a
> --- /dev/null
> +++ b/tests/guest-debug/test_gdbstub.py
> @@ -0,0 +1,58 @@
> +"""Helper functions for gdbstub testing
> +
> +"""
> +from __future__ import print_function
> +import gdb
> +import sys
> +import traceback
> +
> +fail_count =3D 0
> +
> +
> +def report(cond, msg):
> +    """Report success/fail of a test"""
> +    if cond:
> +        print("PASS: {}".format(msg))
> +    else:
> +        print("FAIL: {}".format(msg))
> +        global fail_count
> +        fail_count +=3D 1
> +
> +
> +def main(test, expected_arch=3DNone):
> +    """Run a test function
> +
> +    This runs as the script it sourced (via -x, via run-test.py)."""
> +    try:
> +        inferior =3D gdb.selected_inferior()
> +        arch =3D inferior.architecture()
> +        print("ATTACHED: {}".format(arch.name()))
> +        if expected_arch is not None:
> +            report(arch.name() =3D=3D expected_arch,
> +                   "connected to {}".format(expected_arch))
> +    except (gdb.error, AttributeError):
> +        print("SKIP: not connected")
> +        exit(0)
> +
> +    if gdb.parse_and_eval("$pc") =3D=3D 0:
> +        print("SKIP: PC not set")
> +        exit(0)
> +
> +    try:
> +        test()
> +    except:
> +        print("GDB Exception:")
> +        traceback.print_exc(file=3Dsys.stdout)
> +        global fail_count
> +        fail_count +=3D 1
> +        import code
> +        code.InteractiveConsole(locals=3Dglobals()).interact()
> +        raise

While I can see this is useful we don't want to default to an
interactive console as that will hang the test in CI type setups. Can we
make this a option we enable?

> +
> +    try:
> +        gdb.execute("kill")
> +    except gdb.error:
> +        pass
> +
> +    print("All tests complete: {} failures".format(fail_count))
> +    exit(fail_count)
> diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarc=
h64/gdbstub/test-sve-ioctl.py
> index ee8d467e59d..a78a3a2514d 100644
> --- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
> +++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
> @@ -8,19 +8,10 @@
>  #
>=20=20
>  import gdb
> -import sys
> +from test_gdbstub import main, report
>=20=20
>  initial_vlen =3D 0
> -failcount =3D 0
>=20=20
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print ("PASS: %s" % (msg))
> -    else:
> -        print ("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
>=20=20
>  class TestBreakpoint(gdb.Breakpoint):
>      def __init__(self, sym_name=3D"__sve_ld_done"):
> @@ -64,26 +55,5 @@ def run_test():
>=20=20
>      gdb.execute("c")
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    report(arch.name() =3D=3D "aarch64", "connected to aarch64")
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except:
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    import code
> -    code.InteractiveConsole(locals=3Dglobals()).interact()
> -    raise
>=20=20
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +main(run_test, expected_arch=3D"aarch64")
> diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gd=
bstub/test-sve.py
> index afd8ece98dd..84cdcd4a32e 100644
> --- a/tests/tcg/aarch64/gdbstub/test-sve.py
> +++ b/tests/tcg/aarch64/gdbstub/test-sve.py
> @@ -6,20 +6,10 @@
>  #
>=20=20
>  import gdb
> -import sys
> +from test_gdbstub import main, report
>=20=20
>  MAGIC =3D 0xDEADBEEF
>=20=20
> -failcount =3D 0
> -
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print ("PASS: %s" % (msg))
> -    else:
> -        print ("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
>=20=20
>  def run_test():
>      "Run through the tests one by one"
> @@ -54,24 +44,5 @@ def run_test():
>              report(str(v.type) =3D=3D "uint64_t", "size of %s" % (reg))
>              report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC))
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    report(arch.name() =3D=3D "aarch64", "connected to aarch64")
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except:
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -
> -print("All tests complete: %d failures" % failcount)
>=20=20
> -exit(failcount)
> +main(run_test, expected_arch=3D"aarch64")
> diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiar=
ch/gdbstub/interrupt.py
> index c016e7afbbf..90a45b5140a 100644
> --- a/tests/tcg/multiarch/gdbstub/interrupt.py
> +++ b/tests/tcg/multiarch/gdbstub/interrupt.py
> @@ -8,19 +8,7 @@
>  #
>=20=20
>  import gdb
> -import sys
> -
> -failcount =3D 0
> -
> -
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print("PASS: %s" % (msg))
> -    else:
> -        print("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
> +from test_gdbstub import main, report
>=20=20
>=20=20
>  def check_interrupt(thread):
> @@ -59,6 +47,9 @@ def run_test():
>      Test if interrupting the code always lands us on the same thread when
>      running with scheduler-lock enabled.
>      """
> +    if len(gdb.selected_inferior().threads()) =3D=3D 1:
> +        print("SKIP: set to run on a single thread")
> +        exit(0)
>=20=20
>      gdb.execute("set scheduler-locking on")
>      for thread in gdb.selected_inferior().threads():
> @@ -66,32 +57,4 @@ def run_test():
>                 "thread %d resumes correctly on interrupt" % thread.num)
>=20=20
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -if len(gdb.selected_inferior().threads()) =3D=3D 1:
> -    print("SKIP: set to run on a single thread")
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
> -
> -# Finally kill the inferior and exit gdb with a count of failures
> -gdb.execute("kill")
> -exit(failcount)
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/=
gdbstub/memory.py
> index fb1d06b7bb7..532b92e7fb3 100644
> --- a/tests/tcg/multiarch/gdbstub/memory.py
> +++ b/tests/tcg/multiarch/gdbstub/memory.py
> @@ -9,18 +9,7 @@
>=20=20
>  import gdb
>  import sys
> -
> -failcount =3D 0
> -
> -
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print("PASS: %s" % (msg))
> -    else:
> -        print("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
> +from test_gdbstub import main, report
>=20=20
>=20=20
>  def check_step():
> @@ -99,29 +88,5 @@ def run_test():
>=20=20
>      report(cbp.hit_count =3D=3D 0, "didn't reach backstop")
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
> -
> -# Finally kill the inferior and exit gdb with a count of failures
> -gdb.execute("kill")
> -exit(failcount)
> +
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiar=
ch/gdbstub/registers.py
> index 688c0611072..b3d13cb077f 100644
> --- a/tests/tcg/multiarch/gdbstub/registers.py
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -7,20 +7,11 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>=20=20
>  import gdb
> -import sys
>  import xml.etree.ElementTree as ET
> +from test_gdbstub import main, report
>=20=20
> -initial_vlen =3D 0
> -failcount =3D 0
>=20=20
> -def report(cond, msg):
> -    "Report success/fail of test."
> -    if cond:
> -        print("PASS: %s" % (msg))
> -    else:
> -        print("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
> +initial_vlen =3D 0
>=20=20
>=20=20
>  def fetch_xml_regmap():
> @@ -75,6 +66,7 @@ def fetch_xml_regmap():
>=20=20
>      return reg_map
>=20=20
> +
>  def get_register_by_regnum(reg_map, regnum):
>      """
>      Helper to find a register from the map via its XML regnum
> @@ -84,6 +76,7 @@ def get_register_by_regnum(reg_map, regnum):
>              return entry
>      return None
>=20=20
> +
>  def crosscheck_remote_xml(reg_map):
>      """
>      Cross-check the list of remote-registers with the XML info.
> @@ -144,6 +137,7 @@ def crosscheck_remote_xml(reg_map):
>          elif "seen" not in x_reg:
>              print(f"{x_reg} wasn't seen in remote-registers")
>=20=20
> +
>  def initial_register_read(reg_map):
>      """
>      Do an initial read of all registers that we know gdb cares about
> @@ -214,27 +208,4 @@ def run_test():
>          complete_and_diff(reg_map)
>=20=20
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -
> -try:
> -    run_test()
> -except (gdb.error):
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
> -
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gd=
bstub/sha1.py
> index 416728415f9..1ce711a402c 100644
> --- a/tests/tcg/multiarch/gdbstub/sha1.py
> +++ b/tests/tcg/multiarch/gdbstub/sha1.py
> @@ -7,19 +7,11 @@
>  #
>=20=20
>  import gdb
> -import sys
> +from test_gdbstub import main, report
> +
>=20=20
>  initial_vlen =3D 0
> -failcount =3D 0
>=20=20
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print("PASS: %s" % (msg))
> -    else:
> -        print("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
>=20=20
>  def check_break(sym_name):
>      "Setup breakpoint, continue and check we stopped."
> @@ -35,6 +27,7 @@ def check_break(sym_name):
>=20=20
>      bp.delete()
>=20=20
> +
>  def run_test():
>      "Run through the tests one by one"
>=20=20
> @@ -57,28 +50,5 @@ def run_test():
>      # finally check we don't barf inspecting registers
>      gdb.execute("info registers")
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
> -
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tc=
g/multiarch/gdbstub/test-proc-mappings.py
> index 04ec61d2197..564613fabf0 100644
> --- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> +++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> @@ -3,20 +3,7 @@
>  This runs as a sourced script (via -x, via run-test.py)."""
>  from __future__ import print_function
>  import gdb
> -import sys
> -
> -
> -n_failures =3D 0
> -
> -
> -def report(cond, msg):
> -    """Report success/fail of a test"""
> -    if cond:
> -        print("PASS: {}".format(msg))
> -    else:
> -        print("FAIL: {}".format(msg))
> -        global n_failures
> -        n_failures +=3D 1
> +from test_gdbstub import main, report
>=20=20
>=20=20
>  def run_test():
> @@ -37,26 +24,4 @@ def run_test():
>      # report("/sha1" in mappings, "Found the test binary name in the map=
pings")
>=20=20
>=20=20
> -def main():
> -    """Prepare the environment and run through the tests"""
> -    try:
> -        inferior =3D gdb.selected_inferior()
> -        print("ATTACHED: {}".format(inferior.architecture().name()))
> -    except (gdb.error, AttributeError):
> -        print("SKIPPING (not connected)")
> -        exit(0)
> -
> -    if gdb.parse_and_eval('$pc') =3D=3D 0:
> -        print("SKIP: PC not set")
> -        exit(0)
> -
> -    try:
> -        # Run the actual tests
> -        run_test()
> -    except gdb.error:
> -        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
> -    print("All tests complete: %d failures" % n_failures)
> -    exit(n_failures)
> -
> -
> -main()
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/=
tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> index 926fa962b77..00c26ab4a95 100644
> --- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> +++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> @@ -6,18 +6,8 @@
>  #
>=20=20
>  import gdb
> -import sys
> +from test_gdbstub import main, report
>=20=20
> -failcount =3D 0
> -
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print ("PASS: %s" % (msg))
> -    else:
> -        print ("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
>=20=20
>  def run_test():
>      "Run through the tests one by one"
> @@ -26,28 +16,5 @@ def run_test():
>      report(isinstance(auxv, str), "Fetched auxv from inferior")
>      report(auxv.find("sha1"), "Found test binary name in auxv")
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
>=20=20
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +main(run_test)
> diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/test=
s/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> index e57d2a8db8b..4d6b6b9fbe7 100644
> --- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> +++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> @@ -6,18 +6,8 @@
>  #
>=20=20
>  import gdb
> -import sys
> +from test_gdbstub import main, report
>=20=20
> -failcount =3D 0
> -
> -def report(cond, msg):
> -    "Report success/fail of test"
> -    if cond:
> -        print ("PASS: %s" % (msg))
> -    else:
> -        print ("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
>=20=20
>  def run_test():
>      "Run through the tests one by one"
> @@ -29,28 +19,5 @@ def run_test():
>      frame =3D gdb.selected_frame()
>      report(str(frame.function()) =3D=3D "thread1_func", "break @ %s"%fra=
me)
>=20=20
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval('$pc') =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> -
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
>=20=20
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +main(run_test)
> diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s3=
90x/gdbstub/test-signals-s390x.py
> index ca2bbc0b03e..b6b7b39fc46 100644
> --- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
> +++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
> @@ -7,19 +7,7 @@
>  #
>=20=20
>  import gdb
> -import sys
> -
> -failcount =3D 0
> -
> -
> -def report(cond, msg):
> -    """Report success/fail of test"""
> -    if cond:
> -        print("PASS: %s" % (msg))
> -    else:
> -        print("FAIL: %s" % (msg))
> -        global failcount
> -        failcount +=3D 1
> +from test_gdbstub import main, report
>=20=20
>=20=20
>  def run_test():
> @@ -42,31 +30,7 @@ def run_test():
>      gdb.Breakpoint("_exit")
>      gdb.execute("c")
>      status =3D int(gdb.parse_and_eval("$r2"))
> -    report(status =3D=3D 0, "status =3D=3D 0");
> -
> -
> -#
> -# This runs as the script it sourced (via -x, via run-test.py)
> -#
> -try:
> -    inferior =3D gdb.selected_inferior()
> -    arch =3D inferior.architecture()
> -    print("ATTACHED: %s" % arch.name())
> -except (gdb.error, AttributeError):
> -    print("SKIPPING (not connected)", file=3Dsys.stderr)
> -    exit(0)
> -
> -if gdb.parse_and_eval("$pc") =3D=3D 0:
> -    print("SKIP: PC not set")
> -    exit(0)
> +    report(status =3D=3D 0, "status =3D=3D 0")
>=20=20
> -try:
> -    # Run the actual tests
> -    run_test()
> -except (gdb.error):
> -    print("GDB Exception: %s" % (sys.exc_info()[0]))
> -    failcount +=3D 1
> -    pass
>=20=20
> -print("All tests complete: %d failures" % failcount)
> -exit(failcount)
> +main(run_test)
> diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstu=
b/test-svc.py
> index 804705fede9..17210b4e020 100644
> --- a/tests/tcg/s390x/gdbstub/test-svc.py
> +++ b/tests/tcg/s390x/gdbstub/test-svc.py
> @@ -3,20 +3,7 @@
>  This runs as a sourced script (via -x, via run-test.py)."""
>  from __future__ import print_function
>  import gdb
> -import sys
> -
> -
> -n_failures =3D 0
> -
> -
> -def report(cond, msg):
> -    """Report success/fail of a test"""
> -    if cond:
> -        print("PASS: {}".format(msg))
> -    else:
> -        print("FAIL: {}".format(msg))
> -        global n_failures
> -        n_failures +=3D 1
> +from test_gdbstub import main, report
>=20=20
>=20=20
>  def run_test():
> @@ -35,26 +22,4 @@ def run_test():
>      gdb.execute("si")
>=20=20
>=20=20
> -def main():
> -    """Prepare the environment and run through the tests"""
> -    try:
> -        inferior =3D gdb.selected_inferior()
> -        print("ATTACHED: {}".format(inferior.architecture().name()))
> -    except (gdb.error, AttributeError):
> -        print("SKIPPING (not connected)")
> -        exit(0)
> -
> -    if gdb.parse_and_eval('$pc') =3D=3D 0:
> -        print("SKIP: PC not set")
> -        exit(0)
> -
> -    try:
> -        # Run the actual tests
> -        run_test()
> -    except gdb.error:
> -        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
> -    print("All tests complete: %d failures" % n_failures)
> -    exit(n_failures)
> -
> -
> -main()
> +main(run_test)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

