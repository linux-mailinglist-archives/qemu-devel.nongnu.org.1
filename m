Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806378C0B5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauL0-00064s-Cr; Tue, 29 Aug 2023 04:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qauKt-000635-9E
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qauKr-00068L-6n
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693298668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fw6R4aLpYaUGz33JitFXw8SYZiJy3kU2MndWcVgB1s=;
 b=VIzd5hTzuidY+oKQlKrG7apYuDd1A4OsAIM2mbhR/7pw9E1K7CkBUtrMeaorakk/Fi8Ei+
 tuLO7lkLZZJTiK120+kYawh5JnTy52AbmpmD8ju2cBv7Ar13t3E8u2SHcMqKCspbBTJFXo
 tWnOC4LLug5jiDWYkjFhEsv9pMS7/EM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-zZW6QvydOV-d5hhaprBoQg-1; Tue, 29 Aug 2023 04:44:27 -0400
X-MC-Unique: zZW6QvydOV-d5hhaprBoQg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993d41cbc31so326489466b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298665; x=1693903465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fw6R4aLpYaUGz33JitFXw8SYZiJy3kU2MndWcVgB1s=;
 b=B/xgSEohWuQMd4WctG3mCMCAWbXEb46SP4d2eEw0O9QGxMmedFvgJWfIZ2IOwtKtvZ
 0s14QxuajOO9TT6BtGORmHoG+Yv6ZXMA+NnX3gUBPOSGEf99604Rg9ts7q+ipnSL3XvL
 k5kCahhs+opdgG9oBqUjnHPJyr+KJnjF1VtfjEosBKeA5kAabuv9naGOFzmj9yK9sAmJ
 nLI3IDaH93RyFEW5tk7K8hxD91lhjJYPn4JbeladJKBlBisfHVV7FMx55csRH543hWO+
 7CKzHtv7uk3YcDrWxNNzHP/XyZLPLWBOh9hfk+kg2QeufJYoGza5rkMPC8XTxiU8T12f
 UFOw==
X-Gm-Message-State: AOJu0Yw3Lm60ue3Jls1lOEs85cAPj5ReumojVTXdms/tj2Vmn/o1b1Gz
 LInIn8Tvu+kiAN2H7pX8L1dCUyGBwIc97dT+8hD8eNT0Fy1iVGyFaTw9NpfAD5iOLwLuYe+trdp
 1/Bg8huuSOOYJs9rWftt7Q90=
X-Received: by 2002:a17:907:75d8:b0:9a5:821e:1655 with SMTP id
 jl24-20020a17090775d800b009a5821e1655mr7533763ejc.71.1693298665688; 
 Tue, 29 Aug 2023 01:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBg1UL6PBG5KDsl1bLpXJ3sBxa0abJBzMCp8T4+FlGYd+vSkxWtw/W9CPheUR+gA0L6vczcA==
X-Received: by 2002:a17:907:75d8:b0:9a5:821e:1655 with SMTP id
 jl24-20020a17090775d800b009a5821e1655mr7533749ejc.71.1693298665330; 
 Tue, 29 Aug 2023 01:44:25 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a1709063e5200b0099275c59bc9sm5743691eji.33.2023.08.29.01.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 01:44:24 -0700 (PDT)
Message-ID: <a85cf501-28cc-1811-c48a-130c4f0fdd68@redhat.com>
Date: Tue, 29 Aug 2023 10:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
 <c348e12f-4667-3459-ef2c-86b514456132@redhat.com>
 <38eafe9c-e213-400c-8130-5b30539f5841@virtuozzo.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <38eafe9c-e213-400c-8130-5b30539f5841@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29.08.23 09:06, Andrey Drobyshev wrote:
> On 8/25/23 17:29, Hanna Czenczek wrote:
>> On 01.06.23 21:28, Andrey Drobyshev via wrote:
>>> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
>>> the data read from the old and new backing files are aligned using
>>> BlockDriverState (or BlockBackend later on) referring to the target
>>> image.
>>> However, this isn't quite right, because target image is only being
>>> written to and has nothing to do with those buffers.  Let's fix that.
>> I don’t understand.  The write to the target image does use one of those
>> buffers (buf_old, specifically).
>>
>> This change is correct for buf_new/blk_new_backing, but for buf_old, in
>> theory, we need a buffer that fulfills both the alignment requirements
>> of blk and blk_old_backing.  (Not that this patch really makes the
>> situation worse for buf_old.)
>>
>> Hanna
>>
> Hmm, you're right.  In which case the right thing to do would probably
> be smth like:
>
>>           float local_progress = 0;
>>   
>> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
>> +        if (bdrv_opt_mem_align(blk_bs(blk)) >
>> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
>> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> +        } else {
>> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
>> +        }
>> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>>   
>>           size = blk_getlength(blk);
> I'll include this in v2 if you don't have any objections.

Looks good to me, thanks!


