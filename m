Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC57D9405
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:42:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJMS-0001ui-EY; Fri, 27 Oct 2023 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJMQ-0001tn-87; Fri, 27 Oct 2023 05:42:34 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJMO-00042J-Dp; Fri, 27 Oct 2023 05:42:33 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507be298d2aso2723968e87.1; 
 Fri, 27 Oct 2023 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698399750; x=1699004550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Kiz2KMdg7YL05gR8LgSt7smgQdVxoWMShyrXxPJfs9s=;
 b=ju5AxphV8bNKX4ZDNoNhotjpq8dBTU+UpuHpJ4D9i73BrMfh+6iCl08AwmtP8E/Ae3
 9maDx+3r87T54lIHtrck9yQuIS4f4hhAhsCk+IbxBvIlsJt4l153hAbDWMdHOhxGqzWM
 wgtEUPP7IaMFW0ddNtRZ67VtvRyw5vDC+Wr4RXTPgy47VeEqo7X5GKmO8VSH/cvDHZ5J
 FGhUogsPOe04wFcpiE1tYLS9uK0VLZ+ZT4ScP7iLD85f4RRICZa3KzP3l7AObFwfXPf8
 QHOg81qWD6e72lvIo8anv5AkIihzLdzRzRrbQpt+OO3d2iFaqi8hTYIwVBHn0/wi/J6E
 A8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698399750; x=1699004550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kiz2KMdg7YL05gR8LgSt7smgQdVxoWMShyrXxPJfs9s=;
 b=FEV9GWBhRH7XVy6JiDesIcZTstz/sGGxP2pAN+vmV04GfHYhrC5ZZ08vywPnPz/2w3
 2Md7CyKRhNSXYDAH5oyVANDRMs1Yu78K++rBt9YD8V3Vlvdoe7qtR8qYup38lxQKq3WD
 61ZiGqDmrjyx3+z3fG72vbEavw6Rjanb2815ZAVEN6mZR0ClEZNMVDknu/2+GtkasQob
 vR7MZGx3dT/MEIY4vJ37bM8RJa9hiIVdJuD8bRaHcg00hEb1QX9NuuvCafEYEDMx09qE
 8Ztn4/kzpZAD6bdhPozzUaiOvL1h+RZwInWeadmqLzxwMCb9lRZuzgK4FDopxKyzzLXy
 Wj8w==
X-Gm-Message-State: AOJu0Yx29UXPwxhMDBov6rExdd0LwfbPfc3N3/mXmNwkpTJvvBXvXc1r
 xvxbZA4VV7DToCFXhMfZuhk=
X-Google-Smtp-Source: AGHT+IGhjfQTzfpSI0jSZ3Vaoz7HQMUUZYv6yz0Ojq0M+dEBGy0psEQV6EoLJB1bLce08/1kjOIo9w==
X-Received: by 2002:a05:6512:406:b0:508:1eb0:3d4a with SMTP id
 u6-20020a056512040600b005081eb03d4amr1422321lfk.22.1698399749812; 
 Fri, 27 Oct 2023 02:42:29 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 du15-20020a05600c634f00b003fc16ee2864sm1170909wmb.48.2023.10.27.02.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:42:29 -0700 (PDT)
Message-ID: <1ac8c57c-d154-4176-802c-505e4d785a5e@gmail.com>
Date: Fri, 27 Oct 2023 10:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/28] net: add qemu_create_nic_bus_devices()
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
 <20231025145042.627381-25-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-25-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x129.google.com
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
> This will instantiate any NICs which live on a given bus type. Each bus
> is allowed *one* substitution (for PCI it's virtio → virtio-net-pci, for
> Xen it's xen → xen-net-device; no point in overengineering it unless we
> actually want more).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   include/net/net.h |  3 +++
>   net/net.c         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


