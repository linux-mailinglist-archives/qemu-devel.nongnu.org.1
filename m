Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048273D00B
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDMeO-0003VV-Tb; Sun, 25 Jun 2023 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qDMeN-0003VH-Kq
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:07:19 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qDMeL-0000eJ-M4
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687687634; x=1688292434; i=deller@gmx.de;
 bh=4xENDnCSAzFB53bT6lVAhASoKyyo1fi5wNC5voGFoDc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Okw1olIMSxEeCg6PM/glJ7TNLO0uvm2iweoB4B02yJxQvn71brSngoZeq2snWgq/xx35l3d
 QPGx7zecxYstgfp9zSBXuxdJFcsI1zKARkj/RCMPUezike/zNsDrbuCypayyGNLtkEjzTUCY5
 gtTrk/cblzPPEindVmcVBPEd6cuAopxoqzUSpGKiMEMfyQyNUvFo1mpsS+11jTStGwBSdGgFX
 0ydKfM1UeG5y41Ssuw5VmTNE6RfP578bGvyCLG8HJSFJQUzTmvVQobnMkRBcfLqbXyGiZF7CS
 kngRtnsZgGrHfVpZlhTNjkrj7kUzi2+PzO4MS4wnDRoudxRPaE5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1qT79P2853-00K5pP; Sun, 25
 Jun 2023 12:07:14 +0200
Message-ID: <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
Date: Sun, 25 Jun 2023 12:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
 <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+VRMs6dMdu0NowYIzTNOxsvrfEmixEW1+xgVMMw5ZZjINdz4r9p
 G8idCFZaE64ggwqWKXxBSRprbq3bvGCYOl+Uki3cv6k/TXslxt+JKqRTS73n3XtJocZPB8v
 sp27yeuTQR1tchnTtSGKU/WLztFMVFdwIIKWNH0HjVIsvTxJI2cIHP+8mwO0oJZ0Bvn6JFz
 6pUcfuK2zUmGVrXbKAkwQ==
UI-OutboundReport: notjunk:1;M01:P0:hXOTY+x5i+E=;Yuugx21zBX77H5uJIGu7CVHtuF6
 en0gbiHx9HTEQ+ILW8MQKBw52ASCQelDhZ6BsZvAVCxYoGpeuaRk9X6rcyJiqjO2EbNdCydr6
 +nzprYK28inU3HtJ9iR/d/KslaQEqd5Oc+LA4/8cxivnVCr4+wIWFnxaf0vVHlIb60208TBiM
 9inBT6M4bnxjnZI/fTiVT4whpxM6ed9rcTbwJWmZmx4VBMM8L64t1l8JtMYm7fXL7lj/LbrIx
 EBkSY0oHYBA+0GtlmnPrHHO2V0Sb1h5v5zQl8JJ0fWn6sBL54ZSBs6S9JA6F0Bphac/ktEvLF
 zhjYVZDWmne6KjuRuRBFpE4wmT2NoUIDsraq5AU/wY5Veasn2114sunF3zjEiG7tZnE5sSn4q
 ePoyw6j7n0bEVk9NIk4c0iJ5GDycfNIRhUeY2BbaRCAJD19HRdbnA9UPv6j3MgM95wsj5lP1S
 izTKXUwxeNKaTPraeEQ7I4Dz7Uq92HoJds0ufAjHYlhkt3+s59lFRV8D506u/UpEvNsO6ni+t
 UjvacHTlwbyg+M+5P56GK7b/Kf26g5xegvKXwDAm40yc194fWtDwrFVSHqE1/C+55sIZLA8w9
 RCDO0nANdIRNqg8C8LSxlBRfTTmIqSxyzeh8a4pN8WSoobrZPGD2uhzxjwAQqhL5b5Hg1eMKA
 HC3egXwYbL5RLm7B/DBzaNxYEbZCNOYgQLGvXv/imF5sgpdNwJ+fxOP3+NMHish4NMIvuSlHk
 9QRTYSBy1idhofVT9DZTtsXqMjOFgxUWc/u1ommL1P3Ijeee2FMRuvt1zpjetVA7lt6kCZFm4
 JmlC46nT9VdoqvauZX5Q8CDSxh6htkX9PSpjJxSJI2I0HulVwJ4NNpIi+DvRY7jb/Gh8g7iBt
 Ew/dk0hXQ7Tq20ybDA09M1i9jhSjcoMxot2+tlSvFSi20T3zuqXrQlMFOsOrDmUOHgLjC257t
 hiMv2g==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/25/23 10:57, Michael Tokarev wrote:
> 24.06.2023 14:50, Helge Deller =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> When the OS triggers a reboot, the reset helper function sends a
>> qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET) together with an
>> EXCP_HLT exception to halt the CPUs.
>>
>> So, at reboot when initializing the CPUs again, make sure to set all
>> instruction pointers to the firmware entry point, disable any interrupt=
s,
>> disable data and instruction translations, enable PSW_Q bit=C2=A0 and t=
ell qemu
>> to unhalt (halted=3D0) the CPUs again.
>>
>> This fixes the various reboot issues which were seen when rebooting a
>> Linux VM, including the case where even the monarch CPU has been virtua=
lly
>> halted from the OS (e.g. via "chcpu -d 0" inside the Linux VM).
>
> Is this a -stable material?=C2=A0 It applies cleanly to 8.0 and 7.2.

Yes, please.
At least for 8.0 I think it should be added.
I didn't tested 7.2, but can do and would prefer it if could be added ther=
e too.

Thanks!
Helge

