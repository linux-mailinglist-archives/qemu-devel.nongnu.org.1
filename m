Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2807EE393
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:00:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dpu-0000Q7-E7; Thu, 16 Nov 2023 09:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3dpr-0000PC-FD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:59:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3dpl-0000yr-W3
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:59:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso724834f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700146748; x=1700751548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ+6IBaHZ+aRXCXql29DlqNunmVix3Y409j9XYiToUc=;
 b=UCWzlnurV/CCh7QlJN8oVYCna/7POcEKspMNgIF95dbXoH6PbdmUrlGvuhWOdalwvC
 XsH1JZLXHbWb7lK24k53/VbJC/GfrXiiTX3zpZfuC+UbWY0a1f34uPcg2faS4FcA1us3
 rrlDYSdisH8Ys5RROCnJQthQ9ZPksIacczReeudwRTRGrsLXntW0GzENX6Xkkmoz9U3o
 xdYgM3NUPZbc4pUrjpPbsdowJPYVmlnk8A8M3g2FZSI4DAEkErBik6V7pD3RA623V8O4
 eIO/bZ4/DukUYcf5hgYS0VsHhY8Cxkla+EKb2eOzrnpn+iBDTFWkqMDJzbNc92iGa+H+
 s+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700146748; x=1700751548;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJ+6IBaHZ+aRXCXql29DlqNunmVix3Y409j9XYiToUc=;
 b=fqt4Zqo4R+xQh/Uq86WPs2L4nRYzXQHNEe32WXberX+TdrDdNTM+ckuyN5E6SZfiFy
 ViN9wjGOb0aaNBPhMu4QZQ50epkOQaJ6dyfytjOoRA4BVTB5ge2xWaF88U6OsjhJcSxq
 gG+t30X3bli/4Tbzn8x/eXpKhADZyargwokpZ5j2ZoUnNu7Ztf7XOUykpfk3L16FFWkz
 vOfxMG9qS68jeAKOa27Cfr+RPonC2IePFHoioP1zPo9xEel5AmG6QnDM2A99AQ5dVIbE
 R7zWt423kKYP9iJNwyq5IDSB+iBIvbprYL4CgSkUhfYPEXfdN53bOrA8h/KYx2dJZJ1Q
 lYJQ==
X-Gm-Message-State: AOJu0YxY/6KocCBTUoWrrnU0bbiLJrpscA8We+4Q9SVdE1lBT5pRr9kW
 bnSMN82Fplz5oZ5EOrnRQNN9xA==
X-Google-Smtp-Source: AGHT+IFWbOZ67L3fHsZaX2h3woDC9+QsHBmham4z5NPbBIo9ksTlgro5keK47KxekkUr33OpuDiGeQ==
X-Received: by 2002:a05:6000:178b:b0:32f:8a08:3617 with SMTP id
 e11-20020a056000178b00b0032f8a083617mr12485762wrg.5.1700146747888; 
 Thu, 16 Nov 2023 06:59:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dk14-20020a0560000b4e00b0032179c4a46dsm13943734wrb.100.2023.11.16.06.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 06:59:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 206D35F781;
 Thu, 16 Nov 2023 14:59:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luis Machado <luis.machado@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,  qemu-devel@nongnu.org,  Akihiko
 Odaki <akihiko.odaki@daynix.com>,  Luis Machado <luis.machado@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  qemu-s390x@nongnu.org,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  qemu-ppc@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,  David Hildenbrand
 <david@redhat.com>,  "gdb@gnu.org" <gdb@gnu.org>
Subject: Re: [PULL 06/23] tests/tcg: add an explicit gdbstub register tester
In-Reply-To: <37df0557-faf0-4667-925f-fcc7deac4f52@arm.com> (Luis Machado's
 message of "Thu, 16 Nov 2023 09:56:40 +0000")
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
 <20231107142354.3151266-7-alex.bennee@linaro.org>
 <CWXN9HF4AXGM.19H4A5BU366S1@wheely> <87il62vip5.fsf@draig.linaro.org>
 <37df0557-faf0-4667-925f-fcc7deac4f52@arm.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 16 Nov 2023 14:59:07 +0000
Message-ID: <87y1exu4lg.fsf@draig.linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Luis Machado <luis.machado@arm.com> writes:

> On 11/15/23 20:56, Alex Benn=C3=A9e via Gdb wrote:
>> "Nicholas Piggin" <npiggin@gmail.com> writes:
>>
>>> On Wed Nov 8, 2023 at 12:23 AM AEST, Alex Benn=C3=A9e wrote:
>>>> We already do a couple of "info registers" for specific tests but this
>>>> is a more comprehensive multiarch test. It also has some output
>>>> helpful for debugging the gdbstub by showing which XML features are
>>>> advertised and what the underlying register numbers are.
>>>>
>>>> My initial motivation was to see if there are any duplicate register
>>>> names exposed via the gdbstub while I was reviewing the proposed
>>>> register interface for TCG plugins.
>>>>
>>>> Mismatches between the xml and remote-desc are reported for debugging
>>>> but do not fail the test.
>>>>
>>>> We also skip the tests for the following arches for now until we can
>>>> investigate and fix any issues:
>>>>
>>>>   - s390x (fails to read v0l->v15l, not seen in remote-registers)
>>>>   - ppc64 (fails to read vs0h->vs31h, not seen in remote-registers)
>>>
>>> binutils-gdb.git/gdb/rs6000-tdep.c has:
>>>
>>> static const char *
>>> rs6000_register_name (struct gdbarch *gdbarch, int regno)
>>> {
>>>   ppc_gdbarch_tdep *tdep =3D (ppc_gdbarch_tdep *) gdbarch_tdep (gdbarch=
);
>>>
>>>   /* The upper half "registers" have names in the XML description,
>>>      but we present only the low GPRs and the full 64-bit registers
>>>      to the user.  */
>>>   if (tdep->ppc_ev0_upper_regnum >=3D 0
>>>       && tdep->ppc_ev0_upper_regnum <=3D regno
>>>       && regno < tdep->ppc_ev0_upper_regnum + ppc_num_gprs)
>>>     return "";
>>>
>>>   /* Hide the upper halves of the vs0~vs31 registers.  */
>>>   if (tdep->ppc_vsr0_regnum >=3D 0
>>>       && tdep->ppc_vsr0_upper_regnum <=3D regno
>>>       && regno < tdep->ppc_vsr0_upper_regnum + ppc_num_gprs)
>>>     return "";
>>>
>>> (s390 looks similar for V0-V15 lower).
>>>
>>> I guess it is because the upper half is not a real register but an
>>> extension of an existing FP register to make a vector register. I
>>> just don't know how that should be resolved with QEMU.
>>>
>>> Should we put an exception in the test case for these? Or is there
>>> something we should be doing differently with the XML regs?
>>
>> Yeah I suspect this is just inconsistency between targets on gdb. My
>> naive assumption was XML should match the displayed registers but it
>> seems there is additional filtering going on.
>>
>> It seems in this case the registers are still there and have regnums (so
>> I assume the stub could be asked for them) but the names have been
>> squashed. I guess we could detect that and accept it?
>>
>>>
>>> i386 gdb does similar:
>>>
>>> static const char *
>>> i386_register_name (struct gdbarch *gdbarch, int regnum)
>>> {
>>>   /* Hide the upper YMM registers.  */
>>>   if (i386_ymmh_regnum_p (gdbarch, regnum))
>>>     return "";
>>>
>>>   /* Hide the upper YMM16-31 registers.  */
>>>   if (i386_ymmh_avx512_regnum_p (gdbarch, regnum))
>>>     return "";
>>>
>>>   /* Hide the upper ZMM registers.  */
>>>   if (i386_zmmh_regnum_p (gdbarch, regnum))
>>>     return "";
>>>
>>>   return tdesc_register_name (gdbarch, regnum);
>>> }
>>>
>>> So, I'm not sure how they don't fail this test. Does QEMU just
>>> not have YMM/ZMM in XML regmap?
>>
>> No I think we only send the core one with XMM regs and there are no
>> additional registers sent via gdb_register_coprocessor.
>>
>>>
>>> Thanks,
>>> Nick
>
> FTR, luis.machado@linaro.org doesn't exist anymore.
>
> As for the XML, it serves as an architecture hint/description of what fea=
tures and registers
> are available.
>
> GDB will process that and will potentially include additional pseudo-regi=
sters (so QEMU doesn't
> need to do so, unless it is some pseudo-register not accounted by gdb).
>
> The rest of the features/registers gdb doesn't care about, it will just a=
dd them to the end of the
> list, and will assign whatever number is next. GDB will be able to read/w=
rite them, but nothing more
> than that.

So with a bit of fiddling I can do:

modified   tests/tcg/multiarch/gdbstub/registers.py
@@ -44,7 +44,6 @@ def fetch_xml_regmap():
=20
     total_regs =3D 0
     reg_map =3D {}
-    frame =3D gdb.selected_frame()
=20
     tree =3D ET.fromstring(xml)
     for f in tree.findall("feature"):
@@ -61,12 +60,8 @@ def fetch_xml_regmap():
         for r in regs:
             name =3D r.attrib["name"]
             regnum =3D int(r.attrib["regnum"])
-            try:
-                value =3D frame.read_register(name)
-            except ValueError:
-                report(False, f"failed to read reg: {name}")
=20
-            entry =3D { "name": name, "initial": value, "regnum": regnum }
+            entry =3D { "name": name, "regnum": regnum }
=20
             if name in reg_map:
                 report(False, f"duplicate register {entry} vs {reg_map[nam=
e]}")
@@ -80,6 +75,15 @@ def fetch_xml_regmap():
=20
     return reg_map
=20
+def get_register_by_regnum(reg_map, regnum):
+    """
+    Helper to find a register from the map via its XML regnum
+    """
+    for regname, entry in reg_map.items():
+        if entry['regnum'] =3D=3D regnum:
+            return entry
+    return None
+
 def crosscheck_remote_xml(reg_map):
     """
     Cross-check the list of remote-registers with the XML info.
@@ -90,6 +94,7 @@ def crosscheck_remote_xml(reg_map):
=20
     total_regs =3D len(reg_map.keys())
     total_r_regs =3D 0
+    total_r_elided_regs =3D 0
=20
     for r in r_regs:
         fields =3D r.split()
@@ -100,6 +105,15 @@ def crosscheck_remote_xml(reg_map):
             r_name =3D fields[0]
             r_regnum =3D int(fields[6])
=20
+            # Some registers are "hidden" so don't have a name
+            # although they still should have a register number
+            if r_name =3D=3D "''":
+                total_r_elided_regs +=3D 1
+                x_reg =3D get_register_by_regnum(reg_map, r_regnum)
+                if x_reg is not None:
+                    x_reg["hidden"] =3D True
+                continue
+
             # check in the XML
             try:
                 x_reg =3D reg_map[r_name]
@@ -118,13 +132,38 @@ def crosscheck_remote_xml(reg_map):
     # registers on a 32 bit machine. Also print what is missing to
     # help with debug.
     if total_regs !=3D total_r_regs:
-        print(f"xml-tdesc has ({total_regs}) registers")
-        print(f"remote-registers has ({total_r_regs}) registers")
+        print(f"xml-tdesc has {total_regs} registers")
+        print(f"remote-registers has {total_r_regs} registers")
+        print(f"of which {total_r_elided_regs} are hidden")
=20
         for x_key in reg_map.keys():
             x_reg =3D reg_map[x_key]
-            if "seen" not in x_reg:
-                print(f"{x_reg} wasn't seen in remote-registers")
+            if "hidden" in x_reg:
+                print(f"{x_reg} elided by gdb")
+            elif "seen" not in x_reg:
+                report(False, f"{x_reg} wasn't seen in remote-registers")
+
+def initial_register_read(reg_map):
+    """
+    Do an initial read of all registers that we know gdb cares about
+    (so ignore the elided ones).
+    """
+    frame =3D gdb.selected_frame()
+
+    for e in reg_map.values():
+        name =3D e["name"]
+        regnum =3D e["regnum"]
+
+        try:
+            if "hidden" in e:
+                value =3D frame.read_register(regnum)
+            else:
+                value =3D frame.read_register(name)
+
+            e["initial"] =3D value
+        except ValueError:
+                report(False, f"failed to read reg: {name}")
+
=20
 def complete_and_diff(reg_map):
     """
@@ -144,18 +183,19 @@ def complete_and_diff(reg_map):
     changed =3D 0
=20
     for e in reg_map.values():
-        name =3D e["name"]
-        old_val =3D e["initial"]
+        if "hidden" not in e:
+            name =3D e["name"]
+            old_val =3D e["initial"]
=20
-        try:
-            new_val =3D frame.read_register(name)
-        except:
-            report(False, f"failed to read {name} at end of run")
-            continue
+            try:
+                new_val =3D frame.read_register(name)
+            except ValueError:
+                report(False, f"failed to read {name} at end of run")
+                continue
=20
-        if new_val !=3D old_val:
-            print(f"{name} changes from {old_val} to {new_val}")
-            changed +=3D 1
+            if new_val !=3D old_val:
+                print(f"{name} changes from {old_val} to {new_val}")
+                changed +=3D 1
=20
     # as long as something changed we can be confident its working
     report(changed > 0, f"{changed} registers were changed")
@@ -168,6 +208,7 @@ def run_test():
=20
     if reg_map is not None:
         crosscheck_remote_xml(reg_map)
+        initial_register_read(reg_map)
         complete_and_diff(reg_map)

I'll wrap that into my next set of patches.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

