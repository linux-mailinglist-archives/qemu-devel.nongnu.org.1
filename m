Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0B7E2F67
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:05:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07j3-0002iI-Ut; Mon, 06 Nov 2023 17:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07j0-0002hr-Fz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 17:05:38 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07iz-0006j5-0L
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 17:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bYGSLEVCaiGiq4Dan5KDK6N94f3aCKxGBQDG9GF7ghA=; b=rNkRiDyMF+H7Xt9z4NM2LvE7Pq
 Ehwjges2qFLbtIEL2dObDBNKqfoRLlEWZAVPsRplp9ZaHLgNcE4AGOlPsMHLl5ktGz+F6GIVPzPVB
 T9ISNNWfE5s2onXthdDOPbR8xhJehbdr5UpkjQSPbp8WaZKII9fMjmlEu2p9+D5wBEpfgLW78RtOJ
 6dltWeIXIHnp+dIhjfT9nm2mUsxUl/JsesNjYQZdx4wlZrgNAHyXJy00M2xHPuFyTnerIJtzZGZKl
 S/nOa5ZCQoMBft6eSUAWRaI+0soKGuHVMvLWiv94fobhe1hXmlC3+hAK6Wv9imJHxGf44Cy8mI8JT
 OyBCneHZnnjtcDtBx10EVWo7oglvR65zrn+4eN0GEaAVOB0y2yOMUHkAV0/7X9cpcFsd9XyBRYM0j
 A/AcAssWgBA9jAU0LjYc3fEWJ5LNKdxPmprdTeg8buwWmxs3M69scm+KiYLxrr6B++YFwLpcYR+qk
 j/oHqCKDJmStiuvikrsLr+06W5Uyxn5LkBDec8kJ5NUy3y7H9F4n9CWnYpi5IW0mdk+x9lirR2rdq
 GeTXrIKez4xNrO05ih8fAcIKGHmjSryQGgwAtI47ar90FYQiCK55Ewhq32zUT0bD1LyQLAiNQDABe
 tALrmkvUHM2vyjPcOTwnjUgIUFv05feVMD5MMz2hM=;
Received: from [2a00:23c4:8bb0:5400:786d:754a:beab:3c15]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07ij-0007JT-56; Mon, 06 Nov 2023 22:05:25 +0000
Message-ID: <6653e59c-6314-4a92-a836-cc11c6b7f311@ilande.co.uk>
Date: Mon, 6 Nov 2023 22:05:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-18-richard.henderson@linaro.org>
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
In-Reply-To: <20231106065827.543129-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:786d:754a:beab:3c15
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 17/71] target/sparc: Constify VMState in machine.c
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

On 06/11/2023 06:57, Richard Henderson wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/machine.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 274e1217df..b1b1e16b13 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -10,7 +10,7 @@ static const VMStateDescription vmstate_cpu_timer = {
>       .name = "cpu_timer",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(frequency, CPUTimer),
>           VMSTATE_UINT32(disabled, CPUTimer),
>           VMSTATE_UINT64(disabled_mask, CPUTimer),
> @@ -29,7 +29,7 @@ static const VMStateDescription vmstate_trap_state = {
>       .name = "trap_state",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(tpc, trap_state),
>           VMSTATE_UINT64(tnpc, trap_state),
>           VMSTATE_UINT64(tstate, trap_state),
> @@ -42,7 +42,7 @@ static const VMStateDescription vmstate_tlb_entry = {
>       .name = "tlb_entry",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(tag, SparcTLBEntry),
>           VMSTATE_UINT64(tte, SparcTLBEntry),
>           VMSTATE_END_OF_LIST()
> @@ -111,7 +111,7 @@ const VMStateDescription vmstate_sparc_cpu = {
>       .version_id = SPARC_VMSTATE_VER,
>       .minimum_version_id = SPARC_VMSTATE_VER,
>       .pre_save = cpu_pre_save,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
>           VMSTATE_UINT32(env.nwindows, SPARCCPU),
>           VMSTATE_VARRAY_MULTIPLY(env.regbase, SPARCCPU, env.nwindows, 16,

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


