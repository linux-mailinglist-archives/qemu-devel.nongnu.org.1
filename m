Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78AB831CEB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:54:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUiD-0006gA-1b; Thu, 18 Jan 2024 10:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUiB-0006g1-Od
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:53:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUi9-0000et-Uz
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:53:47 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso32548405e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705593224; x=1706198024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0iNZVli43o0z37Y5aAGtMUTah5lzLv3LDNeGz4kdock=;
 b=P07q5OWJC3T+LtnqhRWbXo+qviON5o9xYnirPj02RmU7WTRBhAGp59s7HEbP/m5dPA
 PV+Gn7qgrJCNdvrdBYmM8rqqdKr0mJLun6njLlDBMOL8tMJk7QetpuQmdLGsOpe/tp9L
 nGayNkbD3BnedgBwQTDzUOyOui+b3p2w4Kjbg02yyXALcwgjYUd4Z+h4TY763SX0q/ha
 ZeOiduUx4nNbWOIQ9yzecJ/SlWHqev5oyU0cTXsSEqB8tNhDJ3T7Reg351hOup/hgw0E
 EmzRgIX7aTr47/fE1RuNvyufn6yHTwf6nz81M59bivDUssowD/IwRuBUwHI6un6fAv2S
 RUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593224; x=1706198024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0iNZVli43o0z37Y5aAGtMUTah5lzLv3LDNeGz4kdock=;
 b=tE6lOtN+RuitBHlgTULi3DSLXqheicvHBq239E19/bZEqsPtdas5FmW+y8Jap/6694
 sqRaIiCi5NV3IGj3q/rd/J3/NaFaz9c5/IOtOy44A80HYlIbKSPKrYaccjKW1lUhfQwb
 XhSsV81s7zcrPvhSG2IiC3NRrkbFV7HrsLP6bQdEdgGyW4No7K6aIG9EFzos4MD9T6iT
 osOTIFunB7tUHlGj6aKziJKkwqftjJEbi5GxUTwnlQCvLb4hrEyWB0Q8x8H0D/mdg3aO
 3W40m3T5Hp2abRVWVfjdS7H+vei2COytBjjDImDaFbNgTBaY7h7kQeAp6z3DIINclU5a
 YiOg==
X-Gm-Message-State: AOJu0YzMNk/r93QYqReKFk1Qd8CvtHTesHD6NDT2j/GycTQmLkpAH2sl
 9gBPBMEe49h8GHzCQbRcLZpf9gYvnY7iLUcMHRvvpG+tq1EDYtRTf9PGIn4FNtY=
X-Google-Smtp-Source: AGHT+IEXM/KOdD0h3w3FBer0RozfH30/0LxBMJtd1G6evegSc6rBmXW4eI+bd8h1jP/CEVRHJQRR1w==
X-Received: by 2002:a7b:cb87:0:b0:40e:62d8:3321 with SMTP id
 m7-20020a7bcb87000000b0040e62d83321mr649719wmi.34.1705593224257; 
 Thu, 18 Jan 2024 07:53:44 -0800 (PST)
Received: from [192.168.108.175] (33.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.33]) by smtp.gmail.com with ESMTPSA id
 g15-20020a5d64ef000000b00336f43fa654sm4398752wri.22.2024.01.18.07.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 07:53:43 -0800 (PST)
Message-ID: <e9a43ce9-2e2d-4f5e-a3f2-98c958285895@linaro.org>
Date: Thu, 18 Jan 2024 16:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
 <CAFEAcA-n3pu6YEaohm_7Wj8yO+oxYB2b6u+T1Jq6Pmi70wU4bg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-n3pu6YEaohm_7Wj8yO+oxYB2b6u+T1Jq6Pmi70wU4bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/1/24 18:46, Peter Maydell wrote:
> On Wed, 17 Jan 2024 at 09:16, <peterx@redhat.com> wrote:
>>
>> From: Peter Xu <peterx@redhat.com>
>>
>> QEMU resets do not have a way to order reset hooks.  Add one coarse grained
>> reset stage so that some devices can be reset later than some others.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/sysemu/reset.h |  5 ++++
>>   hw/core/reset.c        | 60 +++++++++++++++++++++++++++++++-----------
>>   2 files changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
>> index 609e4d50c2..0de697ce9f 100644
>> --- a/include/sysemu/reset.h
>> +++ b/include/sysemu/reset.h
>> @@ -5,9 +5,14 @@
>>
>>   typedef void QEMUResetHandler(void *opaque);
>>
>> +#define  QEMU_RESET_STAGES_N  2
>> +
> 
> Our reset handling APIs are already pretty complicated, and
> raw qemu_register_reset() is kind of a legacy API that I would
> prefer that we try to move away from, not add extra complexity to.
> 
> Our device reset design already has a multiple-phase system
> (see docs/devel/reset.rst), part of the point of which is to
> try to give us a way to deal with reset-ordering problems.
> I feel like the right way to handle the issue you're trying to
> address is to ensure that the thing that needs to happen last is
> done in the 'exit' phase rather than the 'hold' phase (which is
> where legacy reset methods get called).

I concur. Devices reset is hard, but bus reset is even harder.
Having a quick look, the issues tracked by Alex & Peter might
come from the PCI bridges using the legacy DeviceReset. In
particular functions like:

- hw/pci-bridge/pcie_root_port.c

  46 static void rp_reset_hold(Object *obj)
  47 {
  48     PCIDevice *d = PCI_DEVICE(obj);
  49     DeviceState *qdev = DEVICE(obj);
  50
  51     rp_aer_vector_update(d);
  52     pcie_cap_root_reset(d);
  53     pcie_cap_deverr_reset(d);
  54     pcie_cap_slot_reset(d);
  55     pcie_cap_arifwd_reset(d);
  56     pcie_acs_reset(d);
  57     pcie_aer_root_reset(d);
  58     pci_bridge_reset(qdev);
  59     pci_bridge_disable_base_limit(d);
  60 }

- hw/pci-bridge/pcie_pci_bridge.c

107 static void pcie_pci_bridge_reset(DeviceState *qdev)
108 {
109     PCIDevice *d = PCI_DEVICE(qdev);
110     pci_bridge_reset(qdev);
111     if (msi_present(d)) {
112         msi_reset(d);
113     }
114     shpc_reset(d);
115 }

- hw/pci-bridge/xio3130_downstream.c

  56 static void xio3130_downstream_reset(DeviceState *qdev)
  57 {
  58     PCIDevice *d = PCI_DEVICE(qdev);
  59
  60     pcie_cap_deverr_reset(d);
  61     pcie_cap_slot_reset(d);
  62     pcie_cap_arifwd_reset(d);
  63     pci_bridge_reset(qdev);
  64 }

should really be split and converted as ResettablePhases.

pci_bridge_reset() is likely a ResettableExitPhase one.

> There are some annoying wrinkles here, notably that legacy
> qemu_register_reset() doesn't support 3-phase reset and so
> the phasing only happens for devices reset via the device/bus
> tree hierarchy. But I think the way to go is to try to move
> forward with that design (i.e. expand 3-phase reset to
> qemu_register_reset() and/or move things using qemu_register_reset()
> to device reset where that makes sense), not to ignore it and
> put a completely different reset-ordering API in a different place.

Unfortunately despite DeviceReset being deprecated since 4 years
in commit c11256aa6f ("hw/core: add Resettable support to BusClass
and DeviceClass"), we keep adding code using this legacy API; for
example in the last 4 months:

- e029bb00a7 ("hw/pci-host: Add Astro system bus adapter found on 
PA-RISC machines")
- 2880e676c0 ("Add virtio-sound device stub")
- 4a58330343 ("hw/cxl: Add a switch mailbox CCI function")
- 95e1019a4a ("vhost-user-scsi: free the inflight area when reset")
- 6f9c3aaa34 ("fsl-imx: add simple RTC emulation for i.MX6 and i.MX7 
boards")

Regards,

Phil.

