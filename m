Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F407B7E461A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:34:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0P1n-0004v0-9I; Tue, 07 Nov 2023 11:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0P1k-0004uk-V7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:34:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0P1h-0000Nm-Px
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BHE5AeKTCsrsBI5fVozJMntpUX0XqsDrjH/d3EjiNR8=; b=D5lVrvWHQ+d/agnExK6wviH9oT
 GUA7/4zdjEXSTiidFG3wD4yss1404YPPqLdBtOmPh6P96nnYnqlGepZH/DL8EoJBBwVgFkrXXMTEA
 4zKGjsXOKNFB/BoBSjF1HQUqcjSoO0/QYUZf0308DaKUEp9fpwth9yJou8+mXOz7AALVlN9zhYC3J
 zF6K1/W0+CKo3Al6wcCBernrjH1VC45h3Cdev1bWjuk1gPrXWgMmiM8mt5+3eCCv5oWyAHbOhEgbz
 sEFpPBjOZprmIIiFJ7YmjJr3AgpqnbHK0jOXU1cW149r4SZZVNWLtX7ocPBqjQwgIzAdsNdUDFQyO
 vwZ/xG92kDDjUjiUpCJWLWoE0DufkUghY7CazpRYU7yMe9Jg/X7JGz4B9HIYZthsg/Rtfi6+CnDqB
 k6CV1IV6KwTC/Xr9PBl8WM4KmzUmUAB4dpWcW98gAWkHsFNvpgkHRaowYPT/1zAK0RvCb0DLIwqj+
 +0rPu61trvv22Dxl/TLqIOTIoQ6SdpP5vgioXZEiDinEKStWZSFDacmaUx8WehQcQqzcuOg/xzPu2
 LeOB+e8WpYfP3mub+quv3N7tCTIcahZh5CvmkiK24bjSCLlMECJQLopRULzVQiP/fqiZglGZKiZH6
 YEPPv0k8OLMkKBVXIMDxdXQyPi42TZC/dO8RFbi0U=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.10])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0P1Q-0002U2-A9; Tue, 07 Nov 2023 16:33:52 +0000
Message-ID: <a82e7b9a-0659-49ab-97c7-1f5852d742fa@ilande.co.uk>
Date: Tue, 7 Nov 2023 16:33:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-111-richard.henderson@linaro.org>
 <8abcfb1b-6fdd-4d74-a75e-419b89a093ca@ilande.co.uk>
 <058ad3c3-7e84-4aab-99b2-6b31d2688ff2@linaro.org>
Content-Language: en-US
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <058ad3c3-7e84-4aab-99b2-6b31d2688ff2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 81/94] target/sparc: Move FDMULQ to decodetree
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 07/11/2023 04:49, Richard Henderson wrote:

> On 11/6/23 14:02, Mark Cave-Ayland wrote:
>> I was working through my SPARC boot tests for your latest target/sparc series when 
>> I spotted a segfault on my FreeBSD SPARC64 image. A git bisect indicated that this 
>> was the patch that originally introduced the error, something I must have missed 
>> when testing the original decodetree conversion series.
>>
>> The reproducer is:
>>
>> ./qemu-system-sparc64 -m 256 -cdrom FreeBSD-10.3-RELEASE-sparc64-bootonly.iso \
>>      -boot d -nographic
>>
>> and the error is a segfault in devd:
>>
>> ...
>> ...
>> Trying to mount root from cd9660:/dev/iso9660/10_3_RELEASE_SPARC64_BO [ro]...
>> Entropy harvesting: interrupts ethernet point_to_point swi.
>> Starting file system checks:
>> Mounting local file systems:.
>> Writing entropy file:.
>> /etc/rc: WARNING: $hostname is not set -- see rc.conf(5).
>> Starting Network: lo0 hme0.
>> lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> metric 0 mtu 16384
>>          options=600003<RXCSUM,TXCSUM,RXCSUM_IPV6,TXCSUM_IPV6>
>>          inet6 ::1 prefixlen 128
>>          inet6 fe80::1%lo0 prefixlen 64 scopeid 0x2
>>          inet 127.0.0.1 netmask 0xff000000
>>          nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
>> hme0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> metric 0 mtu 1500
>>          options=8000b<RXCSUM,TXCSUM,VLAN_MTU,LINKSTATE>
>>          ether 52:54:00:12:34:56
>>          nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
>>          media: Ethernet autoselect
>> Starting devd.
>> pid 246 (ps), uid 0: exited on signal 11
>> Segmentation fault
>> ^^^^^^^^^^^^^^^^^^
> 
> 
> I certainly can't imagine that FdMULq is really at fault, because it's not 
> implemented on real hardware (and thus I really doubt FreeBSD attempted to use it), 
> and CPU_FEATURE_FLOAT128 is not enabled by your command-line.
> 
> The only thing that I can imagine is that this is some sort of timing related issue 
> and bisect behaved randomly.

Hmmm you're right, it seems that there is a semi-random aspect to the issue which is 
why the bisection didn't give a good result.

In order to mitigate this, I repeated the bisection again but this time booting the 
FreeBSD image 5 times in a row, only marking the commit as good if all 5 boot tests 
passed [1] without displaying a segfault message [2]. That bisection led me to this 
commit:


86b82fe021f46ed4501b16132f7e3fccd0a1ad5d is the first bad commit
commit 86b82fe021f46ed4501b16132f7e3fccd0a1ad5d
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed Oct 4 17:51:37 2023 -0700

      target/sparc: Move JMPL, RETT, RETURN to decodetree

      Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
      Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

   target/sparc/insns.decode |   7 +++
   target/sparc/translate.c  | 126 +++++++++++++++++++++++++++++-----------------
   2 files changed, 88 insertions(+), 45 deletions(-)


I tried repeating the boot 5 times in a row test on both this commit and the commit 
before it, and that appeared to confirm the bisection result with the failures only 
appearing with commit 86b82fe021.

 > All that said, I can't replicate this with master.
 > Can you, now?

Yes, the issue is still present in master for me. My host is Debian bookworm (stable, 
x86_64) configured as './configure' '--target-list=sparc64-softmmu' '--enable-slirp' 
'--enable-debug' and the command line is:

./qemu-system-sparc64 -m 256 -cdrom FreeBSD-10.3-RELEASE-sparc64-bootonly.iso \
      -boot d -nographic


ATB,

Mark.

[1] Sometimes the image hangs just after "Trying to mount root .." but that appears 
to be a timing issue and not directly related to this series. In this cases where 
this happened, I simply quit QEMU and rebooted the image again.

[2] Normally the segfault message comes from devd, but during the bisection I did 
occasionally see it coming from other processes.

