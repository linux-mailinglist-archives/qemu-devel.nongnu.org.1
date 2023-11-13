Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697A57E9B22
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:25:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2V2r-0001TE-1y; Mon, 13 Nov 2023 06:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2V2p-0001Sy-D6; Mon, 13 Nov 2023 06:23:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2V2n-0004Tk-38; Mon, 13 Nov 2023 06:23:55 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc58219376so38277535ad.1; 
 Mon, 13 Nov 2023 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699874631; x=1700479431; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++R/uzQ6paNmh5OupDgUH1maiyFXUSGjFKDmWn4pHnU=;
 b=GTEVIpDz5jWKPtOwT8lAdjss0ec6aeR772Y9J0lwILkNgK9bamri0gnMiJx8opcdo6
 +0bb3LErx4AE7QZ7ke9Pjyl40tgRYe5uftS95qeZiSybByFrcZdNZDTP2E9K+tDIJwfc
 Uwn39Ukz76bT5QJ6JKesAtEzRLx0p2IQRQ6kETvGCab27Y0VmrFMNO/iPYOBCLo96Kc7
 ZQHKfrL2ASsNPt14kPE/CGQIy3v2gY8YmHfiKt/v8dhrC+kHkDsIgtU2z18jiMiyufif
 xmDeYcGAY0oQS4TI5X3dSqD+JVu2TXCcAKgWCLYRx32fkSYO2H4bLi8esRjlzomF7NAc
 IOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699874631; x=1700479431;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=++R/uzQ6paNmh5OupDgUH1maiyFXUSGjFKDmWn4pHnU=;
 b=lj/2KyDvriG5rVlbG8bwwP5yv+i8h33I86/OrCLM9/iu8XtzwL4QI+AzHLzA9hCek4
 /hi0D/WGEosnzcSMu8GmDf7Tcox+3EXGyCfU1W7Dmh+eyy0Yl6rusHI/rRV4DIm5QZKX
 uQFFgfdkm2bUQPHAZ1lRJjWceEz499TnwTiJMzwni9JqUHtAxUOiZ7JdO2slVodROEm1
 MKkPbMvn9NsduBrmtK+3kzcV20hTyUd+ewh1iDnGUPI55Rd5l+DZ2GZuIvJHb85K7GmE
 31hqldjOX7th37HBMsdXHCSPk8jh7QVCDxKWz+GNkj7qb7ZjWxtiPsXfoqzVZY7AKmcg
 xTvg==
X-Gm-Message-State: AOJu0YwhcSGYdJqh4/7/yUslyGfNhuDo05EzTdLZ6FsPhnpflGCo8dGy
 iZYNXSJHbm5/0BUXsGhCOoU=
X-Google-Smtp-Source: AGHT+IGCqb7vbFVjuViZoYjvAJpK6TocWBuRgVYINlpTyfgC+ZJewH23jL2WQTWRrHQydlleuXek0w==
X-Received: by 2002:a17:902:e886:b0:1c8:8f5f:b610 with SMTP id
 w6-20020a170902e88600b001c88f5fb610mr8090860plg.13.1699874630953; 
 Mon, 13 Nov 2023 03:23:50 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902e88500b001c3a8b135ebsm3818575plg.282.2023.11.13.03.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 03:23:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Nov 2023 21:23:43 +1000
Message-Id: <CWXN9HF4AXGM.19H4A5BU366S1@wheely>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Akihiko Odaki" <akihiko.odaki@daynix.com>, "Luis Machado"
 <luis.machado@linaro.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 <qemu-s390x@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Richard Henderson" <richard.henderson@linaro.org>, "David Hildenbrand"
 <david@redhat.com>
Subject: Re: [PULL 06/23] tests/tcg: add an explicit gdbstub register tester
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
 <20231107142354.3151266-7-alex.bennee@linaro.org>
In-Reply-To: <20231107142354.3151266-7-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Nov 8, 2023 at 12:23 AM AEST, Alex Benn=C3=A9e wrote:
> We already do a couple of "info registers" for specific tests but this
> is a more comprehensive multiarch test. It also has some output
> helpful for debugging the gdbstub by showing which XML features are
> advertised and what the underlying register numbers are.
>
> My initial motivation was to see if there are any duplicate register
> names exposed via the gdbstub while I was reviewing the proposed
> register interface for TCG plugins.
>
> Mismatches between the xml and remote-desc are reported for debugging
> but do not fail the test.
>
> We also skip the tests for the following arches for now until we can
> investigate and fix any issues:
>
>   - s390x (fails to read v0l->v15l, not seen in remote-registers)
>   - ppc64 (fails to read vs0h->vs31h, not seen in remote-registers)

binutils-gdb.git/gdb/rs6000-tdep.c has:

static const char *
rs6000_register_name (struct gdbarch *gdbarch, int regno)
{
  ppc_gdbarch_tdep *tdep =3D (ppc_gdbarch_tdep *) gdbarch_tdep (gdbarch);

  /* The upper half "registers" have names in the XML description,
     but we present only the low GPRs and the full 64-bit registers
     to the user.  */
  if (tdep->ppc_ev0_upper_regnum >=3D 0
      && tdep->ppc_ev0_upper_regnum <=3D regno
      && regno < tdep->ppc_ev0_upper_regnum + ppc_num_gprs)
    return "";

  /* Hide the upper halves of the vs0~vs31 registers.  */
  if (tdep->ppc_vsr0_regnum >=3D 0
      && tdep->ppc_vsr0_upper_regnum <=3D regno
      && regno < tdep->ppc_vsr0_upper_regnum + ppc_num_gprs)
    return "";

(s390 looks similar for V0-V15 lower).

I guess it is because the upper half is not a real register but an
extension of an existing FP register to make a vector register. I
just don't know how that should be resolved with QEMU.

Should we put an exception in the test case for these? Or is there
something we should be doing differently with the XML regs?

i386 gdb does similar:

static const char *
i386_register_name (struct gdbarch *gdbarch, int regnum)
{
  /* Hide the upper YMM registers.  */
  if (i386_ymmh_regnum_p (gdbarch, regnum))
    return "";

  /* Hide the upper YMM16-31 registers.  */
  if (i386_ymmh_avx512_regnum_p (gdbarch, regnum))
    return "";

  /* Hide the upper ZMM registers.  */
  if (i386_zmmh_regnum_p (gdbarch, regnum))
    return "";

  return tdesc_register_name (gdbarch, regnum);
}

So, I'm not sure how they don't fail this test. Does QEMU just
not have YMM/ZMM in XML regmap?

Thanks,
Nick


>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Luis Machado <luis.machado@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: qemu-s390x@nongnu.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20231106185112.2755262-7-alex.bennee@linaro.org>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b86ea7f75a..26e7633346 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2927,7 +2927,7 @@ F: gdbstub/*
>  F: include/exec/gdbstub.h
>  F: include/gdbstub/*
>  F: gdb-xml/
> -F: tests/tcg/multiarch/gdbstub/
> +F: tests/tcg/multiarch/gdbstub/*
>  F: scripts/feature_to_c.py
>  F: scripts/probe-gdb-support.py
> =20
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index f3bfaf1a22..d31ba8d6ae 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -93,12 +93,21 @@ run-gdbstub-thread-breakpoint: testthread
>  		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>  		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
>  	hitting a breakpoint on non-main thread)
> +
> +run-gdbstub-registers: sha512
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(GDB) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
> +	checking register enumeration)
> +
>  else
>  run-gdbstub-%:
>  	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst =
-%,,$(TARGET_NAME)) support")
>  endif
>  EXTRA_RUNS +=3D run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
> -	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
> +	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
> +	      run-gdbstub-registers
> =20
>  # ARM Compatible Semi Hosting Tests
>  #
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiar=
ch/gdbstub/registers.py
> new file mode 100644
> index 0000000000..ff6076b09e
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -0,0 +1,197 @@
> +# Exercise the register functionality by exhaustively iterating
> +# through all supported registers on the system.
> +#
> +# This is launched via tests/guest-debug/run-test.py but you can also
> +# call it directly if using it for debugging/introspection:
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import gdb
> +import sys
> +import xml.etree.ElementTree as ET
> +
> +initial_vlen =3D 0
> +failcount =3D 0
> +
> +def report(cond, msg):
> +    "Report success/fail of test."
> +    if cond:
> +        print("PASS: %s" % (msg))
> +    else:
> +        print("FAIL: %s" % (msg))
> +        global failcount
> +        failcount +=3D 1
> +
> +
> +def fetch_xml_regmap():
> +    """
> +    Iterate through the XML descriptions and validate.
> +
> +    We check for any duplicate registers and report them. Return a
> +    reg_map hash containing the names, regnums and initial values of
> +    all registers.
> +    """
> +
> +    # First check the XML descriptions we have sent. Most arches
> +    # support XML but a few of the ancient ones don't in which case we
> +    # need to gracefully fail.
> +
> +    try:
> +        xml =3D gdb.execute("maint print xml-tdesc", False, True)
> +    except (gdb.error):
> +        print("SKIP: target does not support XML")
> +        return None
> +
> +    total_regs =3D 0
> +    reg_map =3D {}
> +    frame =3D gdb.selected_frame()
> +
> +    tree =3D ET.fromstring(xml)
> +    for f in tree.findall("feature"):
> +        name =3D f.attrib["name"]
> +        regs =3D f.findall("reg")
> +
> +        total =3D len(regs)
> +        total_regs +=3D total
> +        base =3D int(regs[0].attrib["regnum"])
> +        top =3D int(regs[-1].attrib["regnum"])
> +
> +        print(f"feature: {name} has {total} registers from {base} to {to=
p}")
> +
> +        for r in regs:
> +            name =3D r.attrib["name"]
> +            regnum =3D int(r.attrib["regnum"])
> +            try:
> +                value =3D frame.read_register(name)
> +            except ValueError:
> +                report(False, f"failed to read reg: {name}")
> +
> +            entry =3D { "name": name, "initial": value, "regnum": regnum=
 }
> +
> +            if name in reg_map:
> +                report(False, f"duplicate register {entry} vs {reg_map[n=
ame]}")
> +                continue
> +
> +            reg_map[name] =3D entry
> +
> +    # Validate we match
> +    report(total_regs =3D=3D len(reg_map.keys()),
> +           f"counted all {total_regs} registers in XML")
> +
> +    return reg_map
> +
> +def crosscheck_remote_xml(reg_map):
> +    """
> +    Cross-check the list of remote-registers with the XML info.
> +    """
> +
> +    remote =3D gdb.execute("maint print remote-registers", False, True)
> +    r_regs =3D remote.split("\n")
> +
> +    total_regs =3D len(reg_map.keys())
> +    total_r_regs =3D 0
> +
> +    for r in r_regs:
> +        fields =3D r.split()
> +        # Some of the registers reported here are "pseudo" registers tha=
t
> +        # gdb invents based on actual registers so we need to filter the=
m
> +        # out.
> +        if len(fields) =3D=3D 8:
> +            r_name =3D fields[0]
> +            r_regnum =3D int(fields[6])
> +
> +            # check in the XML
> +            try:
> +                x_reg =3D reg_map[r_name]
> +            except KeyError:
> +                report(False, f"{r_name} not in XML description")
> +                continue
> +
> +            x_reg["seen"] =3D True
> +            x_regnum =3D x_reg["regnum"]
> +            if r_regnum !=3D x_regnum:
> +                report(False, f"{r_name} {r_regnum} =3D=3D {x_regnum} (x=
ml)")
> +            else:
> +                total_r_regs +=3D 1
> +
> +    # Just print a mismatch in totals as gdb will filter out 64 bit
> +    # registers on a 32 bit machine. Also print what is missing to
> +    # help with debug.
> +    if total_regs !=3D total_r_regs:
> +        print(f"xml-tdesc has ({total_regs}) registers")
> +        print(f"remote-registers has ({total_r_regs}) registers")
> +
> +        for x_key in reg_map.keys():
> +            x_reg =3D reg_map[x_key]
> +            if "seen" not in x_reg:
> +                print(f"{x_reg} wasn't seen in remote-registers")
> +
> +def complete_and_diff(reg_map):
> +    """
> +    Let the program run to (almost) completion and then iterate
> +    through all the registers we know about and report which ones have
> +    changed.
> +    """
> +    # Let the program get to the end and we can check what changed
> +    b =3D gdb.Breakpoint("_exit")
> +    if b.pending: # workaround Microblaze weirdness
> +        b.delete()
> +        gdb.Breakpoint("_Exit")
> +
> +    gdb.execute("continue")
> +
> +    frame =3D gdb.selected_frame()
> +    changed =3D 0
> +
> +    for e in reg_map.values():
> +        name =3D e["name"]
> +        old_val =3D e["initial"]
> +
> +        try:
> +            new_val =3D frame.read_register(name)
> +        except:
> +            report(False, f"failed to read {name} at end of run")
> +            continue
> +
> +        if new_val !=3D old_val:
> +            print(f"{name} changes from {old_val} to {new_val}")
> +            changed +=3D 1
> +
> +    # as long as something changed we can be confident its working
> +    report(changed > 0, f"{changed} registers were changed")
> +
> +
> +def run_test():
> +    "Run through the tests"
> +
> +    reg_map =3D fetch_xml_regmap()
> +
> +    if reg_map is not None:
> +        crosscheck_remote_xml(reg_map)
> +        complete_and_diff(reg_map)
> +
> +
> +#
> +# This runs as the script it sourced (via -x, via run-test.py)
> +#
> +try:
> +    inferior =3D gdb.selected_inferior()
> +    arch =3D inferior.architecture()
> +    print("ATTACHED: %s" % arch.name())
> +except (gdb.error, AttributeError):
> +    print("SKIPPING (not connected)", file=3Dsys.stderr)
> +    exit(0)
> +
> +if gdb.parse_and_eval('$pc') =3D=3D 0:
> +    print("SKIP: PC not set")
> +    exit(0)
> +
> +try:
> +    run_test()
> +except (gdb.error):
> +    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> +    failcount +=3D 1
> +    pass
> +
> +print("All tests complete: %d failures" % failcount)
> +exit(failcount)
> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/t=
cg/multiarch/system/Makefile.softmmu-target
> index dee4f58dea..32dc0f9830 100644
> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> @@ -48,9 +48,20 @@ run-gdbstub-untimely-packet: hello
>  	$(call quiet-command, \
>  		(! grep -Fq 'Packet instead of Ack, ignoring it' untimely-packet.gdb.e=
rr), \
>  		"GREP", file untimely-packet.gdb.err)
> +
> +run-gdbstub-registers: memory
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(GDB) \
> +		--qemu $(QEMU) \
> +		--output $<.registers.gdb.out \
> +		--qargs \
> +		"-monitor none -display none -chardev file$(COMMA)path=3D$<.out$(COMMA=
)id=3Doutput $(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
> +	softmmu gdbstub support)
>  else
>  run-gdbstub-%:
>  	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst =
-%,,$(TARGET_NAME)) support")
>  endif
> =20
> -MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt run-gdbstub=
-untimely-packet
> +MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
> +	run-gdbstub-untimely-packet run-gdbstub-registers
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.t=
arget
> index 5721c159f2..1d08076756 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -38,4 +38,11 @@ PPC64_TESTS +=3D signal_save_restore_xer
>  PPC64_TESTS +=3D xxspltw
>  PPC64_TESTS +=3D test-aes
> =20
> +ifneq ($(GDB),)
> +# Skip for now until vsx registers sorted out
> +run-gdbstub-registers:
> +	$(call skip-test, $<, "BROKEN reading VSX registers")
> +endif
> +
> +
>  TESTS +=3D $(PPC64_TESTS)
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
> index 826f0a18e4..49af091c38 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -100,6 +100,10 @@ run-gdbstub-svc: hello-s390x-asm
>  		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
>  	single-stepping svc)
> =20
> +# Skip for now until vx registers sorted out
> +run-gdbstub-registers:
> +	$(call skip-test, $<, "BROKEN reading VX registers")
> +
>  EXTRA_RUNS +=3D run-gdbstub-signals-s390x run-gdbstub-svc
>  endif
> =20


