Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6788B8FF1
	for <lists+qemu-devel@lfdr.de>; Wed,  1 May 2024 21:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2FEF-0008Vk-E5; Wed, 01 May 2024 15:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s2FEC-0008VW-Vp
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:02:53 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s2FEB-0000sA-8V
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714590168;
 bh=9kITYvs1HN/n9hcLwm+Kai3ykiaV/euLrKeDt6DNLlM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZnjJnRokKzSNLBZmxu/YTUO9U1UPdFJ8mRLFph0XJnECTJ0iq12EAPoDQRVAxZSYJ
 hLaLfkfRwbkvMQiYKaaSedM5+024oSRfCaDP++T7rjIhyjs1LTHLbP//PrLZk38cDF
 xh/N9IoAizeTHvLwRVGIBvsV19b1ZXH0rjk3aUKAjvHPz1RrOt7KqFGj/lljp9IMYW
 OJVUdgVKwek1tsQbxz1NFLpZkUulBq2/3DmHb8fcTjar3rjpzOjaT1D//bJJP6BAMN
 Q2WGZ3QWkSG3Zj2Be8wVWbMbQbh4ArCU0wusKYXX4Ruyw6bwt276n4ckkuo2djLsIN
 ZF1Z2aTdKCNLQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0493337820A4;
 Wed,  1 May 2024 19:02:45 +0000 (UTC)
Message-ID: <5b240c8a-f1c5-487f-a528-cbb4f440094f@collabora.com>
Date: Wed, 1 May 2024 22:02:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/11] virtio-gpu: Support suspension of commands
 processing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
 <8a153bf1-f86c-46c8-a29a-08e9a0197dc3@daynix.com>
 <4c6b3ca0-4813-48f4-87f8-a94e911c02d3@collabora.com>
 <10337ba0-70ce-436c-9cac-398851ebdfc9@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <10337ba0-70ce-436c-9cac-398851ebdfc9@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/27/24 08:48, Akihiko Odaki wrote:
>>
>> The VIRTIO_GPU_FILL_CMD() macro returns void and this macro is used by
>> every function processing commands. Changing process_cmd() to return
>> bool will require to change all those functions. Not worthwhile to
>> change it, IMO. >
>> The flag reflects the exact command status. The !finished + !suspended
>> means that command is fenced, i.e. these flags don't have exactly same
>> meaning.
> 
> It is not necessary to change the signature of process_cmd(). You can
> just refer to !finished. No need to have the suspended flag.

Not sure what you're meaning. The !finished says that cmd is fenced,
this fenced command is added to the polling list and the fence is
checked periodically by the fence_poll timer, meanwhile next virgl
commands are executed in the same time.

This is completely different from the suspension where whole cmd
processing is blocked until command is resumed.

-- 
Best regards,
Dmitry


