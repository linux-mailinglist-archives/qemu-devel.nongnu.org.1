Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667676551F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0h8-0001ze-JH; Thu, 27 Jul 2023 09:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP0h5-0001yx-UM
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:06:15 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP0h2-0004tM-JK
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:06:14 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so1654875e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690463170; x=1691067970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8qyDSDkajXCyk30Z5QuWV36IT8LpvE+bjKqjFlBeTjA=;
 b=mATEbYpHuxnPnoXPapVur4nX2fJ9+4TD3FKmV/IYg3t9+hGg4FXvaOPU9mfSBHjPIq
 OjdPDFo07WAj5D41NBKEnyJX07c3U9UicPRimHHSpaWQ6WpjIrl1DEEktH0mgmNaQZqB
 KyJT48t6BEo/kPo89n20WeOXHJWOu5iLN7n3QAa22OR8WrCGSpMGv1mDqhGaQZ7UV1B4
 6ALlBUymiyjdSvB1qOtbYBALnXbbQhBay1BFTWQtM0XjrZrYZCFFVYnzA2nUDpFiG7Qa
 01yRdHTan25N3pcXq7c257POwRRI4WfYct53v7iuz5L28lfq1ctESTCS6LFFoFduzJJh
 KzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690463170; x=1691067970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qyDSDkajXCyk30Z5QuWV36IT8LpvE+bjKqjFlBeTjA=;
 b=F47sgFJ4KirrkwGQkxvLf3njBKW7RgGR4TVdWTNArIX/Q7y26rWJIfkB4AYD3I8jR3
 fNvalu0YQP+t/gFVCGyPvefmXOsouH6HZ7SgSs+QHKigO+rLaz+P1KS6PiJhdPkCAzLf
 duoHHE8gSCoHN3nPRU1zu81OPVJmn4WCra/pk8t1iW7+kzHZSTxRqXgnuBjMq799kQ40
 EzjvFQdjGDz1k/pzZSAV3d6Ba6DRzH4nci2pNFwoafnQxKLZnMJrUc4ubZITgySJMSRE
 X0kENyfRabmzZJDfWUB4gLCmGUMIO+uZc0A1+xcQ191wRPAUH3UhFqDgqaFd7usFqCBx
 P46A==
X-Gm-Message-State: ABy/qLaRGI5l2al8NeCY3qGJBZkTCxry33+h/GrU8bVTOT6uyxTlQbGC
 kKiquUWSyZu8JfI7tEvaJin1U1iaFyUE5H1HXwsxpg==
X-Google-Smtp-Source: APBJJlHUaCYQ0o91/wHoHjaEhDSCQ5SeJc+b0A6vG2UAXHZ6JaKmvJWegHrT+p+P0MZu07Va3/WpxFK6J1goSo/9MBU=
X-Received: by 2002:a05:6512:2386:b0:4fb:821e:2241 with SMTP id
 c6-20020a056512238600b004fb821e2241mr2358984lfv.23.1690463170267; Thu, 27 Jul
 2023 06:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230725180337.2937292-1-jsnow@redhat.com>
In-Reply-To: <20230725180337.2937292-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 14:05:59 +0100
Message-ID: <CAFEAcA8hGsXsfLECdRwe7u=DRtK6LE2twT3HaF7w_T2-SNYwgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] python/machine: use socketpair() for console socket
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Tue, 25 Jul 2023 at 19:04, John Snow <jsnow@redhat.com> wrote:
>
> Like we did for the QMP socket, use socketpair() for the console socket
> so that hopefully there isn't a race condition during early boot where
> data might get dropped on the floor.
>
> May or may not help with various race conditions where early console
> output is not showing up in the logs and/or potentially being missed by
> wait_for_console_pattern.
>

This seems to improve the test I was having trouble with on s390
(machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware)

However it still fails sometimes, apparently we get the first line
of output from the guest but lose a couple of subsequent lines.
Here's a failing log:

2023-07-27 12:55:29,870 protocol         L0481 DEBUG| Transitioning
from 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
2023-07-27 12:55:29,930 __init__         L0153 DEBUG| NOTICE:  Booting
Trusted Firmware
2023-07-27 12:55:29,955 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL2
2023-07-27 12:55:29,955 __init__         L0153 DEBUG| NOTICE:  BL2:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-27 12:55:29,955 __init__         L0153 DEBUG| NOTICE:  BL2:
Built : 16:44:16, May 30 2023
2023-07-27 12:55:30,092 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL31
2023-07-27 12:55:30,092 __init__         L0153 DEBUG| NOTICE:  BL31:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-27 12:55:30,092 __init__         L0153 DEBUG| NOTICE:  BL31:
Built : 16:44:16, May 30 2023
2023-07-27 12:55:30,092 __init__         L0153 DEBUG| UEFI firmware
(version 1.0 built at 17:14:57 on Mar 21 2023)
2023-07-27 12:55:45,281 __init__         L0153 DEBUG|
ESC[2JESC[04DESC[=3hESC[2JESC[09DESC[2JESC[04DESC[0mESC[30mESC[40m
2023-07-27 12:55:45,538 __init__         L0153 DEBUG|
ESC[01;01HESC[0mESC[34mESC[47m
2023-07-27 12:55:45,642 __init__         L0153 DEBUG|
ESC[01;01HESC[02;02HQEMU SBSA-REF MachineESC[03;02Harm-virtESC[44C2.00
GHzESC[04;02H1.0ESC[49C1024 MB
RAMESC[05;02HESC[52CESC[06;02HESC[52CESC[0mESC[37mESC[40mESC[21;01H
2023-07-27 12:55:45,840 __init__         L0153 DEBUG|
ESC[21;01HESC[0mESC[30mESC[40mESC[25;53H  ESC[01D  ESC[01D  ESC[01D
ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D
 ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D  ESC[01D
ESC[01D  ESC[01D  ESC[0mESC[30mESC[47mESC[07;01H
2023-07-27 12:55:45,926 __init__         L0153 DEBUG| ESC[07;01H
2023-07-27 12:55:46,032 __init__         L0153 DEBUG|
ESC[0mESC[37mESC[40mESC[30C<Standard English>ESC[0mESC[30mESC[47m
   ESC[57D   Select Language            ESC[0mESC[34mESC[47mESC[09;01H

ESC[0mESC[30mESC[47mESC[10;01H   ESC[02D>ESC[01CDevice Manager
                               ESC[11;01H   ESC[02D>ESC[01CBoot
Manager                                          ESC[12;01H
ESC[02D>ESC[01CBoot Maintenance Manager
ESC[0mESC[34mESC[47mESC[13;01H
                ESC[0mESC[30mESC[47mESC[14;01H   Continue
                                ESC[15;01H   Reset
                            ESC[16;01H
                        ESC[17;01H
                    ESC[18;01H
                ESC[19;01H
            ESC[20;01H
2023-07-27 12:55:46,067 __init__         L0153 DEBUG|
ESC[0mESC[37mESC[40mESC[23;02H ESC[22;02H ESC[50C
   ESC[51D                          ESC[23;53H
  ESC[77D^v=Move Highlight       ESC[22;03H
ESC[23;27H<Enter>=Select Entry      ESC[0mESC[34mESC[47mESC[08;58HThis
is the option
2023-07-27 12:55:46,076 __init__         L0153 DEBUG| ESC[57Cone
adjusts to change
2023-07-27 12:55:46,076 __init__         L0153 DEBUG| ESC[57Cthe
language for the
2023-07-27 12:55:46,080 __init__         L0153 DEBUG| ESC[57Ccurrent system
2023-07-27 12:55:46,085 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,085 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,087 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,090 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,094 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,094 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,100 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:55:46,101 __init__         L0153 DEBUG| ESC[57C
2023-07-27 12:58:25,379 stacktrace       L0039 ERROR|
2023-07-27 12:58:25,380 stacktrace       L0041 ERROR| Reproduced
traceback from:
/home/linux1/qemu/build/aarch64/tests/venv/lib/python3.8/site-packages/avocado/core/test.py:770
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR| Traceback (most
recent call last):
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/venv/lib/python3.8/site-packages/avocado/core/decorators.py",
line 90, in wrapper
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|     return
function(obj, *args, **kwargs)
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/machine_aarch64_sbsaref.py",
line 96, in test_sbsaref_edk2_firmware
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|
wait_for_console_pattern(self, "BL1: v2.9(release):v2.9")
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/avocado_qemu/__init__.py",
line 199, in wait_for_console_pattern
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|
_console_interaction(test, success_message, failure_message, None,
vm=vm)
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/avocado_qemu/__init__.py",
line 148, in _console_interaction
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|     msg =
console.readline().decode().strip()
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/usr/lib/python3.8/socket.py", line 669, in readinto
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|     return
self._sock.recv_into(b)
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/venv/lib/python3.8/site-packages/avocado/plugins/runner.py",
line 77, in sigterm_handler
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR|     raise
RuntimeError("Test interrupted by SIGTERM")
2023-07-27 12:58:25,381 stacktrace       L0045 ERROR| RuntimeError:
Test interrupted by SIGTERM

Compared to the output logs for a passing run, you can see that
although we captured the first line of output from the guest
("Booting Trusted Firmware") we missed lines 2 and 3 (the
BL1 version line and the BL1 Built: line).

2023-07-27 12:54:07,676 protocol         L0481 DEBUG| Transitioning
from 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
2023-07-27 12:54:07,690 __init__         L0153 DEBUG| NOTICE:  Booting
Trusted Firmware
2023-07-27 12:54:07,691 __init__         L0153 DEBUG| NOTICE:  BL1:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-27 12:54:07,691 __init__         L0153 DEBUG| BL1: Built :
16:44:16, May 30 2023
2023-07-27 12:54:07,754 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL2
2023-07-27 12:54:07,828 __init__         L0153 DEBUG| NOTICE:  BL2:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-27 12:54:07,828 __init__         L0153 DEBUG| NOTICE:  BL2:
Built : 16:44:16, May 30 2023
2023-07-27 12:54:07,855 __init__         L0153 DEBUG| NOTICE:  BL1: Booting BL31
2023-07-27 12:54:07,877 __init__         L0153 DEBUG| NOTICE:  BL31:
v2.9(release):v2.9.0-51-gc0d8ee386
2023-07-27 12:54:07,883 __init__         L0153 DEBUG| NOTICE:  BL31:
Built : 16:44:16, May 30 2023
2023-07-27 12:54:07,891 __init__         L0153 DEBUG| UEFI firmware
(version 1.0 built at 17:14:57 on Mar 21 2023)
2023-07-27 12:54:18,354 __init__         L0153 DEBUG|
ESC[2JESC[04DESC[=3hESC[2JESC[09DESC[2JESC[04DESC[0mESC[30mESC[40m
2023-07-27 12:54:18,539 __init__         L0153 DEBUG|
ESC[01;01HESC[0mESC[34mESC[47m
2023-07-27 12:54:18,631 __init__         L0153 DEBUG|
ESC[01;01HESC[02;02HQEMU SBSA-REF MachineESC[03;02Harm-virtESC[44C2.00
GHzESC[04;02H1.0ESC[49C1024 MB
RAMESC[05;02HESC[52CESC[06;02HESC[52CESC[0mESC[37mESC[40mESC[21;01H
2023-07-27 12:54:18,639 machine          L0627 DEBUG| Shutting down VM
appliance; timeout=30
2023-07-27 12:54:18,639 machine          L0551 DEBUG| Attempting
graceful termination
2023-07-27 12:54:18,639 machine          L0518 DEBUG| Closing console socket
2023-07-27 12:54:18,640 machine          L0561 DEBUG| Politely asking
QEMU to terminate


thanks
-- PMM

