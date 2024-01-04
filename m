Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160718248C8
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 20:13:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLT8T-0007ty-E3; Thu, 04 Jan 2024 14:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLT8R-0007tl-RJ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:12:07 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLT8C-0005fX-8v
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704395504; x=1705000304; i=deller@gmx.de;
 bh=X6cgtvhYUiz2qsG5N+tBVlhlMdP5uEkrm7cCFAwFDL4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=mTD9+dHQTY50J9ju7RUKOtXFuxm0e5DzX5gr5EpGQdJLr86yQMt0uzX6VLwKI8Cw
 tEOSeV6huZgQ0MdKd7U/joav4Oqb8raUb7ET9VzeWj9txD5hFIUNOZMVcLhAgELi8
 QmygxBpT6kEPKae2q/IU8UTTbQP/dayyg4rqyiZG4QBHxdUUwG8Jo7lNN7sDWQ9p2
 SFnq6LAtEUN/c8j5gF/pOX1S2oaWGPim7aK25opSj9qv1fLzvayotVwTZu1TE/nZR
 UU6ahNtGSbuDPoTDuBAIZwObqfUIyiMTnlz5apKGjtFSOSMvUung8qGl2Jm2mKYsm
 escrFH4uiminKWjTJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.158.235]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1rk33H0lmB-00SK60; Thu, 04
 Jan 2024 20:11:44 +0100
Message-ID: <6d18d4a1-a507-4f6b-bb71-dbefdbee26be@gmx.de>
Date: Thu, 4 Jan 2024 20:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/hppa qemu v8.2 regression fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240104183628.101366-1-deller@kernel.org>
 <62b4a27b-b4e8-4101-a0c9-d548c72935aa@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <62b4a27b-b4e8-4101-a0c9-d548c72935aa@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xyAo6w2THWoYumpcDcGWTIB80BDY2/3hId7zsBa0BiFSZl9mVYp
 ppeRXhywdYYsPvc4VvY1O0wLk7pbXkzeYB1IAhmX2kVs8kNTkKqXwEnv1cQlBLt1ZUuocPE
 THyimZJLJlzEaUdXFhOxc8qDvJPe8mXfciqIFy3k40l7o7NEP5b1v4qfpKoauPpKbyodCpx
 clWKZYTbJDRzQhRLfWVRQ==
UI-OutboundReport: notjunk:1;M01:P0:BUm4NqSFCho=;8b0z3PASRnrXIK4fBP3eAG4ze9Z
 Eicm7cay0Okr+9RLNvdCN24EcgkSxvexLtB5apeVYv+00BFfL7kYpCpcetjXPV+O1iWPFMy8i
 k9r7LtA7/rjaXdmdxVJ/AvjiB0hEMCiMzTPXSCiA08MPOzgFSkbA7/Ojtr5lwsVNEQ6+AHqLV
 +eWAVU33cMMJhTj1DDR77bmEvZhlm0Y2igJVQoUoS0VvOL61TnGeF/2pn1ZUX3MUDLwDaYQ13
 zT6veFQOFc3xCBnGoN0m8dLrAyx2mRiok7cipYn2MGGa7YJemxLnMs7/m1KmEmH/r1rP6sjWi
 Jn34wkAn702oqhYxVbkgIOat+zwcDSFdyk1Y8lNmKHI6lqglZY6OGeee+RgjIK+gP+5cVJeQQ
 dJ2mA6LvJ44eVT/DjnJDI1Ul4doqktqSqfNJoci9nGtT5/a0DVgqm4thJI3iSsl1nWWeHn61Z
 nHhMSTmfqUREVPXLv8bFacX5DTZTsJIGPQVAZTMa+Xjv83655DboBVvxsX/mqAnByfZDVPJum
 bACzsu6hB1XCR/df+M8BS5APzHWYFavZMIxnDjn3K2cZ+QyLdp+cCwM4Q5G4zzS1TxDciWVYL
 lytpMb7RdKN+MLrhxe+jQ683aS1PX7Oue2KvxkifabtCxBTYkcrq2cw7cyfGTcbOUAeXP+0x4
 hzhAxjeK2N6MtFpQFe3p5+gTrPJXXTZsFu1O4vBsyqWNYcGV34RfBN8V9IuVqQAGnoDBM+4PH
 wPcxFNdEJytEm6MWD/sUjSNGYOsl3YIMSqQ/+7y1coLt+3QKOIIW30tpfI1dBcVi7e6gl0M43
 2bCmvK/gqD8YNX2BPBFNrgVXgJxHu/HtXnsYOk8S/slnRJCLJWbH92BysvUow7QtzAV/pPeqz
 3zUR2MZEMUWFrlXVhYwu+K/bxsCdSy6w+BGmq4+XGgQE9ZxjTLvwFcWVBVA4qxZD9GlZAzt8W
 /2J7PA==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/4/24 19:46, Michael Tokarev wrote:
> 04.01.2024 21:36, deller@kernel.org:
> ...
>
> Not commenting on anything yet, but this one just draw my attention:
>
>> =C2=A0 pc-bios/hppa-firmware.img | Bin 681388 -> 163316 bytes
>
> This is quite a significant reduction in size, - more than 4 times.
> Is that right?

Yes. I stripped the firmware binary to keep the mail overhead small.
The symbols are not needed as long as you don't do debugging, and
if you want to debug you better build the firmware yourself anyway.

Helge

