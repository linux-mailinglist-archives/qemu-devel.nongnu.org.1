Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1457AAAE2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjb0B-0002AB-FY; Fri, 22 Sep 2023 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qjb09-00029m-M8
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:55:01 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qjb08-00016P-5G
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:55:01 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59bebd5bdadso22429507b3.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695369299; x=1695974099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8RXYYOqkolR4tgfj+/pR4qTvePP5DdDSeLK49U0/dw=;
 b=Vonsk2IEgMM6Yy7EHqiWhsUlHnCysRMsi9ZBRO5t1YmeSUfd4TLvK4uCMo6tXhLJjQ
 o3QUPNiWRR+JiTA3gyG1DQzKnNFjHgclwJzLLtC/LGKDsaUkJu0mNaOtpKdYV5+Sk2mN
 g3EoZs1Q/dsd/B9E+w8bxKWv/l7d+rwV5xZIQCwnwk2n2aVkKgjmCuMoZoA3LR5UiBjG
 kcZ/Wa/f7S49AyBjC7wA6Rh7xFMUXWCwQTIhdzKOVAIopOl/k5UAUnIYZOvCzzBxe1eq
 Vc4mQHVKNgZ0gcTEAfclVLyj81ACyVzZiRvPr+wic3HbK6Ug+QFgCS+PgQ9KuYk779o4
 pN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695369299; x=1695974099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8RXYYOqkolR4tgfj+/pR4qTvePP5DdDSeLK49U0/dw=;
 b=pZtYNmVS96XAF0jxwd/a1fYhk81sT9eUYarearNsQTdjw1pUqQWmt6bI0RZ2+mJqdM
 hussIafrDxSIVY9cI2VUMUXmSzmH0eT/S+oBhsBYdu8qCzG45x0Zh9DmmnQZmz4D2Uvl
 BJAWwUzaWaiMfY8sIQ1cUMt7X1ZfebNbeuthg5nH+5ZRDFtj9y4oddI4KjlqJhmuuCuV
 qjaSzKVh0K8ZbF2iDXXW57dnuPD1BjItkGGBIc7/sVHdBs9kXtlfdGEIsfc0sjPsjeiC
 lDq6iEffjxbFhDNvj8q86htMS3C4+17kCsSOjwX5DdOmZH2ffA9ASPvxp5Np3/qu479I
 cu0w==
X-Gm-Message-State: AOJu0YxNV5gScEtMFa0gINB3i3ThAnMvs2tUUiu5g15OgNoiiylpXfFX
 2Dw+6N+isSkz3p9jBFXesKo=
X-Google-Smtp-Source: AGHT+IGkCXCqQW0xPMFjAF/2h7RN/DE7xkOIqvXLg6jkoeiOLg1gR9PUTF7YkZ1rX0jQd/k4EF+5qg==
X-Received: by 2002:a0d:c341:0:b0:583:307d:41bc with SMTP id
 f62-20020a0dc341000000b00583307d41bcmr7342128ywd.27.1695369298892; 
 Fri, 22 Sep 2023 00:54:58 -0700 (PDT)
Received: from [157.82.207.177] ([157.82.207.177])
 by smtp.gmail.com with ESMTPSA id
 z27-20020a637e1b000000b00563e1ef0491sm2552667pgc.8.2023.09.22.00.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:54:58 -0700 (PDT)
Message-ID: <faae6c7b-2b2b-44e5-99b8-261f17f28645@gmail.com>
Date: Fri, 22 Sep 2023 16:54:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Alyssa Ross <hi@alyssa.is>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 marcandre.lureau@redhat.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 xen-devel@lists.xenproject.org, Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <20230829003629.410-7-gurchetansingh@chromium.org>
 <2620fca0-a5b4-49d0-bf91-fd359ee4999b@gmail.com>
 <3830bf8d-8c25-950c-f901-8d70dbfc06a6@ilande.co.uk>
 <CAAfnVBknhG=QYn=OFjNW9h=KbDtQ=xq3AEs5Pg=AG3LTO=LZ6w@mail.gmail.com>
 <6256f069-ee39-495e-a8c3-ea2328f085a2@gmail.com> <87lecyejry.fsf@alyssa.is>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <87lecyejry.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023/09/22 16:42, Alyssa Ross wrote:
> Akihiko Odaki <akihiko.odaki@gmail.com> writes:
> 
>> Practically there is very low chance to hit the bug. I think only
>> fuzzers and malicious actors will trigger it, and probably no one will
>> dare using virtio-gpu-rutabaga or virtio-gpu-gl in a security-sensitive
>> context.
> 
> Well, this is exactly what Chrome OS does, albiet with crosvm rather
> than QEMU, right?

I think so, but QEMU's virtio-gpu-rutabaga and virtio-gpu-gl should be 
very different from crosvm in terms that it does not isolate the 
graphics stack into a separate process while I believe crosvm does so. 
Having the entire graphics stack in a VMM is a security nightmare; it 
means giving a complex shader compiler the highest privilege. We need to 
use vhost-user-gpu instead for process isolation.

Since we already have such a serious security hazard, I don't think we 
have to care much about security. But security approximately equals to 
reliability, which matters for virtio-gpu-rutabaga and virtio-gpu-gl 
too, so it's still nice to get the bug fixed.

