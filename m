Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3035E9D5F53
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 13:55:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETAF-0004my-Fx; Fri, 22 Nov 2024 07:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tETAD-0004mS-Mk
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tETA8-0001io-4b
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732280006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FaKzPoIOcbnLE2rqBstv5iMoKQD/qR7qhwV5rj6dPOo=;
 b=MDdDaqtseCUKkg/OGntvtwtpDzokZuBf563XTizjN3dgctbf7/Zq/pxMoH+jKwaYsmoWKn
 ATq5dPRmKxb+ojZ7cyEuwgiVGn1jyg4MKoArf7d3QWYAvpAE6cn5D8xbCdxji6o/Afo8iT
 oesvZO/oOAcUfHpYTjmjM4EAFM4uazo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-SQoTPVVSOqOllTRg9nFAeQ-1; Fri, 22 Nov 2024 07:53:25 -0500
X-MC-Unique: SQoTPVVSOqOllTRg9nFAeQ-1
X-Mimecast-MFC-AGG-ID: SQoTPVVSOqOllTRg9nFAeQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso15638245e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 04:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732280004; x=1732884804;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FaKzPoIOcbnLE2rqBstv5iMoKQD/qR7qhwV5rj6dPOo=;
 b=BJX5ueWhf3XtwJy5HV+nUm1ni2lqC67WHfjp6wXrW5nux6O8hZ6u++SVO8TQLVGNMG
 V/jCk+bip8IM5oDVobIpD9tz5DR5NUdTtphvl5UZPPKjblBBlkyk6BLptNem1hPvsMk3
 PHitNmLCNHrL8Xb0YyYnRnTLq3LD7EepAk7wqF9PUeVXffUiRKin4lMlcDXlSF2T71JN
 vndQtD2yVPxa92TDkbmNey/9gu5iNA1/i4PX+jr1/ab/p1vEE0r0zygoZY3yQZaLmuPV
 LrVT/xC5SZIfv5J99b/GZ5/RoVRD2dUz9L30aEIBo6oiqzH0qxmnSKdMa1ZFWNTdSbDu
 CSyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUtb6wvBlr69Tu//tBDhQOuZM5BUTgJ8+yf5dKEIP1qLdgBPELqwwm+4/Nv76Dnal45Nnk0AHLnP0H@nongnu.org
X-Gm-Message-State: AOJu0YxulDvWhktGSvK1klfWypuoctf/LV5+M9500ttN2tHHX5G/VHof
 rDuxfCjyQI6SXmTipR2cLYBp591RBMg86PY+3lhzr9Bv3kgG/KHV1NQW9ibjBTDjISQPTQJ3Hk4
 QnwyMJKHyz0QwpTFTTzCTKODB+0QPsBYzXoc0qGNDv4IJDBMALxDE
X-Gm-Gg: ASbGncsHFeMrlPVeSwEwlML6l58TIfX2/Vfw1f7luKIGJlu/+0wvRt9QK+Och7EGnSF
 yRV+xaptgI0O7DeTPOSKAGcFO9hzSPuJHR3v/yI1ps6VTZRN8Ss4+KEpi0j3HZEoKpvfxLXatlV
 rJfyEQ9GF7AtDpbe46ZWzzpSnIlp0aJaOjr6o03N2QksChko25/a2Bi8K8hweoPGOr4b7KBTfgd
 mmNpu6OzjBs+o9DSKuy3NJ0+uXtlHECMBCm32nq9gxyvrNKXQV3rxI=
X-Received: by 2002:a05:600c:3b94:b0:431:51c0:c90f with SMTP id
 5b1f17b1804b1-433ce4c1e59mr21630505e9.21.1732280004042; 
 Fri, 22 Nov 2024 04:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbphXsGvLTNLipJdNht0sGuASWvTUxDwKsf3q9+MwJq1QFur3fDC+q4LGdyx1BVd6alUaVFA==
X-Received: by 2002:a05:600c:3b94:b0:431:51c0:c90f with SMTP id
 5b1f17b1804b1-433ce4c1e59mr21630205e9.21.1732280003664; 
 Fri, 22 Nov 2024 04:53:23 -0800 (PST)
Received: from [192.168.10.28] ([151.49.204.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9be8sm2334323f8f.24.2024.11.22.04.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 04:53:23 -0800 (PST)
Message-ID: <5b91eba1-be60-48b9-ab6c-9f483601e36e@redhat.com>
Date: Fri, 22 Nov 2024 13:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/scsi: Cleanup around
 scsi_bus_legacy_handle_cmdline()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241122111939.11936-1-philmd@linaro.org>
 <f18c00d1-1ae3-4f14-9e6e-5fa1fb09b1d5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <f18c00d1-1ae3-4f14-9e6e-5fa1fb09b1d5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/22/24 13:37, Thomas Huth wrote:
> On 22/11/2024 12.19, Philippe Mathieu-Daudé wrote:
>> When a device model requires legacy command line handling,
>> call scsi_bus_legacy_handle_cmdline() in its realize handler
>> instead of having each user call it.
>>
>> This applies to:
>>   - spapr_vscsi
>>   - lsi53c810 / lsi53c895a
>>   - sysbus_esp
>>
>> Note, scsi_bus_legacy_handle_cmdline() prototype could be
>> made private to hw/scsi/ to restrict its use to scsi device
>> implementations.
> 
> Not sure whether this is the right way to go ... shouldn't the handling 
> of the legacy command line be rather part of the machine than being part 
> of the SCSI controller device? Imagine for example a machine that has 
> multiple, different SCSI controllers - I think you'd rather want to let 
> the machine decide where the legacy devices should be grabbed from than 
> having the SCSI controller devices fight for them...?

I agree that it should be done in the machines generally:

1) if the machine creates a SCSI controller, it should then call
scsi_bus_legacy_handle_cmdline().  This is the case for esp and for
spapr-vscsi (so spapr_vscsi_create() could be inlined in its caller).

2) lsi53c* is the odd one out because it was "the" way to add "-drive
if=scsi" to the PC machine.

For case (2) it's okay to call it in the realize function, I guess.
However, let's only process -drive if=scsi for devices added on the
command-line.

The LSI HBA should not call  scsi_bus_legacy_handle_cmdline() if
dev->hotplugged.  I think we can do it without a deprecation period,
and in fact assert that !phase_check(PHASE_MACHINE_READY) in
scsi_bus_legacy_handle_cmdline().

Paolo


