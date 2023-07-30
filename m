Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD476880B
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 22:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQDAx-0006cP-6R; Sun, 30 Jul 2023 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQDAv-0006cH-9H
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 16:38:01 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQDAt-0004Mr-CR
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 16:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749476; x=1691354276; i=deller@gmx.de;
 bh=V4qQg+rlOj8GWAESp0aa6+NEISv+GRu2S/ZMCU7dqFw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jcCDXtum1DxwMj2+Jkn6I9lczSGoHdqE6Qpl1be3vDo9N32ZJ+yWnatWNRFpsPHN7ohYDfq
 3JP7SkA3m6w/vIRhyKftdEA6CqrG2S3z8GvP2EhE+N3iWtc1XhS+aK67kGP3W4uF3T3KOfN7v
 aS0vrqzAQ/aQv4EFgv2ISWMdbmhtRYGJMDhN9q6rg9mlQ3OKidPD6GHAX/KqC80/jzenYv5gI
 Pj5pzTJSB45KC3coN98DziC237J6nPnLggIFsC6v5ZWmHs3iSWX5yj8K77LoyE3knbNhZNNB9
 fhY4YlHxf1tr2wKHvV4Dyaf/VkJjaT2GHaERCF6805tfdpOIYE6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1ppmUa1NHI-00aV6U; Sun, 30
 Jul 2023 22:37:56 +0200
Message-ID: <2c178363-b1a3-1192-09ac-2bbfa7ae7672@gmx.de>
Date: Sun, 30 Jul 2023 22:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user
 in translator_use_goto_tb()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <ZMakYpOgco2Ihg0G@p100>
 <b0ff6b75-60c9-aa3e-e701-a4062558a9bf@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <b0ff6b75-60c9-aa3e-e701-a4062558a9bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6yCMDsrqpQni1Hmn0kiIqACCKsG1/U2xi7DYSQDjYiV6Yq6h0yv
 WHUQGUDtAVe1fBx/Smq9VZj0xYNDIDKKswHuJPYwjvfTjOOJuaut7QWlEUVwt65CFKb8nCv
 IAoG+hw/2QOk+fRSHlUjiO+qerWp21MMXDBZFWk02YZ3zthMVhVctGAe8fAr/4Cxj9x3ryP
 VH9sZ6jkJ+roMv0rDXXcw==
UI-OutboundReport: notjunk:1;M01:P0:7Mus97HbWsU=;6cuQt9Ln0xqmEdbJRrso1Uz9ULj
 otq+OYcIHRNDf+/vpgE7dWIOdtmsTBod4CfmPcbF6ATgUcVHKrlA9eAfLP/VNoYHmU3W5ucWA
 mt1gS0vp1tlHjRD/wv4wKVyTY5J24uXHvA2vRBiNxiCl8qhEf8mc+xpzOVjN7z4hQI/h/n7oO
 e3xtjvyI7vEZ1HoKIsa4HHcGJdsJCpwxWNlgTpFVeUo2MhJpm/Z6BhZ2oKTD5YiJ1S52NWcul
 olB8BuAJjmz8whu3hqsxCxwzsEB1E8nfHYOeo03GKiZ/o1qG+wA3TauDN61suNhj/+q8zqc0x
 v4hVtyAUOkFdyRxEU2U3WFkKsItHKTpfuRQnKPDKpQh+thiNQQj9+Re7IU5viJ4k53i1J8cIL
 Zt0sI/lhQ+X3rQQbdIi/ET+JoFMW4UzrZ8bUJAAkOmWBfpBjCl6IjVJtD+58ewfumjzAexn2g
 t76780axFQgVfOaV+Xj+5uflF8i7aqmEboaCQvu/HsVii5DYVuQo61PxlOlekI+AjVGX8/vyQ
 sPagW2ilrOao037wR7mAj/g8MSSf8m/Q7wnUXgIa4rybO+PIXva9w/hzbrlUMimaY1DZa2h7k
 fBl7MDFfK1I9MXdxnChzlZjXXU3tDPN/NQBbyV9ZU7l3GVCd7GEUUG+u6xFriEdlq03P/nNSs
 2P6nlkhlWGuQnTXfC7KWAkCpEI8GrjE1IJlPI+FdFdA+KrttpfVmA3eE5IMIJA462bc21sN2i
 Z+F61NelXIx9DCDW0dgKVReGRvjUxsoBKlFB+BLG65A9Ka54qjC0BK4i+xl2HG5e301XB3piH
 NSIU5WeyhCTM6Req2vWODL0d7h3MRzdHNVlaidAsrg02S/2Y4ZYU34zY1ol/bis6fpsTVgIa5
 S2I8Zo6qbL3Zan+3+mhe3+QtGPdBs5pn93QJNFZu9WLHB9BNM7iSEZI9gsXou2p3J0LbGSQc/
 mrGzXA==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/30/23 22:03, Richard Henderson wrote:
> On 7/30/23 10:56, Helge Deller wrote:
>> I'm quite unclear about translator_use_goto_tb() for qemu-user
>> emulation....(and in general).
>>
>> Based on the function name, the function translator_use_goto_tb() shall
>> help to decide if a program should use goto_tb() and exit_tb() to jump
>> to the next instruction.
>>
>> Currently, if the destination is on the same page, it returns true.
>> I wonder, if it shouldn't return false in this case instead, because
>> arches have code like this: (taken from target/hppa/translate.c):
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (... && translator_use_goto_tb(ctx, f)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_goto_tb(which)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_movi_reg(cpu_i=
aoq_f, f);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_movi_reg(cpu_i=
aoq_b, b);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_exit_tb(ctx->b=
ase.tb, which);
>> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_iaoq_entry(cpu_ia=
oq_f, f, cpu_iaoq_b);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_iaoq_entry(cpu_ia=
oq_b, b, ctx->iaoq_n_var);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_lookup_and_got=
o_ptr();
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Shouldn't, if the destination is on the same page, the (faster?)
>> path with tcg_gen_lookup_and_goto_ptr() be taken instead?
>
> No, because tcg_gen_lookup_and_goto_ptr is not the faster path.
> That always involves a lookup, then an indirect branch.

Ah, ok. So my assumption was wrong, and this explains it.

> The goto_tb path is linked, so only requires a lookup once, and the
> branch may be direct (depending on the host architecture).
Probably the last question in this regard:

This code:
IN:
0x00010c98:  cmpib,<>,n 0,r19,0x10c98

generates "nop/jmp" in the code:

the tcg_gen_goto_tb() branch:
OUT:
0x7fd7e400070e:  85 db                    testl    %ebx, %ebx
0x7fd7e4000710:  0f 85 20 00 00 00        jne      0x7fd7e4000736
0x7fd7e4000716:  90                       nop				<- from "tcg_gen_op1i(IND=
EX_op_goto_tb, idx)" in tcg_gen_goto_tb()
0x7fd7e4000717:  e9 00 00 00 00           jmp      0x7fd7e400071c	<- jump =
is effective useless.
0x7fd7e400071c:  c7 45 00 a3 0c 01 00     movl     $0x10ca3, (%rbp)
0x7fd7e4000723:  c7 45 04 a7 0c 01 00     movl     $0x10ca7, 4(%rbp)
0x7fd7e400072a:  48 8d 05 0f ff ff ff     leaq     -0xf1(%rip), %rax
0x7fd7e4000731:  e9 e2 f8 ff ff           jmp      0x7fd7e4000018
0x7fd7e4000736:  90                       nop				<- here too.
0x7fd7e4000737:  e9 00 00 00 00           jmp      0x7fd7e400073c
0x7fd7e400073c:  c7 45 00 9f 0c 01 00     movl     $0x10c9f, (%rbp)
0x7fd7e4000743:  c7 45 04 9b 0c 01 00     movl     $0x10c9b, 4(%rbp)
0x7fd7e400074a:  48 8d 05 f0 fe ff ff     leaq     -0x110(%rip), %rax
0x7fd7e4000751:  e9 c2 f8 ff ff           jmp      0x7fd7e4000018

I assume those nops/jmp+0 is to be able to insert breakpoints?

But those nops/jmps are never in the tcg_gen_lookup_and_goto_ptr() branch,
probably because breakpoints are checked in HELPER(lookup_tb_ptr), right?

0x7ff47c0006d0:  0f 85 18 00 00 00        jne      0x7ff47c0006ee
0x7ff47c0006d6:  c7 45 00 a3 0c 01 00     movl     $0x10ca3, (%rbp)
0x7ff47c0006dd:  c7 45 04 a7 0c 01 00     movl     $0x10ca7, 4(%rbp)
0x7ff47c0006e4:  48 8b fd                 movq     %rbp, %rdi
0x7ff47c0006e7:  e8 34 bf 42 0f           callq    0x7ff48b42c620
0x7ff47c0006ec:  ff e0                    jmpq     *%rax
0x7ff47c0006ee:  c7 45 00 9f 0c 01 00     movl     $0x10c9f, (%rbp)
0x7ff47c0006f5:  c7 45 04 9b 0c 01 00     movl     $0x10c9b, 4(%rbp)
0x7ff47c0006fc:  48 8b fd                 movq     %rbp, %rdi
0x7ff47c0006ff:  e8 1c bf 42 0f           callq    0x7ff48b42c620
0x7ff47c000704:  ff e0                    jmpq     *%rax

Question:
Couldn't those nops be avoided in the tcg_gen_goto_tb() branch too, e.g.
if breakpoints are checked when returning through the prologue exit path?

Thanks!
Helge

