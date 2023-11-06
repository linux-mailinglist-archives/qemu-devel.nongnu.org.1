Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF657E2940
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:00:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r020O-0001cQ-0x; Mon, 06 Nov 2023 10:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r020E-0001c6-Uq; Mon, 06 Nov 2023 10:59:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r020D-0000w0-0n; Mon, 06 Nov 2023 10:59:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso35558395e9.2; 
 Mon, 06 Nov 2023 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699286339; x=1699891139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YdRU2ICAmJ5fzVK5A8/S2GOgHKTlNLHwKSHWlkevpuU=;
 b=csFHVWrG5M804KpbE92BLsFDaNX0WQ4MtqOYcTh9R6YJnC8QHwtNc6x+zSvEie4CZG
 Zz3oUFuVmYUi0z+pmugt/1UQGCtqYDWHNoOfahDYarvwtAcXs0t5yEPYwOejX0HhgzaJ
 CcyJFeWwHAaCmhHvrCq0zNqM57zCLDGko5rKbDHETVK7974dOp2BBk0LeU8FRYNpJJcx
 0PyNMtLYKkfmmwwD7H23iBiiLa9C15fIoxteiA/cSWNx9d9BGEWRwwOrSClMy7zNOzNu
 VR5aZ1RlfdT37ul0z5uDgDZfcAc9Ua5hoQnpAJ8oG7PuKIrjJ1KgOjesYp5cwUTp66Cc
 a6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699286339; x=1699891139;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdRU2ICAmJ5fzVK5A8/S2GOgHKTlNLHwKSHWlkevpuU=;
 b=G3sBHtTrmmVKcJlOvebDn7N7BQG2HUNpSUJUYCF8uWpKj/V3vC0FqEEud+u5fvINOV
 2WD6hb50ggDI+RPI0d8n2ZGlR7lXpCX0I5R5chlm5mP7Em4uMJMYg4VUTw+Z8R0+r+AM
 3e0zFVyle7ERwrb8JAUq6FZKQgSV56PpgNfwpHVRonn4S2d1eIcZzrQCSEdGC68lVUyZ
 VJAgQbC1DPuo7GjE8ViKHb5jI6aZFg957jiUxm+fp2oqWBitagRDk/NKiKz94qY80OHz
 dA3Up1WKsKeFdFqsqk6U/fxOcmBwSDKTWTaOLw0SWzFW6LVs1Y0taLMxsRPfLJhJtduZ
 UOnw==
X-Gm-Message-State: AOJu0YwY5Jv9zmbNA9ILb78mXjCNW2Q3QPhXqNOzQnTW8g6R+uZBMBXJ
 s9bVsw4j2zykcExDbpEYLks=
X-Google-Smtp-Source: AGHT+IG+oPN1NQBnC7slICVrFKIK+QQJ+pHrO26W48S90buGxRQhChU5XJhSimZD7bEJ7PpCsy+dGA==
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id
 j17-20020a5d6051000000b0032da4c4f700mr20821057wrt.38.1699286338898; 
 Mon, 06 Nov 2023 07:58:58 -0800 (PST)
Received: from [10.95.110.31] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 bs14-20020a056000070e00b0032d8eecf901sm10060456wrb.3.2023.11.06.07.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:58:58 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2cb5f62-9a32-4ea2-bb34-b551dcb0755c@xen.org>
Date: Mon, 6 Nov 2023 15:58:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] hw/xen: automatically assign device index to
 block devices
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231106143507.1060610-1-dwmw2@infradead.org>
 <20231106143507.1060610-7-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231106143507.1060610-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 06/11/2023 14:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There's no need to force the user to assign a vdev. We can automatically
> assign one, starting at xvda and searching until we find the first disk
> name that's unused.
> 
> This means we can now allow '-drive if=xen,file=xxx' to work without an
> explicit separate -driver argument, just like if=virtio.
> 
> Rip out the legacy handling from the xenpv machine, which was scribbling
> over any disks configured by the toolstack, and didn't work with anything
> but raw images.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   blockdev.c                          |  15 +++-
>   hw/block/xen-block.c                | 118 ++++++++++++++++++++++++++--
>   hw/xen/xen_devconfig.c              |  28 -------
>   hw/xenpv/xen_machine_pv.c           |   9 ---
>   include/hw/xen/xen-legacy-backend.h |   1 -
>   5 files changed, 125 insertions(+), 46 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


