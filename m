Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26A758147
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLmv2-0002yw-17; Tue, 18 Jul 2023 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLmuz-0002yf-Aj
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:47:17 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLmux-0007XM-6d
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689695230; x=1690300030; i=deller@gmx.de;
 bh=kkl01ZuxQz//IYInRtet9l5v2qx5fuA/Ohk5f1LWPgg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TqLCn5e1uB8l8A5qh6gBZ9rEVvYP28aCrpMces2n74oLBfaP9X3aEeVF0AJ7OkAmGGDpHoo
 3D6SUYCkDYewbkV2t9JV0t5udaaH6SBbW2TOwbioE5GYW/Ak9Fp8Vpw9Qn2ZTPSsGVfwxpadc
 MKQ0HeAlu95rMv3x97NPs9t1oE7nXmwoCL0jemOhcHZXVYe7/qGSMLQdvZvoW6VRrTVNpfWAX
 KZFJZKNLm6wCg17VWecGfYbHO/2Taz8rsq/rRM+NpwftDtCU02gj8snTtRAFH3wNMiiE4kt70
 gQwnChKumvL3RWCm1n3B3hRtcmWq+Bs0+K7aQ46A/LV8xlvxAlwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.74]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1pvHlm2H2m-00zpVl; Tue, 18
 Jul 2023 17:47:10 +0200
Message-ID: <5c669362-cdf7-eb69-56be-1ff9074957a2@gmx.de>
Date: Tue, 18 Jul 2023 17:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] Revert "linux-user: Make sure initial brk(0) is
 page-aligned"
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Markus F . X . J . Oberhumer" <notifications@github.com>
References: <20230717213545.142598-1-deller@gmx.de>
 <20230717213545.142598-2-deller@gmx.de> <mvmsf9lcoml.fsf@suse.de>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <mvmsf9lcoml.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UsDv2crGecsoVNtW7GEOh+4xhsmyfjRdUKkw9t0v9XmZ07QlHwy
 z4uYuFY8RlIzwNKVn2t5kk3KtOxIVwYdM5ZzJi5XcD0EwTJ67DP51uy2CMffnpdAd7sDwAO
 RxukB/+tkRxltcjnHVg4R5NyWjZSInMy78xjfIoePjTCn4HBuaR64yZYb5TInLWp1j3rpfT
 G2n0ejHwwQ1mXfm1GHIVw==
UI-OutboundReport: notjunk:1;M01:P0:IPkIl734HrE=;tLbHG+OMlhhCNrtKrfCDcbpRN2H
 I20NDE8PNCuHrLXE0pnGHo3gXxdpQlkxqC9PSEYaoj8Zb717YauFPt7D5M0Vmrr0TZIaYUkoj
 lNexjU9QZ7RyxuGkDY6dTPZxcbGQQnrS8fYUBbRfm1ZI0ZLDQLGMaux18bXT4kHtptCOq7PnG
 x2h1w9N7KDNahqSfzNR97nrC0A+0RxqotINGiUPoH8DD1aR/WsPRKQDv02r8pk2XRG45K2oPZ
 2pZtdd7P1osuSyR7reBAkplWnH7/0xjc5xOgA9IwIECHQSR2DIUw/VuKyN/r+Tc7KJnLpwgYm
 Fh+Zf4EdFRykbVr+t+VTjC1bkHZKY5mvXCtsraCmiWZaxvQFIp2UMw+Jndia99rbfC2DNhznV
 BkOwjH7/w1vZPbmXrm4unWOpJyajpIy2653j9AkZfE1SDxlHIWC1Ua3zmOyobkCum7J990Foe
 lah4bniIQ4MMQ3q+cLhgCNqZiWzajmwd5XziTybJwVn2SeVJaveiXjQu0NsvRyWvN52STViuv
 QtFozDTDUWigEqvlf7y4hpo4nGYQ94wR+nSS10CGrypQjQGepk7KAL8V8XHTXU7tKVllT/LJH
 /zFjNR5Q81fBnpTtqzQxH8wzsiJ3iMCt/l27xvkb0t5YzVqC1jSXi85fvY42XkPtqwt4Sefne
 fx+hpxe3myas1mqWCFYp3eX81drHkH+hZNY0fez4eNzvm5w1Q3u0f8Yi6YsH83bhsXxpNQ+ho
 7HuaUY/NssC32uaMlH1A7XiCSqxIidPQrX0R3ZnqgPPh2sWy9uP/NStTHmbkBGbaY/CczagCH
 e+fQeuwCY69uyaTNI7hThAxuK94/HL/TlOZNUHjCy24Rfw2AxuElywVAwjy2f+bS6BIuEbHJq
 bE8MSAaKllqnT0bJaQAbL1Lypw8YVnLPeptoHCfETQrERpSoK5ILI6O7bfCgzJ02+A3O6m1QY
 gZPb0pF2k9a6r3Uy5rzX2NB2fQw=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/18/23 15:53, Andreas Schwab wrote:
> On Jul 17 2023, Helge Deller wrote:
>
>> This reverts commit d28b3c90cfad1a7e211ae2bce36ecb9071086129.
>>
>> It just hides the real bug, and even the Linux kernel may
>> return page-unaligned addresses.
>
> The initial brk is always page aligned, see binfmt_elf.c:set_brk and the
> various arch_randomize_brk implementations.

Oh, your are absolutely right. I indeed missed to look at binfmt_elf.c:set=
_brk().
I'll drop this patch in the v2 series.

Thanks!
Helge

