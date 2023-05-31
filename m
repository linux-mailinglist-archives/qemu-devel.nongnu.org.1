Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC3718E8E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UM5-0008SW-4E; Wed, 31 May 2023 18:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UM3-0008SJ-Hl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:31:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UM1-0004lh-Tk
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:31:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so1887695e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572300; x=1688164300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LeSF3VtyYj9aReJgsSQ4yN4Kk0oJsK1bPIaxcsFUUhQ=;
 b=qzoknjDKTxvVHIk90mXltOwLdAUEgk21RnO3C8bCk3AHwszkmsegfwi+7jq+lSLgjg
 aVppc/GQSv43sPcHongmU/kKlbF3GzHXyLOtdbej+gQFPtH/G8DPYFG9fwIgcRDQriNr
 kdUajyKWo0i83BzwOZZVJVudOY8Jfnt9417FX8cfN7lGxyeF9wbsyvKZOtJcsyzL22Q1
 PIAyyO6izu0ShFLqqXKLfOYxvXV8M6HMvF+QBr42D1ZJxHBogDziHg+PnxZYsCSbSDrE
 fsVAL7QKrAD8UvxGxNm60z72wdwRY/1PDW2E+/KiDlbwjTR+4oD4MLqQP0PCB82LbV+N
 dfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572300; x=1688164300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LeSF3VtyYj9aReJgsSQ4yN4Kk0oJsK1bPIaxcsFUUhQ=;
 b=TCgMDdOdhIakQ4E2nkNrkeyorARtPdckFvS3dfD+oxm/2X9TLAbRrO5Yp7h2S59PpC
 OhAY/zquL4u6pBFItTUn3UBN8cyTyFXrvcbJRF2GD7SARbOOCIrDwus65eddPEUkqmTN
 zmTtm5rvio+Ljy9G66aL8A1VuwASO4a5qWvmHwWn4gmStdRbXw2zE0I/Bcu+CaHOl9kQ
 H5fwbfeWoU/KD1mt8uISmZDMIHa0asqTH7aqXfiRwHxZyoWS36NoNn7ohIzt/yg1JsyT
 oSYyuEvwseypO+F19jAmvHBIL5+QKgQY9tJeGJWgvNNJhNui7dBStH7Fajr06IsI5cz0
 IlJw==
X-Gm-Message-State: AC+VfDw11vo/OdYYnq5HkUtka8FFpZ6He7OQdl3ihuLN1ZLtpaLZ7pZz
 xbb8l64NOwNaepF5/cxQIniqIA==
X-Google-Smtp-Source: ACHHUZ5YekqSB/sbfWIx2Rxb1+QKZqDcApCDPUe6RBFPX4KYwQBM5RODu/aXjOCAn4pfKrKz3Lcf0w==
X-Received: by 2002:a7b:cb9a:0:b0:3f6:42e:579d with SMTP id
 m26-20020a7bcb9a000000b003f6042e579dmr677135wmi.27.1685572300292; 
 Wed, 31 May 2023 15:31:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b003f605814850sm76017wmk.37.2023.05.31.15.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:31:40 -0700 (PDT)
Message-ID: <f3fff871-3e7b-6ace-887d-a9b8adedc1c8@linaro.org>
Date: Thu, 1 Jun 2023 00:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230526231558.1660396-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 27/5/23 01:15, Alex Williamson wrote:
> This RFC proposes to allow a vfio-pci device to manipulate the PCI
> Express capability of an associated root port to enable Atomic Op
> completer support as equivalent to host capabilities.  This would
[...]

> While it's not exactly standard practice to modify root port device
> capabilities runtime, it also does not seem to be precluded by the PCIe
> Spec (6.0.1).  The Atomic Op completion bits of the DEVCAP2 register
> are defined as Read-only:
> 
> 7.4 Configuration Register Types
>   Read-only - Register bits are read-only and cannot be altered by software.
>               Where explicitly defined, these bits are used to reflect changing
>               hardware state, and as a result bit values can be observed to
>               change at run time. Register bit default values and bits that
>               cannot change value at run time, are permitted to be hard-coded,
>               initialized by system/device firmware, or initialized by hardware
>               mechanisms such as pin strapping or nonvolatile storage.
>               Initialization by system firmware is permitted only for system-
>               integrated devices. If the optional feature that would Set the
>               bits is not implemented, the bits must be hardwired to Zero.
> 
> Here "altered by software" is relative to guest writes to the config
> space register, whereas in this implementation we're acting as hardware
> and the bits are changing to reflect a change in runtime capabilities.
> The spec does include a HwInit register type which would restrict the
> value from changing at runtime outside of resets.  Therefore while it
> would not be advised to update these bits arbitrarily, it does seem safe
> and compatible with guest software to update the value on device attach
> and detach.

 From my previous (short) PCIe experience, this is also my understanding.

