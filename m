Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 537717590A4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2su-00079O-Qa; Wed, 19 Jul 2023 04:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qM2sq-00078t-1b
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:50:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qM2sl-0005K1-JI
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:50:07 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLiTI-1qdiI439LU-00HiV8; Wed, 19 Jul 2023 10:50:00 +0200
Message-ID: <29cd5218-a9be-1947-e075-b892023213e8@vivier.eu>
Date: Wed, 19 Jul 2023 10:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Wrong unpacked structure for epoll_event on qemu-or1k
 (openrisc user-space)
Content-Language: fr
To: Luca Bonissi <qemu@bonslack.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
 <CAFEAcA9vkyO_kivpSGV7jPW+DCbSD1BNA+SsLixViamXRi61CQ@mail.gmail.com>
 <fa561a63-991a-329e-d9f2-5b334d94516b@bonslack.org>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <fa561a63-991a-329e-d9f2-5b334d94516b@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HK92QWG02fuRnyq6HuWVso5C1vcf5v/yNK2Pmz9PchfbzcnKNkO
 OY1U37BiOC+Ov16JAP7dkRFiUnya2HFNwkL5IQceCZF1TWwoIhNysahXpCZJjlZHZeAp07e
 68RGQtuvEYB/+2vE5ykY7QJNiu5TiG4OcVWiFWDI8Tr9zYEBwmN1liQ6auDDm4TqeyR2WJ1
 o2+YFrpBbGiwaZncu5wVQ==
UI-OutboundReport: notjunk:1;M01:P0:7kOdQjBiOmM=;jYZSnZLEmELkDxTQ7yJOvo8bqBF
 SWkPWQtQ+l2p2dZzhZIMnR98eYom4GdNviRFicvGEEuPRBsFqMuWvy6T2hSN+YaoNrePbatmv
 +uQyR0aweTk0MOjVEkqP89j+2vDSwwaTUQn43c9JY8SiLKH1z4qxwocp5CscIrJaTfFTI6XsZ
 2MRAp29ID2RrVfq4h0dDckt3fy4qU/CtSDC9QNyzOFqMPxyN2kGtyFzo5x+jSXfkBdwVFR4hM
 HaWlHKNXaiE8VX8Uti3YU/KE1iif6BdQmlIxgswSCN2lrh31WfSNAI31IWmc+5rTxGr7MM+Th
 MBCMfp6VzbYtnLE4Wum7y8uW3w+pIG8FAww57HkFzXaloNLVl/WOmfIfmweS0r4hing3NqIWw
 NRfloRkE1uzAZj7Fq1n9MECEhTXsrGDpZkNRjhxdMWcJMn01u0StC+j20lruh4lChjAQdC1xd
 2YtH0J/k1rNrCBgGeXHWkRxD9b5ASsAOqsPHvoOnbOF8ZOgIrJ1cw9oQy2kicExNBf9eOxryK
 mee0eGStPyBFhHS/LShJGfGDqX4kf3eU33fEVf6vQVrEvv3bfdC0NEFssVtAfY7IV0EtOxONe
 99zzLXuEX3O/zqmi5nYYGrsmn/Wm5b5yMSRDId4DP8jypy7aw21JdPg0j1Cim7sD8RBVZyEuU
 ZjHtYWpjDv5T8LN1rJpYV5wmbF6AulNzyOS8q+DX5Q==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 18/07/2023 à 17:06, Luca Bonissi a écrit :
> On 18/07/23 16:40, Peter Maydell wrote:
>> Hi; thanks for this patch. Unfortunately we need patches
>> to include a Signed-off-by: line that says you're legally
>> OK with it being contributed to QEMU, or we can't take them.
> 
> Sorry for the missing "signed-off-by" line, adding it just now:
> 
> ==============
> The or1k epoll_event structure - unlike other architectures - is packed, so we need to define it as 
> packed in qemu-user, otherwise it leads to infinite loop due to missing file descriptor in the 
> returned data:
> 
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
> 
> diff -up a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> --- a/linux-user/syscall_defs.h    2023-03-27 15:41:42.000000000 +0200
> +++ b/linux-user/syscall_defs.h    2023-06-30 17:29:39.034322213 +0200
> @@ -2714,7 +2709,7 @@
>   #define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
> 
>   #ifdef CONFIG_EPOLL
> -#if defined(TARGET_X86_64)
> +#if defined(TARGET_X86_64) || defined(TARGET_OPENRISC)
>   #define TARGET_EPOLL_PACKED QEMU_PACKED
>   #else
>   #define TARGET_EPOLL_PACKED

According to linux/glibc sourced, epoll is only packed for x86_64.

Did you try to check the alignment of the structure with gdb of a C program using offsetof() in an 
openrisc VM or linux-user container?

Perhaps the default alignment of long is not correctly defined in qemu for openrisc?

You can check with:

int main(void)
{
         printf("alignof(short) %ld\n", __alignof__(short));
         printf("alignof(int) %ld\n", __alignof__(int));
         printf("alignof(long) %ld\n", __alignof__(long));
         printf("alignof(long long) %ld\n", __alignof__(long long));
}

See include/exec/user/abitypes.h to update the value.

Thanks,
Laurent

