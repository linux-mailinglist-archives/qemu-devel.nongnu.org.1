Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED3824331
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:01:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOGH-00075A-Pl; Thu, 04 Jan 2024 08:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rLOGF-00074L-6W; Thu, 04 Jan 2024 08:59:51 -0500
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rLOG4-0004fL-C6; Thu, 04 Jan 2024 08:59:50 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id D676C806FD;
 Thu,  4 Jan 2024 14:59:33 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id BLs-F1S1x9_9; Thu,  4 Jan 2024 14:59:33 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 80462806F6;
 Thu,  4 Jan 2024 14:59:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 80462806F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704376773;
 bh=RT/5EEyUFXLy4aIWJ6X5RYoImRe9pDsh/pHd5qXJirI=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=JtnaZeURk6tuuZ6iKzg9VxIBTaLbcHdIm9w8UZ4aitMQ/0Uuz17QnjsIKU+tLT9ww
 0T3ikON3Tsq3kO90zDybMBN/bPe2QAjF1cDiqW+5bGlJPjLcZitr4JgNnZAKKHonAk
 egWA2ijBJk4HWhVS0RJ7DbKx5ST3UHKOHscGQ6bA=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id MORqh4gQCaDx; Thu,  4 Jan 2024 14:59:33 +0100 (CET)
Received: from [IPV6:2a01:e34:ec63:e440:de99:aaf:30a9:1726] (unknown
 [IPv6:2a01:e34:ec63:e440:de99:aaf:30a9:1726])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 39AAC8071B;
 Thu,  4 Jan 2024 14:59:33 +0100 (CET)
Content-Type: multipart/alternative;
 boundary="------------v0t6mTOmJI5ml08UknmfLzhl"
Message-ID: <2342eaa3-435b-4f21-bcd3-146733908a18@telecom-paris.fr>
Date: Thu, 4 Jan 2024 14:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] hw/misc: Implement STM32L4x5 EXTI
Content-Language: fr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
 <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
 <877ckpgrie.fsf@telecom-paris.fr>
 <b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org>
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Autocrypt: addr=samuel.tardieu@telecom-paris.fr; keydata=
 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
 0Qc4lE599nwZx5uXfjLY
In-Reply-To: <b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org>
Received-SPF: pass client-ip=2001:660:330f:2::dd;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------v0t6mTOmJI5ml08UknmfLzhl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 04/01/2024 14:40, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/1/24 14:23, Samuel Tardieu wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>
>>> This doesn't build:
>>>
>>> ../../hw/misc/stm32l4x5_exti.c:172:9: error: expected expression
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint32_t set1 =3D va=
lue & ~DIRECT_LINE_MASK1;
>>> [=E2=80=A6]
>>> I could build using:
>>> -=C2=A0=C2=A0=C2=A0 case EXTI_SWIER1:
>>> +=C2=A0=C2=A0=C2=A0 case EXTI_SWIER1: {
>>
>> Out or curiosity, which C compiler or option do you use for checking?=20
>> I have no problem building this using "./configure=20
>> --target-list=3Darm-softmmu" with GCC 12.3.0.
>
> C compiler for the host machine: clang (clang 15.0.0 "Apple clang=20
> version 15.0.0 (clang-1500.0.40.1)")
> C linker for the host machine: clang ld64 1015.7
Indeed, it looks like mixing labels, declarations and statements is a=20
GCC extension. I've switched to clang and can reproduce the failure. Than=
ks!
--------------v0t6mTOmJI5ml08UknmfLzhl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html data-lt-installed=3D"true">
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body style=3D"padding-bottom: 1px;">
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 04/01/2024 14:40, Philippe
      Mathieu-Daud=C3=A9 wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org">On
      4/1/24 14:23, Samuel Tardieu wrote:
      <br>
      <blockquote type=3D"cite">
        <br>
        Philippe Mathieu-Daud=C3=A9 <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:philmd@linaro.org">&lt;philmd@linaro.org&gt;</a> writes:
        <br>
        <br>
        <blockquote type=3D"cite">This doesn't build:
          <br>
          <br>
          ../../hw/misc/stm32l4x5_exti.c:172:9: error: expected
          expression
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint32_t set1 =
=3D value &amp; ~DIRECT_LINE_MASK1;
          <br>
          [=E2=80=A6]
          <br>
          I could build using:
          <br>
          -=C2=A0=C2=A0=C2=A0 case EXTI_SWIER1:
          <br>
          +=C2=A0=C2=A0=C2=A0 case EXTI_SWIER1: {
          <br>
        </blockquote>
        <br>
        Out or curiosity, which C compiler or option do you use for
        checking? I have no problem building this using "./configure
        --target-list=3Darm-softmmu" with GCC 12.3.0.
        <br>
      </blockquote>
      <br>
      C compiler for the host machine: clang (clang 15.0.0 "Apple clang
      version 15.0.0 (clang-1500.0.40.1)")
      <br>
      C linker for the host machine: clang ld64 1015.7
      <br>
    </blockquote>
    Indeed, it looks like mixing labels, declarations and statements is
    a GCC extension. I've switched to clang and can reproduce the
    failure. Thanks!<br>
    <div id=3D"grammalecte_menu_main_button_shadow_host"
      style=3D"width: 0px; height: 0px;"></div>
  </body>
  <lt-container></lt-container>
</html>

--------------v0t6mTOmJI5ml08UknmfLzhl--

