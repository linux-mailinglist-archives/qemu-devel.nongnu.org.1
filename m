Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A5822C66
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:55:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKzpL-0002aY-7p; Wed, 03 Jan 2024 06:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKzp1-0002Zd-Ck
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:54:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKzoy-00034b-8f
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:54:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d89446895so2210145e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704282841; x=1704887641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QTOzRujsrPO5wQFzcQJT+nwJzWPf9UoZpHXN/k5hWGI=;
 b=OCYyOuHT1GwALfDaepRkl+Y5tN0fevC5M6YDMi+qp8N93AixgljLSMyxtiHnNp7H5K
 ALbwnynWiSTUijDtCJn9Bm+P/kBN9hEZZnU2d0wIl9wJ7BOEQJyLXzFatZzlfyYut4nk
 rbMWGMQBuNhu2TP1clOp/L6MHrbPs2cizGktjEHjqATdqP+FyKtmcyIDhQk80HjTzRL6
 8/yFvl4TtBMO83wDpyBv/LXD72iXdcLWkhoAhJx1uLSzRT/xuoC3CeOio6feDFWgxoM3
 TTyzUD7IWSOKr5ynuLuD8Lac45RrgBsPpIeoE2NWx01agHcp0EGdQKo5neuYk0thK447
 7rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704282841; x=1704887641;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QTOzRujsrPO5wQFzcQJT+nwJzWPf9UoZpHXN/k5hWGI=;
 b=RuFOiM7JWaS1pwmD2yNybgc+kmB81yAmGPPTVpCNVdvU99fysCFO5Sf+BbbFtrf7G8
 ekus58pH05XIpdZnrD4C5mHvlJgouNQtEci1WFC3lhMN11mJtGZxUaRolUTIqt2iZJ+h
 B6S0mxdB635tGh7M63tS6wGiAyMelUAoSmEAwT8UJh114hL7qdX1ASoCkLZ437u1lWz+
 KNqttcZwcAVik4ajqCUS/q7MP1DXQzTwq80SZ03YD6syAFKmh4q8Adzq51SxEcfY6Hvk
 vQTPk3IxRucIAwTzWZ4/IxppHt0vh8KCSuaqHk9d8+tucqRVB6hZRx+DzeELwVd5sqxf
 ujcQ==
X-Gm-Message-State: AOJu0Yzrrff4Qr4eIdXSrTruD8iuobyuk880QhnPgTw2Nn3NF1Wj58+a
 cZm3s51pxVYSCwtgSq85RyOaYQg80y9Arw==
X-Google-Smtp-Source: AGHT+IFH6U2doCYBK2PCSb9RolyVOXdvdjy1qSV01/3xnv1xktdGiOgmGhpMP6D7FBpLfp6ioR6EJw==
X-Received: by 2002:a05:600c:1f82:b0:40d:8846:bbac with SMTP id
 je2-20020a05600c1f8200b0040d8846bbacmr543097wmb.92.1704282841535; 
 Wed, 03 Jan 2024 03:54:01 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 f7-20020a5d4dc7000000b00336ebf93416sm18527652wru.17.2024.01.03.03.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 03:54:00 -0800 (PST)
Message-ID: <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
Date: Wed, 3 Jan 2024 12:53:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
 <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
 <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x <qemu-s390x@nongnu.org>
In-Reply-To: <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Richard,

On 3/1/24 09:54, Michael Tokarev wrote:
> 03.01.2024 03:22, Richard Henderson wrote:
>> On 12/22/23 01:51, Michael Tokarev wrote:
> ...
>>> git bisect points to this commit:
>>>
>>> commit ab84dc398b3b702b0c692538b947ef65dbbdf52f
>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>> Date:   Wed Aug 23 23:04:24 2023 -0700
>>>
>>>      tcg/optimize: Optimize env memory operations
>>>
>>> So far, this seems to work on amd64 host, but fails on s390x host -
>>> where this has been observed so far.  Maybe it also fails in some
>>> other combinations too, I don't yet know.  Just finished bisecting
>>> it on s390x.
>>
>> I haven't been able to build a reproducer for this.
>> Have you an image or kernel you can share?
> 
> Sure.
> 
> Here's my actual testing "image": 
> http://www.corpit.ru/mjt/tmp/s390x-chacha.tar.gz
> 
> It contains vmlinuz and initrd - generated on a debian s390x system 
> using standard
> debian tools.
> 
> Actual command line I used when doing bisection:
> 
>   ~/qemu/b/qemu-system-s390x -append "root=/dev/vda rw" -nographic -smp 
> 2 -drive format=raw,file=vmlinuz,if=virtio -no-user-config -m 1G -kernel 
> vmlinuz -initrd initrd -snapshot

I had a quick look at the reproducer and reduced the code
area to:

void tcg_optimize(TCGContext *s)
{
     ...
         switch (opc) {
         case INDEX_op_ld_vec:
             done = fold_tcg_ld_memcopy(&ctx, op);


static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
{
     ...
     if (src && src->base_type == type) {
         return tcg_opt_gen_mov(ctx, op, temp_arg(dst), temp_arg(src));
     }


static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, 
TCGArg src)
{
     ...
     switch (ctx->type) {
     case TCG_TYPE_V128:
         new_op = INDEX_op_mov_vec;


By disabling this optimization, the test succeeds.

Looking at commit 4caad79f8d ("tcg/s390x: Support 128-bit load/store")
and remembering the constraints change on PPC LQ in
https://lore.kernel.org/qemu-devel/20240102013456.131846-1-richard.henderson@linaro.org/
I wondered if LPQ constraints are correct, but I disabled
TCG_TARGET_HAS_qemu_ldst_i128 and the bug persists (so
re-enabled).

Then disabling TCG_TARGET_HAS_v64 and TCG_TARGET_HAS_v128 the bug
disappears.

The problematic chacha20 guest code could be:

Restarting code generation with smaller translation block (max 86 insns)
----------------
IN:
0x3ff80025a62:  eb67 f030 0024  stmg     %r6, %r7, 0x30(%r15)
0x3ff80025a68:  a719 ff60       lghi     %r1, -0xa0
0x3ff80025a6c:  b904 000f       lgr      %r0, %r15
0x3ff80025a70:  41f1 f000       la       %r15, 0(%r1, %r15)
0x3ff80025a74:  e300 f000 0024  stg      %r0, 0(%r15)
0x3ff80025a7a:  c070 0000 12c3  larl     %r7, -0x7ffd8000
0x3ff80025a80:  a708 000a       lhi      %r0, 0xa
0x3ff80025a84:  e789 5000 0c36  .byte    0xe7, 0x89, 0x50, 0x00, 0x0c, 0x36
0x3ff80025a8a:  e7a0 6000 0806  .byte    0xe7, 0xa0, 0x60, 0x00, 0x08, 0x06
0x3ff80025a90:  e7bf 7000 4c36  .byte    0xe7, 0xbf, 0x70, 0x00, 0x4c, 0x36
0x3ff80025a96:  e70b 0000 0456  .byte    0xe7, 0x0b, 0x00, 0x00, 0x04, 0x56
0x3ff80025a9c:  e718 0000 0456  .byte    0xe7, 0x18, 0x00, 0x00, 0x04, 0x56
0x3ff80025aa2:  e74b 0000 0456  .byte    0xe7, 0x4b, 0x00, 0x00, 0x04, 0x56
0x3ff80025aa8:  e758 0000 0456  .byte    0xe7, 0x58, 0x00, 0x00, 0x04, 0x56
0x3ff80025aae:  e78b 0000 0456  .byte    0xe7, 0x8b, 0x00, 0x00, 0x04, 0x56
0x3ff80025ab4:  e798 0000 0456  .byte    0xe7, 0x98, 0x00, 0x00, 0x04, 0x56
0x3ff80025aba:  e7cb 0000 0456  .byte    0xe7, 0xcb, 0x00, 0x00, 0x04, 0x56
0x3ff80025ac0:  e7d8 0000 0456  .byte    0xe7, 0xd8, 0x00, 0x00, 0x04, 0x56
0x3ff80025ac6:  e70b 0000 0c56  .byte    0xe7, 0x0b, 0x00, 0x00, 0x0c, 0x56
0x3ff80025acc:  e718 0000 0c56  .byte    0xe7, 0x18, 0x00, 0x00, 0x0c, 0x56
0x3ff80025ad2:  e74b 0000 0c56  .byte    0xe7, 0x4b, 0x00, 0x00, 0x0c, 0x56
0x3ff80025ad8:  e758 0000 0c56  .byte    0xe7, 0x58, 0x00, 0x00, 0x0c, 0x56
0x3ff80025ade:  e73a 0000 0456  .byte    0xe7, 0x3a, 0x00, 0x00, 0x04, 0x56
0x3ff80025ae4:  e77a c000 26f3  .byte    0xe7, 0x7a, 0xc0, 0x00, 0x26, 0xf3
0x3ff80025aea:  e7ba d000 26f3  .byte    0xe7, 0xba, 0xd0, 0x00, 0x26, 0xf3
0x3ff80025af0:  e7fa e000 26f3  .byte    0xe7, 0xfa, 0xe0, 0x00, 0x26, 0xf3
0x3ff80025af6:  e73b d000 2af3  .byte    0xe7, 0x3b, 0xd0, 0x00, 0x2a, 0xf3
0x3ff80025afc:  e77b e000 2af3  .byte    0xe7, 0x7b, 0xe0, 0x00, 0x2a, 0xf3
0x3ff80025b02:  e729 0000 0456  .byte    0xe7, 0x29, 0x00, 0x00, 0x04, 0x56
0x3ff80025b08:  e769 0000 0456  .byte    0xe7, 0x69, 0x00, 0x00, 0x04, 0x56
0x3ff80025b0e:  e7a9 0000 0456  .byte    0xe7, 0xa9, 0x00, 0x00, 0x04, 0x56
0x3ff80025b14:  e7e9 0000 0456  .byte    0xe7, 0xe9, 0x00, 0x00, 0x04, 0x56
0x3ff80025b1a:  e729 0000 0c56  .byte    0xe7, 0x29, 0x00, 0x00, 0x0c, 0x56
0x3ff80025b20:  e769 0000 0c56  .byte    0xe7, 0x69, 0x00, 0x00, 0x0c, 0x56
0x3ff80025b26:  e7c7 0000 0856  .byte    0xe7, 0xc7, 0x00, 0x00, 0x08, 0x56
0x3ff80025b2c:  e7db 0000 0856  .byte    0xe7, 0xdb, 0x00, 0x00, 0x08, 0x56
0x3ff80025b32:  e7ef 0000 0856  .byte    0xe7, 0xef, 0x00, 0x00, 0x08, 0x56
0x3ff80025b38:  e700 1000 20f3  .byte    0xe7, 0x00, 0x10, 0x00, 0x20, 0xf3
0x3ff80025b3e:  e744 5000 20f3  .byte    0xe7, 0x44, 0x50, 0x00, 0x20, 0xf3
0x3ff80025b44:  e788 9000 20f3  .byte    0xe7, 0x88, 0x90, 0x00, 0x20, 0xf3
0x3ff80025b4a:  e7cc d000 20f3  .byte    0xe7, 0xcc, 0xd0, 0x00, 0x20, 0xf3
0x3ff80025b50:  e700 1000 2ef3  .byte    0xe7, 0x00, 0x10, 0x00, 0x2e, 0xf3
0x3ff80025b56:  e744 5000 2ef3  .byte    0xe7, 0x44, 0x50, 0x00, 0x2e, 0xf3
0x3ff80025b5c:  e733 0000 006d  .byte    0xe7, 0x33, 0x00, 0x00, 0x00, 0x6d
0x3ff80025b62:  e777 4000 006d  .byte    0xe7, 0x77, 0x40, 0x00, 0x00, 0x6d
0x3ff80025b68:  e7bb 8000 006d  .byte    0xe7, 0xbb, 0x80, 0x00, 0x00, 0x6d
0x3ff80025b6e:  e7ff c000 006d  .byte    0xe7, 0xff, 0xc0, 0x00, 0x00, 0x6d
0x3ff80025b74:  e733 0000 0e6d  .byte    0xe7, 0x33, 0x00, 0x00, 0x0e, 0x6d
0x3ff80025b7a:  e777 4000 0e6d  .byte    0xe7, 0x77, 0x40, 0x00, 0x0e, 0x6d
0x3ff80025b80:  e733 0010 2033  .byte    0xe7, 0x33, 0x00, 0x10, 0x20, 0x33
0x3ff80025b86:  e777 0010 2033  .byte    0xe7, 0x77, 0x00, 0x10, 0x20, 0x33
0x3ff80025b8c:  e7bb 0010 2033  .byte    0xe7, 0xbb, 0x00, 0x10, 0x20, 0x33
0x3ff80025b92:  e7ff 0010 2033  .byte    0xe7, 0xff, 0x00, 0x10, 0x20, 0x33
0x3ff80025b98:  e733 0010 2c33  .byte    0xe7, 0x33, 0x00, 0x10, 0x2c, 0x33
0x3ff80025b9e:  e777 0010 2c33  .byte    0xe7, 0x77, 0x00, 0x10, 0x2c, 0x33
0x3ff80025ba4:  e722 3000 20f3  .byte    0xe7, 0x22, 0x30, 0x00, 0x20, 0xf3
0x3ff80025baa:  e766 7000 20f3  .byte    0xe7, 0x66, 0x70, 0x00, 0x20, 0xf3
0x3ff80025bb0:  e7aa b000 20f3  .byte    0xe7, 0xaa, 0xb0, 0x00, 0x20, 0xf3
0x3ff80025bb6:  e7ee f000 20f3  .byte    0xe7, 0xee, 0xf0, 0x00, 0x20, 0xf3
0x3ff80025bbc:  e722 3000 2ef3  .byte    0xe7, 0x22, 0x30, 0x00, 0x2e, 0xf3
0x3ff80025bc2:  e766 7000 2ef3  .byte    0xe7, 0x66, 0x70, 0x00, 0x2e, 0xf3
0x3ff80025bc8:  e711 2000 006d  .byte    0xe7, 0x11, 0x20, 0x00, 0x00, 0x6d
0x3ff80025bce:  e755 6000 006d  .byte    0xe7, 0x55, 0x60, 0x00, 0x00, 0x6d
0x3ff80025bd4:  e799 a000 006d  .byte    0xe7, 0x99, 0xa0, 0x00, 0x00, 0x6d
0x3ff80025bda:  e7dd e000 006d  .byte    0xe7, 0xdd, 0xe0, 0x00, 0x00, 0x6d
0x3ff80025be0:  e711 2000 0e6d  .byte    0xe7, 0x11, 0x20, 0x00, 0x0e, 0x6d
0x3ff80025be6:  e755 6000 0e6d  .byte    0xe7, 0x55, 0x60, 0x00, 0x0e, 0x6d
0x3ff80025bec:  e711 000c 2033  .byte    0xe7, 0x11, 0x00, 0x0c, 0x20, 0x33
0x3ff80025bf2:  e755 000c 2033  .byte    0xe7, 0x55, 0x00, 0x0c, 0x20, 0x33
0x3ff80025bf8:  e799 000c 2033  .byte    0xe7, 0x99, 0x00, 0x0c, 0x20, 0x33
0x3ff80025bfe:  e7dd 000c 2033  .byte    0xe7, 0xdd, 0x00, 0x0c, 0x20, 0x33
0x3ff80025c04:  e711 000c 2c33  .byte    0xe7, 0x11, 0x00, 0x0c, 0x2c, 0x33
0x3ff80025c0a:  e755 000c 2c33  .byte    0xe7, 0x55, 0x00, 0x0c, 0x2c, 0x33
0x3ff80025c10:  e700 1000 20f3  .byte    0xe7, 0x00, 0x10, 0x00, 0x20, 0xf3
0x3ff80025c16:  e744 5000 20f3  .byte    0xe7, 0x44, 0x50, 0x00, 0x20, 0xf3
0x3ff80025c1c:  e788 9000 20f3  .byte    0xe7, 0x88, 0x90, 0x00, 0x20, 0xf3
0x3ff80025c22:  e7cc d000 20f3  .byte    0xe7, 0xcc, 0xd0, 0x00, 0x20, 0xf3
0x3ff80025c28:  e700 1000 2ef3  .byte    0xe7, 0x00, 0x10, 0x00, 0x2e, 0xf3
0x3ff80025c2e:  e744 5000 2ef3  .byte    0xe7, 0x44, 0x50, 0x00, 0x2e, 0xf3
0x3ff80025c34:  e733 0000 006d  .byte    0xe7, 0x33, 0x00, 0x00, 0x00, 0x6d
0x3ff80025c3a:  e777 4000 006d  .byte    0xe7, 0x77, 0x40, 0x00, 0x00, 0x6d
0x3ff80025c40:  e7bb 8000 006d  .byte    0xe7, 0xbb, 0x80, 0x00, 0x00, 0x6d
0x3ff80025c46:  e7ff c000 006d  .byte    0xe7, 0xff, 0xc0, 0x00, 0x00, 0x6d
0x3ff80025c4c:  e733 0000 0e6d  .byte    0xe7, 0x33, 0x00, 0x00, 0x0e, 0x6d
0x3ff80025c52:  e777 4000 0e6d  .byte    0xe7, 0x77, 0x40, 0x00, 0x0e, 0x6d
0x3ff80025c58:  e733 0008 2033  .byte    0xe7, 0x33, 0x00, 0x08, 0x20, 0x33

Regards,

Phil.

