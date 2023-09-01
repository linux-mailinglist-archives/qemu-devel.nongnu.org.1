Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6678FF93
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:59:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5bX-0001nK-GL; Fri, 01 Sep 2023 10:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5bU-0001n3-KC
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:58:32 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5bR-0002YG-1u
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693580306; x=1694185106; i=deller@gmx.de;
 bh=r5myozIejJUe6xZDXwltXMMvwOFBx9smAWxCKitEsf0=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Q5p+zfZ3fVUfEdlEh8s80QQIgJdWn4eb/k/Xg00FutmkMnbHpI59JEs+Jf9u5PQ2G7XbQVw
 rLJUW9qH846Mv01NJ3X3T7bOU5f66y8y1nrNxv0toKaRCCDlQC3AByxXEIxzeRE/l8dtnOYYL
 hPGKrLTi+y7vwPGnmxRwzdlmErNYtOmCXMcaFss8mnzqILtTLuyL5E3krYuW0WyzCTuzKfzeY
 rzpTByHBeKlf59Gz8szg65kM/zz9yK+TxWWfcgb9qHmb4cWDO3kWyI9BlXDu/MYtHrBAB2mwC
 cK4p4+Fyw0iL+zOcA08WST/ai6UhF+QVNCkt38OwPD7yt9hj5dtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1qPvza1nhE-00EOhs; Fri, 01
 Sep 2023 16:58:26 +0200
Message-ID: <15405ae0-1422-05f6-eb82-38e8dc9af2bc@gmx.de>
Date: Fri, 1 Sep 2023 16:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/13] linux-user: Use WITH_MMAP_LOCK_GUARD in
 target_{shmat, shmdt}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-12-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230824010237.1379735-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FgkqzTqYqLMK4Pn8cLzf8DTp8H5tNzsYozkX8XO9WiQ+Z24Gps
 3jVTLEr049/KDYuoQy30NWy+eXGn8Zsko+Ye+21ReuXc4Qsab6J1BsdrBBY3H2epY4/Yl9u
 6HoIHxfRpkQz8hE9pibZ9RtqZE+QWTp2KVhaxo+7UB2aI2+JxfJmfGJLgDU0XVc8r6qojKc
 4jyHQZM4b9S136+Jqntfg==
UI-OutboundReport: notjunk:1;M01:P0:RbAbyMyx8Bg=;nwbB7+StiA24b8a/OOtdRZG66R6
 /GIrpXJhCMN/m7f/hFTKpJSiqR12mgzLBo/lJjrPHpOQGRSOtdNlRsnfSO16GvRQ1WZ19wi18
 1qE4KRvTTZTDMDCIOfiuyltwpc88hDz7GkwFoKZnEggS4OmbxgIMwnObGJZXJ2G9Fha5HUpcr
 leAk2yi911B8o3TKQzwv68sQKD0ZsA9E4oY6xU98vLBvfVVMKif8mCKRNUAzyQbVhni/iM/l5
 symukzDdJlyVgevl4DfY361GcNFDHrcQbvqASeu4Yr8vy0MbCG0M3t8BBRnUfDwTRP8sIwW/p
 1piFt0jNBhqNsIhwZ935MtVKAPbxCVWB+D0bPPPYBrxIB/JEaf5CfvFr3ySsMqvy057HznmK6
 xBmFPxzn05PW6k4iJGB1ap9qLkBcovXM1LGHJp4B+ELun0mbb0AfJC0mY3DYjXeGpcqSbINsI
 xRGCS2lobQ7aJdHrjQTulzkn9qx+38g56pW9f80rCMl/4VUFljSKugtNN1zCUuf10dVOUOp4l
 0Nio8n/RjqqPF4lMhLpmKioTn5Mna5cCpDsvCNN8OZMHGBB4f8TEDI1TH73lU7UXXGwPu01SB
 q19Z8OB1GSwFgZ1ChHpngYcvxiB2KMUdN+3UpVvKuIKY8DqR3PqpTV9N4FfCcxZLIKbmeXYFb
 bUUjqPCWNb1pIOZllo/CnC2Kd/WwNKIqTW0WL3KYjmOcdhwA8qo2QtO6Y+92j3KklXqxKowPL
 4fpOby67LIzVfGU5n0TCDM6r+reBlGChi+Mlv4CoNKRV/EL4nzO2L6+MlAkZVn4tJtgGRI8lx
 bC3FF+rM5BitQFGvnuGHwyOzQeQRSQvbPaQU66c+ac2Lu8vKqZlwOQ7h5ZVUmBkiaNquNWWFf
 ZDko+pXJxmVZUHVe+bL6F9LXzuerFjUyFgJiydWfk1yEquKr/6YOAYMTOseGGqjrYaz83cLo6
 vWdGew==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/24/23 03:02, Richard Henderson wrote:
> Move the CF_PARALLEL setting outside of the mmap lock.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   linux-user/mmap.c | 98 ++++++++++++++++++++++-------------------------
>   1 file changed, 46 insertions(+), 52 deletions(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 3aeacd1ecd..f45b2d307c 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1017,9 +1017,8 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int =
shmid,
>   {
>       CPUState *cpu =3D env_cpu(cpu_env);
>       abi_ulong raddr;
> -    void *host_raddr;
>       struct shmid_ds shm_info;
> -    int i, ret;
> +    int ret;
>       abi_ulong shmlba;
>
>       /* shmat pointers are always untagged */
> @@ -1044,7 +1043,43 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int=
 shmid,
>           return -TARGET_EINVAL;
>       }
>
> -    mmap_lock();
> +    WITH_MMAP_LOCK_GUARD() {
> +        void *host_raddr;
> +
> +        if (shmaddr) {
> +            host_raddr =3D shmat(shmid, (void *)g2h_untagged(shmaddr), =
shmflg);
> +        } else {
> +            abi_ulong mmap_start;
> +
> +            /* In order to use the host shmat, we need to honor host SH=
MLBA.  */
> +            mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz,
> +                                       MAX(SHMLBA, shmlba));
> +
> +            if (mmap_start =3D=3D -1) {
> +                return -TARGET_ENOMEM;
> +            }
> +            host_raddr =3D shmat(shmid, g2h_untagged(mmap_start),
> +                               shmflg | SHM_REMAP);
> +        }
> +
> +        if (host_raddr =3D=3D (void *)-1) {
> +            return get_errno(-1);
> +        }
> +        raddr =3D h2g(host_raddr);
> +
> +        page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
> +                       PAGE_VALID | PAGE_RESET | PAGE_READ |
> +                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
> +
> +        for (int i =3D 0; i < N_SHM_REGIONS; i++) {
> +            if (!shm_regions[i].in_use) {
> +                shm_regions[i].in_use =3D true;
> +                shm_regions[i].start =3D raddr;
> +                shm_regions[i].size =3D shm_info.shm_segsz;
> +                break;
> +            }
> +        }
> +    }
>
>       /*
>        * We're mapping shared memory, so ensure we generate code for par=
allel
> @@ -1057,65 +1092,24 @@ abi_ulong target_shmat(CPUArchState *cpu_env, in=
t shmid,
>           tb_flush(cpu);
>       }
>
> -    if (shmaddr) {
> -        host_raddr =3D shmat(shmid, (void *)g2h_untagged(shmaddr), shmf=
lg);
> -    } else {
> -        abi_ulong mmap_start;
> -
> -        /* In order to use the host shmat, we need to honor host SHMLBA=
.  */
> -        mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA,=
 shmlba));
> -
> -        if (mmap_start =3D=3D -1) {
> -            errno =3D ENOMEM;
> -            host_raddr =3D (void *)-1;
> -        } else {
> -            host_raddr =3D shmat(shmid, g2h_untagged(mmap_start),
> -                               shmflg | SHM_REMAP);
> -        }
> -    }
> -
> -    if (host_raddr =3D=3D (void *)-1) {
> -        mmap_unlock();
> -        return get_errno((intptr_t)host_raddr);
> -    }
> -    raddr =3D h2g((uintptr_t)host_raddr);
> -
> -    page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
> -                   PAGE_VALID | PAGE_RESET | PAGE_READ |
> -                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
> -
> -    for (i =3D 0; i < N_SHM_REGIONS; i++) {
> -        if (!shm_regions[i].in_use) {
> -            shm_regions[i].in_use =3D true;
> -            shm_regions[i].start =3D raddr;
> -            shm_regions[i].size =3D shm_info.shm_segsz;
> -            break;
> -        }
> -    }
> -
> -    mmap_unlock();
>       return raddr;
>   }
>
>   abi_long target_shmdt(abi_ulong shmaddr)
>   {
> -    int i;
>       abi_long rv;
>
>       /* shmdt pointers are always untagged */
>
> -    mmap_lock();
> -
> -    for (i =3D 0; i < N_SHM_REGIONS; ++i) {
> -        if (shm_regions[i].in_use && shm_regions[i].start =3D=3D shmadd=
r) {
> -            shm_regions[i].in_use =3D false;
> -            page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, =
0);
> -            break;
> +    WITH_MMAP_LOCK_GUARD() {
> +        for (int i =3D 0; i < N_SHM_REGIONS; ++i) {
> +            if (shm_regions[i].in_use && shm_regions[i].start =3D=3D sh=
maddr) {
> +                shm_regions[i].in_use =3D false;
> +                page_set_flags(shmaddr, shmaddr + shm_regions[i].size -=
 1, 0);
> +                break;
> +            }
>           }
> +        rv =3D get_errno(shmdt(g2h_untagged(shmaddr)));
>       }
> -    rv =3D get_errno(shmdt(g2h_untagged(shmaddr)));
> -
> -    mmap_unlock();
> -
>       return rv;
>   }


