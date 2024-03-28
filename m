Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C42887E21
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 18:21:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roRWL-0006m0-4K; Sun, 24 Mar 2024 13:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roRWJ-0006ls-8F
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:31 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roRWH-0000eZ-1J
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711300825; x=1711905625; i=deller@gmx.de;
 bh=zms4ozTXIFrA1/sgjgLztruAnNBUlY+HLeoYpvvUlr4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=nWOwLXDeXpSD22Fx1/Kcnr8ZBP0maAHfCszcbywZZ8McrIYLiLIj0c6+HV3gaIwZ
 wZ1o7gwpDCijvO1iDygpsL4BHDJH7/ardr017SCtyK6FyrjBfXW+Yf01ebqR0ytyR
 PhnGB7dEhMTKO0FUOeah7/H3m9n3D+hceRuUmfSe8UzhZht8dCsUvSUSBWU42jNJD
 ld8Mj0a53psTg1jxS2//elJRiPiTkeF9Yg7HjSFvodkFW60IaWr+pM9FJFXK/KLvV
 3Ol2+8C8/87hKZ6sL/OGEXwu1NeTusgw/yLyG59Dis/gOc1qr99zo2TRN5X4q20sp
 4KDFz23bjSjPEWAosQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1rpp653ZIr-001Ppa; Sun, 24
 Mar 2024 18:20:24 +0100
Message-ID: <4c2e6e00-70a2-4ea7-8dee-7a7ab02fd732@gmx.de>
Date: Sun, 24 Mar 2024 18:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] target/hppa: Avoid nullification for uaddcmt
 instruction
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@kernel.org>, svens@stackframe.org, qemu-devel@nongnu.org
References: <Zf9GaFSsAJ5AAzKk@p100>
 <b08eb4b1-c7c4-4248-9681-bff883495ba2@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b08eb4b1-c7c4-4248-9681-bff883495ba2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/VNGagLXYc0RyA9W1zLQX36TSwWpYmCl2GA+0rIkzswD1FY8TFr
 1TzTyVedLxDRbF8JS07BOCvXt5+jBw6oNzffWGzgDkJD/ocPcJWFSnNzv6hs4E+zrBZ983L
 TO+XOF0kPHoAfLZ/+k/qxmfKKmwKC43Bonkl42KqYEWcty5UjMulLspVhQawIp0kXBZCznD
 rHFur0DVfqQ+I9xUTbhMw==
UI-OutboundReport: notjunk:1;M01:P0:XmWctnEPq/E=;OyxxUzgeDpnUEilhW87G3q1UmD1
 kydQKdBNB7XKYxlpKmuLju0klJ0BSu1J8fU/rCM0Xby//EAPq28vn3CCf7dUSUgsq5tqCs48H
 vTEjcJFIKY2cW9AQ96LGDw3dIrGvsN9MnW2TY1MgQVtrYD100AKnIVog/3JmAr5fmrHpTo9ZA
 7SAtYGU4AcfMf0cPJSf3yePGUluWVG3kiLbFfHcSxDJRJ01vOaaWc0BpHlGouBrIvwwXMFC3y
 CfZWH+JEmkY0V07Pn1W0htxsLflBRWbnRre35keYf2seA1SB3Rng7fWsGMXI66JvLj2MwmzZf
 lQE0uS4wBRRnenAg6DZWYtbH2RA8A7ktFqdlOkjIlc4+TPrlnE42ds38sBd/ae5+kXMRimLFs
 JEzwoPkwXJafDLdCyv1fJauQLw2Yp3/zHY5bM9+0UqFeWDH+X9VBJfwkdvdnI4uHeWtFCBB0E
 gY2vtK1Y93ba0K9iHyIn7Q9DAwJyej2igUMsrUM3RF7QAHCfWwxbmsWPWO9iyvCL+chy+6Q0n
 uvo/mW8TzBTBlMtxJOqIqKEmAZ4PbO7NA6zNRa4lLq7cCSRahMqsCyhtNFv7PD+PwvqdwekUh
 AkkxZm/2bXrsYBTnwDEs9bHtEZe3u6MHcwIYXOj2QlaU1JuSJUh+8Nviz/eTk7NTQ4OsmKurW
 hxVs5emwb5+AXj9G8yP3BdXFmTAfFs926EvQjJKwmm7c8r1ahK1R33nxS7IlCg08YRT8qtAOr
 omfUlRrS68/+3TssNUUihcDvR5d5PPtl5+qXXr6fFXnLkrX+8gid86nfOduLRp53M1eZkPIjC
 dQetVIG9PU19GQI9YOauJSU1U4VWb9LQwhzaRT/83CmWE=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/24/24 18:13, Richard Henderson wrote:
> On 3/23/24 11:15, Helge Deller wrote:
>> The uaddcmt (UNIT ADD COMPLEMENT AND TRAP ON CONDITION) instruction
>> triggers a trap if the condition is true, and stores the result of the
>> addition in the target register otherwise.
>> It does not use the condition to nullify the following instruction, so
>> drop the calculated condition and do not install it as null_cond.
>
> That's not what the manual says:
>
> if (trapc =3D=3D TC && cond_satisfied)
>  =C2=A0=C2=A0=C2=A0 conditional_trap;
> else {
>  =C2=A0=C2=A0=C2=A0 GR[t] =E2=86=90 res;
>  =C2=A0=C2=A0=C2=A0 if (cond_satisfied) PSW[N] =E2=86=90 1;
> }

The above is from the 64-bit manual.
My mail was based on the info from the 32-bit manual, which says:
	res =E2=86=90 GR[r1] + =E2=88=BCGR[r2];
	if (cond_satis=EF=AC=81ed)
		conditional_trap;
	else
		GR[t] =E2=86=90 res

But basically it doesn't matter, since as you explain below,
if it traps, it won't return anyway and as such PSW[N] will
not be modified.

> We have implemented this like so:
>
> if (trapc =3D=3D TC)
>  =C2=A0=C2=A0=C2=A0 conditional_trap(cond_satisfied);
> GR[t] =E2=86=90 res;
> if (cond_satisfied) PSW[N] =E2=86=90 1;
>
> because the conditional trap step does not return if it traps.

Yes.
Thanks for review anyway!

Helge

>> This patch is not tested and as such sent as RFC.
>> I just stumbled over the apparently wrong behaviour while debugging the
>> uaddcm instruction.
>
> Under separate cover you said the condition might be computed incorrectl=
y.=C2=A0 I think that is more likely the root cause of the wrong behaviour=
.
>
>
> r~
>


