Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B7799C93
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 06:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfBxl-0003iN-48; Sun, 10 Sep 2023 00:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfBxX-0003gN-Ej
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:22:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfBxT-0008Nc-26
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:22:06 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-565334377d0so2841318a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694319721; x=1694924521;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y41O7m8lzKH6Z6I1rP686Lg5qOtZy5LXRHQ0fLJI1OY=;
 b=cxmRZwnwuQX5EZ62LUKIhXu4MK3H8MU2sX0rMUyA+AbZxf1k1ci5uUxoUzHhwQoEuS
 /VKkhix40aSuVIeSykXw0bDFbDg355zo4gNCvgbgEEjjj4PihN9Af5wZNDwY7an7lYWj
 Q6r1P+HRSht+rrp4jJgfp9rrAfLK3VUAoTcmSlnDcpJgx3nsdjNiUpHFfdUZIWqleJCE
 hcGu3Lvy2u8wgPJ6SXfIiX47E9v3RHMruzgMPtRrMIGYY/wseMgjz7wyLC/cjpwtodJw
 eqEfPJKaXnRc772OYEsd4cH88slmELo4tCwFQnFmLYWGuz4SYuHUhL0IiGPKTVirgt28
 7WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694319721; x=1694924521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y41O7m8lzKH6Z6I1rP686Lg5qOtZy5LXRHQ0fLJI1OY=;
 b=uT+AVnCMn3hJVOy8QjCunYWnH9CoDy4FKsIL1GGjcXbJxmagqskzAIWHF7sgx2dt2X
 mglgon+Tk5St2L/rQte/jFxcLbk2Zci/nFB9ojqoWPgSMne2f6kv2CzHeJIFN8u74ioV
 f6RpGfe+7aa7dazBJQsDlEOLzsXtxO3U0X/UQMbAFiMcKc2wyxe9+443acBSWKqRoCEl
 VyucT7ag2Q42V5L6ibFTRn9luacblmMhiPsAzKkhzsm0MyCzv5v5xtOqh12UV6mkkHhQ
 lz8gL87SyLjlUmbIVMzMmRpFef07mPIn8bKFWRKTU29ehak/hAksxnc8QFslSXq5Q/xc
 nW8A==
X-Gm-Message-State: AOJu0Yzq4HuXNE0KiI8dS5nA3UQdfHvXL4/F/4ZFm7zE1bqJ+95Yncow
 gPSK8M2WHqIzknstN02qxybZyw==
X-Google-Smtp-Source: AGHT+IG3w2NwKdjms/SuiPqAhtRTC9XzAYUKIfiyZjUtztV1ZlgLuJusPzzoM2Ll4o14KuOFM1cx2w==
X-Received: by 2002:a05:6a20:105a:b0:14d:16c:2d20 with SMTP id
 gt26-20020a056a20105a00b0014d016c2d20mr6996494pzc.44.1694319721488; 
 Sat, 09 Sep 2023 21:22:01 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a63b705000000b0056afdbd0a24sm142840pgf.9.2023.09.09.21.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 21:22:01 -0700 (PDT)
Message-ID: <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
Date: Sun, 10 Sep 2023 13:21:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-11-ray.huang@amd.com>
 <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com> <ZPw2UjxogIULU722@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZPw2UjxogIULU722@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/09 18:09, Huang Rui wrote:
> On Thu, Aug 31, 2023 at 06:36:57PM +0800, Akihiko Odaki wrote:
>> On 2023/08/31 18:32, Huang Rui wrote:
>>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>
>>> Enable resource UUID feature and implement command resource assign UUID.
>>> This is done by introducing a hash table to map resource IDs to their
>>> UUIDs.
>>
>> The hash table does not seem to be stored during migration.
> 
> May I know whether you point g->resource_uuids table data in VirtIOGPU
> device should be stored in virtio_gpu_save() and resumed in
> virtio_gpu_load() for virtio migration?

Yes, that's what I meant.

Regards,
Akihiko Odaki

