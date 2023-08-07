Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3ED772799
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:24:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT19e-0006CK-Jt; Mon, 07 Aug 2023 10:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qT19c-0006Bz-3x
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qT19a-0007UC-83
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691418252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcBlqX2sbi2sZk0FipcXfBX+rhC4tzprK4gD+wZTILo=;
 b=XJeSwnIV9KlYIGkNeK5+18TNKWA66kKh0tS7wmKNvlgRP665Sp24eZfblM/ionG0dJWgvB
 NgpsbQKXHNNOyFgffpuPcyN7ggmd4dDkHPsBiAFKLZJxvKeN/lMbDPL85yQcBhRtgAcCKE
 4xhjxPoe7rECNNlCPm7S7Tsby1WEEZw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RE4jgHb3MiigwpDnTr4kzw-1; Mon, 07 Aug 2023 10:24:10 -0400
X-MC-Unique: RE4jgHb3MiigwpDnTr4kzw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9e8abe539so44808201fa.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691418249; x=1692023049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tcBlqX2sbi2sZk0FipcXfBX+rhC4tzprK4gD+wZTILo=;
 b=Dm5axgrHiu+9WFm+HoAa1O1D0AJTRmirLNc29MI+oLWZRExAptq207DDzkgYrbQEBl
 JdbGQTEl5fFC4nVM8E1UlvrhqWgrsxxVAOaM2hxaVIMEPGKmbVgwPAHSSe6uonmc62AF
 e/mC+0it5aRjSyUiJgt57cn14kVfAhvTB8YANgBUrkkfoqZ1TcOJRDrj/fZ+TCHbWlWY
 Yn/fH06H+PSuDKcwkweEp62wO/epMds2ToHIRNg4UR01jisTRIgYDD3UzqMBQW8k1mxQ
 uT6XeUyPKTK4LsA8/Q4SgrP/qYWLoYePsMwEUGKnZs7VcK1VjZSQkz+KZb1ODQkQM+7K
 lF8w==
X-Gm-Message-State: AOJu0YyE+zs4GBNS0Ix3LYz4lXPL24BGN7V2NWvMIl0AwJL0Em1Ic3Bi
 WRYvhM18QKmE0OX3Ldic5ZzLad1dUm85PkL4Ml1mVTxXW+9/oVNNi8aiBi4V9+ZwCnO5B86hzrI
 RkJSl8WecEGCmU2A=
X-Received: by 2002:a2e:3a0f:0:b0:2b6:da66:2d69 with SMTP id
 h15-20020a2e3a0f000000b002b6da662d69mr6502892lja.28.1691418249332; 
 Mon, 07 Aug 2023 07:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE34cB0DmEmXql0MZ37HqaAJUKH2Vs/p7N21ln2Xd/VHwdK12/HDjt+hxP7s7gpb6UVKq6Psg==
X-Received: by 2002:a2e:3a0f:0:b0:2b6:da66:2d69 with SMTP id
 h15-20020a2e3a0f000000b002b6da662d69mr6502871lja.28.1691418248896; 
 Mon, 07 Aug 2023 07:24:08 -0700 (PDT)
Received: from [10.43.17.57] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a1709060c0f00b0098e42bef736sm5368081ejf.176.2023.08.07.07.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 07:24:08 -0700 (PDT)
Message-ID: <b9dc2c50-00cf-12ae-d1c9-cb31d089a24d@redhat.com>
Date: Mon, 7 Aug 2023 16:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/9] gfxstream + rutabaga_gfx
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230803235502.373-1-gurchetansingh@google.com>
From: Erico Nunes <ernunes@redhat.com>
In-Reply-To: <20230803235502.373-1-gurchetansingh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello,

On 04/08/2023 01:54, Gurchetan Singh wrote:
> Prior versions:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html
> 
> https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/
> 
> Changes since v2:
> - Incorporated review feedback
> 
> How to build both rutabaga and gfxstream guest/host libs:
> 
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
> 
> Branch containing this patch series:
> 
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v3

I tried this on Fedora with a Fedora guest and I was able to get Vulkan
headless applications as well as Wayland proxy with sommelier to work.
If you don't mind, I have a few questions.
I was not able to run Vulkan applications over the Wayland proxy, only
unaccelerated apps. This seems to be unsupported yet; is actually
unsupported for now or was something missing in my setup?

Also apparently GL/GLES is only supported on Android right now as you
mentioned, since on Linux the gfxstream guest only installs the Vulkan
library and icd. What is the plan to support GL on Linux; provide
gfxstream GL guest libraries later or enable Zink or some other solution?
Then if I understand correctly, Mesa virgl is not used at all with the
gfxstream solution, so I guess we would need to find a way to ship the
gfxstream guest libraries too on distributions?
Also I wonder about including all of the the dependencies required to
get this to build on distributions as well to enable the feature on
distribution-provided qemu, but I guess we can figure this out later...

And finally out of curiosity, I see that rutabaga also has a
virgl_renderer (and virgl_renderer_next) backend which would then not
use gfxstream but virglrenderer instead. I wonder if there would be any
benefit/features in enabling that with qemu later compared to the
current qemu virtio/virglrenderer implementation (if that would make
sense at all)?

Thanks

Erico


