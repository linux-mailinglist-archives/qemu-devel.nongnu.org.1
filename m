Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1897C9B00
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 21:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs6kb-0008Lo-9I; Sun, 15 Oct 2023 15:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs6kZ-0008LZ-5f
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 15:26:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs6kV-0000qg-9h
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 15:26:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so3723699f8f.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697397959; x=1698002759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zpcsOyZGkAqgX0AaRCT4BzKbdymydzSzy275/c8JMw=;
 b=oXTzImjrRKATKXJ42vKl9bveSLf9+bBrUgRxZWzPAdfwSa/bio07rS3bjUhLDrbAov
 Lrxu9UKvLZqkTlwI1vuSBtIuw7NDllUep9ke32du8ti/VbKB1pyvdCdqS9yjl0jaL5C4
 Kfy9NIq1xRt6PfdNfMpUd3O/kc265LCpv4VS/5fgQs1+8c1yiHquH1AFeSwHScRHBN+h
 YFcvANXsifbQmGONvkn6wGT/tWmU/AS3gNfxuE2QbqLvpeziooG7o77p7lysL7ykX2hN
 d2QLQ7lOqassZ+yval8ZcmsaIyGyfdEWOoUN80guKAjqxpyRNZMpHKIZmPvvOzh/9RyX
 jbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697397959; x=1698002759;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9zpcsOyZGkAqgX0AaRCT4BzKbdymydzSzy275/c8JMw=;
 b=W7xXE0/9GzhRSgyMDOgm2rQuT1L04lD1d5FjmMO1mBehQo5UC8gKEsptpVvOkfuRh+
 1RZ4t9YA2gaVw+jOGxeunicv99OdM4vGYXAHOWoFdQK8ObB7t2g/VXr0Pz2SZ0Hl6GwU
 gPN0JKUv/SNykY+t6OZNoXOwKjJG2fgVYlGkloDo0QpWHqaJZd+c/NzlMJnXlTbuW5+P
 UNc0BcIls8P5jnqEJicFRd/STnPwCNMl6GSrRZKqtlJDEQRuTEpkk3rnnamUUreQhg9K
 GkaZuvO91A7JKpadyeofZ6Ud8049T9FWBNkuo62r2cX+5VUeOkqNwItISI6p+cupGrr3
 Re1w==
X-Gm-Message-State: AOJu0Yz8jTKJR9hbGGGnRmji60bYAblvZ3JUGt9QTuOdj2xRURWQt1Dc
 MEVL/pRcSIv5GL7ReOCJZqApxg==
X-Google-Smtp-Source: AGHT+IFkjKxgfz56Fy5hT0giIQibH9o42hIFmVxK+mxX+PET8JMP10eTs5x8YMh8I9WPPHX3ItAc/Q==
X-Received: by 2002:adf:cc8a:0:b0:319:82c9:8e7d with SMTP id
 p10-20020adfcc8a000000b0031982c98e7dmr29076076wrj.31.1697397958678; 
 Sun, 15 Oct 2023 12:25:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a5d4572000000b003196b1bb528sm4474791wrc.64.2023.10.15.12.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 12:25:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE37D1FFBB;
 Sun, 15 Oct 2023 20:25:57 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-14-richard.henderson@linaro.org>
 <f0c26ccc-ba96-f0ef-4756-370f5114ec94@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
Subject: Re: [PATCH v17 13/16] disas: Allow monitor_disas to read from
 ram_addr_t
Date: Sun, 15 Oct 2023 20:21:59 +0100
In-reply-to: <f0c26ccc-ba96-f0ef-4756-370f5114ec94@linaro.org>
Message-ID: <874jiry9fe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 3/10/23 20:30, Richard Henderson wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>> Introduce a MonitorDisasSpace to replace the current is_physical
>> boolean argument to monitor_disas.  Generate an error if we attempt
>> to read past the end of a single RAMBlock.
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> [rth: Split out of a larger patch; validate the RAMBlock size]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/disas/disas.h     |  8 +++++++-
>>   disas/disas-mon.c         | 32 ++++++++++++++++++++++++++++++--
>>   monitor/hmp-cmds-target.c | 27 ++++++++++++++++-----------
>>   3 files changed, 53 insertions(+), 14 deletions(-)
>> diff --git a/include/disas/disas.h b/include/disas/disas.h
>> index 176775eff7..cd99b0ccd0 100644
>> --- a/include/disas/disas.h
>> +++ b/include/disas/disas.h
>> @@ -5,8 +5,14 @@
>>   void disas(FILE *out, const void *code, size_t size);
>>   void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size=
);
>>   +typedef enum {
>> +    MON_DISAS_GVA, /* virtual */
>> +    MON_DISAS_GPA, /* physical */
>> +    MON_DISAS_GRA, /* ram_addr_t */
>> +} MonitorDisasSpace;
>
>
> Obviously I'd rather see MonitorDisasSpace =3D {MON_DISAS_GVA/GPA}
> introduced in a preliminary patch, but just saying.
>
>>   static void memory_dump(Monitor *mon, int count, int format, int wsize,
>> -                        hwaddr addr, int is_physical)
>> +                        hwaddr addr, MonitorDisasSpace space)
>>   {
>>       int l, line_size, i, max_digits, len;
>>       uint8_t buf[16];
>>       uint64_t v;
>>       CPUState *cs =3D mon_get_cpu(mon);
>>   -    if (!cs && (format =3D=3D 'i' || !is_physical)) {
>
> Why is the '!cs' check removed? Otherwise LGTM.

Yeah it breaks the monitor I think with should be:

  if (!cs && (space =3D=3D MON_DISAS_GVA || format =3D=3D 'i'))

>
>> +    if (space =3D=3D MON_DISAS_GVA || format =3D=3D 'i') {
>>           monitor_printf(mon, "Can not dump without CPU\n");
>>           return;
>>       }
>>         if (format =3D=3D 'i') {
>> -        monitor_disas(mon, cs, addr, count, is_physical);
>> -        return;
>> +        monitor_disas(mon, cs, addr, count, space);
>>       }
>>         len =3D wsize * count;
>> @@ -163,15 +162,21 @@ static void memory_dump(Monitor *mon, int count, i=
nt format, int wsize,
>>       }
>>         while (len > 0) {
>> -        if (is_physical) {
>> -            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
>> -        } else {
>> +        switch (space) {
>> +        case MON_DISAS_GVA:
>>               monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
>> +            break;
>> +        case MON_DISAS_GPA:
>> +            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>>           }
>>           l =3D len;
>> -        if (l > line_size)
>> +        if (l > line_size) {
>>               l =3D line_size;
>> -        if (is_physical) {
>> +        }
>> +        if (space =3D=3D MON_DISAS_GPA) {
>>               AddressSpace *as =3D cs ? cs->as : &address_space_memory;
>>               MemTxResult r =3D address_space_read(as, addr,
>>                                                  MEMTXATTRS_UNSPECIFIED,=
 buf, l);
>> @@ -235,7 +240,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdic=
t)
>>       int size =3D qdict_get_int(qdict, "size");
>>       target_long addr =3D qdict_get_int(qdict, "addr");
>>   -    memory_dump(mon, count, format, size, addr, 0);
>> +    memory_dump(mon, count, format, size, addr, MON_DISAS_GVA);
>>   }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

