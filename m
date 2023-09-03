Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48C790A71
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 03:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcbdG-0005zW-OK; Sat, 02 Sep 2023 21:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcbdA-0005zI-DO
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 21:10:24 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcbd8-0003LQ-6F
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 21:10:24 -0400
Received: from [192.168.1.12] (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id EC0A5442DA;
 Sun,  3 Sep 2023 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693703412; bh=3L+1xSv9c6YVKS5tldoll8NfXhWv6WcK5IMRrVWTUY0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TkAV0GdG5/BVoLRSZ3mozaACAgY5hH1n8jPMtiBvtr6CR2DXa8ylSZtLrN4rlmV86
 PgjKvafqIC9qWL2qHMiQQgrW7Z8yn16FzLC6P+CgziFgrkikav3+Wn5dHV/1MQt9HW
 XRA9rLNs14nSG6zpxl5bOOO7A84kXpxwAwlsibuY=
Message-ID: <e6937197-b09f-4222-2a27-abdd2a2ec10d@jia.je>
Date: Sun, 3 Sep 2023 09:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 16/16] tcg/loongarch64: Implement 128-bit load & store
Content-Language: en-US
To: gaosong@loongson.cn, qemu-devel@nongnu.org
Cc: git@xen0n.name, Richard Henderson <richard.henderson@linaro.org>
References: <20230902050415.1832700-1-c@jia.je>
 <20230902050415.1832700-17-c@jia.je>
 <fdd190b9-2d56-a888-d6b4-da9534a38339@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <fdd190b9-2d56-a888-d6b4-da9534a38339@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 2023/9/3 09:06, Richard Henderson wrote:
> On 9/1/23 22:02, Jiajie Chen wrote:
>> If LSX is available, use LSX instructions to implement 128-bit load &
>> store.
>
> Is this really guaranteed to be an atomic 128-bit operation?
>

Song Gao, please check this.


> Or, as for many vector processors, is this really two separate 64-bit 
> memory operations under the hood?
>
>
>> +static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, 
>> TCGReg data_hi,
>> +                                   TCGReg addr_reg, MemOpIdx oi, 
>> bool is_ld)
>> +{
>> +    TCGLabelQemuLdst *ldst;
>> +    HostAddress h;
>> +
>> +    ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
>> +    if (is_ld) {
>> +        tcg_out_opc_vldx(s, TCG_VEC_TMP0, h.base, h.index);
>> +        tcg_out_opc_vpickve2gr_d(s, data_lo, TCG_VEC_TMP0, 0);
>> +        tcg_out_opc_vpickve2gr_d(s, data_hi, TCG_VEC_TMP0, 1);
>> +    } else {
>> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_lo, 0);
>> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_hi, 1);
>> +        tcg_out_opc_vstx(s, TCG_VEC_TMP0, h.base, h.index);
>> +    }
>
> You should use h.aa.atom < MO_128 to determine if 128-bit atomicity, 
> and therefore the vector operation, is required.  I assume the gr<->vr 
> moves have a cost and two integer operations are preferred when 
> allowable.
>
> Compare the other implementations of this function.
>
>
> r~

