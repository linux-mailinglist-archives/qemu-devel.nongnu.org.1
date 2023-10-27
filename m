Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 214077D9026
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHWd-0005hb-Db; Fri, 27 Oct 2023 03:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHWX-0005fd-43; Fri, 27 Oct 2023 03:44:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHWU-00033N-1C; Fri, 27 Oct 2023 03:44:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40859c464daso14152345e9.1; 
 Fri, 27 Oct 2023 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698392687; x=1698997487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=weNLTHsNEHd1AKAqcG0eLkMfm7+O04Gb2EjgMXPk2o8=;
 b=C4+V/Fk6JBLIXckJh5QHsVYai1uuRhyZMnQvqB0jefIUNimRpL8GuOvYeWRbOCGLyT
 Zh/xoEi+goM5TD6UZZDDv3eFJzsNL2bd1E9oh6JeCbos24qPPoOJZTKbPyvDGn/7bXfo
 M1+eD9pey0VdT2LeLlaz1jSTAqNvpDISxB/Cd8Igt2Pgmm39zAhnIcXoDQQSPZCnWhCc
 B9EUSPGqucy09mJghSiFu+SrihpfqcukkmzfnWJB/9QXeVw/w9BYZ/tyxKfl+HZ1gpVs
 D/f0t6bSIo87nAX2NVBBiqPADRXn2GZUs4ulpFy5hLs7uEn3XvDAfTY5w9P1I48lKYHF
 FqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698392687; x=1698997487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=weNLTHsNEHd1AKAqcG0eLkMfm7+O04Gb2EjgMXPk2o8=;
 b=UuE9YDKkiW3y9qfqgYsdfdeamtwIdZaEx1kinfb7ZhJb4IjkVfEKH6po/l1riS7WO5
 LGfxn1XvV03am0R7FtVL8h79rKzbV+wROlTPNFf7P+S23n+N6xh2j9FjfycRFtNM3EdF
 k4ZLuHVs/eZz5LHqdyVxTtPK63YifGRzLV/fSxpVVInlUQ2qt3xAOyseIHP2aRyDDxnI
 uf/hlG+Wv1fnXfOMglcdNXGJo72sMcJZ5OcR6gjimBcUTMIIcmuZr83FgkMuGTOrBuif
 DnLhNNMBcOXktaDpeZbsD5cT4S9DocwwywO/FV1ECGF9BUSmeY2YQAjQs8rjLNOccUra
 xyhg==
X-Gm-Message-State: AOJu0YwTCqpUuEYS3eqO+SEobjpdrnwNVnOO8RwYSaBRdHBIbhoaQYMC
 jMjDailalYVSgpIV8mZDI90=
X-Google-Smtp-Source: AGHT+IGfHlZcElg4jlYC+dM2f33yrgLaTa3lKMccWGDiPJqAf0Qf0ppM0UHBxCctTNhgycC9pq53SA==
X-Received: by 2002:a05:600c:45d3:b0:405:3dd0:6ee9 with SMTP id
 s19-20020a05600c45d300b004053dd06ee9mr1653222wmo.34.1698392686518; 
 Fri, 27 Oct 2023 00:44:46 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b004068e09a70bsm940661wmo.31.2023.10.27.00.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:44:45 -0700 (PDT)
Message-ID: <d58639b8-09de-4820-88ae-53de0db55f7f@gmail.com>
Date: Fri, 27 Oct 2023 08:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/28] hw/xen: add support for Xen primary console in
 emulated mode
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
 <20231025145042.627381-18-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The primary console is special because the toolstack maps a page into
> the guest for its ring, and also allocates the guest-side event channel.
> The guest's grant table is even primed to export that page using a known
> grant ref#. Add support for all that in emulated mode, so that we can
> have a primary console.
> 
> For reasons unclear, the backends running under real Xen don't just use
> a mapping of the well-known GNTTAB_RESERVED_CONSOLE grant ref (which
> would also be in the ring-ref node in XenStore). Instead, the toolstack
> sets the ring-ref node of the primary console to the GFN of the guest
> page. The backend is expected to handle that special case and map it
> with foreignmem operations instead.
> 
> We don't have an implementation of foreignmem ops for emulated Xen mode,
> so just make it map GNTTAB_RESERVED_CONSOLE instead. This would probably
> work for real Xen too, but we can't work out how to make real Xen create
> a primary console of type "ioemu" to make QEMU drive it, so we can't
> test that; might as well leave it as it is for now under Xen.
> 
> Now at last we can boot the Xen PV shim and run PV kernels in QEMU.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/char/xen_console.c             |  78 ++++++++----
>   hw/i386/kvm/meson.build           |   1 +
>   hw/i386/kvm/trace-events          |   2 +
>   hw/i386/kvm/xen-stubs.c           |   8 ++
>   hw/i386/kvm/xen_gnttab.c          |   7 +-
>   hw/i386/kvm/xen_primary_console.c | 193 ++++++++++++++++++++++++++++++
>   hw/i386/kvm/xen_primary_console.h |  23 ++++
>   hw/i386/kvm/xen_xenstore.c        |  10 ++
>   hw/xen/xen-bus.c                  |   5 +
>   include/hw/xen/xen-bus.h          |   1 +
>   target/i386/kvm/xen-emu.c         |  23 +++-
>   11 files changed, 328 insertions(+), 23 deletions(-)
>   create mode 100644 hw/i386/kvm/xen_primary_console.c
>   create mode 100644 hw/i386/kvm/xen_primary_console.h
> 

Reviewed-by: Paul Durrant <paul@xen.org>



