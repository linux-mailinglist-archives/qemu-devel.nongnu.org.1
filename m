Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0167F715B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:25:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TMJ-0001Rd-F0; Fri, 24 Nov 2023 05:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TMH-0001RB-Bb
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:24:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TME-00072p-A4
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:24:25 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32fd7fc9f19so1064439f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700821459; x=1701426259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/VsI3U8w+a25MVcaTe0VtRw+2yocIrV80N335waQ68=;
 b=RK+FL669CwSZxhPkDW0LlWegSdfOwGuk9KNTQ+yiKnH1MU5ZRws/L9QmZ+3O3M2lOO
 c3n7znh1VFzJVmXm9MgAuCAEN5C8iVZDnxOCyJLXR9183xa6VsHiZRPMjwXZYh8hD2Mq
 rNiOZgVXcHQiTQRWOzumFTGKdE3RKx+fMe31IzhlFJhFk1EJ3vd5DzSOVJxuqMroKLyJ
 wLhxgusRCv22NW0wWN5Hl1BAvFPfbqs5G0wx2kSQu/8NGZ1eP6NAudNN0Tydzxqyowaq
 TUvbqzvqgz5EZeEGKosPaEGBqR35i/YsceLx7fM7EsvRdvgTmM09F7NRsJNAYHD8I8DM
 MOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700821459; x=1701426259;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P/VsI3U8w+a25MVcaTe0VtRw+2yocIrV80N335waQ68=;
 b=P2/oUJI9zLmyt1CJXj1HWNtBfykBQMCJPdanHFgFu9noXyVvB25+NnjSngGMx8WJc4
 r+G9E+V0y20k4NZ4HNeyVXccjULWXdwLFApl43jal1shDI8F2RsSE+Fmlor3vNkJkyRL
 Cw81MHyq5uC92w1ngnV+1m4YpEK0u39yPPewFdLZ8p4D7z/iaaxfOCBels7KS5ZRnEIA
 dQRlRbrL4tTnrC6Z9pVXsr56GBCOIRDu8TSGugo400bJ/akjwmLNTKi8QOD9MgZ9JckO
 XL/dr7444r9Rte7UxPVeRE9S4oUAHSDlHebwnzWVJr3zSjbCxknl4F922aIvlP5RN4JB
 ozhQ==
X-Gm-Message-State: AOJu0YwSmnCTG3YqsOxz3oLkCTuC/yRFkZv6zGSPG0ZR/IGBeOklismi
 Nvzhtg9DIGr/SCUOtBZG929Glg==
X-Google-Smtp-Source: AGHT+IFsNVUkFfZhNR9X3AD6U9xujj0hB2Ss/8LL6H60GlH6PvVke6JAepDZevDEkrg8hVMBNw329w==
X-Received: by 2002:a5d:4b4b:0:b0:332:c6cf:3175 with SMTP id
 w11-20020a5d4b4b000000b00332c6cf3175mr1831498wrs.29.1700821459478; 
 Fri, 24 Nov 2023 02:24:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e15-20020a056000120f00b0032da35baf7bsm3925756wrx.113.2023.11.24.02.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:24:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A69255F7AA;
 Fri, 24 Nov 2023 10:24:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Gavin
 Shan <gshan@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Evgeny Iakovlev
 <eiakovlev@linux.microsoft.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async)
 FIFO to avoid blocking the main loop
In-Reply-To: <CAFEAcA_0BfGVDZWJUPs8hwYRKS8FmzppQgY+s83qxBXHjLJvnw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 13 Nov 2023 13:11:22 +0000")
References: <20231109192814.95977-1-philmd@linaro.org>
 <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
 <4ffed8f5-6624-4488-a74f-567cbd926b78@linaro.org>
 <CAFEAcA_0BfGVDZWJUPs8hwYRKS8FmzppQgY+s83qxBXHjLJvnw@mail.gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 24 Nov 2023 10:24:18 +0000
Message-ID: <87jzq7cuul.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 Nov 2023 at 20:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>>
>> Hi Peter,
>>
>> On 9/11/23 20:29, Peter Maydell wrote:
>> > On Thu, 9 Nov 2023 at 19:28, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
>> >>
>> >> Missing review: #10
>> >>
>> >> Hi,
>> >>
>> >> This series add support for (async) FIFO on the transmit path
>> >> of the PL011 UART.
>> >
>> > Hi; what's the rationale for the "for-8.2" targeting here?
>> > What bug are we fixing?
>>
>> The bug is on Trusted Substrate when the ZynqMP machine is used:
>> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=3D149574
>
> And have we confirmed that the async FIFO support fixes that problem?
> That bug report seems to have mostly just speculation in it that
> maybe this XXX comment is why...

I've been fighting with numerous issues with the TRS build over the last
week so I can confirm I have seen a) a lock up with pl011_write blocking
everything under the BQL because data wasn't read fast enough and b) the
problem goes away with Philippe's patches. So have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

