Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 598357208CA
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 20:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q599E-0006Iw-Su; Fri, 02 Jun 2023 14:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q599C-0006Ih-2T
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 14:05:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5999-0005iD-Rn
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 14:05:09 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MfbwW-1qXtJw15VA-00g2Kp; Fri, 02 Jun 2023 20:05:04 +0200
Message-ID: <ffe8a6c2-4ca7-954a-1461-1aa81b17bff8@vivier.eu>
Date: Fri, 2 Jun 2023 20:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230602174806.2060683-1-peter.maydell@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230602174806.2060683-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:79pp+iY829zO8tqv99CkfPOvmZFoz5VEB5TvH/a8wfqj6rkIGlJ
 0N65vaIYwom+w5/ior5ronMLaYWuXj3v0JxLwsoomXAAoWjOGBIqed2Jjs6/QHGPes227yI
 Y5OK+OhR9Qx5sna1dzjzTwlhuTVcrB9kUD1fh59uSC03Av8rE9xS+ACB4tpLI1FUTm8e5qd
 GKul7LhdNm/ZOJBHqbD0w==
UI-OutboundReport: notjunk:1;M01:P0:GVcUwJ7AlSE=;r/7CizzTR/DNIpreHvI22nY0K7l
 1vZ5ktN8gcepE3qU/BjjGkJgJyYKXo0hwCKU6SB0Yw57SNXT1AJGd7/0cv7P1p8HmuiGzVq5/
 NYcNJ/pRTLCzbtHhf5eF2nh/Gh/vcT/kEmvd/mKgOGtnj+yu8Hzo5mYYIQVOzoryg/xsHeRhW
 VIpsjlphWz/uA1zFH80sAf98xgDp7KqPcSxI5i9vDQCumozuLScaU/nlGrZp5zIL95kcXX5Wf
 OLKk8fAJHcoCnDkYZNH8g2ENJnwJpKPlJ/ZTFBFAM3W3xS65LHLzjHjphX6sxwzljo9n4qciJ
 dY/N9JTOhnr27ebNac7t1OL/j3+aDKIipX01rPwh02t16Nm9j8WOlJRFLd+hLRXhShRDrAYFH
 PvSqMlf4TQs0NzEBU9F4BwAb+IGj98TT3lyMwVyVoyyFPfkOR+toe7ibVNB9ZkaHOKlzcD7O0
 Xdkxa+2AORJVBvaFL1ucXfaQVIutDiC+D4XMzmwYgoWFKhM5GToJfRXH5AspJFT75F21zbsBH
 NzQHSgdoCWK/gty+gF/MbCR0RgiP2IBDdw7jfH/CQs84GMDgMHiVvn4+e+oGDlEoal9LGA0fF
 e/KYiq7fGMQN4OjQBzusvN3RNvGBYRzFaAeEF26WbKJK3oxf5Q4kiT93wM5MNGaquubYqKHCr
 2+000+iDovhl9y+oxKyEpMJUmQwZeitKJnQ7lsjLdQ==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 02/06/2023 à 19:48, Peter Maydell a écrit :
> Coverity doesn't like the way we might end up calling getgroups()
> with a NULL grouplist pointer. This is fine for the special case
> of gidsetsize == 0, but we will also do it if the guest passes
> us a negative gidsetsize. (CID 1512465)
> 
> Explicitly fail the negative gidsetsize with EINVAL, as the kernel
> does. This means we definitely only call the libc getgroups()
> with valid parameters.
> 
> Possibly Coverity may still complain about getgroups(0, NULL), but
> that would be a false positive.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 89b58b386b1..29fdfdf18e4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11574,7 +11574,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>               g_autofree gid_t *grouplist = NULL;
>               int i;
>   
> -            if (gidsetsize > NGROUPS_MAX) {
> +            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
>                   return -TARGET_EINVAL;
>               }
>               if (gidsetsize > 0) {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

