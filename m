Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E558388B2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:18:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSByJ-0008DP-A8; Tue, 23 Jan 2024 03:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSByF-0008Cu-IV
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:17:23 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSByC-0008GE-GJ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:17:23 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a44bb66d3so4452425a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997838; x=1706602638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3voI8ZgZ+1TqLXfXx+xrSq5avYZkOHUUAVsGc2redPg=;
 b=I8F97RpGCDaXOlesEacnW3y+pn1snleFMhvQgb4YklvWeBy+cHB16ROhPh9n0wvtXM
 b1Y35MyKumf9B3/wAbWCJi4G30Z/TgW99Ob8o4OA4JGi1Qw8igJBDuqU5TGKVe6gC+1F
 Z8SZ/n8T5MiWBFZPsdz1dKC3bf0u0rfcncleyihkn4H0erbzI9MvxnDrdQt99Td/WFOU
 c8vxGteZIJac/x9CjAbFBk9Cz2pluWJftw1ZwvceyMCpVurJBPFz5MS3klwxtY0n1CvD
 AFDugLC0qmmRvusPZ7BqyG1B/camC5Al6d/fpaHgC4sMZuownFR9PcxOPQxXDIQ9jNTD
 IzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997838; x=1706602638;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3voI8ZgZ+1TqLXfXx+xrSq5avYZkOHUUAVsGc2redPg=;
 b=YniPXn9x1RbHpHKbYRJas4yY1U3f0iARSb9ybUpAau50nJfVrVLNQJHmopwQ3OGP7i
 omOSwrMdXpl5QMKsnex1LQBssbB9NtDo8tyTRdpEUC4RhPbYWIeKmgSNIKRBG3+eeiV7
 4JMg+qb7MaOB/exXADsFASYm89TJUW1D5tnrUVb5Ps4Nw6Xb7cuJlrJnMSkuCPV87HZ/
 7KGKqdvr/QOn18BUoj+TOjCmvW5RqYUiRInCNWykBeutGoaE/ZrVoEVUUVOGuS+oRfWc
 0jyFNTKPuo2NKqZ3V8aL5yfGRCHrf3zLVm1kN89Rmxi/9UoUBvmUaxQHQFtJ3s61zp3j
 z5eA==
X-Gm-Message-State: AOJu0YwzxK/KAAxrRsxNO6FeLNoLIdGeyCjCAYP55r/r3qlNsDHgtUVZ
 H3s8dKg3ulwDfDvizqrxQzzU1D0b2DoV+Jx/5WOJnbEbg8Ber8fJmA1BrTHFV4o=
X-Google-Smtp-Source: AGHT+IGqO7CHlqxdA17urND9iFTjJ3Htf7Hj85QX/CMk+etVQtMozibMRtvGbzHPZ2Lew0tgsOgbEQ==
X-Received: by 2002:a17:906:3889:b0:a2e:ac18:eb6b with SMTP id
 q9-20020a170906388900b00a2eac18eb6bmr2569503ejd.116.1705997838147; 
 Tue, 23 Jan 2024 00:17:18 -0800 (PST)
Received: from meli.delivery (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 q14-20020a1709060f8e00b00a2a61b9c166sm14116262ejj.33.2024.01.23.00.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 00:17:17 -0800 (PST)
Date: Tue, 23 Jan 2024 10:15:25 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 1/2] hw/core/qdev.c: add qdev_get_human_name()
User-Agent: meli 0.8.5-rc.3
References: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
 <15b15d6d4f2a1706b5e2d85ab18e25bcb03e72c2.1705938003.git.manos.pitsidianakis@linaro.org>
 <1c9c1750-d9c4-4743-afa4-7fafc1f82ed8@linaro.org>
In-Reply-To: <1c9c1750-d9c4-4743-afa4-7fafc1f82ed8@linaro.org>
Message-ID: <7pgcr.qacudqer98uf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 23 Jan 2024 10:13, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Hi Manos,
>
>On 23/1/24 09:09, Manos Pitsidianakis wrote:
>> Add a simple method to return some kind of human readable identifier for
>> use in error messages.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   hw/core/qdev.c         | 10 ++++++++++
>>   include/hw/qdev-core.h | 15 +++++++++++++++
>>   2 files changed, 25 insertions(+)
>> 
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 43d863b0c5..499f191826 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -879,6 +879,16 @@ Object *qdev_get_machine(void)
>>       return dev;
>>   }
>>   
>> +char *qdev_get_human_name(DeviceState *dev)
>> +{
>> +    if (!dev) {
>> +        return g_strdup("");
>> +    }
>> +
>> +    return dev->id ?
>> +           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
>> +}
>> +
>>   static MachineInitPhase machine_phase;
>>   
>>   bool phase_check(MachineInitPhase phase)
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 151d968238..a8c742b4a3 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -993,6 +993,21 @@ const char *qdev_fw_name(DeviceState *dev);
>>   void qdev_assert_realized_properly(void);
>>   Object *qdev_get_machine(void);
>>   
>> +/**
>> + * qdev_get_human_name() - Return a human-readable name for a device
>> + * @dev: The device
>> + *
>> + * .. note::
>> + *    This function is intended for user friendly error messages.
>> + *
>> + * Returns: A newly allocated string containing the device id if not null,
>> + * else the object canonical path if not null. If @dev is NULL, it returns an
>> + * allocated empty string.
>
>In which case do we want to call this with NULL?

None I could think of, just future-proofing the NULL case.


>> + *
>> + * Use g_free() to free it.
>> + */
>> +char *qdev_get_human_name(DeviceState *dev);
>> +
>>   /* FIXME: make this a link<> */
>>   bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
>>   
>

