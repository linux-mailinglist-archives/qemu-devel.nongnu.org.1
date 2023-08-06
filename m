Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029D7715B0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSey8-0000RZ-0V; Sun, 06 Aug 2023 10:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSey5-0000PC-B2
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:42:53 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSey3-0003AS-CF
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691332968; x=1691937768; i=deller@gmx.de;
 bh=bmH6qGCxZjjwsRZy3QOkI0k7S9f9VQhu09YRb3Gw/g8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=EDDfDxYnD0tzTcL05qi45DarUoM0GFbLJUkOAzasLca8Ouqbxo0H582qA6qHEHSSVY8xwaG
 RyHtzAWkdwMTDrxLjDZ+Wg1o89du0lTK6XfhLYn/T7/AupJnszIRshWbq1+BHs3vAmZMjsxGM
 YNn6B/zhyRFJha6ceAwy9mt0mqmaOLKHoKxSYJ0XygMG5YJsJRmeDGGfZjT5H4UzP7xW9vAOX
 Il9layfr8ZruJylR/0wODyR6p6nbO4ukf28oCvtjqnGpGDthakqVEtQ2ucBsjBFKab15A6IaI
 hHTLshVokJxSq35UEY+aq4pyrFGvho/AKW9HCTzpkXfySM3GlLvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1qA29c1e2m-00IpoG; Sun, 06
 Aug 2023 16:42:48 +0200
Message-ID: <700520df-f9d7-09a7-ded5-155eacbd11c6@gmx.de>
Date: Sun, 6 Aug 2023 16:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/23] target/riscv: Use MMU_INDEX() helper
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230806121732.91853-1-deller@gmx.de>
 <20230806121732.91853-11-deller@gmx.de>
 <dd180646-6c55-bfa6-0660-55eb5fa85917@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <dd180646-6c55-bfa6-0660-55eb5fa85917@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7/0Knq9l0Rvi3EnJHv6m8I/SJoQnhdlTVfVlsiPH3j2zuav9G9k
 zKdlvof6HbQGX806SHOdKIoY/QNyu+Y3qiRiAmvPAklJL4EnCr3hedGSuRyuWcQSBmRppLj
 7jY9azb3oiqK9q/gZf3zC6443ZJXTAeDyDjz8uKruj+e/wBTwCsCG68sXDwdsYahvGRNQyb
 3WZSYhQXYLdii5W1BoTLw==
UI-OutboundReport: notjunk:1;M01:P0:u4nTEy+paxw=;J0CGLWLnquZLVwI/+Xdo/V43imG
 9QGV3VNRrT89lB+A3tz3pg+VbBO8IzIOGnoKvdE2w490oASeZ4tlx/dgpEB+5ouOu2r+H1Hch
 6xomYkT9lsSvms6+nMYFlQs7x167HDKTjNfjVLSFms/icXWujxL8GTINk2GapwvV9HvA0FSTf
 o/yZ9zF3096nB7FFMnv6+anvtAgI0gNfsu6tXw9Yp09lyl2MA13BATL3ckcv6LlW8DkfU+HRY
 9F3Z75aMiQDcim7zMP6g7vNwTCv5wK0gI6YnFWj5C+tMd91iq97ShDe+3s5kKuBLVi/a+lRje
 aw8RNowEeWPRfqMmLZYm6h7VcLya/Lvayw7r4rlKahRsY7WUl5Rj0MXTSareYbYUZnLyqn1vd
 WONBo05LVo+i0P8jfDX9UgW09ca7G0YrYWWmBMSTjJHQU18A/CeXTvZDfEZ9JGUmAzyI+HWOA
 Nbl42jkKH0hlzt0bknYBbYx2aFKqH+IRriPKWLRqwL6G08lJrRhtnsuAMnwGYEONeYnU0hBwh
 VEMecvIKyc9wz/J3YDOqtrr5sRr34JS1qq0cd6SNh80q9EY6mdyi/YAuu5UHcJ0W2Xm7W1+U6
 vNHkCIZRF5b2y+Gj8wcdQF+IvVGuYBKq6T8cjgTHiL4rBU66QXJE4kXtGJT8kjs8i6HBa8vEM
 ziyf8JTFwhAEHhsmOhQdE+Q9KCkM7rjLWLEVhh2WFfHviWzfnSvTyPBfDWwftRL6lJmr0e33h
 3hmnh6dt1Y4c5YT5+M+C+uDfvIq8sYR8rbHrf5ZNuBE7C2RAc61kUEfACA0sbjt6lMvx+8wUV
 Szg5AyKIMGDxfv7iWiPGZ1Y0Nlo0wBHYJyFgBCtt/LpCyhXBUjh0G+U8iF+3Miu+SlPtSmnh1
 qm+OP6LSIT20e0M9hN1ZyyeALZel/8dQfFN7+U8OfB8lcCWTNjK5Mn8QqtU+Or59ohQLZEhf8
 GQtGIH/Zm7QME0yjsKws3ZIbAbc=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-4.139, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 8/6/23 16:30, Richard Henderson wrote:
> On 8/6/23 05:17, Helge Deller wrote:
>> Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
>> should be used.=C2=A0 Additionally, in a follow-up patch this helper al=
lows
>> then to optimize the tcg code generation.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 target/riscv/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4=
 ++--
>> =C2=A0 target/riscv/cpu_helper.c | 2 +-
>> =C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 6ea22e0eea..6aba1df64a 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -88,7 +88,7 @@ typedef enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXT_STATUS_DIRTY,
>> =C2=A0 } RISCVExtStatus;
>>
>> -#define MMU_USER_IDX 3
>> +#define MMU_USER_IDX MMU_INDEX(3)
>>
>> =C2=A0 #define MAX_RISCV_PMPS (16)
>>
>> @@ -446,7 +446,7 @@ void riscv_cpu_list(void);
>> =C2=A0 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **er=
rp);
>>
>> =C2=A0 #define cpu_list riscv_cpu_list
>> -#define cpu_mmu_index riscv_cpu_mmu_index
>> +#define cpu_mmu_index(e,i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MMU_INDEX(ris=
cv_cpu_mmu_index(e,i))
>>
>> =C2=A0 #ifndef CONFIG_USER_ONLY
>> =C2=A0 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physad=
dr,
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 9f611d89bb..a8e6950217 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -107,7 +107,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr=
 *pc,
>> =C2=A0 #else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D FIELD_DP32(flags, TB_FLAGS, PR=
IV, env->priv);
>>
>> -=C2=A0=C2=A0=C2=A0 flags |=3D cpu_mmu_index(env, 0);
>> +=C2=A0=C2=A0=C2=A0 flags |=3D riscv_cpu_mmu_index(env, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs =3D get_field(env->mstatus, MSTATUS_F=
S);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vs =3D get_field(env->mstatus, MSTATUS_V=
S);
>
> This is the sort of non-obvious changes that I hoped to avoid by restric=
ting all changes to accel/tcg/cputlb.c.

True.
And, since I've found some other missing pieces now too (e.g. in hppa)
I'm currently tempted to fully agree with you, that handling this
in accel/tcg/cputlb.c only is the better (and cleaner) solution.

I'll try you approach.

Helge

