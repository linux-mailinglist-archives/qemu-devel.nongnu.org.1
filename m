Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFA7D4735
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAdT-0004vB-Km; Tue, 24 Oct 2023 02:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvAdC-0004ub-UZ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:11:11 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvAd8-0008N1-Jt
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:11:10 -0400
Received: from [192.168.111.82] (unknown [124.65.131.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 8B1E044438;
 Tue, 24 Oct 2023 06:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698127862; bh=bMkZMSnhZEUwAsqjhZH20OC7lM5rXzudCE5SV0aJqfQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rvQZFcO5K68OnAE2n68nDgLzZ5s437t8UJufxoJTjUIAkZEQtvfvJyO0s+NvTJrac
 8iLL9ORZ/HCt28g6b4mUrVQo0eNuA2rMlEB2a+Eaxz+hrX3BaQotC5sOpPWm/sbv9x
 577kamLDgGliWNabZ53+M8xxOb9dnnuSxaLIpr0w=
Message-ID: <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
Date: Tue, 24 Oct 2023 14:10:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 2023/10/24 07:26, Richard Henderson wrote:
> On 10/23/23 08:29, Jiajie Chen wrote:
>> This patch series implements the new instructions except sc.q, 
>> because I do not know how to match a pair of ll.d to sc.q.
>
> There are a couple of examples within the tree.
>
> See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 block.
> See target/ppc/translate.c, gen_stqcx_.


The situation here is slightly different: aarch64 and ppc64 have both 
128-bit ll and sc, however LoongArch v1.1 only has 64-bit ll and 128-bit 
sc. I guest the intended usage of sc.q is:


ll.d lo, base, 0

ll.d hi, base, 4

# do some computation

sc.q lo, hi, base

# try again if sc failed



>
>
> r~

