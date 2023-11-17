Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B797EF5C6
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41HN-0007VF-3D; Fri, 17 Nov 2023 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1r41HI-0007Uo-CK
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:01:09 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1r41HE-0002Aa-Nm
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:01:07 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso1977436b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700236862; x=1700841662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bDtPZ3CeG0C0aPMsGxaRlCZCXCSIUJQkLE1iD9QkYg=;
 b=jGQUNENeqdGOYA3+GhNFP2JvFbV20Q0o2SeXYz2+XR0k73nMOWA5O5fTmnHCchKbZe
 yz6Iq2GLXQLWvmaDqQllSMt/cg4PfCDaXy56kTJBTjoVX3QYKui3Xq4s5K0ncz5ucRQ3
 ekEpgt0x+z+yFez8BUFeibZGd3YskBHW8+I2vOpXJAudW0cQ3qlDx+Mzqpz5z6MUgk09
 f6XYGYpmG6GyVUuAIBNmV10NbFOH1B19l17gp5BkJlYPxgWJlFRQsyGidKeoisMriPoO
 h8vAn1i7Az0vwsCi1lavRcSPJ73qkO+zzkT7T4DA4U0cLoVA6PJfZXERSj0NCFDk5MRC
 rn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700236862; x=1700841662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bDtPZ3CeG0C0aPMsGxaRlCZCXCSIUJQkLE1iD9QkYg=;
 b=gt9yeuUiX88LIQXtcOteLRBKqsZLn8jrlyMweL/Pem+zFHFt3BYF6Z3YLGQ9vO4AW8
 4csFPHvJ1xYBTlyb0kqL2rz3kCI5pkh4Nbkaw/fU1CrpqmF8gPo7aCf7WwTjIOgq9Ht1
 tq0AEQ05sLnu7fP7cDU0z3yRnFC2oh+IvteGYzzx8irtjW5AVy/A/j3l3dHSTdFpSfqQ
 DTY63mvpK828Hn+YOMWy+ZnLkGDoef6WoxZkqOKz888A2bRe8eN49gx8jQdV9uHFxib2
 o7pBJ37RlCOgyPndj1ZHncUiegUdMu45siTqRrGX594Mov0g45fO4dgcfCn0E8SCmVVQ
 rtmg==
X-Gm-Message-State: AOJu0YwwlrtJhawo6pORK6/kcsMX4+ST1Pq+IoN/k1AyseTcNpCLmQ+9
 YRFm/6yL1Hg+EqPR2DFdOFw=
X-Google-Smtp-Source: AGHT+IHRpHJsG0iZ5NhlZ2jWJbERlhv57A0aoXF/EubV8my1O2KRMExJIhRdT0JyAnSk3YkWuV+eZA==
X-Received: by 2002:a05:6a00:148c:b0:6be:4228:6970 with SMTP id
 v12-20020a056a00148c00b006be42286970mr23031946pfu.21.1700236861700; 
 Fri, 17 Nov 2023 08:01:01 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a056a00084b00b006b1e8f17b85sm1539943pfk.201.2023.11.17.08.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 08:01:01 -0800 (PST)
Message-ID: <5edb0f5c-6070-411a-b9f5-b05275ddc708@gmail.com>
Date: Sat, 18 Nov 2023 01:00:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Firmware/edk2 20230918 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
 <7d866ee2-a166-457b-8137-4791caaff3cc@gmail.com>
 <jn7jj2lcb5qab7kpi3x46xhli257h7wqyk5ioe74a3etjdl4ga@uz3imwwenks6>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <jn7jj2lcb5qab7kpi3x46xhli257h7wqyk5ioe74a3etjdl4ga@uz3imwwenks6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 2023/11/13 20:09, Gerd Hoffmann wrote:
>> Hi,
>>
>> This apparently broke EDK2 for AArch64. I tried the following command:
>> build/qemu-system-aarch64 -drive
>> file=build/pc-bios/edk2-aarch64-code.fd,format=raw,if=pflash,readonly=on -M
>> virt -cpu max -nographic -cdrom Fedora-Silverblue-ostree-aarch64-37-1.7.iso
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2113005
> 
> tl:dr:  shim is broken, and recent edk2 starting to expose
> EFI_MEMORY_ATTRIBUTE_PROTOCOL makes the bug visible (without
> the protocol the buggy code path is never taken).
> 
> take care,
>    Gerd
> 

That's unfortunate. Thanks for the info.

Regards,
Akihiko Odaki

