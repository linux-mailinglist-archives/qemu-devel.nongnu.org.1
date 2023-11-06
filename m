Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F77E2972
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:11:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02BC-0006oa-6p; Mon, 06 Nov 2023 11:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r02B9-0006oN-7r; Mon, 06 Nov 2023 11:10:19 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r02B5-0003GG-Ni; Mon, 06 Nov 2023 11:10:18 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5869914484fso2617715eaf.0; 
 Mon, 06 Nov 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699287012; x=1699891812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o9tVeKqMjlN1sJbwbYzCcGCuISPVc7ZyUOuNd53U1po=;
 b=JGZPbXQnmtfNpUPobXOR9PNaM7Lg+dHhMufF9W5GS4SB5IIqbEqsC/Q8snnQKrZW/J
 O40fFAETcrQO3zpiaDzU+8D5y8K+Fgg3wS8k7KL1hdbREzOMJnYz3iqUvkT4/+OJnVTS
 Tgu7bblQ6PsogKS8IwzBFW4x1reDMgUVfRKOwgm4EXLNYgRiY/ltTgm1hwBo8DesnqTe
 hqeJj5LVnGQl7VwNMWgPHj2D8sm5k6WBFgUfdeRLJng5T0tWidAM+zu7AU7Lu4CvBiWy
 Xe6GRAhVFKXRLJ84IISCzQIuorsD3o3tE6WIDlqDhRyr0ZhQn8VsO4lZnISIINpKfai/
 gpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699287012; x=1699891812;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9tVeKqMjlN1sJbwbYzCcGCuISPVc7ZyUOuNd53U1po=;
 b=ZBGRCL+AHFzHONY/mIVWr6qOJQbxYU6f+i0+Rklc2xMdHbec1eUhlbkLfIQz3SXfmp
 n1pHApDOfawcKXIayXmhGEngoAd7x6HSLikEfE2RPn4rdvHP5u+cuysAx3jXkPvofCX3
 QiWvW5+ZmLe++72OByRDr+k5c+0Pi7v5SxI9TiRWOIKsdWTz+M9LJtkPPkCWvxvUUXLQ
 uEynkoZDZaTVxonLXzNDBxW5Oatu2qzsmFG3bT0IhfG936Bm8yXRF04dMp5LqKNpZYY7
 DgFn5Lv888OKlGLvDwzkqydxaq+5ptiUd/n2S4cNS+2CNAbGbrxa/fiYnWg3fg5lZwvT
 Eatg==
X-Gm-Message-State: AOJu0Yz/IG9NSrr47NQ0GSSieriSmkhxBtF3sF7/gx9uDeYdhjODnATo
 STskcM9T4LhzKCDT/upHBJo=
X-Google-Smtp-Source: AGHT+IE/sRaTmVzjjCiO2dK5s1AvjHxOUyoPSJxnyNWlqiA3OF+6Q3xTw5HxTC+nzv/U1i2QoMa6WQ==
X-Received: by 2002:a05:6870:788:b0:1e9:c7cc:df9a with SMTP id
 en8-20020a056870078800b001e9c7ccdf9amr148125oab.11.1699287012406; 
 Mon, 06 Nov 2023 08:10:12 -0800 (PST)
Received: from [10.95.110.31] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 d31-20020ab014a2000000b007b0f0d45133sm1599687uae.25.2023.11.06.08.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:10:12 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <9f15534c-8b79-4127-9b91-0dc449547833@xen.org>
Date: Mon, 6 Nov 2023 16:10:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/17] docs: update Xen-on-KVM documentation
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
 <20231106143507.1060610-18-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231106143507.1060610-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=xadimgnik@gmail.com; helo=mail-oo1-xc36.google.com
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

On 06/11/2023 14:35, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add notes about console and network support, and how to launch PV guests.
> Clean up the disk configuration examples now that that's simpler, and
> remove the comment about IDE unplug on q35/AHCI now that it's fixed.
> 
> Update the -initrd option documentation to explain how to quote commas
> in module command lines, and reference it when documenting PV guests.
> 
> Also update stale avocado test filename in MAINTAINERS.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   MAINTAINERS              |   2 +-
>   docs/system/i386/xen.rst | 107 +++++++++++++++++++++++++++++----------
>   qemu-options.hx          |  14 +++--
>   3 files changed, 91 insertions(+), 32 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


