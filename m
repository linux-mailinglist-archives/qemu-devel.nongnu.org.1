Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4286174F6A5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGul-00009i-Bp; Tue, 11 Jul 2023 13:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGuh-00008v-8z
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:12:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGuc-00048p-MU
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:12:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b852785a65so38908355ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689095549; x=1691687549;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hs3GcnUaZVTZlG0ND6sJOdq5ZIJJBX+RZQnfAJQQvWw=;
 b=Su7XhmxJtV6e+5Jt17W69Jlyk9B1M4IkWZ0pUjIRtTUeashJkTB9FisTo3yq8BVOna
 xXzOKxFVeZI/gwV474/cE2WmHne45pN/JlmtsfJNrwE0YG0nL7QWGkEoYQ4vYbUxPvSb
 9IMqu4IzGI9xOAK3WNOE+bMFHWR52CPyWxdKSzD1qjqD+DmrOLB/aFO8EDT+nPxETzCS
 HN30tAE4rND4JH39/qHOwMGUiI4Q33h/NW/yQFXvPFSMReGFQJif2+6ik29T/rUnmHj9
 tr+QZPj5zmY8uZEXEquVszt9RRu8OMp+roVstAwD4RsWRMtPIKa1wArG5H0xUly4U5Xn
 G1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689095549; x=1691687549;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hs3GcnUaZVTZlG0ND6sJOdq5ZIJJBX+RZQnfAJQQvWw=;
 b=CKTF2aV7whmLAMGrz+h+MjnyZ/LuIP2KHm0q3Lb2YhXsLWdAchO8SoUovhymjgSjiM
 9UP4XQllIKRqyoKgpDbdKNs0zxBClL8C9bp8EACOS5z5Ri8A8WQ499RCmfVn/DynGpsM
 Tt/j1DPUendZfrWgwdUjdHf8aO87/+JsQbZKG2vMLZjLFnnu3YC3L7wKdDY8AVA8KT4l
 HQ6BqRscftcRzrEUFP7lmWN2y32dJFKyEXtN41u82AGTgJXWVOqRe7b1s8VzxaxjSMdh
 CYNMfvoXnSOmn8U8c40CQmYHfTZcNXQvUx0l/SRuY6BXPTO3TJwrIFNyAbuTXT55on6J
 LcgQ==
X-Gm-Message-State: ABy/qLbV1DKCYgMz8D4SkFZal1+coUgAvdMXklLkbA9vzqqg2NYpOda9
 k1FytEKK7l0T3zr4q/R6x3Zryg==
X-Google-Smtp-Source: APBJJlGIVLo+usP4Y5fV5I18LDcZMd2MGauNnPYmnMpOYhj/F+XPZ/LiodIh/uhk80Er16Hudqeeng==
X-Received: by 2002:a17:902:d482:b0:1b9:e23b:bb70 with SMTP id
 c2-20020a170902d48200b001b9e23bbb70mr9013649plg.11.1689095548969; 
 Tue, 11 Jul 2023 10:12:28 -0700 (PDT)
Received: from [10.11.0.74] (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 y24-20020a1709029b9800b001ac5896e96esm2161698plp.207.2023.07.11.10.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 10:12:28 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------a3RrFshx5nAbSA1Wrk0txLGf"
Message-ID: <75d71121-a073-2644-b96f-f3aedd8c040a@sifive.com>
Date: Wed, 12 Jul 2023 01:12:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 12/15] target/riscv: Add Zvkg ISA extension support
From: Max Chou <max.chou@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
References: <20230702155354.2478495-1-max.chou@sifive.com>
 <20230702155354.2478495-13-max.chou@sifive.com>
 <f943fa94-d105-da53-28e0-04b7afeba165@ventanamicro.com>
 <9922287f-7852-1167-51ac-53b977c94a94@sifive.com>
 <CAKmqyKP4_oyqHD+dfBJmKX6nuJA4bfgRSi8LUWYOQG9FQ06DEg@mail.gmail.com>
 <68b4d934-5500-4989-fee0-cf57d16b6436@sifive.com>
Content-Language: en-US
In-Reply-To: <68b4d934-5500-4989-fee0-cf57d16b6436@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a multi-part message in MIME format.
--------------a3RrFshx5nAbSA1Wrk0txLGf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/7/11 11:57 AM, Max Chou wrote:

> On 2023/7/11 11:15 AM, Alistair Francis wrote:
>
>> On Mon, Jul 10, 2023 at 6:37 PM Max Chou<max.chou@sifive.com>  wrote:
>>> On 2023/7/8 5:25 PM, Daniel Henrique Barboza wrote:
>>>
>>>> Hi,
>>>>
>>>> This patch breaks some gitlab runners because of this:
>>>>
>>>> On 7/2/23 12:53, Max Chou wrote:
>>>>> From: Nazar Kazakov<nazar.kazakov@codethink.co.uk>
>>>>>
>>>>> This commit adds support for the Zvkg vector-crypto extension, which
>>>>> consists of the following instructions:
>>>>>
>>>>> * vgmul.vv
>>>>> * vghsh.vv
>>>>>
>>>>> Translation functions are defined in
>>>>> `target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
>>>>> `target/riscv/vcrypto_helper.c`.
>>>>>
>>>>> Co-authored-by: Lawrence Hunter<lawrence.hunter@codethink.co.uk>
>>>>> [max.chou@sifive.com: Replaced vstart checking by TCG op]
>>>>> Signed-off-by: Lawrence Hunter<lawrence.hunter@codethink.co.uk>
>>>>> Signed-off-by: Nazar Kazakov<nazar.kazakov@codethink.co.uk>
>>>>> Signed-off-by: Max Chou<max.chou@sifive.com>
>>>>> Reviewed-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>>>>> [max.chou@sifive.com: Exposed x-zvkg property]
>>>>> ---
>>>>>    target/riscv/cpu.c                       |  6 +-
>>>>>    target/riscv/cpu_cfg.h                   |  1 +
>>>>>    target/riscv/helper.h                    |  3 +
>>>>>    target/riscv/insn32.decode               |  4 ++
>>>>>    target/riscv/insn_trans/trans_rvvk.c.inc | 30 ++++++++++
>>>>>    target/riscv/vcrypto_helper.c            | 72 ++++++++++++++++++++++++
>>>>>    6 files changed, 114 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>> index 08b8355f52..699ab5e9fa 100644
>>>>> --- a/target/riscv/cpu.c
>>>>> +++ b/target/riscv/cpu.c
>>>>> @@ -118,6 +118,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
>>>>>        ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>>>>>        ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>>>>>        ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
>>>>> +    ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>>>>>        ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
>>>>>        ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
>>>>>        ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
>>>>> @@ -1194,8 +1195,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU
>>>>> *cpu, Error **errp)
>>>>>         * In principle Zve*x would also suffice here, were they supported
>>>>>         * in qemu
>>>>>         */
>>>>> -    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned ||
>>>>> cpu->cfg.ext_zvknha ||
>>>>> -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
>>>>> +    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg ||
>>>>> cpu->cfg.ext_zvkned ||
>>>>> +         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksh) &&
>>>>> !cpu->cfg.ext_zve32f) {
>>>>>            error_setg(errp,
>>>>>                       "Vector crypto extensions require V or Zve*
>>>>> extensions");
>>>>>            return;
>>>>> @@ -1710,6 +1711,7 @@ static Property riscv_cpu_extensions[] = {
>>>>>        /* Vector cryptography extensions */
>>>>>        DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
>>>>>        DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
>>>>> +    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
>>>>>        DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
>>>>>        DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
>>>>>        DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
>>>>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>>>>> index 27062b12a8..960761c479 100644
>>>>> --- a/target/riscv/cpu_cfg.h
>>>>> +++ b/target/riscv/cpu_cfg.h
>>>>> @@ -85,6 +85,7 @@ struct RISCVCPUConfig {
>>>>>        bool ext_zve64d;
>>>>>        bool ext_zvbb;
>>>>>        bool ext_zvbc;
>>>>> +    bool ext_zvkg;
>>>>>        bool ext_zvkned;
>>>>>        bool ext_zvknha;
>>>>>        bool ext_zvknhb;
>>>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>>>> index 172c91c65c..238343cb42 100644
>>>>> --- a/target/riscv/helper.h
>>>>> +++ b/target/riscv/helper.h
>>>>> @@ -1244,3 +1244,6 @@ DEF_HELPER_5(vsha2cl64_vv, void, ptr, ptr, ptr,
>>>>> env, i32)
>>>>>      DEF_HELPER_5(vsm3me_vv, void, ptr, ptr, ptr, env, i32)
>>>>>    DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
>>>>> +
>>>>> +DEF_HELPER_5(vghsh_vv, void, ptr, ptr, ptr, env, i32)
>>>>> +DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
>>>>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>>>>> index 5ca83e8462..b10497afd3 100644
>>>>> --- a/target/riscv/insn32.decode
>>>>> +++ b/target/riscv/insn32.decode
>>>>> @@ -957,3 +957,7 @@ vsha2cl_vv  101111 1 ..... ..... 010 .....
>>>>> 1110111 @r_vm_1
>>>>>    # *** Zvksh vector crypto extension ***
>>>>>    vsm3me_vv   100000 1 ..... ..... 010 ..... 1110111 @r_vm_1
>>>>>    vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
>>>>> +
>>>>> +# *** Zvkg vector crypto extension ***
>>>>> +vghsh_vv    101100 1 ..... ..... 010 ..... 1110111 @r_vm_1
>>>>> +vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
>>>>> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc
>>>>> b/target/riscv/insn_trans/trans_rvvk.c.inc
>>>>> index 6469dd2f02..af7cd62e7d 100644
>>>>> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
>>>>> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
>>>>> @@ -531,3 +531,33 @@ static inline bool vsm3c_check(DisasContext *s,
>>>>> arg_rmrr *a)
>>>>>      GEN_VV_UNMASKED_TRANS(vsm3me_vv, vsm3me_check, ZVKSH_EGS)
>>>>>    GEN_VI_UNMASKED_TRANS(vsm3c_vi, vsm3c_check, ZVKSH_EGS)
>>>>> +
>>>>> +/*
>>>>> + * Zvkg
>>>>> + */
>>>>> +
>>>>> +#define ZVKG_EGS 4
>>>>> +
>>>>> +static bool vgmul_check(DisasContext *s, arg_rmr *a)
>>>>> +{
>>>>> +    int egw_bytes = ZVKG_EGS << s->sew;
>>>>> +    return s->cfg_ptr->ext_zvkg == true &&
>>>>> +           vext_check_isa_ill(s) &&
>>>>> +           require_rvv(s) &&
>>>>> +           MAXSZ(s) >= egw_bytes &&
>>>>> +           vext_check_ss(s, a->rd, a->rs2, a->vm) &&
>>>>> +           s->sew == MO_32;
>>>>> +}
>>>>> +
>>>>> +GEN_V_UNMASKED_TRANS(vgmul_vv, vgmul_check, ZVKG_EGS)
>>>>> +
>>>>> +static bool vghsh_check(DisasContext *s, arg_rmrr *a)
>>>>> +{
>>>>> +    int egw_bytes = ZVKG_EGS << s->sew;
>>>>> +    return s->cfg_ptr->ext_zvkg == true &&
>>>>> +           opivv_check(s, a) &&
>>>>> +           MAXSZ(s) >= egw_bytes &&
>>>>> +           s->sew == MO_32;
>>>>> +}
>>>>> +
>>>>> +GEN_VV_UNMASKED_TRANS(vghsh_vv, vghsh_check, ZVKG_EGS)
>>>>> diff --git a/target/riscv/vcrypto_helper.c
>>>>> b/target/riscv/vcrypto_helper.c
>>>>> index ff7fb11928..f127fc0d3a 100644
>>>>> --- a/target/riscv/vcrypto_helper.c
>>>>> +++ b/target/riscv/vcrypto_helper.c
>>>>> @@ -769,3 +769,75 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void
>>>>> *vs2_vptr, uint32_t uimm,
>>>>>        vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
>>>>>        env->vstart = 0;
>>>>>    }
>>>>> +
>>>>> +void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
>>>>> +                      CPURISCVState *env, uint32_t desc)
>>>>> +{
>>>>> +    uint64_t *vd = vd_vptr;
>>>>> +    uint64_t *vs1 = vs1_vptr;
>>>>> +    uint64_t *vs2 = vs2_vptr;
>>>>> +    uint32_t vta = vext_vta(desc);
>>>>> +    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
>>>>> +
>>>>> +    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
>>>>> +        uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
>>>>> +        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
>>>>> +        uint64_t X[2] = {vs1[i * 2 + 0], vs1[i * 2 + 1]};
>>>>> +        uint64_t Z[2] = {0, 0};
>>>>> +
>>>>> +        uint64_t S[2] = {brev8(Y[0] ^ X[0]), brev8(Y[1] ^ X[1])};
>>>>> +
>>>>> +        for (uint j = 0; j < 128; j++) {
>>>> ^
>>>>
>>>> and this
>>>>
>>>>      FAILED:
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj
>>>>      i686-w64-mingw32-gcc -m32 -Ilibqemu-riscv64-softmmu.fa.p -I. -I..
>>>>      -Itarget/riscv -I../target/riscv -Isubprojects/dtc/libfdt
>>>>      -I../subprojects/dtc/libfdt -Iqapi -Itrace -Iui -Iui/shader
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-1
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
>>>>      -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11
>>>> -O2 -g
>>>>      -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
>>>>      -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
>>>>      -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
>>>>      -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
>>>>      -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
>>>>      -Wmissing-format-attribute -Wno-missing-include-dirs
>>>>      -Wno-shift-negative-value -Wno-psabi -iquote . -iquote
>>>>      /builds/danielhb/qemu -iquote /builds/danielhb/qemu/include -iquote
>>>>      /builds/danielhb/qemu/host/include/i386 -iquote
>>>>      /builds/danielhb/qemu/host/include/generic -iquote
>>>>      /builds/danielhb/qemu/tcg/i386 -mms-bitfields -D_GNU_SOURCE
>>>>      -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
>>>>      -fno-common -fwrapv -fno-pie -no-pie -DNEED_CPU_H
>>>>      '-DCONFIG_TARGET="riscv64-softmmu-config-target.h"'
>>>>      '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -MF
>>>> libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj.d -o
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -c
>>>>      ../target/riscv/vcrypto_helper.c
>>>>      ../target/riscv/vcrypto_helper.c: In function 'helper_vghsh_vv':
>>>>      ../target/riscv/vcrypto_helper.c:791:14: error: unknown type name
>>>>      'uint'; did you mean 'u_int'?
>>>>        791 |         for (uint j = 0; j < 128; j++) {
>>>>            |              ^~~~
>>>>            |              u_int
>>>>      ../target/riscv/vcrypto_helper.c: In function 'helper_vgmul_vv':
>>>>      ../target/riscv/vcrypto_helper.c:825:14: error: unknown type name
>>>>      'uint'; did you mean 'u_int'?
>>>>        825 |         for (uint j = 0; j < 128; j++) {
>>>>            |              ^~~~
>>>>            |              u_int
>>>>      [2503/3700] Compiling C object
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vector_helper.c.obj
>>>>
>>>>
>>>> If you want to take a look yourself:
>>>>
>>>> https://gitlab.com/danielhb/qemu/-/jobs/4615946161
>>>>
>>>> The fix is to use 'int' instead of 'uint' in both cases.
>>>>
>>>> I apologize for noticing the error this late. I haven't had the chance
>>>> to run
>>>> Gitlab runners in these patches until now.
>>>>
>>>> Alistair, in case you decide to take this series you'll have to amend
>>>> this
>>>> in-tree I'm afraid. It's too late to ask for another review.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>>
>>>> Daniel
>>> Hi Daniel,
>>>
>>> Thanks you for the testing and notification.
>>> If this series are not be taken at the 8.1 feature freeze (July 11th),
>>> I'll provide the next version with the fix.
>> Hey Max,
>>
>> Thanks for the patches. Unfortunately they won't make the feature
>> freeze. They depend on other patches and I haven't gotten a chance to
>> look at them yet. If you can send a new version I can start reviewing
>> and apply them to my tree in preparation of the next release
>>
>> Alistair
> Hi Alistair,
>
> No problem, I'll send a new version based on the riscv-to-apply.next branch.
>
> Thanks,
> Max
Hi Alistair,

The v8 patches rebase to the riscv-to-apply.next branch and include the
fix of the cross win32 build issue.
https://patchew.org/QEMU/20230711165917.2629866-1-max.chou@sifive.com/

Thanks,
Max

>>> Thanks,
>>>
>>> Max
>>>
>>>>> +            if ((S[j / 64] >> (j % 64)) & 1) {
>>>>> +                Z[0] ^= H[0];
>>>>> +                Z[1] ^= H[1];
>>>>> +            }
>>>>> +            bool reduce = ((H[1] >> 63) & 1);
>>>>> +            H[1] = H[1] << 1 | H[0] >> 63;
>>>>> +            H[0] = H[0] << 1;
>>>>> +            if (reduce) {
>>>>> +                H[0] ^= 0x87;
>>>>> +            }
>>>>> +        }
>>>>> +
>>>>> +        vd[i * 2 + 0] = brev8(Z[0]);
>>>>> +        vd[i * 2 + 1] = brev8(Z[1]);
>>>>> +    }
>>>>> +    /* set tail elements to 1s */
>>>>> +    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
>>>>> +    env->vstart = 0;
>>>>> +}
>>>>> +
>>>>> +void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState
>>>>> *env,
>>>>> +                      uint32_t desc)
>>>>> +{
>>>>> +    uint64_t *vd = vd_vptr;
>>>>> +    uint64_t *vs2 = vs2_vptr;
>>>>> +    uint32_t vta = vext_vta(desc);
>>>>> +    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
>>>>> +
>>>>> +    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
>>>>> +        uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
>>>>> +        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
>>>>> +        uint64_t Z[2] = {0, 0};
>>>>> +
>>>>> +        for (uint j = 0; j < 128; j++) {
>>>> ^
>>>>
>>>> The error being thrown:
>>>>
>>>>      FAILED:
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj
>>>>      i686-w64-mingw32-gcc -m32 -Ilibqemu-riscv64-softmmu.fa.p -I. -I..
>>>>      -Itarget/riscv -I../target/riscv -Isubprojects/dtc/libfdt
>>>>      -I../subprojects/dtc/libfdt -Iqapi -Itrace -Iui -Iui/shader
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-1
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
>>>>      -I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
>>>>      -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11
>>>> -O2 -g
>>>>      -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
>>>>      -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
>>>>      -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
>>>>      -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
>>>>      -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
>>>>      -Wmissing-format-attribute -Wno-missing-include-dirs
>>>>      -Wno-shift-negative-value -Wno-psabi -iquote . -iquote
>>>>      /builds/danielhb/qemu -iquote /builds/danielhb/qemu/include -iquote
>>>>      /builds/danielhb/qemu/host/include/i386 -iquote
>>>>      /builds/danielhb/qemu/host/include/generic -iquote
>>>>      /builds/danielhb/qemu/tcg/i386 -mms-bitfields -D_GNU_SOURCE
>>>>      -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
>>>>      -fno-common -fwrapv -fno-pie -no-pie -DNEED_CPU_H
>>>>      '-DCONFIG_TARGET="riscv64-softmmu-config-target.h"'
>>>>      '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -MF
>>>> libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj.d -o
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -c
>>>>      ../target/riscv/vcrypto_helper.c
>>>>      ../target/riscv/vcrypto_helper.c: In function 'helper_vghsh_vv':
>>>>      ../target/riscv/vcrypto_helper.c:791:14: error: unknown type name
>>>>      'uint'; did you mean 'u_int'?
>>>>        791 |         for (uint j = 0; j < 128; j++) {
>>>>            |              ^~~~
>>>>            |              u_int
>>>>      ../target/riscv/vcrypto_helper.c: In function 'helper_vgmul_vv':
>>>>      ../target/riscv/vcrypto_helper.c:825:14: error: unknown type name
>>>>      'uint'; did you mean 'u_int'?
>>>>        825 |         for (uint j = 0; j < 128; j++) {
>>>>            |              ^~~~
>>>>            |              u_int
>>>>      [2503/3700] Compiling C object
>>>>      libqemu-riscv64-softmmu.fa.p/target_riscv_vector_helper.c.obj
>>>>
>>>>
>>>>> +            if ((Y[j / 64] >> (j % 64)) & 1) {
>>>>> +                Z[0] ^= H[0];
>>>>> +                Z[1] ^= H[1];
>>>>> +            }
>>>>> +            bool reduce = ((H[1] >> 63) & 1);
>>>>> +            H[1] = H[1] << 1 | H[0] >> 63;
>>>>> +            H[0] = H[0] << 1;
>>>>> +            if (reduce) {
>>>>> +                H[0] ^= 0x87;
>>>>> +            }
>>>>> +        }
>>>>> +
>>>>> +        vd[i * 2 + 0] = brev8(Z[0]);
>>>>> +        vd[i * 2 + 1] = brev8(Z[1]);
>>>>> +    }
>>>>> +    /* set tail elements to 1s */
>>>>> +    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
>>>>> +    env->vstart = 0;
>>>>> +}
--------------a3RrFshx5nAbSA1Wrk0txLGf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 2023/7/11 11:57 AM, Max Chou wrote:<br>
    </p>
    <blockquote type="cite"
      cite="mid:68b4d934-5500-4989-fee0-cf57d16b6436@sifive.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>On 2023/7/11 11:15 AM, Alistair Francis wrote:<br>
      </p>
      <blockquote type="cite"
cite="mid:CAKmqyKP4_oyqHD+dfBJmKX6nuJA4bfgRSi8LUWYOQG9FQ06DEg@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Mon, Jul 10, 2023 at 6:37 PM Max Chou <a class="moz-txt-link-rfc2396E" href="mailto:max.chou@sifive.com" moz-do-not-send="true">&lt;max.chou@sifive.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 2023/7/8 5:25 PM, Daniel Henrique Barboza wrote:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Hi,

This patch breaks some gitlab runners because of this:

On 7/2/23 12:53, Max Chou wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Nazar Kazakov <a class="moz-txt-link-rfc2396E" href="mailto:nazar.kazakov@codethink.co.uk" moz-do-not-send="true">&lt;nazar.kazakov@codethink.co.uk&gt;</a>

This commit adds support for the Zvkg vector-crypto extension, which
consists of the following instructions:

* vgmul.vv
* vghsh.vv

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Co-authored-by: Lawrence Hunter <a class="moz-txt-link-rfc2396E" href="mailto:lawrence.hunter@codethink.co.uk" moz-do-not-send="true">&lt;lawrence.hunter@codethink.co.uk&gt;</a>
[<a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:max.chou@sifive.com" moz-do-not-send="true">max.chou@sifive.com</a>: Replaced vstart checking by TCG op]
Signed-off-by: Lawrence Hunter <a class="moz-txt-link-rfc2396E" href="mailto:lawrence.hunter@codethink.co.uk" moz-do-not-send="true">&lt;lawrence.hunter@codethink.co.uk&gt;</a>
Signed-off-by: Nazar Kazakov <a class="moz-txt-link-rfc2396E" href="mailto:nazar.kazakov@codethink.co.uk" moz-do-not-send="true">&lt;nazar.kazakov@codethink.co.uk&gt;</a>
Signed-off-by: Max Chou <a class="moz-txt-link-rfc2396E" href="mailto:max.chou@sifive.com" moz-do-not-send="true">&lt;max.chou@sifive.com&gt;</a>
Reviewed-by: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com" moz-do-not-send="true">&lt;dbarboza@ventanamicro.com&gt;</a>
[<a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:max.chou@sifive.com" moz-do-not-send="true">max.chou@sifive.com</a>: Exposed x-zvkg property]
---
  target/riscv/cpu.c                       |  6 +-
  target/riscv/cpu_cfg.h                   |  1 +
  target/riscv/helper.h                    |  3 +
  target/riscv/insn32.decode               |  4 ++
  target/riscv/insn_trans/trans_rvvk.c.inc | 30 ++++++++++
  target/riscv/vcrypto_helper.c            | 72 ++++++++++++++++++++++++
  6 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08b8355f52..699ab5e9fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -118,6 +118,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
      ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
      ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
      ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
      ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
@@ -1194,8 +1195,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU
*cpu, Error **errp)
       * In principle Zve*x would also suffice here, were they supported
       * in qemu
       */
-    if ((cpu-&gt;cfg.ext_zvbb || cpu-&gt;cfg.ext_zvkned ||
cpu-&gt;cfg.ext_zvknha ||
-         cpu-&gt;cfg.ext_zvksh) &amp;&amp; !cpu-&gt;cfg.ext_zve32f) {
+    if ((cpu-&gt;cfg.ext_zvbb || cpu-&gt;cfg.ext_zvkg ||
cpu-&gt;cfg.ext_zvkned ||
+         cpu-&gt;cfg.ext_zvknha || cpu-&gt;cfg.ext_zvksh) &amp;&amp;
!cpu-&gt;cfg.ext_zve32f) {
          error_setg(errp,
                     "Vector crypto extensions require V or Zve*
extensions");
          return;
@@ -1710,6 +1711,7 @@ static Property riscv_cpu_extensions[] = {
      /* Vector cryptography extensions */
      DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
      DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
+    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
      DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
      DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
      DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 27062b12a8..960761c479 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -85,6 +85,7 @@ struct RISCVCPUConfig {
      bool ext_zve64d;
      bool ext_zvbb;
      bool ext_zvbc;
+    bool ext_zvkg;
      bool ext_zvkned;
      bool ext_zvknha;
      bool ext_zvknhb;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 172c91c65c..238343cb42 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1244,3 +1244,6 @@ DEF_HELPER_5(vsha2cl64_vv, void, ptr, ptr, ptr,
env, i32)
    DEF_HELPER_5(vsm3me_vv, void, ptr, ptr, ptr, env, i32)
  DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
+
+DEF_HELPER_5(vghsh_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5ca83e8462..b10497afd3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -957,3 +957,7 @@ vsha2cl_vv  101111 1 ..... ..... 010 .....
1110111 @r_vm_1
  # *** Zvksh vector crypto extension ***
  vsm3me_vv   100000 1 ..... ..... 010 ..... 1110111 @r_vm_1
  vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
+
+# *** Zvkg vector crypto extension ***
+vghsh_vv    101100 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc
b/target/riscv/insn_trans/trans_rvvk.c.inc
index 6469dd2f02..af7cd62e7d 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -531,3 +531,33 @@ static inline bool vsm3c_check(DisasContext *s,
arg_rmrr *a)
    GEN_VV_UNMASKED_TRANS(vsm3me_vv, vsm3me_check, ZVKSH_EGS)
  GEN_VI_UNMASKED_TRANS(vsm3c_vi, vsm3c_check, ZVKSH_EGS)
+
+/*
+ * Zvkg
+ */
+
+#define ZVKG_EGS 4
+
+static bool vgmul_check(DisasContext *s, arg_rmr *a)
+{
+    int egw_bytes = ZVKG_EGS &lt;&lt; s-&gt;sew;
+    return s-&gt;cfg_ptr-&gt;ext_zvkg == true &amp;&amp;
+           vext_check_isa_ill(s) &amp;&amp;
+           require_rvv(s) &amp;&amp;
+           MAXSZ(s) &gt;= egw_bytes &amp;&amp;
+           vext_check_ss(s, a-&gt;rd, a-&gt;rs2, a-&gt;vm) &amp;&amp;
+           s-&gt;sew == MO_32;
+}
+
+GEN_V_UNMASKED_TRANS(vgmul_vv, vgmul_check, ZVKG_EGS)
+
+static bool vghsh_check(DisasContext *s, arg_rmrr *a)
+{
+    int egw_bytes = ZVKG_EGS &lt;&lt; s-&gt;sew;
+    return s-&gt;cfg_ptr-&gt;ext_zvkg == true &amp;&amp;
+           opivv_check(s, a) &amp;&amp;
+           MAXSZ(s) &gt;= egw_bytes &amp;&amp;
+           s-&gt;sew == MO_32;
+}
+
+GEN_VV_UNMASKED_TRANS(vghsh_vv, vghsh_check, ZVKG_EGS)
diff --git a/target/riscv/vcrypto_helper.c
b/target/riscv/vcrypto_helper.c
index ff7fb11928..f127fc0d3a 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -769,3 +769,75 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void
*vs2_vptr, uint32_t uimm,
      vext_set_elems_1s(vd_vptr, vta, env-&gt;vl * esz, total_elems * esz);
      env-&gt;vstart = 0;
  }
+
+void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
+                      CPURISCVState *env, uint32_t desc)
+{
+    uint64_t *vd = vd_vptr;
+    uint64_t *vs1 = vs1_vptr;
+    uint64_t *vs2 = vs2_vptr;
+    uint32_t vta = vext_vta(desc);
+    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
+
+    for (uint32_t i = env-&gt;vstart / 4; i &lt; env-&gt;vl / 4; i++) {
+        uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
+        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
+        uint64_t X[2] = {vs1[i * 2 + 0], vs1[i * 2 + 1]};
+        uint64_t Z[2] = {0, 0};
+
+        uint64_t S[2] = {brev8(Y[0] ^ X[0]), brev8(Y[1] ^ X[1])};
+
+        for (uint j = 0; j &lt; 128; j++) {
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">^

and this

    FAILED:
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj
    i686-w64-mingw32-gcc -m32 -Ilibqemu-riscv64-softmmu.fa.p -I. -I..
    -Itarget/riscv -I../target/riscv -Isubprojects/dtc/libfdt
    -I../subprojects/dtc/libfdt -Iqapi -Itrace -Iui -Iui/shader
    -I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-1
    -I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
    -I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
    -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11
-O2 -g
    -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
    -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
    -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
    -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
    -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
    -Wmissing-format-attribute -Wno-missing-include-dirs
    -Wno-shift-negative-value -Wno-psabi -iquote . -iquote
    /builds/danielhb/qemu -iquote /builds/danielhb/qemu/include -iquote
    /builds/danielhb/qemu/host/include/i386 -iquote
    /builds/danielhb/qemu/host/include/generic -iquote
    /builds/danielhb/qemu/tcg/i386 -mms-bitfields -D_GNU_SOURCE
    -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
    -fno-common -fwrapv -fno-pie -no-pie -DNEED_CPU_H
    '-DCONFIG_TARGET="riscv64-softmmu-config-target.h"'
    '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -MF
libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj.d -o
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -c
    ../target/riscv/vcrypto_helper.c
    ../target/riscv/vcrypto_helper.c: In function 'helper_vghsh_vv':
    ../target/riscv/vcrypto_helper.c:791:14: error: unknown type name
    'uint'; did you mean 'u_int'?
      791 |         for (uint j = 0; j &lt; 128; j++) {
          |              ^~~~
          |              u_int
    ../target/riscv/vcrypto_helper.c: In function 'helper_vgmul_vv':
    ../target/riscv/vcrypto_helper.c:825:14: error: unknown type name
    'uint'; did you mean 'u_int'?
      825 |         for (uint j = 0; j &lt; 128; j++) {
          |              ^~~~
          |              u_int
    [2503/3700] Compiling C object
    libqemu-riscv64-softmmu.fa.p/target_riscv_vector_helper.c.obj


If you want to take a look yourself:

<a class="moz-txt-link-freetext" href="https://gitlab.com/danielhb/qemu/-/jobs/4615946161" moz-do-not-send="true">https://gitlab.com/danielhb/qemu/-/jobs/4615946161</a>

The fix is to use 'int' instead of 'uint' in both cases.

I apologize for noticing the error this late. I haven't had the chance
to run
Gitlab runners in these patches until now.

Alistair, in case you decide to take this series you'll have to amend
this
in-tree I'm afraid. It's too late to ask for another review.


Thanks,


Daniel
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Hi Daniel,

Thanks you for the testing and notification.
If this series are not be taken at the 8.1 feature freeze (July 11th),
I'll provide the next version with the fix.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Hey Max,

Thanks for the patches. Unfortunately they won't make the feature
freeze. They depend on other patches and I haven't gotten a chance to
look at them yet. If you can send a new version I can start reviewing
and apply them to my tree in preparation of the next release

Alistair</pre>
      </blockquote>
      <pre>Hi Alistair,

No problem, I'll send a new version based on the riscv-to-apply.next branch.

Thanks,
Max</pre>
    </blockquote>
    Hi Alistair,<br>
    <br>
    The v8 patches rebase to the riscv-to-apply.next branch and include
    the<br>
    fix of the cross win32 build issue.<br>
<a class="moz-txt-link-freetext" href="https://patchew.org/QEMU/20230711165917.2629866-1-max.chou@sifive.com/">https://patchew.org/QEMU/20230711165917.2629866-1-max.chou@sifive.com/</a><br>
    <br>
    Thanks,<br>
    Max<br>
    <br>
    <blockquote type="cite"
      cite="mid:68b4d934-5500-4989-fee0-cf57d16b6436@sifive.com">
      <pre>
</pre>
      <blockquote type="cite"
cite="mid:CAKmqyKP4_oyqHD+dfBJmKX6nuJA4bfgRSi8LUWYOQG9FQ06DEg@mail.gmail.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Thanks,

Max

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+            if ((S[j / 64] &gt;&gt; (j % 64)) &amp; 1) {
+                Z[0] ^= H[0];
+                Z[1] ^= H[1];
+            }
+            bool reduce = ((H[1] &gt;&gt; 63) &amp; 1);
+            H[1] = H[1] &lt;&lt; 1 | H[0] &gt;&gt; 63;
+            H[0] = H[0] &lt;&lt; 1;
+            if (reduce) {
+                H[0] ^= 0x87;
+            }
+        }
+
+        vd[i * 2 + 0] = brev8(Z[0]);
+        vd[i * 2 + 1] = brev8(Z[1]);
+    }
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, env-&gt;vl * 4, total_elems * 4);
+    env-&gt;vstart = 0;
+}
+
+void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState
*env,
+                      uint32_t desc)
+{
+    uint64_t *vd = vd_vptr;
+    uint64_t *vs2 = vs2_vptr;
+    uint32_t vta = vext_vta(desc);
+    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
+
+    for (uint32_t i = env-&gt;vstart / 4; i &lt; env-&gt;vl / 4; i++) {
+        uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
+        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
+        uint64_t Z[2] = {0, 0};
+
+        for (uint j = 0; j &lt; 128; j++) {
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">^

The error being thrown:

    FAILED:
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj
    i686-w64-mingw32-gcc -m32 -Ilibqemu-riscv64-softmmu.fa.p -I. -I..
    -Itarget/riscv -I../target/riscv -Isubprojects/dtc/libfdt
    -I../subprojects/dtc/libfdt -Iqapi -Itrace -Iui -Iui/shader
    -I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-1
    -I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
    -I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
    -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11
-O2 -g
    -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
    -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration
    -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
    -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
    -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
    -Wmissing-format-attribute -Wno-missing-include-dirs
    -Wno-shift-negative-value -Wno-psabi -iquote . -iquote
    /builds/danielhb/qemu -iquote /builds/danielhb/qemu/include -iquote
    /builds/danielhb/qemu/host/include/i386 -iquote
    /builds/danielhb/qemu/host/include/generic -iquote
    /builds/danielhb/qemu/tcg/i386 -mms-bitfields -D_GNU_SOURCE
    -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
    -fno-common -fwrapv -fno-pie -no-pie -DNEED_CPU_H
    '-DCONFIG_TARGET="riscv64-softmmu-config-target.h"'
    '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -MF
libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj.d -o
    libqemu-riscv64-softmmu.fa.p/target_riscv_vcrypto_helper.c.obj -c
    ../target/riscv/vcrypto_helper.c
    ../target/riscv/vcrypto_helper.c: In function 'helper_vghsh_vv':
    ../target/riscv/vcrypto_helper.c:791:14: error: unknown type name
    'uint'; did you mean 'u_int'?
      791 |         for (uint j = 0; j &lt; 128; j++) {
          |              ^~~~
          |              u_int
    ../target/riscv/vcrypto_helper.c: In function 'helper_vgmul_vv':
    ../target/riscv/vcrypto_helper.c:825:14: error: unknown type name
    'uint'; did you mean 'u_int'?
      825 |         for (uint j = 0; j &lt; 128; j++) {
          |              ^~~~
          |              u_int
    [2503/3700] Compiling C object
    libqemu-riscv64-softmmu.fa.p/target_riscv_vector_helper.c.obj


</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+            if ((Y[j / 64] &gt;&gt; (j % 64)) &amp; 1) {
+                Z[0] ^= H[0];
+                Z[1] ^= H[1];
+            }
+            bool reduce = ((H[1] &gt;&gt; 63) &amp; 1);
+            H[1] = H[1] &lt;&lt; 1 | H[0] &gt;&gt; 63;
+            H[0] = H[0] &lt;&lt; 1;
+            if (reduce) {
+                H[0] ^= 0x87;
+            }
+        }
+
+        vd[i * 2 + 0] = brev8(Z[0]);
+        vd[i * 2 + 1] = brev8(Z[1]);
+    }
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, env-&gt;vl * 4, total_elems * 4);
+    env-&gt;vstart = 0;
+}
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------a3RrFshx5nAbSA1Wrk0txLGf--

