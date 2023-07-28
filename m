Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFC767786
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUcp-0003ry-CL; Fri, 28 Jul 2023 17:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPUcn-0003rh-Eg
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:03:49 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPUcl-0003ND-NM
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690578218; x=1691183018; i=deller@gmx.de;
 bh=khRcNfXB+8/q0ZK/qIhsdqN8RAmcQeIGPlwFFtCgPHs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=GDyCwK91dxAVdq1iyD+reH5/kKGDMBYHNkAmJR+nhK0nCkOZAz6AoTf8BOpi6fybIBBqmly
 wn7isErSrJWJOLzhWoQLeuAlHhVYmXcVERn97N7Qzr1YICGGJ8HznmZ5EW+TaiE2Hy3ilUkMx
 Jvh15MzTTmj2yVSs7FRn9bNz5o/jMlIhvaUwRw6zXGJ9e4OkipvLdQpEXnict98DEiCaTYrij
 R/v0SimUJ6Bb+e8DOVPn8Z4UKemBNCVejjSUUj9rIKFbYgQU55PxrEqagz82GKXd6RxnbbP7h
 h5vzh9EgMmrMLP/HJSIz5XqtVEFB+Gd1l+rgML1TE5c+CiNrxo7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.73]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1qVp5C3YmF-008Z9s; Fri, 28
 Jul 2023 23:03:37 +0200
Message-ID: <ffe41182-cf01-6baa-4f87-9f476d63c4ed@gmx.de>
Date: Fri, 28 Jul 2023 23:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Reiser
 <jreiser@bitwagon.com>, "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMQVnqY+F+5sTNFd@p100>
 <b3249b9e-d687-68e1-77b6-9c8703644266@linaro.org>
 <73d477e3-a647-a166-f735-3d1400e505b0@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <73d477e3-a647-a166-f735-3d1400e505b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BnNRZc6OF9UfB9MjViNv10yPnafYWPDQ6tU1FohMnJ0JAnekjkn
 zazwCCVgQlIVlDMhGTm+CzR184KOBt81/5WJhpFeLuHkwGMrbPNJ9dgf9xr8k2ns6hMt/i6
 ipDoaU1F+RxGk2+tyVBVr9Dzn8Ov3fX8Nj6VbMMEK64UG3ocaM6UgX6Bcn3x4m66odnoWga
 fRvyIva+TcZQ9UPTigrQg==
UI-OutboundReport: notjunk:1;M01:P0:s5IXNm/AkAQ=;TP2QL9xRhX5/kLyOyRAgv1hEUCk
 HQhp7OMQQ1VKPTF4FFQmCWV02PzOXurjEgFp5kbrlReqHbBAiOHQxznz1seTGf/L+xZzwrgKv
 29YeIMufIcz7D10WAv24FHqC3qZaaLoTqOv4H8hzP7JGM9eK4y+WFUMssdoECaPqBPsfkiY7Q
 rk2pB4SQYXIrCIpaKkKbftX0YsoN72OwjuiWn2Ujk0EbjTBYvf6Dz2xc/DzrFy5jTRttXYQQS
 1YgzTkzpSf8Oya7l0XF6HX+QA9TcVrb+9USmWjddtzOhHTzDk9GVz9RnraNH+nDJ74XsaiyvE
 /tQ9HPXcHHbidMgEsFfJUck1QxLrSNYs06AVe/IlxsRtI8CWT1uoQXDlZj2IxruLEB+/gNKdF
 Lxh7a647EVs8yoVu6+ZbqJYtALL0emi4FsxoDXWwncsyy+q2R67soCgbPkNfoTwR7QiGMZ3KR
 Ou41crc2ouBh46md9orwfyx1VwiMDjR5hM0H9vdkBl8Xmr+ZjDDvVmjzHUgriUPQ874GEGiQG
 DM935paAOqKp7yK6a5VnF2EHXEuIvoTkHr103vZfIRa+tiXi96BmlJEafE21iS56I/G5DXTGd
 4G6wK2QLyMnXLCZ05ejY5ambPQDyV8Vitat/HDooVQPNCg87DfQb88XaW3tRXRsSV83jPMkiW
 zZzQkbUr9on+wB77P7w0O/KZFWFuq+nORQ43GnTlc4IrAz9+hOEZVqFOVvawR4cllF/G31yS+
 vX60Fxt0yj3lR8I0frudXgvQoG9Vq3i5JzjynNjPVUInlvNLhBoNR45tpuqA1bnUzDDlHRtA9
 PrXzoEJaaLXyk2J4lM2iOjs0A9jQIVVWbuO0swyGfbL9QStYZtieFwJnTLtGbymQjBtivhz5O
 aXFvSOvyP1CI98oXnLv8Z2cqNQCmJ2KLqseTs/GJ4h+T2s8RMiFF1P494oeM7mB8DXULQ+QSu
 DlEJSdBjhPXcW6I1DmT52wRzk+0=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/28/23 22:57, Richard Henderson wrote:
> On 7/28/23 13:51, Richard Henderson wrote:
>> On 7/28/23 12:23, Helge Deller wrote:
>>> +=C2=A0=C2=A0=C2=A0 /* endianess-swap if emulating armeb */
>>> +=C2=A0=C2=A0=C2=A0 oldval =3D tswap64(oldval);
>>> +=C2=A0=C2=A0=C2=A0 newval =3D tswap64(newval);
>>
>> Oh btw, it's not about arm vs armeb, but guest vs host.
>> This also fixes armel on big-endian hosts.

Even better: One patch fixes multiple issues :-)

> Anyway, I adjusted the comment and queued.

Thank you!

Helge

