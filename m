Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28037D943F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJVy-0008At-2d; Fri, 27 Oct 2023 05:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJVw-0008AF-1W; Fri, 27 Oct 2023 05:52:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJVt-000796-Je; Fri, 27 Oct 2023 05:52:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso15239525e9.2; 
 Fri, 27 Oct 2023 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698400339; x=1699005139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2yiE3kmnMlzeuIC0wQ9aeOyHGBx7Hm50hNBXLvo1oLI=;
 b=euh4idqd+s37mOEHga0nzKtDtMD415RDp4vBAw/knLRv4lSx2LtDk9vi51JQ2uUnWz
 k1ix29DgKTXI0+G9qTryD0oaBvjHNcTawFBIPXCTRHrD0cwmRDNZhpWUnlA7ZznAjWlu
 /9yYWjyQQAEjpOYtD1lbl/PJ8ut5wmqLwqnnxvSflZqfsIIVN+pRaSqOSUy5aJTmE/Ne
 br6lHekJtujDZyaf3eI8Ye2aAnZ2DHYAntG9Qo0IBDZcSGflLjeDAidcTGCVmrAqh4ss
 kzxRVu+41/0scpGe1/PKFaUmyhHuEw0VT47ScxTs9UjVoRtSHh3Ex+H70M19WIRRynpD
 RZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400339; x=1699005139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yiE3kmnMlzeuIC0wQ9aeOyHGBx7Hm50hNBXLvo1oLI=;
 b=EUSoYC61pkgz3TPda2UQ+q6b0dWLWmlAsmbMr1YGtmk4ZhHqxRVzXotsEecNEkyHEM
 k7iuSDa2p/0bLhnv79Nu7RFYBaw/fHYXIr82epUG2zx8JieYzAnNqzEr8llpxVrrh8G9
 vr860I62gx+heoWAb1KiN80dwmArlEYQu0ulGO6Lb9N7Q6gYkHbvwAfT/K0gK0RO3LFt
 kIbF9PdgvyZ5Rg7pyQudTuT5yvKTN+e6MYUnJH6YyfMV5PFvlJHFdouK8q+sSDDQnAKK
 7ig2DXATyGEDvJ8wL2x7Vulpc9OJ56ye+HVjhWmNCxSEwJH2rz6OYJFtw/VWA4lMqdzQ
 PdKQ==
X-Gm-Message-State: AOJu0Yx/fqKdJvxLhTFo9dbC3MSEwzxZ2Rl9a0F5Gzib8vev3dpmMnbC
 vLLxdirxZjVUuiDRMTixKMg=
X-Google-Smtp-Source: AGHT+IEuLWOC6r1FV8oQb3wkYtxJ/Wfx1Om4s2yzSuMliOYSNXtiWemTUbczcZfVgloepcRrPb3iTw==
X-Received: by 2002:a05:600c:4ecd:b0:403:31a:77b9 with SMTP id
 g13-20020a05600c4ecd00b00403031a77b9mr1829515wmq.37.1698400339330; 
 Fri, 27 Oct 2023 02:52:19 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b003fee53feab5sm1212290wmb.10.2023.10.27.02.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:52:18 -0700 (PDT)
Message-ID: <88aad170-24f2-4ec6-b43c-ac87dde81255@gmail.com>
Date: Fri, 27 Oct 2023 10:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/28] hw/xen: use qemu_create_nic_bus_devices() to
 instantiate Xen NICs
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-28-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-28-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32f.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When instantiating XenBus itself, for each NIC which is configured with
> either the model unspecified, or set to to "xen" or "xen-net-device",
> create a corresponding xen-net-device for it.
> 
> Now we can launch emulated Xen guests with '-nic user', and this fixes
> the setup for Xen PV guests, which was previously broken in various
> ways and never actually managed to peer with the netdev.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-bus.c                    |  4 ++++
>   hw/xen/xen_devconfig.c              | 25 -------------------------
>   hw/xenpv/xen_machine_pv.c           |  9 ---------
>   include/hw/xen/xen-legacy-backend.h |  1 -
>   4 files changed, 4 insertions(+), 35 deletions(-)
> 

Yay! I've been wanting this for years but ETIME.

Reviewed-by: Paul Durrant <paul@xen.org>



