Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68271240A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2U56-0003q8-JT; Fri, 26 May 2023 05:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2U53-0003pI-Jn
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2U51-0000jm-Ri
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685094590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+me7z+dwUpEe2fwAvOZdeOW2gImMtbBtRipr5AjLnbE=;
 b=evA/RJR3tjlSV8leTLdUgsBGTzemfTSmkJGRA4fiAey6pOPxMuGRXXjlcH4/JpPv4758hU
 mk72ioCe1idFUDYUw7nOm6dOmNw0DA9AcUBL67WnDHcpsdsYzqDqLZ3iUHfFuoLmnMH4ql
 fPymYSTG8qW+ayVPLmLZBf9BaZs5iI0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-bO2EKw27NrakXbnVZItRAA-1; Fri, 26 May 2023 05:49:49 -0400
X-MC-Unique: bO2EKw27NrakXbnVZItRAA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3079c6648e3so326835f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685094588; x=1687686588;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+me7z+dwUpEe2fwAvOZdeOW2gImMtbBtRipr5AjLnbE=;
 b=KwoSXpa7I9uSEVOAHBXt6FKEQEj3Z7QKxN3CwqTq6fKTjBGFxo7mD5CI97HETldkG9
 A7u5dxwCMfm0QJJCAVF7ej62ziT3fM7Bv8FD74BkGBmyVZS+22bGHjFLjABLbaBBmh99
 shBZR3T5MDsD4mMm1UYybQ5FsnCtmkcqeRf2nYMoI2NbIL3rCcOSIyhs+8pAtmUiDiRQ
 lsitRDZiHVW7ecqCTCSHx13ARoUn9R/7S/gpwGvtH8IPPQPZ4OsVjscJUIFpzNDjXveU
 nvzS/T3Ka8db5FFwvemDzLgJOpJ2O8M5z+dfVeHwN5bHzT1ZfQd0qmhHZHSo8YAmUmZA
 E6hw==
X-Gm-Message-State: AC+VfDw0CRdTr5LN/L/oSt3iDtFj2O3t7uB94j4YA8Mwcn3kpLp42769
 mouVvPyTUytRG8c7oraRXUBb9nP7JssOmSbolQVcjcYjuvnPtIrkrK+risTUMKJGWUG3UG1n0Gw
 I3G47tKtVMLbuUt0=
X-Received: by 2002:a5d:4ac6:0:b0:309:54b6:33b0 with SMTP id
 y6-20020a5d4ac6000000b0030954b633b0mr1161146wrs.44.1685094587940; 
 Fri, 26 May 2023 02:49:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ddowtzy1czM/PHVoM9tvJjhayIg4hTGANn/PLpg+L2k17o4VJkKo1nfrhumkKj7HHFei2ig==
X-Received: by 2002:a5d:4ac6:0:b0:309:54b6:33b0 with SMTP id
 y6-20020a5d4ac6000000b0030954b633b0mr1161134wrs.44.1685094587651; 
 Fri, 26 May 2023 02:49:47 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o12-20020adfe80c000000b002fe13ec49fasm4476397wrm.98.2023.05.26.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 02:49:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/20] target/arm: Add commentary for
 CPUARMState.exclusive_high
In-Reply-To: <dbb368d0-839c-ad09-01de-09b1a62416af@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 26 May 2023 10:56:47
 +0200")
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-2-richard.henderson@linaro.org>
 <dbb368d0-839c-ad09-01de-09b1a62416af@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 11:49:46 +0200
Message-ID: <87zg5r1kxx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> Hi,
>
> On 26/5/23 01:25, Richard Henderson wrote:
>> Document the meaning of exclusive_high in a big-endian context,
>> and why we can't change it now.
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index d469a2637b..4e16eab82e 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -677,8 +677,15 @@ typedef struct CPUArchState {
>>           uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
>>           uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
>>       } vfp;
>> +
>>       uint64_t exclusive_addr;
>>       uint64_t exclusive_val;
>> +    /*
>> +     * Contains the 'val' for the second 64-bit register of LDXP, which=
 comes
>> +     * from the higher address, not the high part of a complete 128-bit=
 value.
>> +     * This is perhaps confusingly named, but the name is now baked int=
o the
>> +     * migration format.
>> +     */
>>       uint64_t exclusive_high;
>
> Can't we rename the field if we add the old name to check_fields_match()
> in scripts/vmstate-static-checker.py?
>
> Juan, could we store this renamed information directly in the code in
> VMState? Maybe adding some VMSTATE_KEY_ALIAS(_old_key, _new_key) macro
> and have the migration/ code magically deal with that :)
>
> I.e. here:
>
>   VMSTATE_KEY_ALIAS("exclusive_val", high_addr),

You are asking for magic?
In VMState, that nobody understands.

Sniff.

I remembered that VMState only cares about values, not for field names.
We can rename fields without any trouble....

Until we arrive to dump_vmstate_vmsf().

But I think we can have both things, the only thing that we really care
about vmstate dump is to do comparisons.  And for doing comparisons you
should be using vmstate-static-checker.py

That already have support for this.  Look up:

check_fields_match()

and see how it renamed other fields.

As you know better how to do this, can you play with the script and see
if you can get what you want?

If not, I can try to modify the script to get to what you need.

Later, Juan.


