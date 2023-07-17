Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E238756836
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQN6-0003Hj-58; Mon, 17 Jul 2023 11:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLQN4-0003H0-Dh
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:42:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLQN2-0008MK-FR
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:42:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e48e1f6d1so6263960a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689608561; x=1692200561;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hFUDpA9e2N6LXhWjFJkLb/OKnRq1Se2Oj4JUDP8Fzzk=;
 b=SdX1Af/KhVosGVaRru6pUJRw5LWfAcLbliuJSntR403GLozHCs94NI9h6ut8WSdrmx
 MZa9N00h0h1ANSkOW0q1MQ5a0/Qn29H1q81iZ7YJ1nkhrhNn6zfVHthuRfdg3X6xURsb
 9cSH13stWPnjbPAU7Dx+UPCQMCn9FlB2h/IsNNShbdCSGheOh2ZKcW6wtD/oxYvr4HZg
 pnRVhaHRdPrNpwF8lO+InVNlet7mPYIl8uuVnV2a+//om/TrLycFtUjUHqL6qsazdNuS
 Eu9rjN61+30acADvtdahsPBHCgtEOhH2jpKFzbaioHXbM7vZOkJ76+engh16xHqEqEyz
 odpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689608561; x=1692200561;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFUDpA9e2N6LXhWjFJkLb/OKnRq1Se2Oj4JUDP8Fzzk=;
 b=JBUjt37V7ePzloDSC7CCOyNGof86hmeuO+XcO/+0yYbQq0rRGs8XXgm6TE6dkL5S26
 Au6IYtzR0Uu6DPyVirxOAGUpsg5Npazd7zW9POWkY/szCMCJaFwYEC6FjPQ4HmnnRF7o
 L9P7/XxDlN8q20C59Cz/LfozfPRp9btFF/SwjeEPcPIJej7dhVTjHqMCHFNPT59TXktJ
 S/U1x6+Gp1c4oW0RQtk6gEHn6XAipmsM2YThMXGttR4Tp7/5jsaoKVkJf+8BB2fSGvHu
 gelsMWlfzSDKckUuV0jYJsPhDbecHfHNrxYq9vuU8tskHTQJuTd+1aBOwkeoEr+bSCvZ
 Dpiw==
X-Gm-Message-State: ABy/qLYaoy2g4cRh6/bzz2eUxmnFy3FcknVBdLyz1GpAnHoz7jHRUEQg
 Wukq+qhQHY5tzIfdJWzW0IoblcAdOIaVuWk7p4ajIafWjSDrkEwB
X-Google-Smtp-Source: APBJJlHuIDj8tCjDl0D2iJ5+SDDWYxea5uo2icE5AaBe9CMa75HA77/VEpCFAmhdZyqqGbwGh16RmMOdxrYx798k43I=
X-Received: by 2002:aa7:dacc:0:b0:51e:344f:81ae with SMTP id
 x12-20020aa7dacc000000b0051e344f81aemr11842025eds.14.1689608561499; Mon, 17
 Jul 2023 08:42:41 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 16:42:30 +0100
Message-ID: <CAFEAcA-fos6Agg09mtZJDdcStpCqdnLpyW4=MQnKRkZA_Tt9Zw@mail.gmail.com>
Subject: avocado test: log shows initial chunk of terminal output is missing
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

I'm looking at an avocado test that's failing intermittently
on s390 host:
machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware

This test looks for various things on the terminal output,
and it's failing because it hasn't seen the first thing it looks
for. The avocado log seems to show that the guest has booted
past that point and has produced a later chunk of the output,
and avocado appears to have simply lost the earlier output that
the test case is trying to match on.

Does this "some of the terminal output is missing"
sound familiar as a bug we already know about ?

2023-07-17 15:16:15,461 protocol         L0481 DEBUG| Transitioning
from 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
2023-07-17 15:16:19,897 __init__         L0153 DEBUG| 3h
2023-07-17 15:16:19,929 __init__         L0153 DEBUG|
2023-07-17 15:16:19,936 __init__         L0153 DEBUG| QEMU SBSA-REF
Machinearm-virt2.00 GHz1.01024 MB RAM
2023-07-17 15:16:19,945 __init__         L0153 DEBUG|
2023-07-17 15:16:19,956 __init__         L0153 DEBUG|
2023-07-17 15:16:19,971 __init__         L0153 DEBUG| <Standard
English>            Select Language
                                    >Device Manager
                       >Boot Manager
          >Boot Maintenance Manager
                                                      Continue
                                        Reset
2023-07-17 15:16:19,974 __init__         L0153 DEBUG|
                                                               ^v=Move
Highlight                               <Enter>=Select Entry      This
is the option
2023-07-17 15:16:19,975 __init__         L0153 DEBUG| one adjusts to change
2023-07-17 15:16:19,975 __init__         L0153 DEBUG| the language for the
2023-07-17 15:16:19,975 __init__         L0153 DEBUG| current system
2023-07-17 15:16:19,976 __init__         L0153 DEBUG|
2023-07-17 15:16:19,976 __init__         L0153 DEBUG|
2023-07-17 15:16:19,976 __init__         L0153 DEBUG|
2023-07-17 15:16:19,977 __init__         L0153 DEBUG|
2023-07-17 15:16:19,977 __init__         L0153 DEBUG|
2023-07-17 15:16:19,977 __init__         L0153 DEBUG|
2023-07-17 15:16:19,978 __init__         L0153 DEBUG|
2023-07-17 15:16:19,978 __init__         L0153 DEBUG|
2023-07-17 15:19:11,248 stacktrace       L0039 ERROR|
2023-07-17 15:19:11,248 stacktrace       L0041 ERROR| Reproduced
traceback from:
/home/linux1/qemu/build/all/tests/venv/lib/python3.8/site-packages/avocado/core/test.py:770
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR| Traceback (most
recent call last):
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/all/tests/avocado/machine_aarch64_sbsaref.py",
line 95, in test_sbsaref_edk2_firmware
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|
wait_for_console_pattern(self, "Booting Trusted Firmware")
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/all/tests/avocado/avocado_qemu/__init__.py",
line 199, in wait_for_console_pattern
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|
_console_interaction(test, success_message, failure_message, None,
vm=vm)
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/all/tests/avocado/avocado_qemu/__init__.py",
line 148, in _console_interaction
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|     msg =
console.readline().decode().strip()
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|   File
"/usr/lib/python3.8/socket.py", line 669, in readinto
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|     return
self._sock.recv_into(b)
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/all/tests/venv/lib/python3.8/site-packages/avocado/plugins/runner.py",
line 77, in sigterm_handler
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR|     raise
RuntimeError("Test interrupted by SIGTERM")
2023-07-17 15:19:11,249 stacktrace       L0045 ERROR| RuntimeError:
Test interrupted by SIGTERM


You can tell data has been lost because that '3h' is part
of the trailing end of an ANSI escape sequence, I think.

Full job.log at
https://people.linaro.org/~peter.maydell/job.log

The failure is intermittent: when it works the relevant part
of the job.log looks like this:

2023-07-17 15:37:56,648 protocol         L0481 DEBUG| Transitioning
from 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
2023-07-17 15:37:56,650 __init__         L0153 DEBUG| NOTICE:  Booting
Trusted Firmware
2023-07-17 15:37:56,650 __init__         L0153 DEBUG| NOTICE:  BL1:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-17 15:37:56,650 __init__         L0153 DEBUG| NOTICE:  BL1:
Built : 16:44:16, May 30 2023
2023-07-17 15:37:56,653 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL2
2023-07-17 15:37:56,656 __init__         L0153 DEBUG| NOTICE:  BL2:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-17 15:37:56,656 __init__         L0153 DEBUG| NOTICE:  BL2:
Built : 16:44:16, May 30 2023
2023-07-17 15:37:56,667 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL31
2023-07-17 15:37:56,668 __init__         L0153 DEBUG| NOTICE:  BL31:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-17 15:37:56,668 __init__         L0153 DEBUG| NOTICE:  BL31:
Built : 16:44:16, May 30 2023
2023-07-17 15:37:56,671 __init__         L0153 DEBUG| UEFI firmware
(version 1.0 built at 17:14:57 on Mar 21 2023)
2023-07-17 15:37:57,593 __init__         L0153 DEBUG|
ESC[2JESC[04DESC[=3hESC[2JESC[09DESC[2JESC[04DESC[0mESC[30mESC[40m
2023-07-17 15:37:57,610 __init__         L0153 DEBUG|
ESC[01;01HESC[0mESC[34mESC[47m
2023-07-17 15:37:57,616 __init__         L0153 DEBUG|
ESC[01;01HESC[02;02HQEMU SBSA-REF MachineESC[03;02Harm-virtESC[44C2.00
GHzESC[04;02H1.0ESC[49C1024 MB RAM
ESC[05;02HESC[52CESC[06;02HESC[52CESC[0mESC[37mESC[40mESC[21;01H
2023-07-17 15:37:57,616 machine          L0617 DEBUG| Shutting down VM
appliance; timeout=30
2023-07-17 15:37:57,616 machine          L0541 DEBUG| Attempting
graceful termination
2023-07-17 15:37:57,616 machine          L0513 DEBUG| Closing console socket
2023-07-17 15:37:57,616 machine          L0551 DEBUG| Politely asking
QEMU to terminate

(the test is looking for some of those BL1: BL2: etc lines before it starts
looking for the "QEMU SBSA-REF Machine" text.)

thanks
-- PMM

