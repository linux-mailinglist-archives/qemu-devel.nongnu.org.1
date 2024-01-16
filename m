Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709682F223
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:09:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlzQ-0003Sq-E0; Tue, 16 Jan 2024 11:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPlzO-0003S7-IX
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:08:34 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPlzM-0007WK-PI
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:08:34 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2cad931c50so458741766b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705421311; x=1706026111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yaUlQTJX/I3+KN8As6ccKE2k0B+o5pcCS3YyW3Qr5xQ=;
 b=RNu9LG2LbOgU8s8FJxhFlrafoUMMb3heCrm5p+ni5Zi95SEA8BQ6VNUwZvjcskWERn
 J3Y8fk+2dgL1hxN2OFqMc8/58qxXfBXVgq25FfAoCRqlm4eSWmz85Nl9eRXTxh+9p3X9
 72xXoFIab+LJiZcK6ic0HiqvNKwrFrsb+Lm2QFkzkDa/ExMzZA4huA8AHWjzvjaM4et7
 SeEQEc/cnQNiDctf0ccUuYP04SmnHbEgFFhqL7Bx7oytcvj1Z2YvckipJhozf6ycIc2E
 7fGEAUmunmWrlQGRIF59KTXpSKnHYNrml72WyFIMWSfCQOO1j10wjZpzhaUgTchWcEha
 KWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421311; x=1706026111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yaUlQTJX/I3+KN8As6ccKE2k0B+o5pcCS3YyW3Qr5xQ=;
 b=EnUenykTJ4G7EMk21ScKY6Kqa9PXfYeh5pQJXmMbZSOiGCdOuPEqlb0JTqYE23gszp
 vhsO+6L7xy89MyzjvChgOCVURpjEGYoRNM61iE/w9SkTJNYsQlWxNA4zSaw+mtOYg4LC
 RPb+89XTZxNT/jb+LQugewDp6J/J6zbGphuQ4c6PKENMii5ARvglzoLWEnwDWcvIyRY8
 90AplvhFuOLLORYhglldxFT5dVa55ouIEM8HVeaOsRkQvIIFeWg/wVymlEGOR08UMqja
 kK+XOix1RFJvl2Ovht5hEngP3gVpdSkoHil/fQ2bPuKcxjlGnlrta2wovQf5ODUUTyyX
 ALLA==
X-Gm-Message-State: AOJu0YzEZrC8ysS5q0XnFgyfjNAUjd8dd+KM4ceXLy6tDb6J/Dur+5H3
 ChagzrKejtpAlomIpGbRjGdpsQDha/VbEw==
X-Google-Smtp-Source: AGHT+IHpCIJZarbIVd62n7m9Ige8fGJAg4RhGccFwTtb3oFMc7VULsz+vFQvFQ1uSTuAcemgBMIq7g==
X-Received: by 2002:a17:907:7252:b0:a28:fa54:ff4a with SMTP id
 ds18-20020a170907725200b00a28fa54ff4amr5198170ejc.22.1705421311035; 
 Tue, 16 Jan 2024 08:08:31 -0800 (PST)
Received: from [192.168.1.102] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 ga8-20020a170906b84800b00a2dda4e81adsm2431201ejb.42.2024.01.16.08.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:08:30 -0800 (PST)
Message-ID: <4b7fe91d-9e96-4de4-af6f-c9be81c43ab1@linaro.org>
Date: Tue, 16 Jan 2024 17:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas
 <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
 <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
 <CAFEAcA8ZMHwKeEmwakt9BHt5Z_0DihYXtfTP-sOSBnt2dv6hWg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8ZMHwKeEmwakt9BHt5Z_0DihYXtfTP-sOSBnt2dv6hWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/1/24 17:54, Peter Maydell wrote:
> On Mon, 8 Jan 2024 at 13:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Gerd,
>>
>> On 8/1/24 13:53, Philippe Mathieu-Daudé wrote:
>>> From: Gerd Hoffmann <kraxel@redhat.com>
>>>
>>> Add an update buffer where all block updates are staged.
>>> Flush or discard updates properly, so we should never see
>>> half-completed block writes in pflash storage.
>>>
>>> Drop a bunch of FIXME comments ;)
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++----------
>>>    1 file changed, 80 insertions(+), 26 deletions(-)


>>> +static const VMStateDescription vmstate_pflash_blk_write = {
>>> +    .name = "pflash_cfi01_blk_write",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = pflash_blk_write_state_needed,
>>> +    .fields = (const VMStateField[]) {
>>> +        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writeblock_size),
>>
>> I don't get the difference with VMSTATE_VBUFFER_ALLOC_UINT32() which
>> sets VMS_ALLOC. In this case pflash_cfi01_realize() does the alloc so
>> we don't need VMS_ALLOC?
> 
> Yes, that's the idea. A VMS_ALLOC vmstate type means "this
> block of memory is dynamically sized at runtime, so when the
> migration code is doing inbound migration it needs to
> allocate a buffer of the right size first (based on some
> state struct field we've already migrated) and then put the
> incoming data into it". VMS_VBUFFER means "the size of the buffer
> isn't a compile-time constant, so we need to fish it out of
> some other state struct field". So:
> 
>   VMSTATE_VBUFFER_UINT32: we need to migrate (a pointer to) an array
>   of uint32_t; the size of that is in some other struct field,
>   but it's a runtime constant and we can assume the memory has
>   already been allocated
> 
>   VMSTATE_VBUFFER_ALLOC_UINT32: we need to migrate an array
>   of uint32_t of variable size dependent on the inbound migration
>   data, and so the migration code must allocate it

Thanks Peter!

Do you mind if we commit your explanation as is? As:

-- >8 --
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 294d2d8486..5c6f6c5c32 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -573,4 +573,6 @@ extern const VMStateInfo vmstate_info_qlist;

-/* a variable length array (i.e. _type *_field) but we know the
- * length
+/**
+ * VMSTATE_STRUCT_VARRAY_POINTER_KNOWN:
+ *
+ * A variable length array (i.e. _type *_field) but we know the length.
   */
@@ -678,2 +680,10 @@ extern const VMStateInfo vmstate_info_qlist;

+/**
+ * VMSTATE_VBUFFER_UINT32:
+ *
+ * We need to migrate (a pointer to) an array of uint32_t; the size of
+ * that is in some other struct field, but it's a runtime constant and
+ * we can assume the memory has already been allocated.
+*/
+
  #define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, 
_field_size) { \
@@ -688,2 +698,9 @@ extern const VMStateInfo vmstate_info_qlist;

+/**
+ * VMSTATE_VBUFFER_ALLOC_UINT32:
+ *
+ * We need to migrate an array of uint32_t of variable size dependent
+ * on the inbound migration data, and so the migration code must
+ * allocate it.
+*/
  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
---


