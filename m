Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B87B432E
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 21:06:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmfGo-00067W-8C; Sat, 30 Sep 2023 15:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1qmfGk-00067L-UY
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 15:04:51 -0400
Received: from mail.xen0n.name ([115.28.160.31] helo=mailbox.box.xen0n.name)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1qmfGg-0002gS-Sk
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 15:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1696100643; bh=WFKL6672x7BjGR89htiNdEyqByNS7c+mrHapNq8xf18=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H9L+JG84DaAjHpeHU6+uPdt+qNG4Xe+/Glq8JUWtvXhKOH3KTEyC/LANUw2Zm4kJJ
 uTaa8EC+kr7Tu5lw8A4+dSAxtw9dRDjt//zRhNqrZAAO+S2S28931qwt+KtsJzfoML
 1YP6djMwq82v/UhGL1x+0DtB3B7hIUcgdQ2Ozh5E=
Received: from [IPV6:240e:388:8d29:7200:ab91:7c43:136f:4b7b] (unknown
 [IPv6:240e:388:8d29:7200:ab91:7c43:136f:4b7b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 65390600D1;
 Sun,  1 Oct 2023 03:04:03 +0800 (CST)
Message-ID: <b082d345-72e0-44a6-a303-f2291999726b@xen0n.name>
Date: Sun, 1 Oct 2023 03:04:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tcg/loongarch64: Improvements for 128-bit load/store
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
 <b9704f72-e4de-74e4-9b10-8ba14cea3d2d@linaro.org>
From: WANG Xuerui <i.qemu@xen0n.name>
In-Reply-To: <b9704f72-e4de-74e4-9b10-8ba14cea3d2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.28.160.31; envelope-from=i.qemu@xen0n.name;
 helo=mailbox.box.xen0n.name
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/30/23 10:13, Richard Henderson wrote:
> Ping.
> 
> r~
> 
> On 9/16/23 15:01, Richard Henderson wrote:
>> For tcg generated code, use new registers with load so that we never
>> overlap the input address, so that we can simplify address build for
>> 64-bit user-only.
>>
>> For tcg out-of-line code, implement the host/ headers to for atomic 
>> 128-bit
>> load and store, reducing the cases for which we must raise EXCP_ATOMIC.
>>
>>
>> r~
>>
>> Based-on: 20230916171223.521545-1-richard.henderson@linaro.org
>> ("[PULL v2 00/39] tcg patch queue")
>>
>> Richard Henderson (7):
>>    tcg: Add C_N2_I1
>>    tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
>>    util: Add cpuinfo for loongarch64
>>    tcg/loongarch64: Use cpuinfo.h
>>    host/include/loongarch64: Add atomic16 load and store
>>    accel/tcg: Remove redundant case in store_atom_16
>>    accel/tcg: Fix condition for store_atom_insert_al16
>>
>>   .../include/loongarch64/host/atomic128-ldst.h | 52 +++++++++++++++++++
>>   host/include/loongarch64/host/cpuinfo.h       | 21 ++++++++
>>   .../loongarch64/host/load-extract-al16-al8.h  | 39 ++++++++++++++
>>   .../loongarch64/host/store-insert-al16.h      | 12 +++++
>>   tcg/loongarch64/tcg-target-con-set.h          |  2 +-
>>   tcg/loongarch64/tcg-target.h                  |  8 +--
>>   accel/tcg/cputlb.c                            |  2 +-
>>   tcg/tcg.c                                     |  5 ++
>>   util/cpuinfo-loongarch.c                      | 35 +++++++++++++
>>   accel/tcg/ldst_atomicity.c.inc                | 14 ++---
>>   tcg/loongarch64/tcg-target.c.inc              | 25 +++++----
>>   util/meson.build                              |  2 +
>>   12 files changed, 189 insertions(+), 28 deletions(-)
>>   create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
>>   create mode 100644 host/include/loongarch64/host/cpuinfo.h
>>   create mode 100644 
>> host/include/loongarch64/host/load-extract-al16-al8.h
>>   create mode 100644 host/include/loongarch64/host/store-insert-al16.h
>>   create mode 100644 util/cpuinfo-loongarch.c

Sorry for the delay; I've skimmed through the series and tested on 
Loongson 3C5000L hardware, so

Reviewed-by: WANG Xuerui <git@xen0n.name>

