Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B284153F
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 22:51:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUZWZ-0003fg-7U; Mon, 29 Jan 2024 16:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZWH-0003cx-Uu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 16:50:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZWF-00037d-V1
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 16:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQgjNvRGRGDM5LkhF/S3dEUBcrd1gPoQNP8KSIgg4Qc=; b=G4DOKqYcKkV3C38k37eGcxz670
 DyZNsRjntn5P8yCPvyBRQPlP1vHna5iH8NVBLai2uHTNlydhhF53jtMLfdweqTRrkOmJ+6Rkg9Eg4
 sp1ux3teB5ewxBWC4ZmtZKisWRFBdKOTr8o7aEp3QfzOWYp8bPQvRZxj/Nfbmh0iE5khYcKtJ1rfP
 pLH8AB0Es3gOfzCfe/MVo/eaOg2yuG16qHkna4yXbxYGrvL6Ca/AomBRX+5d+VCfXVAYeQt4XaJyr
 ZkR4OP7gk6UEVmwkoKT7EoRDDf1xkGJi7Ef5Am637uxPenfkFLQQlXRtXBKkdr3ACPuuTg4pIPEPE
 bsVJ7su/ah2rvsXXRcQ8jwZPixkee3WHa9u5sPpPKllEy9SOJfEVEvSfNLyhPKEtDsVPxFP1bMEOe
 omrZ3obXq7VwrmByJdq+1aEZ6DFG58S9Lf2CUFU4iOrNeyMRZWWAnhgLRvakqfOm+pXYMf4hXDh+M
 q1Kx9tfkhCd6+j8o2EChkA9BM1j5mq1G0LrT20DyP7rKyyT8MIK/CtYnaNOpmhftOiOklVXcxz/Ud
 DZzxEV0ppKVBni8NDQW96hC2apNuW8mqRt16lwqvbg2quw/yGRsyJhHV5K9IolVRpnAdcQeCiRxKE
 reP2z7HP4PxNSIzsVFfmFB7SM92v5z9X5WxgkUmwc=;
Received: from [2a00:23c4:8bb2:a00:c9b9:c424:5b7e:9d9f]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZVa-0004q3-Kx; Mon, 29 Jan 2024 21:49:42 +0000
Message-ID: <cc4b0d24-1bc6-48ed-9e6a-dfdee7883404@ilande.co.uk>
Date: Mon, 29 Jan 2024 21:50:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <a96a571b-55b7-46b4-a793-bb405ef10467@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
In-Reply-To: <a96a571b-55b7-46b4-a793-bb405ef10467@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:a00:c9b9:c424:5b7e:9d9f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/22] target/sparc: floating-point cleanup
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

On 28/01/2024 06:49, Richard Henderson wrote:

> On 11/4/23 03:38, Richard Henderson wrote:
>> Major changes:
>>
>> (1) Get rid of the env->qt[01] temporaries and use TCGv_i128 for float128.
>> (2) Perform ieee exception check within the helpers, before any writeback
>>      to the floating point registers.
>> (3) Split env->fsr into pieces to simplify update, especially compares.
>>
>>
>> r~
>>
>>
>> Based-on: 20231101041132.174501-1-richard.henderson@linaro.org
>> ("[PATCH v2 00/21] target/sparc: Cleanup condition codes etc")
> 
> Ping.
> 
> Prerequisites are upstream, and it rebases cleanly on master.
> For reference,
> 
>    https://gitlab.com/rth7680/qemu/-/commits/tgt-sparc-fp
>  
> r~

Oops looks like I forgot about this series. I'm not sure I have any images that 
explicitly test floating point operations, but I can at least run it through my 
OpenBIOS test images and check for regressions over the next couple of days.

>> Richard Henderson (22):
>>    target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BCOPY
>>    target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BFILL
>>    target/sparc: Remove gen_dest_fpr_F
>>    target/sparc: Introduce gen_{load,store}_fpr_Q
>>    target/sparc: Inline FNEG, FABS
>>    target/sparc: Use i128 for FSQRTq
>>    target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
>>    target/sparc: Use i128 for FqTOs, FqTOi
>>    target/sparc: Use i128 for FqTOd, FqTOx
>>    target/sparc: Use i128 for FCMPq, FCMPEq
>>    target/sparc: Use i128 for FsTOq, FiTOq
>>    target/sparc: Use i128 for FdTOq, FxTOq
>>    target/sparc: Use i128 for Fdmulq
>>    target/sparc: Remove qt0, qt1 temporaries
>>    target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
>>    target/split: Split ver from env->fsr
>>    target/sparc: Clear cexc and ftt in do_check_ieee_exceptions
>>    target/sparc: Merge check_ieee_exceptions with FPop helpers
>>    target/sparc: Split cexc and ftt from env->fsr
>>    target/sparc: Remove cpu_fsr
>>    target/sparc: Split fcc out of env->fsr
>>    target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK
>>
>>   target/sparc/cpu.h          |  39 +-
>>   target/sparc/helper.h       | 116 ++----
>>   linux-user/sparc/cpu_loop.c |   2 +-
>>   linux-user/sparc/signal.c   |  14 +-
>>   target/sparc/cpu.c          |  32 +-
>>   target/sparc/fop_helper.c   | 510 +++++++++++++----------
>>   target/sparc/gdbstub.c      |   8 +-
>>   target/sparc/ldst_helper.c  |   3 -
>>   target/sparc/machine.c      |  38 +-
>>   target/sparc/translate.c    | 799 ++++++++++++------------------------
>>   10 files changed, 680 insertions(+), 881 deletions(-)


ATB,

Mark.


