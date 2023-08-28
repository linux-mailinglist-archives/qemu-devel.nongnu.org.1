Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D678B678
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag3k-0000aM-VC; Mon, 28 Aug 2023 13:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiegec@aosc.io>) id 1qaffk-0002ea-2g
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:05:04 -0400
Received: from relay3.mymailcheap.com ([217.182.66.161])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiegec@aosc.io>) id 1qafff-0003Tq-Rm
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:05:02 -0400
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id BEC593E988;
 Mon, 28 Aug 2023 19:04:51 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id 8E87C40603;
 Mon, 28 Aug 2023 17:04:51 +0000 (UTC)
Received: from [192.168.1.3] (unknown [223.72.44.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4E9D540696;
 Mon, 28 Aug 2023 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1693242291; bh=ZxfIFvMZHE/RDfmT1nKISC28DmGdx3xM1WtDIG83J4w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bTus6sbs2POWRDUTyA+3sZCTr1K+mcY1F/35V2q6WXEjKY9TlhPoiHjSy/9/TXXhH
 foLJrUL0lMG7o61Jl+s9gZpc8wu7eKJkeNiRWfaF9HpuwmO9lB/rGabHNrf0XenwOw
 lb41elCPTQa0xV0PxOtaHU2dbVFvsgo9L/thnfKI=
Message-ID: <65f6d07a-36c4-a65f-91be-d2fe2d978e75@aosc.io>
Date: Tue, 29 Aug 2023 01:04:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 02/11] tcg/loongarch64: Lower basic tcg vec ops to LSX
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-3-c@jia.je>
 <692c49da-af4d-3913-cf82-726294a0d792@linaro.org>
From: Jiajie Chen <jiegec@aosc.io>
In-Reply-To: <692c49da-af4d-3913-cf82-726294a0d792@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E87C40603
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
Received-SPF: permerror client-ip=217.182.66.161; envelope-from=jiegec@aosc.io;
 helo=relay3.mymailcheap.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Aug 2023 13:29:45 -0400
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

There seems to some problem with the email server, try my another email 
address to send this email.


On 2023/8/29 00:57, Richard Henderson wrote:
> On 8/28/23 08:19, Jiajie Chen wrote:
>> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned 
>> vece,
>> +                             TCGReg rd, int64_t v64)
>> +{
>> +    /* Try vldi if imm can fit */
>> +    if (vece <= MO_32 && (-0x200 <= v64 && v64 <= 0x1FF)) {
>> +        uint32_t imm = (vece << 10) | ((uint32_t)v64 & 0x3FF);
>> +        tcg_out_opc_vldi(s, rd, imm);
>> +        return;
>> +    }
>
> v64 has the value replicated across 64 bits.
> In order to do the comparison above, you'll want
>
>     int64_t vale = sextract64(v64, 0, 8 << vece);
>     if (-0x200 <= vale && vale <= 0x1ff)
>         ...
>
> Since the only documentation for LSX is qemu's own translator code, 
> why are you testing vece <= MO_32?  MO_64 should be available as 
> well?  Or is there a bug in trans_vldi()?


Sorry, my mistake. I was messing MO_64 with bit 12 in vldi imm.


>
> It might be nice to leave a to-do for vldi imm bit 12 set, for the 
> patterns expanded by vldi_get_value().  In particular, mode == 9 is 
> likely to be useful, and modes {1,2,3,5} are easy to test for.
>

Sure, I was thinking about the complexity of pattern matching on those 
modes, and decided to skip the hard part in the first patch series.


>
>> +
>> +    /* Fallback to vreplgr2vr */
>> +    tcg_out_movi(s, type, TCG_REG_TMP0, v64);
>
> type is a vector type; you can't use it here.
> Correct would be TCG_TYPE_I64.
>
> Better to load vale instead, since that will take fewer insns in 
> tcg_out_movi.


Sure.


>
>
>> +static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>> +                           unsigned vecl, unsigned vece,
>> +                           const TCGArg args[TCG_MAX_OP_ARGS],
>> +                           const int const_args[TCG_MAX_OP_ARGS])
>> +{
>> +    TCGType type = vecl + TCG_TYPE_V64;
>> +    TCGArg a0, a1, a2;
>> +    TCGReg base;
>> +    TCGReg temp = TCG_REG_TMP0;
>> +    int32_t offset;
>> +
>> +    a0 = args[0];
>> +    a1 = args[1];
>> +    a2 = args[2];
>> +
>> +    /* Currently only supports V128 */
>> +    tcg_debug_assert(type == TCG_TYPE_V128);
>> +
>> +    switch (opc) {
>> +    case INDEX_op_st_vec:
>> +        /* Try to fit vst imm */
>> +        if (-0x800 <= a2 && a2 <= 0x7ff) {
>> +            base = a1;
>> +            offset = a2;
>> +        } else {
>> +            tcg_out_addi(s, TCG_TYPE_I64, temp, a1, a2);
>> +            base = temp;
>> +            offset = 0;
>> +        }
>> +        tcg_out_opc_vst(s, a0, base, offset);
>> +        break;
>> +    case INDEX_op_ld_vec:
>> +        /* Try to fit vld imm */
>> +        if (-0x800 <= a2 && a2 <= 0x7ff) {
>> +            base = a1;
>> +            offset = a2;
>> +        } else {
>> +            tcg_out_addi(s, TCG_TYPE_I64, temp, a1, a2);
>> +            base = temp;
>> +            offset = 0;
>> +        }
>> +        tcg_out_opc_vld(s, a0, base, offset);
>
> tcg_out_addi has a hole in bits [15:12], and can take an extra insn if 
> those bits are set.  Better to load the offset with tcg_out_movi and 
> then use VLDX/VSTX instead of VLD/VST.


Sure.


>
>> @@ -159,6 +170,30 @@ typedef enum {
>>   #define TCG_TARGET_HAS_mulsh_i64        1
>>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>>   +#define TCG_TARGET_HAS_v64              0
>> +#define TCG_TARGET_HAS_v128             use_lsx_instructions
>> +#define TCG_TARGET_HAS_v256             0
>
> Perhaps reserve for a follow-up, but TCG_TARGET_HAS_v64 can easily be 
> supported using the same instructions.
>
> The only difference is load/store, where you could use FLD.D/FST.D to 
> load the lower 64-bits of the fp/vector register, or VLDREPL.D to load 
> and initialize all bits and VSTELM.D to store the lower 64-bits.
>
> I tend to think the float insns are more flexible, having a larger 
> displacement, and the availability of FLDX/FSTX as well.


Sure.


>
>
> r~

