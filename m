Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE57EECE4
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:44:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tWA-0007aV-Hp; Fri, 17 Nov 2023 02:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3tW8-0007Yz-Si; Fri, 17 Nov 2023 02:43:56 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3tW6-0001Vd-Np; Fri, 17 Nov 2023 02:43:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ce3084c2d1so14827065ad.3; 
 Thu, 16 Nov 2023 23:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700207032; x=1700811832; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aJYQqtZH04HYLsyWLRfuqNm7PUW474tn+oZTqmg5hQ=;
 b=URc5Nq/ZiYdLFNoUjD1VzgkgRGpMSzfbSVUd7Bb9F+Sq290jtWh3Z4w2No5LTBnEnl
 NBywpgtR4Yut+CjacJgYYICXwQmFdtVZmFAbCm81xeNcP4KszvzclzFRpCpGwiQHV5in
 EKd9d5UL/Hv6oZAV7FBNgp14NqtfPY441vmJCjRamwA9AKcTdd/MEz6rKuXfgCvnjG6a
 i4SeiN5m9w6j/Mlsu9TSlZiCq6nXd0DMOD2l+h3TLg8Tf/HvQQPrMiF7NFp1X68bwHpD
 greD1I9a8Uwk/JE6fSTujnDtJGvjWmZfZN5a1ZDFw7nioSy6astAVjkotYZGK42ZCl1x
 e7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700207032; x=1700811832;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+aJYQqtZH04HYLsyWLRfuqNm7PUW474tn+oZTqmg5hQ=;
 b=u3gI2kmuGH9A5f5zk5QRlpnNpRYd60X88Vbzbjhlik+znxHd7qhaWqdie0baLECxm5
 2l95iZ1/lyEqTAkrAoj1gf2U7nvNwaMyBHPhfe+SrojCQQTPANJ7Yc79ued0Rrsv21PP
 Klw+NZsQlzt66ToxOQxIPnC2bAM2KMeB8x9qUxwam9w10HG01vVMzc20Gqi139J3fBpI
 LiCyRx15yIWMeL0HKIzC+8OUec7UOjNVypywKpUNBU4BxdFKsS/ItEiqwCmXkFCD5StP
 prBScxTrAENgswhrGpLpY65a5X3R5vuBkyGBnYMc24i5KAvooovsgKRiny1ncVijdyd3
 EQgA==
X-Gm-Message-State: AOJu0YzLLcsm3ZIidE/pgyjHZ3ksQ7mrbtbPv26MRMirxdRdxT4DdVf9
 PjeWbjtQHBxPAtMW10jTIbE=
X-Google-Smtp-Source: AGHT+IGpDFhQMoMwWr+ahc7HVtOZ0/FOslJsn/T/jDH5OvMFvhKlma1YIM8NH5UptfBp9UyKwcWCrg==
X-Received: by 2002:a17:903:32cc:b0:1ce:61f4:590b with SMTP id
 i12-20020a17090332cc00b001ce61f4590bmr223577plr.4.1700207032204; 
 Thu, 16 Nov 2023 23:43:52 -0800 (PST)
Received: from localhost ([1.146.110.245]) by smtp.gmail.com with ESMTPSA id
 n3-20020a170902e54300b001ce5b859a59sm788446plf.305.2023.11.16.23.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 23:43:51 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Nov 2023 17:43:20 +1000
Message-Id: <CX0X2X6F3YHX.ET31VLOF1VJK@wheely>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, <qemu-s390x@nongnu.org>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-ppc@nongnu.org>, "Luis
 Machado" <luis.machado@arm.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Richard Henderson" <richard.henderson@linaro.org>, "David Hildenbrand"
 <david@redhat.com>
Subject: Re: [RFC PATCH] tests/tcg: finesse the registers check for "hidden"
 regs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231116173953.2501204-1-alex.bennee@linaro.org>
In-Reply-To: <20231116173953.2501204-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Fri Nov 17, 2023 at 3:39 AM AEST, Alex Benn=C3=A9e wrote:
> The reason the ppc64 and s390x test where failing was because gdb
> hides them although they are still accessible via regnum. We can
> re-arrange the test a little bit and include these two arches in our
> test.
>
> We still don't explicitly fail for registers that just disappear like
> in the ARM case:
>
>   xml-tdesc has 228 registers
>   remote-registers has 219 registers
>   of which 0 are hidden
>   {'name': 'CNTP_CVAL', 'regnum': 96} wasn't seen in remote-registers
>   {'name': 'CNTV_CVAL', 'regnum': 101} wasn't seen in remote-registers
>   {'name': 'PAR', 'regnum': 113} wasn't seen in remote-registers
>   {'name': 'CPUACTLR', 'regnum': 114} wasn't seen in remote-registers
>   {'name': 'CPUECTLR', 'regnum': 127} wasn't seen in remote-registers
>   {'name': 'CPUMERRSR', 'regnum': 140} wasn't seen in remote-registers
>   {'name': 'TTBR1', 'regnum': 148} wasn't seen in remote-registers
>   {'name': 'L2MERRSR', 'regnum': 161} wasn't seen in remote-registers
>   {'name': 'TTBR0', 'regnum': 168} wasn't seen in remote-registers

Nice! Thanks for getting ppc64 working, comment below.

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: qemu-s390x@nongnu.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: qemu-ppc@nongnu.org
> Cc: Luis Machado <luis.machado@arm.com>
> ---
>  tests/tcg/multiarch/gdbstub/registers.py | 80 ++++++++++++++++++------
>  tests/tcg/ppc64/Makefile.target          |  7 ---
>  tests/tcg/s390x/Makefile.target          |  4 --
>  3 files changed, 61 insertions(+), 30 deletions(-)
>
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiar=
ch/gdbstub/registers.py
> index ff6076b09e..342d6fd78f 100644
> --- a/tests/tcg/multiarch/gdbstub/registers.py
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -44,7 +44,6 @@ def fetch_xml_regmap():
> =20
>      total_regs =3D 0
>      reg_map =3D {}
> -    frame =3D gdb.selected_frame()
> =20
>      tree =3D ET.fromstring(xml)
>      for f in tree.findall("feature"):
> @@ -61,12 +60,8 @@ def fetch_xml_regmap():
>          for r in regs:
>              name =3D r.attrib["name"]
>              regnum =3D int(r.attrib["regnum"])
> -            try:
> -                value =3D frame.read_register(name)
> -            except ValueError:
> -                report(False, f"failed to read reg: {name}")
> =20
> -            entry =3D { "name": name, "initial": value, "regnum": regnum=
 }
> +            entry =3D { "name": name, "regnum": regnum }
> =20
>              if name in reg_map:
>                  report(False, f"duplicate register {entry} vs {reg_map[n=
ame]}")
> @@ -80,6 +75,15 @@ def fetch_xml_regmap():
> =20
>      return reg_map
> =20
> +def get_register_by_regnum(reg_map, regnum):
> +    """
> +    Helper to find a register from the map via its XML regnum
> +    """
> +    for regname, entry in reg_map.items():
> +        if entry['regnum'] =3D=3D regnum:
> +            return entry
> +    return None
> +
>  def crosscheck_remote_xml(reg_map):
>      """
>      Cross-check the list of remote-registers with the XML info.
> @@ -90,6 +94,7 @@ def crosscheck_remote_xml(reg_map):
> =20
>      total_regs =3D len(reg_map.keys())
>      total_r_regs =3D 0
> +    total_r_elided_regs =3D 0
> =20
>      for r in r_regs:
>          fields =3D r.split()
> @@ -100,6 +105,15 @@ def crosscheck_remote_xml(reg_map):
>              r_name =3D fields[0]
>              r_regnum =3D int(fields[6])
> =20
> +            # Some registers are "hidden" so don't have a name
> +            # although they still should have a register number
> +            if r_name =3D=3D "''":
> +                total_r_elided_regs +=3D 1

Should this also increment total_r_regs so that it doesn't trip the
warning?

Thanks,
Nick

> +                x_reg =3D get_register_by_regnum(reg_map, r_regnum)
> +                if x_reg is not None:
> +                    x_reg["hidden"] =3D True
> +                continue
> +
>              # check in the XML
>              try:
>                  x_reg =3D reg_map[r_name]
> @@ -118,14 +132,40 @@ def crosscheck_remote_xml(reg_map):
>      # registers on a 32 bit machine. Also print what is missing to
>      # help with debug.
>      if total_regs !=3D total_r_regs:
> -        print(f"xml-tdesc has ({total_regs}) registers")
> -        print(f"remote-registers has ({total_r_regs}) registers")
> +        print(f"xml-tdesc has {total_regs} registers")
> +        print(f"remote-registers has {total_r_regs} registers")
> +        print(f"of which {total_r_elided_regs} are hidden")
> =20
>          for x_key in reg_map.keys():
>              x_reg =3D reg_map[x_key]
> -            if "seen" not in x_reg:
> +            if "hidden" in x_reg:
> +                print(f"{x_reg} elided by gdb")
> +            elif "seen" not in x_reg:
>                  print(f"{x_reg} wasn't seen in remote-registers")
> =20
> +def initial_register_read(reg_map):
> +    """
> +    Do an initial read of all registers that we know gdb cares about
> +    (so ignore the elided ones).
> +    """
> +    frame =3D gdb.selected_frame()
> +
> +    for e in reg_map.values():
> +        name =3D e["name"]
> +        regnum =3D e["regnum"]
> +
> +        try:
> +            if "hidden" in e:
> +                value =3D frame.read_register(regnum)
> +                e["initial"] =3D value
> +            elif "seen" in e:
> +                value =3D frame.read_register(name)
> +                e["initial"] =3D value
> +
> +        except ValueError:
> +                report(False, f"failed to read reg: {name}")
> +
> +
>  def complete_and_diff(reg_map):
>      """
>      Let the program run to (almost) completion and then iterate
> @@ -144,18 +184,19 @@ def complete_and_diff(reg_map):
>      changed =3D 0
> =20
>      for e in reg_map.values():
> -        name =3D e["name"]
> -        old_val =3D e["initial"]
> +        if "initial" in e and "hidden" not in e:
> +            name =3D e["name"]
> +            old_val =3D e["initial"]
> =20
> -        try:
> -            new_val =3D frame.read_register(name)
> -        except:
> -            report(False, f"failed to read {name} at end of run")
> -            continue
> +            try:
> +                new_val =3D frame.read_register(name)
> +            except ValueError:
> +                report(False, f"failed to read {name} at end of run")
> +                continue
> =20
> -        if new_val !=3D old_val:
> -            print(f"{name} changes from {old_val} to {new_val}")
> -            changed +=3D 1
> +            if new_val !=3D old_val:
> +                print(f"{name} changes from {old_val} to {new_val}")
> +                changed +=3D 1
> =20
>      # as long as something changed we can be confident its working
>      report(changed > 0, f"{changed} registers were changed")
> @@ -168,6 +209,7 @@ def run_test():
> =20
>      if reg_map is not None:
>          crosscheck_remote_xml(reg_map)
> +        initial_register_read(reg_map)
>          complete_and_diff(reg_map)
> =20
> =20
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.t=
arget
> index 1d08076756..5721c159f2 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -38,11 +38,4 @@ PPC64_TESTS +=3D signal_save_restore_xer
>  PPC64_TESTS +=3D xxspltw
>  PPC64_TESTS +=3D test-aes
> =20
> -ifneq ($(GDB),)
> -# Skip for now until vsx registers sorted out
> -run-gdbstub-registers:
> -	$(call skip-test, $<, "BROKEN reading VSX registers")
> -endif
> -
> -
>  TESTS +=3D $(PPC64_TESTS)
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
> index 46544fecd4..0e670f3f8b 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -103,10 +103,6 @@ run-gdbstub-svc: hello-s390x-asm
>  		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
>  	single-stepping svc)
> =20
> -# Skip for now until vx registers sorted out
> -run-gdbstub-registers:
> -	$(call skip-test, $<, "BROKEN reading VX registers")
> -
>  EXTRA_RUNS +=3D run-gdbstub-signals-s390x run-gdbstub-svc
>  endif
> =20


