Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453A7D55B9
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJBo-00014u-SZ; Tue, 24 Oct 2023 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJBm-000124-35; Tue, 24 Oct 2023 11:19:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJBk-0002fp-B5; Tue, 24 Oct 2023 11:19:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso13997445e9.0; 
 Tue, 24 Oct 2023 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698160762; x=1698765562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VEfz8HGhwcX+gjgFcsp72jn1Jb62YijVFIO7IeDxV9U=;
 b=mCRGptSPe9Pbw4RnjwNAa3/EOYfzpUxm2C3wzdBX7/kWOssyh4jw2yAWvTv1DXMMSc
 s352zIrXATFvJDlDqgcZJfaVGFNa+ZjPzj/+ZL+WQdAQVdyBX9QVBCTkIZiRTnOps+Gr
 iscvwhFrVKzMh90dFbNsfQ9T4UQpxB014v38QeRKRK1nALXvMuermnFzKQWTHWLMeTx8
 58lRG6S+Pwj3GOzrQStm/y9TSuCLQ0Lim2/oHe/BdQp4Wqj0bx1s6ztJ9nLEpLF64979
 LZL5a+yH/TL7IahVoGHO5fdxxJrFgHT7E1oKu/g7XQfiExQTBu0YUogD5EMPL82fkM9T
 yCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698160762; x=1698765562;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEfz8HGhwcX+gjgFcsp72jn1Jb62YijVFIO7IeDxV9U=;
 b=QZbFoKVL9+nxIqax5NmE3ztCA8gla1BpW4U64aCeW9IAGgeMAJnaCHkKVO7UWRozio
 AFNzUJsiGSnObPtASeurVnCyP34ScSP8Q/Y60epMYaH7peUzAb8OLJGxl3EQTSx1smL5
 xjQ6XSN8Vfyz6lDiXlDTL8qLjNhoWSuAfXTEM//BKEwQOrUIkkFeV9NcuekzM7tHshN1
 WfocDX+gQDPOWTXW3zdgwVSuHwzVJSoUnlx2CwjyqxVuJnz+kKAJmzZzgOY+7Z3hPPjx
 73N8AJpj31/4+ZJPxfYeMOJq6GAZAh12wU830aZu87bo039ITckGSdlSTps59J9zONb5
 EA6Q==
X-Gm-Message-State: AOJu0Ywx9HmelTeWF03iS2qHib6ypFZB52ISs1VpR3PDcW6AtfXN+SnS
 36KvxI61Y+bEnylBrUuWU+M=
X-Google-Smtp-Source: AGHT+IFftEtEWBlIWSE4+gB3PiSf+ybDx5RYYWCq9oIN1LDrIU9iRO6mz1Q4jl+RB/Bs7pJY5A6gBQ==
X-Received: by 2002:adf:ef42:0:b0:32d:aa14:875d with SMTP id
 c2-20020adfef42000000b0032daa14875dmr9015766wrp.29.1698160762122; 
 Tue, 24 Oct 2023 08:19:22 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d4001000000b0032dc1fc84f2sm10223557wrp.46.2023.10.24.08.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:19:21 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <88ce2b55-c933-4c72-933f-c8cd10470c7f@xen.org>
Date: Tue, 24 Oct 2023 16:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/xen: fix XenStore watch delivery to guest
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231019154020.99080-1-dwmw2@infradead.org>
 <20231019154020.99080-6-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231019154020.99080-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32b.google.com
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

On 19/10/2023 16:40, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When fire_watch_cb() found the response buffer empty, it would call
> deliver_watch() to generate the XS_WATCH_EVENT message in the response
> buffer and send an event channel notification to the guest… without
> actually *copying* the response buffer into the ring. So there was
> nothing for the guest to see. The pending response didn't actually get
> processed into the ring until the guest next triggered some activity
> from its side.
> 
> Add the missing call to put_rsp().
> 
> It might have been slightly nicer to call xen_xenstore_event() here,
> which would *almost* have worked. Except for the fact that it calls
> xen_be_evtchn_pending() to check that it really does have an event
> pending (and clear the eventfd for next time). And under Xen it's
> defined that setting that fd to O_NONBLOCK isn't guaranteed to work,
> so the emu implementation follows suit.
> 
> This fixes Xen device hot-unplug.
> 
> Fixes: 0254c4d19df ("hw/xen: Add xenstore wire implementation and implementation stubs")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
> index 660d0b72f9..82a215058a 100644
> --- a/hw/i386/kvm/xen_xenstore.c
> +++ b/hw/i386/kvm/xen_xenstore.c
> @@ -1357,10 +1357,12 @@ static void fire_watch_cb(void *opaque, const char *path, const char *token)
>       } else {
>           deliver_watch(s, path, token);
>           /*
> -         * If the message was queued because there was already ring activity,
> -         * no need to wake the guest. But if not, we need to send the evtchn.
> +         * Attempt to queue the message into the actual ring, and send
> +         * the event channel notification if any bytes are copied.
>            */
> -        xen_be_evtchn_notify(s->eh, s->be_port);
> +        if (put_rsp(s) > 0) {
> +            xen_be_evtchn_notify(s->eh, s->be_port);
> +        }

There's actually the potential for an assertion failure there; if the 
guest has specified an oversize token then deliver_watch() will not set 
rsp_pending... then put_rsp() will fail its assertion that the flag is true.

   Paul

>       }
>   }
>   


