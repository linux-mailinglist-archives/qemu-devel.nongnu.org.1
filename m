Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82007C7856
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 23:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr2py-0003Tp-TW; Thu, 12 Oct 2023 17:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qr2pu-0003Qq-Dk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 17:03:14 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qr2pr-0008Tp-W8
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 17:03:14 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a5d26511f7so44486739f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697144590; x=1697749390;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VL8aKH5KAl8+bvrZEeSOSsgD1t6VL+9AG3AxbOMOOik=;
 b=fikq/pNTxHk/20SEIIxD5FUyAR7p3u3rO0sK3o70fu3b6WunZALM/kX2YjvJj6W7QV
 VSa07474tUU9FSWExRqCvhkZ9o4QFfMjOD38n/bM5vxD8s1Uojg1AznhgjSLq04WPFvs
 sWhmZuTHQOaFZsfrE7W4UOgwPPuNs7xZPLACwJMHMFkkdcmRiMacVuCM+nKsrncdzEEe
 1iAiM6LAe3o9bYa6ov20XdAVTBhB3OT2U+9t4qABZlCC2NLj61veprvL3is6FCSZTbsp
 MYW4SGN4SrO6LUPP/1XoUITkvHsQ59X4/g1vygYqIxCYgmmPOlRhDBOYttX9k2OaWnkO
 s4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144590; x=1697749390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VL8aKH5KAl8+bvrZEeSOSsgD1t6VL+9AG3AxbOMOOik=;
 b=U7IIsqs4ae1ywl0XpPuRanhI46b+/WJ3uJ59RjQ0DjqrHpnrDxQQmhgyYP2/EJjUWP
 jKM1cxUYFDWPJNUfjsekOFKHC5gSLnnnj/iL5GFmedvt0JYnM0kgfYzQseL+zzJIJX1N
 CRLHKZJukWYnb2qBuBHsZ2OQbah0F7OSOFq/2dW8CW33Nb22U56HPEDFf8i1FpMNGs7k
 ofi67hK0SilQ7vTgaEkdCXahNTef8hk1qUdGyUUgAprgMQn/c3I1IH4Ue2LT176RufPE
 AlL/O/lEbendCJgRVE8+JXqPJtoDtp2quFgzkmIM5ryTdk93SqD2oQ3souQEmLX3Z25t
 380A==
X-Gm-Message-State: AOJu0YwnxXYOo1MQwgUirNOBbnfYQwJY9ryfET+bJfn0Rc9iUmmFWTi8
 KjErrkuaS7edzObc5Ar38d9CWNSQC/FPawEBRUOjUQ==
X-Google-Smtp-Source: AGHT+IEqKCJ3Q3b3P/TpyHj03Le8s5aozY2I3z/fInnmJEq2Cje1cebUFUnfpX2AyKVRUT1BeWaQoQ==
X-Received: by 2002:a5d:9cd5:0:b0:79f:d4e6:5175 with SMTP id
 w21-20020a5d9cd5000000b0079fd4e65175mr28516775iow.16.1697144590533; 
 Thu, 12 Oct 2023 14:03:10 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a9-20020aa780c9000000b0069266a66a6esm12098425pfn.139.2023.10.12.14.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 14:03:10 -0700 (PDT)
Message-ID: <77f9ccb8-fb00-470b-b010-6c8a0dfaf99d@daynix.com>
Date: Fri, 13 Oct 2023 06:03:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/tcg: add an explicit gdbstub register tester
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231012170426.1335442-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231012170426.1335442-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/13 2:04, Alex Bennée wrote:
> We already do a couple of "info registers" for specific tests but this
> is a more comprehensive multiarch test. It also has some output
> helpful for debugging the gdbstub by showing which XML features are
> advertised and what the underlying register numbers are.
> 
> My initial motivation was to see if there are any duplicate register
> names exposed via the gdbstub while I was reviewing the proposed
> register interface for TCG plugins.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>

I have some comments for some implementation details, but the intention 
sounds good to me.

> ---
>   tests/tcg/multiarch/Makefile.target           |  10 +-
>   tests/tcg/multiarch/gdbstub/registers.py      | 173 ++++++++++++++++++
>   .../multiarch/system/Makefile.softmmu-target  |  14 +-
>   3 files changed, 195 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
> 
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index 43bddeaf21..d5e05ac343 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -95,6 +95,13 @@ run-gdbstub-thread-breakpoint: testthread
>   		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
>   	hitting a breakpoint on non-main thread)
>   
> +run-gdbstub-registers: sha512
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(HAVE_GDB_BIN) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
> +	checking register enumeration)
> +
>   else
>   run-gdbstub-%:
>   	$(call skip-test, "gdbstub test $*", "no guest arch support")
> @@ -104,7 +111,8 @@ run-gdbstub-%:
>   	$(call skip-test, "gdbstub test $*", "need working gdb")
>   endif
>   EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
> -	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
> +	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
> +	      run-gdbstub-registers
>   
>   # ARM Compatible Semi Hosting Tests
>   #
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
> new file mode 100644
> index 0000000000..7f331082cb
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -0,0 +1,173 @@
> +from __future__ import print_function

I think this and other lines are just copied from the other tests, but I 
leave some comments anyway:
This line is no longer necessary since Python 2 is already dead.

> +#
> +# Exercise the register functionality by exhaustively iterating
> +# through all supported registers on the system.
> +#
> +# This is launched via tests/guest-debug/run-test.py but you can also
> +# call it directly if using it for debugging/introspection:
> +#
> +#
> +#

Let's have SPDX-License-Identifier and remove supurious lines that only 
have #.

> +
> +import gdb
> +import sys
> +import xml.etree.ElementTree as ET
> +
> +initial_vlen = 0
> +failcount = 0
> +
> +def report(cond, msg):
> +    "Report success/fail of test."
> +    if cond:
> +        print("PASS: %s" % (msg))
> +    else:
> +        print("FAIL: %s" % (msg))
> +        global failcount
> +        failcount += 1

What about using Python's unittest?

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
> +    total_regs = 0
> +    reg_map = {}
> +    frame = gdb.selected_frame()
> +
> +    # First check the XML descriptions we have sent
> +    xml = gdb.execute("maint print xml-tdesc", False, True)
> +    tree = ET.fromstring(xml)
> +    for f in tree.findall("feature"):
> +        name = f.attrib["name"]
> +        regs = f.findall("reg")
> +
> +        total = len(regs)
> +        total_regs += total
> +        base = int(regs[0].attrib["regnum"])
> +        top = int(regs[-1].attrib["regnum"])
> +
> +        print(f"feature: {name} has {total} registers from {base} to {top}")
> +
> +        for r in regs:
> +            name = r.attrib["name"]
> +            value = frame.read_register(name).__str__()
> +            regnum = int(r.attrib["regnum"])
> +            entry = { "name": name,
> +                      "initial": value,
> +                      "regnum": regnum }
> +            try:
> +                reg_map[name] = entry
> +            except KeyError:
> +                report(False, f"duplicate register {r} vs {reg_map[name]}")

I don't think python raises KeyError for duplicate key.

> +
> +    # Validate we match
> +    report(total_regs == len(reg_map.keys()),
> +           f"counted all {total_regs} registers in XML")
> +
> +    return reg_map
> +
> +def crosscheck_remote_xml(reg_map):
> +    """
> +    Cross-check the list of remote-registers with the XML info.
> +    """
> +
> +    remote = gdb.execute("maint print remote-registers", False, True)
> +    r_regs = remote.split("\n")
> +
> +    total_regs = len(reg_map.keys())
> +    total_r_regs = 0
> +
> +    for r in r_regs:
> +        fields = r.split()
> +        # Some of the registers reported here are "pseudo" registers that
> +        # gdb invents based on actual registers so we need to filter them
> +        # out.
> +        if len(fields) == 8:
> +            r_name = fields[0]
> +            r_regnum = int(fields[1])
> +
> +            # check in the XML
> +            try:
> +                x_reg = reg_map[r_name]
> +            except KeyError:
> +                report(False, "{r_name} not in XML description")
> +                continue
> +
> +            x_regnum = x_reg["regnum"]
> +            if r_regnum != x_regnum:
> +                report(False, f"{r_name} {r_regnum} == {x_regnum} (xml)")
> +            else:
> +                total_r_regs += 1
> +
> +    report(total_regs == total_r_regs, f"xml-tdesc and remote-registers agree")
> +
> +def complete_and_diff(reg_map):
> +    """
> +    Let the program run to (almost) completion and then iterate
> +    through all the registers we know about and report which ones have
> +    changed.
> +    """
> +    # Let the program get to the end and we can check what changed
> +    gdb.Breakpoint("_exit")
> +    gdb.execute("continue")
> +
> +    frame = gdb.selected_frame()
> +    changed = 0
> +
> +    for e in reg_map.values():
> +        name = e["name"]
> +        old_val = e["initial"]
> +
> +        try:
> +            new_val = frame.read_register(name).__str__()
> +        except:
> +            report(False, f"failed to read {name} at end of run")
> +            continue
> +
> +        if new_val != old_val:
> +            print(f"{name} changes from {old_val} to {new_val}")
> +            changed += 1
> +
> +    # as long as something changed we can be confident its working
> +    report(changed > 0, f"{changed} registers were changed")
> +
> +
> +def run_test():
> +    "Run through the tests"
> +
> +    reg_map = fetch_xml_regmap()
> +
> +    crosscheck_remote_xml(reg_map)
> +
> +    complete_and_diff(reg_map)
> +
> +
> +#
> +# This runs as the script it sourced (via -x, via run-test.py)
> +#
> +try:
> +    inferior = gdb.selected_inferior()
> +    arch = inferior.architecture()
> +    print("ATTACHED: %s" % arch.name())
> +except (gdb.error, AttributeError):
> +    print("SKIPPING (not connected)", file=sys.stderr)
> +    exit(0)
> +
> +if gdb.parse_and_eval('$pc') == 0:
> +    print("SKIP: PC not set")
> +    exit(0)
> +
> +try:
> +    run_test()
> +except (gdb.error):
> +    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> +    failcount += 1
> +    pass
> +
> +print("All tests complete: %d failures" % failcount)
> +exit(failcount)
> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
> index 90810a32b2..dc97d71e42 100644
> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> @@ -27,6 +27,17 @@ run-gdbstub-memory: memory
>   		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
>   		--bin $< --test $(MULTIARCH_SRC)/gdbstub/memory.py, \
>   	softmmu gdbstub support)
> +
> +run-gdbstub-registers: memory
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(HAVE_GDB_BIN) \
> +		--qemu $(QEMU) \
> +		--output $<.registers.gdb.out \
> +		--qargs \
> +		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
> +	softmmu gdbstub support)
> +
>   run-gdbstub-interrupt: interrupt
>   	$(call run-test, $@, $(GDB_SCRIPT) \
>   		--gdb $(HAVE_GDB_BIN) \
> @@ -58,4 +69,5 @@ run-gdbstub-%:
>   	$(call skip-test, "gdbstub test $*", "need working gdb")
>   endif
>   
> -MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt run-gdbstub-untimely-packet
> +MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-registers \
> +		  run-gdbstub-interrupt run-gdbstub-untimely-packet

