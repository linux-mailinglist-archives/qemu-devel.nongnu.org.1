Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED77D9191
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIDu-0007wk-9F; Fri, 27 Oct 2023 04:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIDs-0007wD-5E; Fri, 27 Oct 2023 04:29:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIDq-00054g-M3; Fri, 27 Oct 2023 04:29:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40850b244beso13914085e9.2; 
 Fri, 27 Oct 2023 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698395376; x=1699000176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uawWEYvnU1I7SsFfXaVgl6JK99lbvsL15u5TMr7vQn8=;
 b=LOGiVyYbDsKnTLra98DqiZukxE8TGdmb9xreQYRX++J0nDQPYPpvnZb8GdNRgq905x
 RSIHYCOTp2xVnavsxyzXsxnrIkL7gwSvs8ja8LYnVtLLzpMbCz4IPVOCjQMWN40+bJvr
 SCE9UOSDh58H9UmQfFo+GWy3d7GJvWZtXi3dE6+moYv3AgFCSODRskCR9oHRPK+NUhdw
 nHZfXaXbqlzP4xPyl5pBKmN1EI9sht/wqED1TcuBrMaKEaTrz1PGQ6fK5FPOkABkb52G
 HsR8K/ZBVLPdG8OyRMVnGVI/nissbgjuwN+igzkZoBMrK5Ah2K0vH0SdwVjrXUF1GdBm
 u2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395376; x=1699000176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uawWEYvnU1I7SsFfXaVgl6JK99lbvsL15u5TMr7vQn8=;
 b=adgUNq1Ie6PYFCFnTw8t+mMKwuIyTu4Yh52lQgmLet0p7CN4C6vv1YREiagyAMAexg
 7QhzC0+fNWHs59D2Vo9xLtLZcBKEDcLauTP5vplaJjWxcAqbc7cQhxyvZa0SqbKZXbpX
 EPIRCfw40xniz7E0eVDtDYnrnpIkCu6F265515swoF7kW9rbbi0EwJz+5OuyLSB+hJ2w
 VIznPW0RJqJ07LnD2P6kpdOeDhG5/BuwEph0ugopaYLjxk9Gpn3beQ3vwoKot9pz6MSF
 3lxej+4uLrhjx3K/2fWlLwZheQqx4hwC/YcOVLUGRfR1IlEHhoA5Cxek09oNwkhFg2UB
 +u9A==
X-Gm-Message-State: AOJu0YzaKyY2+yeuu2ntgz5wsLK+vYn9fVabYPqOW+vy6X+INYuQvfj8
 2+TDB7SrQIduImGw835fBQQ=
X-Google-Smtp-Source: AGHT+IEhOFiWCBEfo+wHr0Pp7y4a5kzJHetZXB/E/pRI16RlTXShKDIVxn2mzdbzdHFgDhukzBbnCg==
X-Received: by 2002:a05:600c:1c06:b0:404:4b6f:d70d with SMTP id
 j6-20020a05600c1c0600b004044b6fd70dmr1726336wms.17.1698395376081; 
 Fri, 27 Oct 2023 01:29:36 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b0040849ce7116sm4519893wmo.43.2023.10.27.01.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:29:35 -0700 (PDT)
Message-ID: <0aabb787-eacf-48d9-83b6-3769c7436cf9@gmail.com>
Date: Fri, 27 Oct 2023 09:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/28] hw/xen: only remove peers of PCI NICs on unplug
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
 <20231025145042.627381-19-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x329.google.com
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
> When the Xen guest asks to unplug *emulated* NICs, it's kind of unhelpful
> also to unplug the peer of the *Xen* PV NIC.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/xen/xen_platform.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>

