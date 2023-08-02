Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7376C884
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7RC-0002LF-BC; Wed, 02 Aug 2023 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR7RA-0002L6-F6
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:42:32 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR7R8-0003r5-7K
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690965745; x=1691570545; i=deller@gmx.de;
 bh=SiLMcg0ZUU/obi/K8mTCoFwu6Or0WZ7DXTw2jUQ91DE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=erC7GW6S7jw0BBTZx+wh1I7rSvo14Ma+IuDZod65durjKf+IS8XRTjJV0lpLmD0EPrFHdJA
 JPhuds5S4QNPpzfHPMgOdRpguSCZFVyKSBAyEmuj73k4eYtyvG5ooGQGvXJj2DESja46l45qn
 vB5VEhqDJpZr6p11jDt6WK4peCVAa1GaIR16zm+kPOiMpH0wgevDpgDUPLotG6s4klXGVhpq3
 0rmXKJvMO0qbxmFolLQzMUZOGCyKEhADQxG2e0oVvguLwZCH05L+ZUN9xOyabsHjTv3mO7uf9
 mDvlVXXotuUIFM7IAXsnCE2zLMBnP8DkWyaWIcGMh+ba4PUpURhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1paFfO0UYF-00rmuH; Wed, 02
 Aug 2023 10:42:25 +0200
Message-ID: <c1e68eb1-6d26-22fd-8c51-c1ba1e472187@gmx.de>
Date: Wed, 2 Aug 2023 10:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
 <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lvv/bMVvuPUtmvR0p7wLUuvd1Xyn4qeU5z7nwf659695vbrlHRI
 6Z1ipCfmrxPS3yZjwPKbYEF5NAom1nCUnEgI80XIjXhqPXp6rc6aXH2AJMXxU4+PTP8g5as
 O/Bo3Pe7ts7T8sUDTyuIjZWg/KYqkosxb2uLODc1QIL85PL/ffCGSokg/+7QGWNbE1S8byy
 pOvX0W1SXlHJ035tKXbCQ==
UI-OutboundReport: notjunk:1;M01:P0:cP5k3fLSAFA=;d+ZuQQecdKXZlF3JanJzkRCLzHP
 jay6nFjtBb0aVcKK1pLgN84sruUgnS3kNIywpVPUfX2s3FRl6mO1g4ix4WIxA0AcwKboc6VPg
 GlFsDzNVWmDda0fprVgvdSs0BVNpBU3W00MImiBlC5HVL1EDxVB5j99RdmOxhrwdH9i13Nmhz
 DS5Il8RewHQYf5OcL/1/j8OsEcXnf47NrlbM1T1ISeO/6WhGKxbdGcf0bMm7OkfVuTTxmGdze
 5+TVnHdSSo5/2+Z6XlVvIVJbjREFMnzPhZfKc+GXIrQ/fJIFEf20DB5OkKi/DqImeWr5k87h4
 tENRY/CVusiznlggqcIRfiLG0C9aI2ezC9lSD+y6o2PlHhXsl2lrsbeFHqjJpvH3tRks0/ip6
 LfCTaOwzOY+bLR79MCcBappe/wTt6JoFjR50CZMLlC1/kNrMqtc5eRtnCugk7a8bnTMRe/R9v
 S/194SvKK0CgG9Qog5qr8EkswoMyowI4NgA39Kssy7Rv8UcToZCITRErAIbaXvcwHxG+I0kAo
 3ByAQaTBmswT0Gq7OtmMgVM1kPtZ80/a7ywFVC96tdTHt8KUllqJCJMtV10fWQYD7fJZDC+hx
 vdDva1cy0pnJ5B+AW99IAXjMBu5z+dlm0DaLJFK65c9VbyvDYiFFkUvvjnQRStJztxCUCfBtv
 Kyrb0tiHRlBty8wkqQug1YKQKE9i8NOVtubPOwfax+XtyD4mQ3yaWZJQNFrHJnqfKThUZ6xa9
 edl58ThvopBc3j8qFB6JzF3cmHwhJ1ifHTm15Ss/OA5dx7rpFwdXCCB9pM6KIUjX99/oH/woV
 WPncBCLKnt4eQrO+oCqyuCsWxjH1aMCfvZ1ldjj7ZCQyhV6NlnlHipOnRpJldMoN1MYKNvIfK
 DzQPcMMAJngbHaePwinaFdvRgHmdKOH0n5QvsmvI1TWb11X7QNB5ilPj9bY2jI3kbJV9ygsK9
 gLBqs87CTLI+QuE4NJKK5K36FIc=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/2/23 09:49, Akihiko Odaki wrote:
> On 2023/08/02 8:27, Helge Deller wrote:
>> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address for =
all
>> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
>>
>> Additionally modify the elf loader to load dynamic pie executables at
>> around:
>> ~ 0x5500000000=C2=A0 for 64-bit guest binaries on 64-bit host,
>> - 0x00300000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 64-bit host=
, and
>> - 0x00000000=C2=A0=C2=A0=C2=A0 for 32-bit guest binaries on 32-bit host=
.
>
> Why do you change guest addresses depending on the host?

The addresses are guest-addresses.
A 32-bit guest PIE can't be loaded at e.g. 0x5500000000,
while a 64-bit guest PIE needs to be loaded at 0x5500000000.

>> With this patch the Thread Sanitizer (TSan) application will work again=
,
>> as in commit aab613fb9597 ("linux-user: Update TASK_UNMAPPED_BASE for
>> aarch64").
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 linux-user/elfload.c |=C2=A0 6 ++++--
>> =C2=A0 linux-user/loader.h=C2=A0 | 12 ++++++++++++
>> =C2=A0 linux-user/mmap.c=C2=A0=C2=A0=C2=A0 | 35 ++++++++++++++++++-----=
------------
>> =C2=A0 3 files changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 47a118e430..8f5a79b537 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3021,6 +3021,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct elfhdr *ehdr =3D (struct elfhdr *=
)bprm_buf;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct elf_phdr *phdr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong load_addr, load_bias, loaddr, =
hiaddr, error;
>> +=C2=A0=C2=A0=C2=A0 unsigned long load_offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, retval, prot_exec;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_main_executable;
>> @@ -3121,6 +3122,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * select guest_base.=C2=A0 In this case we pass a size.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 probe_guest_base(image_name, 0, hiaddr - loaddr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loa=
d_offset =3D TASK_UNMAPPED_BASE_PIE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> @@ -3138,7 +3140,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In both cases, we will overwrite=
 pages in this range with mappings
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from the executable.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 load_addr =3D target_mmap(loaddr, (size_t)hiaddr - =
loaddr + 1, PROT_NONE,
>> +=C2=A0=C2=A0=C2=A0 load_addr =3D target_mmap(loaddr + load_offset, (si=
ze_t)hiaddr - loaddr + 1, PROT_NONE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (is_main_executable ? MAP_FIXED : 0),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1, 0);
>> @@ -3176,7 +3178,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->start_data =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->end_data =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* possible start for brk is behind all =
sections of this ELF file. */
>> -=C2=A0=C2=A0=C2=A0 info->brk =3D TARGET_PAGE_ALIGN(hiaddr);
>> +=C2=A0=C2=A0=C2=A0 info->brk =3D TARGET_PAGE_ALIGN(load_offset + hiadd=
r);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->elf_flags =3D ehdr->e_flags;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prot_exec =3D PROT_EXEC;
>> diff --git a/linux-user/loader.h b/linux-user/loader.h
>> index 59cbeacf24..3bbfc108eb 100644
>> --- a/linux-user/loader.h
>> +++ b/linux-user/loader.h
>> @@ -18,6 +18,18 @@
>> =C2=A0 #ifndef LINUX_USER_LOADER_H
>> =C2=A0 #define LINUX_USER_LOADER_H
>>
>> +/* where to map binaries? */
>> +#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
>> +# define TASK_UNMAPPED_BASE_PIE 0x5500000000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 0x7000000000
>> +#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
>> +# define TASK_UNMAPPED_BASE_PIE=C2=A0=C2=A0=C2=A0 0x00300000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 (GUEST_ADDR_MAX - 0x2000=
0000 + 1)
>> +#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
>> +# define TASK_UNMAPPED_BASE_PIE=C2=A0=C2=A0=C2=A0 0x00000000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 0x40000000
>> +#endif
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Read a good amount of data initially, to hopefully get a=
ll the
>> =C2=A0=C2=A0 * program headers loaded.
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index c624feead0..3441198e21 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -23,6 +23,7 @@
>> =C2=A0 #include "user-internals.h"
>> =C2=A0 #include "user-mmap.h"
>> =C2=A0 #include "target_mman.h"
>> +#include "loader.h"
>>
>> =C2=A0 static pthread_mutex_t mmap_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>> =C2=A0 static __thread int mmap_lock_count;
>> @@ -295,23 +296,6 @@ static bool mmap_frag(abi_ulong real_start, abi_ul=
ong start, abi_ulong last,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>>
>> -#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
>> -#ifdef TARGET_AARCH64
>> -# define TASK_UNMAPPED_BASE=C2=A0 0x5500000000
>> -#else
>> -# define TASK_UNMAPPED_BASE=C2=A0 0x4000000000
>> -#endif
>> -#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
>> -#ifdef TARGET_HPPA
>> -# define TASK_UNMAPPED_BASE=C2=A0 0xfa000000
>> -#else
>> -# define TASK_UNMAPPED_BASE=C2=A0 0xe0000000
>> -#endif
>> -#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
>> -# define TASK_UNMAPPED_BASE=C2=A0 0x40000000
>> -#endif
>> -abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
>> -
>> =C2=A0 unsigned long last_brk;
>>
>> =C2=A0 /*
>> @@ -344,6 +328,23 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong=
 size, abi_ulong align)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong addr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int wrapped, repeat;
>>
>> +=C2=A0=C2=A0=C2=A0 static abi_ulong mmap_next_start;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* initialize mmap_next_start if necessary */
>> +=C2=A0=C2=A0=C2=A0 if (!mmap_next_start) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmap_next_start =3D TASK_UN=
MAPPED_BASE;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do sanity checks on gues=
t memory layout */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mmap_next_start >=3D GU=
EST_ADDR_MAX) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mma=
p_next_start =3D GUEST_ADDR_MAX - 0x1000000000 + 1;
>
> What if GUEST_ADDR_MAX < 0x1000000000?

this check affects 64-bit executables only where GUEST_ADDR_MAX is bigger
than that number. But I agree it's not directly visible from the code.
32-bit ones are taken care of where TASK_UNMAPPED_BASE is defined.

> I think you can just return a hard error when mmap_next_start >=3D GUEST=
_ADDR_MAX.

Can't happen, but I will rewrite it.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (TASK_UNMAPPED_BASE_PIE =
>=3D mmap_next_start) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Memory too small for PIE executables.\n");
>
> Perhaps it's better to use error_report() for new code.

Ok.

Helge

