Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F448AA40B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 22:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxYOZ-0007xl-N3; Thu, 18 Apr 2024 16:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYOX-0007xU-LE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:30:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYOV-0001xa-Sc
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w6eienrKkKiPJMOF6qiMqTZCRGy7rq6JvPfrFkOC/8w=; b=BJCRsJRKXnaZcbfgutVMR8c+vy
 s50tBt9B82qqwrfNKQOXaMMPxXjb+BsmTK64ubGZEXAC9XpR79dt8qRTeUbvWIwK66acbfTisRXPN
 4htThaC+afKWzIbXTxcQRWpf8gHmGPv9wM2sU4FUm/CatPTDWPjhVOI29q1SDPY2jY95G6HEgyZcL
 xlpC6q9tdT5/KcBTNY7gv9Apg7Sz6FMQ6M/bJQm0/6FzPX3oVz/q5RuY2qWcNIdfz50dKTpRGzASQ
 mkklVlqqk11Z+0YvMiKXJgxnNwVi9sOajqzpyIMR+jGS9BlUCULGLIdlNwch8dXjkWlQC+I2LjdLE
 9OzfnYCb/YSBW3KDpCYBj+qM1sdGcCeYoz00k/eSKssUKTWWM0iLXVXTh6BGBi5PzvdEegHod0RpC
 gtSymS0v+K5qRNX6iCLNHtN1C8f99c326DGQQQPM0XxUdWqB9RAboVxk+WA1UPBJ3VfmOu1MtN/7W
 YNkq8vAnfaz7FOt25c7r/CXBgC+A64PvPkIYN7zI1XjeHhv1ot9csbFfLK6go9xGQdSn8bpSk9ECj
 /qafW3QCIM4OrmLI6085TlWg7/3sG1qIVOR/jKIZ0isHwHmyKeYZZQTcO7SqdbklrbBmZlJTArY0e
 UUcbQlYeFK6pAtbILMTGZvAqIPka8NtHtUPSrrQrQ=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYNV-0006Jx-GR; Thu, 18 Apr 2024 21:29:05 +0100
Message-ID: <f6c7ddc5-2671-4e2c-bad4-9850c2bb52f4@ilande.co.uk>
Date: Thu, 18 Apr 2024 21:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <bdd66aac-4de5-44a1-a1d1-86825d337d12@redhat.com>
 <df3d121a-b9cc-469e-ae7a-ded6b7705fe8@ilande.co.uk>
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
In-Reply-To: <df3d121a-b9cc-469e-ae7a-ded6b7705fe8@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/5] Sparc CPU naming and help text improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/04/2024 21:08, Mark Cave-Ayland wrote:

> On 15/04/2024 08:26, Thomas Huth wrote:
> 
>> On 07/03/2024 18.43, Thomas Huth wrote:
>>> The Sparc CPU naming and the corresponding help text is somewhat
>>> confusing for the users. We should avoid spaces in the Names and
>>> provide clear information to the users what can be passed to the
>>> "-cpu" option.
>>> While we're at it, also remove the "+" from two of the CPU names
>>> since this character is now not allowed in device names anymore
>>> (and was worked around with an ugly hack in qom/object.c so far).
>>>
>>> Thomas Huth (5):
>>>    target/sparc/cpu: Rename the CPU models with a "+" in their names
>>>    target/sparc/cpu: Avoid spaces by default in the CPU names
>>>    target/sparc/cpu: Improve the CPU help text
>>>    docs/system/target-sparc: Improve the Sparc documentation
>>>    docs/about: Deprecate the old "UltraSparc" CPU names that contain a
>>>      "+"
>>
>> Ping!
>>
>> Mark, Aryom, could you please comment on this patch series, too?
>>
>> Thanks,
>>   Thomas
> 
> Done! I didn't realise that it was only patches 1 and 2 that were still outstanding 
> until I tested the series, so I've replied to those separately.

Oops actually that's not quite right: looks like my git-am failed on patch 3 because 
it was already applied, but the remaining 2 patches are still relevant. I've just 
replied to those too.


ATB,

Mark.


