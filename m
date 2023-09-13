Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85479E50C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNCq-0000UE-44; Wed, 13 Sep 2023 06:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgNCo-0000Tn-BR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:34:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgNCl-0007K9-ID
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:34:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so591986b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694601281; x=1695206081;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gsX13CnQ+RiKdonhmGaJWnagAUBmE64zMiE8InJYMY=;
 b=CvbgQ85oUmSI6WTYc+EnVa5bOXudv3GffXLvcp5xCJdtG7vP2ENiro50qG97QqiITV
 8wUswpId8xV6qvlxXtM5cXI5Lf+ckvwNOCMN4ooBru9MMgDg1XDePMfrQS5s4ZILkvDs
 lQ9EQLgFZtf7Xc9m/0ydNLMuwtpO+7NZYPzb01zCrI1MMYy8MpF0hBVlCadjyK9lpDyG
 atCLzQZDzoW2eZOXOoQZugrucr06gIuj4ixXtL5UuLo8t5L9ps4IkxleRZTka2rxlAQi
 vCgH+l7TJbSNbMgnoRbUd5rgdytkCIR9Fz5cD+y84WpjidFiKTIcNmhDwTLLWn6esK+b
 WBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694601281; x=1695206081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gsX13CnQ+RiKdonhmGaJWnagAUBmE64zMiE8InJYMY=;
 b=noBon1VMrTTEQDm4m/Kb27Zc8kuNS00PFvti8qWHzh+hk7GKKUZ5SrvValcIV6meon
 DoQZfqygSSj0DsnrZRIxpNPUfhKeUpxSJ+hib1cn0VLTn5iNvAwNF80zMMdiRWSjjTDv
 8V1Sde3u7HZQIOuA3fofFOXWodpZZ1kNoIe7h+/OvIXN8uaRUXZ9ySEPhf7wmR/crxDY
 +F/MtvjBU04e/IR0jDhn359tlHbNAknP+YOH92no/py5cwhvnFalN8Nd9TZuzLLdi7kq
 8oqnPZu10gTmFYq+ryzIl6aGsnyZ0hGHjrBYsLjLCznml0NHPQuKC0kVWyKOBiH3/4Sr
 HBeg==
X-Gm-Message-State: AOJu0YyJmvH9AOYu/pmoT6YmxDGUe/8IVW1PjOOXMmNIU0qr3DCpHlMC
 2QdAFOiNzvtwxwEuSkBruFZd3Q==
X-Google-Smtp-Source: AGHT+IHTPT0tjzcnAJSUL9nT+wX3MjCaTXTLpkly5af71VyfGqmKrnsGwP6chzxn+R6v3usXUofQAw==
X-Received: by 2002:a17:90a:4101:b0:26d:3e6a:cd93 with SMTP id
 u1-20020a17090a410100b0026d3e6acd93mr7104225pjf.17.1694601280912; 
 Wed, 13 Sep 2023 03:34:40 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a63be05000000b00528513c6bbcsm7566372pgf.28.2023.09.13.03.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 03:34:40 -0700 (PDT)
Message-ID: <cf99ac00-6f48-4778-b319-6079a931ba5d@daynix.com>
Date: Wed, 13 Sep 2023 19:34:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
To: Albert Esteve <aesteve@redhat.com>
Cc: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
 <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
 <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2023/09/13 16:55, Albert Esteve wrote:
> Hi Antonio,
> 
> If I'm not mistaken, this patch is related with: 
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html 
> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>
> IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the 
> infrastructure from the patch I linked to store the
> virtio objects, so that they can be later shared with other devices.

I don't think such sharing is possible because the resources are 
identified by IDs that are local to the device. That also complicates 
migration.

Regards,
Akihiko Odaki

