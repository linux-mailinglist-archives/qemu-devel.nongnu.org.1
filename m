Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBB70A96E
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 19:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Q4F-0006VL-MC; Sat, 20 May 2023 13:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0Q4D-0006VB-Tf
 for qemu-devel@nongnu.org; Sat, 20 May 2023 13:08:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0Q4C-0003jR-9Y
 for qemu-devel@nongnu.org; Sat, 20 May 2023 13:08:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-309382efe13so2712168f8f.2
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684602505; x=1687194505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMkCQYgPnXGE90YMUOC4Ohpkx8GIoVEN+6c9iF44+QU=;
 b=fN00iQjH20qvLxc9mP2IL6ZpucHT2RDbSkrYMVXCY+rTP6vYVMFpKvVVAKPi0wxsla
 0NxixEWNiQBhPLEcTHKwPBDq1g1suxGIBU++nOYbAz1R9jbr5vBifB9erGh+ZV+vMena
 I0DBdvdqBuspvVfIgA6x6R7ZjcHMJpBl2zUmbVNEljQRjvhS1uyLAOkzuWaBVkcfESzB
 03YgzyauWqycACvYmj+nE4kYdAr/3V7WHNpoQGLul9eGDH+BitiDAc9RSKSKoLdhQCvh
 iikYHPia5tl1tWF49Qdbocy+kWJdOr+4b70M/k8z+FwuL8BIDi46Ibwl01IQZot/nPap
 atjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684602505; x=1687194505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMkCQYgPnXGE90YMUOC4Ohpkx8GIoVEN+6c9iF44+QU=;
 b=ctZTFAM2wUQ5kAC+ExBHnbcVxc6snivy1tyq5jh+MtCF1dYuCgQEu69UHmwJ7yilGQ
 +xGJmdbQ6kWSiMY0Ffw5p3SH2p5k9PqhSzaW9Hbycz9+GgclDmF2B5TPK55lQ58OF+CU
 ZQ9E1niFWvm/LWvpYv8QTngrftJ0wcc5SvzbZ2rs7WsxOrWYiclObavZPtZdg3FGaGSZ
 Nmn22gM2/NqEYGxGSlWRvvS0+tiai2zxwZ7ggTw8SJOU3YSre3lBRTm2MBXs/HxmaCU+
 WhNoZ1HWsIFf+acIEiiphKjo+B1KrX7jtnmPGHr4szbkYxvX454ZNdEGtx6MVr+o8yIE
 7MiA==
X-Gm-Message-State: AC+VfDzE8KKIQOWeQhGHQ/qCoaGPmOWGDI5d5JgBG+qlLM7k4szpMlF9
 pUJmZehymJ7CoxXuOluy81wEKQ==
X-Google-Smtp-Source: ACHHUZ6VVjkq+HEraagKzGdrcrMhbXkh/MXcbfHfjRREI0kWfyFkL4XWv8xtBJ43tgs4YpmsSga8lQ==
X-Received: by 2002:a5d:6a09:0:b0:309:48b9:977b with SMTP id
 m9-20020a5d6a09000000b0030948b9977bmr3938836wru.22.1684602505609; 
 Sat, 20 May 2023 10:08:25 -0700 (PDT)
Received: from [192.168.69.115] (cho94-h02-176-184-4-185.dsl.sta.abo.bbox.fr.
 [176.184.4.185]) by smtp.gmail.com with ESMTPSA id
 f5-20020a5d4dc5000000b0030644bdefd8sm2446907wru.52.2023.05.20.10.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 May 2023 10:08:25 -0700 (PDT)
Message-ID: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
Date: Sat, 20 May 2023 19:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
 <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.597,
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

On 20/5/23 17:15, Richard Henderson wrote:
> On 5/20/23 06:15, BALATON Zoltan wrote:
>> On Sat, 20 May 2023, Peter Maydell wrote:
>>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
>>> <qemu-devel@nongnu.org> wrote:
>>>>
>>>> From: Ira Weiny <ira.weiny@intel.com>
>>>>
>>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>>>> specified as little endian.
>>>>
>>>> Define st24_le_p() and the supporting functions to store such a field
>>>> from a 32 bit host native value.
>>>>
>>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>>>> used for the size part of the function name.
>>
>> Maybe it's clearer to use 24 but if we want to keep these somewhat 
>> consistent how about using t for Triplet, Three-bytes or Twenty-four?
> 
> I think it's clearer to use '3'.
> When I added 128-bit support I used cpu_ld16_mmu.

There is also ld8u / ld8s / st8.

> I think it would be clearer to not use letters anywhere, and to use 
> units of bytes instead of units of bits (no one can store just a bit), 
> but changing everything is a big job.

So:

ldub ->  ld1u,

lduw_le -> ld2u_le,

virtio_stl -> virtio_st4,

stq_be -> st8_be.

Right?

Also we have:

cpu_ld/st_*
virtio_ld/st_*
ld/st_*_phys
ld/st_*_pci_dma
address_space_ld/st

While mass-changing, we could use FOO_ld/st_BAR with FOO
for API and BAR for API variant (endian, mmuidx, ra, ...):

So:

ld/st_*_pci_dma -> pci_dma_ld/st_*

for ld/st_*_phys I'm not sure.

