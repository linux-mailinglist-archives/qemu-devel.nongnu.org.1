Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C77A99F16
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 04:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7moZ-00085f-UL; Wed, 23 Apr 2025 22:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u7moK-00080n-E2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:59:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u7moG-0000Fm-C5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:59:35 -0400
Received: from loongson.cn (unknown [209.85.219.170])
 by gateway (Coremail) with SMTP id _____8DxWOERqQlo0gfFAA--.63856S3;
 Thu, 24 Apr 2025 10:59:30 +0800 (CST)
Received: from mail-yb1-f170.google.com (unknown [209.85.219.170])
 by front1 (Coremail) with SMTP id qMiowMCxLcUOqQlo+teSAA--.35442S3;
 Thu, 24 Apr 2025 10:59:27 +0800 (CST)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-e694601f624so392656276.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 19:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jxaAh5Mgs3eqbijHbOLowo+oMyCbg0RNbq36x59FC5AwA3OVki5Oup9qXSPeigQqbCOsvuBPBxqi@nongnu.org
X-Gm-Message-State: AOJu0Yz6M7xsIXMn9VPmu8SfV5HS9tqb+6vfUDJMt9WhotVegv0EdCu3
 rOcCyHB9uy/MtJRgpa1R3Ak9Yv3F8oZLt3ZMVszCF0VF76xoCtVDuBahPCBOEQF+tTIaJypKq/C
 ZagvkWI3AzfFpM0EMwlcXhpv3C+3x5ezyE6fTIw==
X-Google-Smtp-Source: AGHT+IGHdfFURrQsOgl/zFEeNjcnFOQMTZotfd3nP0JBNSdwdQFBEJOwW0IFXe4RN4uEHykFHFu+8WakQELySInYvuw=
X-Received: by 2002:a05:6902:1691:b0:e6d:f287:be4 with SMTP id
 3f1490d57ef6-e730353a94cmr1639920276.18.1745463566129; Wed, 23 Apr 2025
 19:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-4-wangrui@loongson.cn>
 <56cfe883-2de5-43f6-67db-a05d88a010e9@loongson.cn>
 <a395f6aa-c623-ba7d-2952-5b7249144ba8@loongson.cn>
 <CAHirt9gZEoTi4dnf69Pe0ZWAxFfn3La0=tcGESoATn1WaF4etg@mail.gmail.com>
 <446f7813-4d26-91c7-0baa-098b5c5eb2b0@loongson.cn>
In-Reply-To: <446f7813-4d26-91c7-0baa-098b5c5eb2b0@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Thu, 24 Apr 2025 10:59:15 +0800
X-Gmail-Original-Message-ID: <CAHirt9jbrmTWgRHBYZAN2t_tzF9CJ86Z_=9XxPpkQYbj7WTqzw@mail.gmail.com>
X-Gm-Features: ATxdqUEEGk3I14C3jouKWw9XY_ylfLWB0xuk17Uq_gbroeFI6QzbrB2gzz1B2K4
Message-ID: <CAHirt9jbrmTWgRHBYZAN2t_tzF9CJ86Z_=9XxPpkQYbj7WTqzw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] target/loongarch: Guard 64-bit-only insn
 translation with TRANS64 macro
To: bibo mao <maobibo@loongson.cn>
Cc: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMCxLcUOqQlo+teSAA--.35442S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ury5WF4rAw4UJF1kCry8Zwc_yoW8AF17Ao
 WfXF47JF1xJ3s8urWYk34kt34qvw1xAasxJ3yUJw1UuF9Yq3Wjkw1fCw1DZay3uFWDAFyU
 Wr4fW3Z5Za13Xwn7l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU
 =
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bibo,

On Thu, Apr 24, 2025 at 10:32=E2=80=AFAM bibo mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2025/4/24 =E4=B8=8A=E5=8D=8810:11, WANG Rui wrote:
> > Hi Song,
> >
> > On Thu, Apr 24, 2025 at 9:40=E2=80=AFAM gaosong <gaosong@loongson.cn> w=
rote:
> >>
> >> =E5=9C=A8 2025/4/18 =E4=B8=8B=E5=8D=884:45, bibo mao =E5=86=99=E9=81=
=93:
> >>>
> >>>
> >>> On 2025/4/18 =E4=B8=8B=E5=8D=884:21, WANG Rui wrote:
> >>>> This patch replaces uses of the generic TRANS macro with TRANS64 for
> >>>> instructions that are only valid when 64-bit support is available.
> >>>>
> >>>> This improves correctness and avoids potential assertion failures or
> >>>> undefined behavior during translation on 32-bit-only configurations.
> >>>>
> >>>> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> >>>> ---
> >>>>    .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++-----=
-----
> >>>>    .../tcg/insn_trans/trans_extra.c.inc          |  8 +++--
> >>>>    .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
> >>>>    .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
> >>>>    .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
> >>>>    target/loongarch/translate.h                  |  4 +++
> >>>>    6 files changed, 40 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>> b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>> index 3d70d75941..77eeedbc42 100644
> >>>> --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>> +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>> @@ -74,38 +74,38 @@ TRANS(sc_w, ALL, gen_sc, MO_TESL)
> >>>>    TRANS(ll_d, 64, gen_ll, MO_TEUQ)
> >>>>    TRANS(sc_d, 64, gen_sc, MO_TEUQ)
> >>>>    TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> >>>> -TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>> +TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>>    TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
> >>>> -TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> >>>> +TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> >>>>    TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
> >>>> -TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> >>>> +TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> >>>>    TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
> >>>> -TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >>>> +TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >>>>    TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
> >>>> -TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> >>>> +TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> >>>>    TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL=
)
> >>>> -TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> >>>> +TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ=
)
> >>>>    TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL=
)
> >>>> -TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> >>>> +TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ=
)
> >>>>    TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TES=
L)
> >>>> -TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> >>>> +TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEU=
Q)
> >>>>    TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TES=
L)
> >>>> -TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> >>>> +TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEU=
Q)
> >>>>    TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> >>>> -TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>> +TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>>    TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TE=
SL)
> >>>> -TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ=
)
> >>>> +TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TE=
UQ)
> >>>>    TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TE=
SL)
> >>>> -TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ=
)
> >>>> +TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TE=
UQ)
> >>>>    TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL=
)
> >>>> -TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >>>> +TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ=
)
> >>>>    TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TE=
SL)
> >>>> -TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ=
)
> >>>> +TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TE=
UQ)
> >>>>    TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_T=
ESL)
> >>>> -TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEU=
Q)
> >>>> +TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_T=
EUQ)
> >>>>    TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_T=
ESL)
> >>>> -TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEU=
Q)
> >>>> +TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_T=
EUQ)
> >>>>    TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_=
TESL)
> >>>> -TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TE=
UQ)
> >>>> +TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl,
> >>>> MO_TEUQ)
> >>>>    TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_=
TESL)
> >>>> -TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TE=
UQ)
> >>>> +TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl,
> >>>> MO_TEUQ)
> >>>> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>> b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>> index eda3d6e561..298a80cff5 100644
> >>>> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>> @@ -69,6 +69,10 @@ static bool trans_rdtimeh_w(DisasContext *ctx,
> >>>> arg_rdtimeh_w *a)
> >>>>      static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
> >>>>    {
> >>>> +    if (!avail_64(ctx)) {
> >>>> +        return false;
> >>>> +    }
> >>>> +
> >>>>        return gen_rdtime(ctx, a, 0, 0);
> >>>>    }
> >>>>    @@ -100,8 +104,8 @@ static bool gen_crc(DisasContext *ctx, arg_rr=
r *a,
> >>>>    TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(=
1))
> >>>>    TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(=
2))
> >>>>    TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(=
4))
> >>>> -TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8)=
)
> >>>> +TRANS64(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(=
8))
> >>>>    TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_t=
l(1))
> >>>>    TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_t=
l(2))
> >>>>    TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_t=
l(4))
> >>>> -TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(=
8))
> >>>> +TRANS64(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c,
> >>>> tcg_constant_tl(8))
> >>>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>> b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>> index ecbfe23b63..34cfab8879 100644
> >>>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>> @@ -233,11 +233,11 @@ static bool gen_iocsrwr(DisasContext *ctx,
> >>>> arg_rr *a,
> >>>>    TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
> >>>>    TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
> >>>>    TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
> >>>> -TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> >>>> +TRANS64(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> >>>>    TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
> >>>>    TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
> >>>>    TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
> >>>> -TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> >>>> +TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> >>>>      static void check_mmu_idx(DisasContext *ctx)
> >>>>    {
> >>>> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>> b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>> index 377307785a..136c4c8455 100644
> >>>> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>> @@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE,
> >>>> EXT_SIGN, gen_sra_w)
> >>>>    TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d=
)
> >>>>    TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d=
)
> >>>>    TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d=
)
> >>>> -TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w=
)
> >>>> +TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_=
w)
> >>>>    TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr=
_d)
> >>>>    TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl=
)
> >>>>    TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
> >>>> @@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN,
> >>>> tcg_gen_shri_tl)
> >>>>    TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
> >>>>    TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
> >>>>    TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
> >>>> -TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> >>>> +TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> >>>>    TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_t=
l)
> >>> The modification looks good to me.
> >>>
> >>>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>> b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>> index dff92772ad..a6f5b346bb 100644
> >>>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>> @@ -4853,9 +4853,9 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_=
i
> >>>> *a, MemOp mop,
> >>>>    TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
> >>>>    TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
> >>>>    TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> >>>> -TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> >>>> +TRANS64(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> >>>>    TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> >>>> -TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> >>>> +TRANS64(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> >>> This looks good, only that I do not know whether it is necessary.
> >>> Can you conclude that LSX/LASX means that 64 bit is supported also?
> >>>
> >>> Song, what is your option?
> >>>
> >> I think LSX/LASX is enough
> >>
> >> Hi , WANG Rui
> >> why only these XXX_d vec instructions need  TRANS64?
> >
> > As far as I know, although there are currently no LoongArch 32-bit
> > implementations that support LSX or LASX, the ISA itself does not
> > explicitly forbid such a combination. In other words, LSX/LASX is not
> > inherently tied to a 64-bit base architecture.
> I do not know. it will be better chip guys can give us the answer. LSX
> is 128bit vector instruction, LASX is 256bit vector instruction, I do
> not know how chip guys skip 64bit support and design another LSX/LASX
> instruction.

Actually, this point is clarified in the LoongArch Reference Manual --
Volume II. According to the first section of the document:

The implementation of LSX or LASX is independent of whether the base
architecture is LA32 or LA64. Except for a small number of
instructions that transfer 64-bit data between general-purpose and
vector registers -- which are only required on LA64 -- all other
vector extension instructions can be implemented on either LA32 or
LA64 processors.

>
> > Given this, I chose to mark certain vector instructions --
> > specifically those that access general-purpose registers using 64-bit
> > data width (such as the _d variants) -- as requiring TRANS64. This
> > ensures the backedn correctly handles them in case LSX/LASX support
> > apperars on a 32-bit target in the future.
> If LSX/LASX support will be added 32-bit target, we need indicator
> showing its capability firstly, and then add partial LSX/LASX support,
> rather than do it now.
>
> We are SW developers, rather than chip designers -:)

You're absolutely right -- we're not chip designers -:) But in a way,
what we're doing with software is building a machine that simulates
the ISA. With just a few dozen lines of code, we can easily create a
32-bit virtual CPU that supports vector features. This kind of setup
is already happening in practice, especially for developers using QEMU
to validate 32-bit system software stacks.

That's why I believe it's worthwhile to introduce the necessary
constraints now, to prevent certain vector instructions -- those that
implicitly rely on 64-bit GPR access -- from silently working in
environments where they shouldn't. This patch aims to ensure
correctness and consistency in such simulated or future scenarios.

Regards,
Rui

>
> Regards
> Bibo Mao
> >
> > Let me know if you have other suggestions or if I misunderstood somehin=
g.
> >
> > Regards,
> > Rui
> >
> >>
> >> I just pick up patch1, 2 to loongarch-next .
> >>
> >> Thanks.
> >> Song Gao
> >>> Regards
> >>> Bibo Mao
> >>>>      static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t
> >>>> oprsz, MemOp mop,
> >>>>                           void (*func)(TCGv, TCGv_ptr, tcg_target_lo=
ng))
> >>>> @@ -4886,15 +4886,15 @@ static bool gen_x2g(DisasContext *ctx,
> >>>> arg_rv_i *a, MemOp mop,
> >>>>    TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
> >>>>    TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
> >>>>    TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
> >>>> -TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>> +TRANS64(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>    TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
> >>>>    TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
> >>>>    TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
> >>>> -TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>> +TRANS64(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>    TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
> >>>> -TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>> +TRANS64(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>    TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
> >>>> -TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>> +TRANS64(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>      static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
> >>>>                            uint32_t oprsz, MemOp mop)
> >>>> @@ -4923,11 +4923,11 @@ static bool gvec_dupx(DisasContext *ctx,
> >>>> arg_vr *a, MemOp mop)
> >>>>    TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
> >>>>    TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
> >>>>    TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
> >>>> -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> >>>> +TRANS64(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> >>>>    TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
> >>>>    TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
> >>>>    TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
> >>>> -TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> >>>> +TRANS64(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> >>>>      static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
> >>>>    {
> >>>> diff --git a/target/loongarch/translate.h b/target/loongarch/transla=
te.h
> >>>> index 018dc5eb17..bbe015ba57 100644
> >>>> --- a/target/loongarch/translate.h
> >>>> +++ b/target/loongarch/translate.h
> >>>> @@ -14,6 +14,10 @@
> >>>>        static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> >>>>        { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
> >>>>    +#define TRANS64(NAME, AVAIL, FUNC, ...) \
> >>>> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> >>>> +    { return avail_64(ctx) && avail_##AVAIL(ctx) && FUNC(ctx, a,
> >>>> __VA_ARGS__); }
> >>>> +
> >>>>    #define avail_ALL(C)   true
> >>>>    #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) =
=3D=3D \
> >>>>                            CPUCFG1_ARCH_LA64)
> >>>>
> >>
>


