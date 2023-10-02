Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A787B518E
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHGp-0007ml-Up; Mon, 02 Oct 2023 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qnHGo-0007mX-Hc
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:39:26 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qnHGi-0007SM-Si
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:39:26 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c1807f3400so37308731fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696246758; x=1696851558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Fas0ygKr9kM0YoKzVTcfd2uOkIoABx+gxXXvLkhbfnU=;
 b=xb/HTTb0SV0QoDe5jhfSc29eryRwnYPdnqE6+V3wrmXTL/fQOnB3YSKEgWx/9oCBZE
 Q7cPDGeuzJcGAuLERlVBn+QhirhoUUbAUW7DuuT/dVUbmjeWIQ4p5JTQgliPVEwgvHdF
 27EjI2fWySQxcbeob987ZhBAxdsZBdRDrOp3zgSw3JujrngH8jW5VzZSbFvA4WKzXhAX
 GUkpUrRVleiXPI9koULsoF0+ZstKDeOpMfOVHhYHx+qF/0DttXnq7pFDRGWAfmJL1CfG
 GShPqo3gormB6H2NeeFF+kCqmJrE22XGguTuQiuMLPefqP6NAQfeGIYR6ch63Aq/0Y7N
 PUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696246758; x=1696851558;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fas0ygKr9kM0YoKzVTcfd2uOkIoABx+gxXXvLkhbfnU=;
 b=vo7YoWHKFTLr4VWIiq9pfNT5p5vmvvi4lDHEeNAwhy93nSSSHPQhBnvu9dkUb+mmTO
 a5N4IwkRfjukPM46kUO6Ri7St28aIeKj7U8I40jd1tDfM5IYAWviZrha6f28ZdQjZx6j
 ji1yeFoy+QbINsBLkSqyo3XSjhXpTSK4jev9dslj47wNQkUJ3HBDKW4vf5C1JJZwFBsX
 NxBVV9qgmC3lgDFs/8Ipkmcadnp3ZtoPE0UOK+CcBN3nbb1QYiVEcfoq9REd11V17kc9
 Vxbysuw6Vr+znKJKBIfElvaA6uDf4lAfvnhw2lMu/OUSjxGq9eTBLRqGD8wnOBNgt9eb
 9+qA==
X-Gm-Message-State: AOJu0Yw4RxZKVlDGEbqrnhmmeFmLK7/kN6+3FHiQRzBCSFvvGz69wZUB
 pAaIRpjhAT53gFwMDfOE8fJYlA==
X-Google-Smtp-Source: AGHT+IFWxt+fnQ5lZXT9u0CjCyKj5t8NTBsI4ytFyYo7zveR0TvWBqb0IleMteepfGm/CgQxGd8zjg==
X-Received: by 2002:a2e:a224:0:b0:2c1:86da:3f61 with SMTP id
 i4-20020a2ea224000000b002c186da3f61mr9030230ljm.9.1696246758440; 
 Mon, 02 Oct 2023 04:39:18 -0700 (PDT)
Received: from [192.168.200.206] (83.21.112.107.ipv4.supernova.orange.pl.
 [83.21.112.107]) by smtp.gmail.com with ESMTPSA id
 b30-20020a05651c0b1e00b002c288388153sm1447244ljr.136.2023.10.02.04.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 04:39:17 -0700 (PDT)
Message-ID: <9f372453-4088-47d2-a501-c32eeaa5d9f5@linaro.org>
Date: Mon, 2 Oct 2023 13:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: SLT must be RO
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
 <9cebce70-59fc-e7bb-5973-3091680b72ea@linaro.org>
 <42e00aaf-2399-4ba9-bef6-8627b8e0718e@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <42e00aaf-2399-4ba9-bef6-8627b8e0718e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

W dniu 8.09.2023 o 15:29, Marcin Juszkiewicz pisze:
> W dniu 31.08.2023 o 12:05, Marcin Juszkiewicz pisze:
>> W dniu 30.08.2023 o 23:48, Michael S. Tsirkin pisze:
>>> current code sets PCI_SEC_LATENCY_TIMER to WO, but for
>>> pcie to pcie bridges it must be RO 0 according to
>>> pci express spec which says:
>>>      This register does not apply to PCI Express. It must be read-only
>>>      and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, 
>>> refer to the
>>>      [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
>>>
>>> also, fix typo in comment where it's make writeable - this typo
>>> is likely what prevented us noticing we violate this requirement
>>> in the 1st place.
>>>
>>> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>
>>> Marcin, could you pls test this patch with virt-8.1 and latest?
>>> Thanks a lot!
>>
>> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>
>> sbsa-ref: PASS
>> virt:     PASS
>> virt-8.1: FAIL (as expected)
>> virt-8.0: FAIL (as expected)
> 
> Can we get this patch refreshed and merged?

ping?



