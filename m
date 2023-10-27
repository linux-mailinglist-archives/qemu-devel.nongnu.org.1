Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D527D8F81
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwH4b-00021z-5g; Fri, 27 Oct 2023 03:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwH4T-00020A-NZ; Fri, 27 Oct 2023 03:15:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwH4R-0008SK-M1; Fri, 27 Oct 2023 03:15:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32f5b83f254so1194697f8f.3; 
 Fri, 27 Oct 2023 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698390947; x=1698995747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=r+vdINcmFGGjA6+x+iJDg46Mk3yJWEt8/WHgQwybeJI=;
 b=MldbtzSluhSSCnmrrOF0/7Rljo3RrrJqBbNOhKETXIo6wiRJIj0X5ThBi2TNSpen9O
 GbgaSbjrHFhWVocoMadz60I8cSE6Cz2R/lw1fxBkS2bs85hDs5gcamcia8X1pvsHwvnu
 I1PsPwNmTrtaDYpgQfctUM9siKOEz+V9OxI6528jOPZ7OrJV8617TTsQHwzpK7Veby4q
 Z56fzD84KPVBwLdlkPeNshS2nXsZyDgfWFDHJ/VIOe6C0OTfdui/8ATjZrCGFX0GyrTX
 BbJlG/Art4vw3WQ9uYStEuYR7kERBTx/zR5s4+x+gFsmr/Si1NTABdOZhLqkqtDhvvu9
 7gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698390947; x=1698995747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+vdINcmFGGjA6+x+iJDg46Mk3yJWEt8/WHgQwybeJI=;
 b=CnzkLZ6s13td8/m0n1/bhVRTm4R1p4EqSCCqWTx03/aAC+I14GJGMqizbTu2J7br2G
 Sw8iujpbD45l/RGwDOPS1uDibW+P5wkEtCQRyi3Mn4J2FhQUAlCQnuq732bKd80S8j8s
 VA6taAxzm4mQTWNxmdxkVKSenIOVJ1JkTrel0UhCSsUPHJEjpKG8T7ZBZOU93bKrJJr4
 jW36c8O1u5K1FACJcbznZUx8U2q/m5JlXdXcPSx2KHMjYYX+nurRtzUuDRffG2KY6vUD
 MXWcYSEJqfhyqNN9SR7SpRnYcSMUI/k/D6YJ/WpvbuKUME1rAGxN+PsJXbaqSLVKpKVg
 fjRw==
X-Gm-Message-State: AOJu0YxrLecrZMpGWWEt7G925REEDnIbzXsOm1BlOvaf+xHfF03mHdoa
 QE9c2gLjJKGCRj2r4/SJOQ0=
X-Google-Smtp-Source: AGHT+IFLvBaX+jKKJG5b7EuYxKD1+NY+YQPBw4JtamDZDEEoV5ML8tHynkORTdYmyuxI7EF3GYGUzw==
X-Received: by 2002:adf:efc4:0:b0:32d:a310:cc2e with SMTP id
 i4-20020adfefc4000000b0032da310cc2emr1551939wrp.34.1698390947261; 
 Fri, 27 Oct 2023 00:15:47 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a0560001a5400b0032ddc3b88e9sm1145980wry.0.2023.10.27.00.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:15:46 -0700 (PDT)
Message-ID: <abb048fe-5c73-4d09-8998-e4e54afe47a3@gmail.com>
Date: Fri, 27 Oct 2023 08:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/28] hw/xen: fix XenStore watch delivery to guest
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
 <20231025145042.627381-6-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42e.google.com
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

Reviewed-by: Paul Durrant <paul@xen.org>


