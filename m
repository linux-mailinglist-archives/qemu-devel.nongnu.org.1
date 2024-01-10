Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D1829AD2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 14:01:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNYBK-00077S-Hr; Wed, 10 Jan 2024 07:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-eric@damsy.net>)
 id 1rNYBE-00077J-QW
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 07:59:36 -0500
Received: from mail.damsy.net ([2a01:7e01::f03c:91ff:fe93:d9c3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-eric@damsy.net>)
 id 1rNYB3-0006IB-VE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 07:59:32 -0500
Message-ID: <aefe25cd-6d67-4594-a368-f8f424526c7d@damsy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damsy.net; s=201803;
 t=1704891562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4r8eZazLgjiMzk/DKUXZkBu5yIo/Yei+trtO5Q1vHc=;
 b=tXwagdUZZJx73BpxwNt/W6hboXzr1kY06nolXMI7SwYX/ZI+Y8t53jiiIBPI02pos1lpHs
 jcg2bZgS7JUsJgI0SXv2dr+4ZM6b7OAQRbi8VagYjc364QntbAjwZzZLReQ4fHYVVfyIyK
 kDvgAKBa9imlvh5lDZLpxG8KXU4OjDVTKY39BF9mZx/b96TxQtD3jDBkngTDJ89Qc9DWDQ
 Ef1tkfbGQNO40X/kycCb6SWUFCQGN4HTQDkej0+MjpyKiHFQTKHf+q305uQdZkoMpr+wDB
 2n0etZdJ5L2KP0bbMtVHsJ5J/sMQAUNJ9m5HSKC+GNq5gzOfO8jAfKVJvZyMsQ==
Date: Wed, 10 Jan 2024 13:59:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v6 07/11] virtio-gpu: Handle resource blob commands
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-8-ray.huang@amd.com>
 <0d08a014-cdf5-4b4f-a683-171ae4c8b6e0@daynix.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <0d08a014-cdf5-4b4f-a683-171ae4c8b6e0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:7e01::f03c:91ff:fe93:d9c3;
 envelope-from=pierre-eric@damsy.net; helo=mail.damsy.net
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Le 21/12/2023 à 09:09, Akihiko Odaki a écrit :
> On 2023/12/19 16:53, Huang Rui wrote:
>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>
>> Support BLOB resources creation, mapping and unmapping by calling the
>> new stable virglrenderer 0.10 interface. Only enabled when available and
>> via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> I have another concern about delaying virgl_renderer_resource_unref() until the resource gets unmapped; the guest will expect the resource ID will be available for a new resource immediately after VIRTIO_GPU_CMD_RESOURCE_UNREF, but it will break the assumption and may corrupt things.
> 

Yes this is a problem.

And another one is virglrenderer is not really thread-safe, so this callstack:

#0  virgl_resource_blob_async_unmap ()
#1  object_finalize ()
#2  object_unref ()
#3  memory_region_unref ()
#4  flatview_destroy ()
#5  call_rcu_thread ()
#6  qemu_thread_start ()

Will call into virgl_renderer_ctx_resource_unmap which in turn uses virgl_resource_lookup
without any multithreading considerations.


Regards,
Pierre-Eric

