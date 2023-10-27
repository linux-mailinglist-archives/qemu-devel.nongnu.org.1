Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C27D941D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJQd-00044w-MY; Fri, 27 Oct 2023 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJQb-00043y-5o; Fri, 27 Oct 2023 05:46:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJQZ-0004u2-EI; Fri, 27 Oct 2023 05:46:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so1284041f8f.3; 
 Fri, 27 Oct 2023 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698400009; x=1699004809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jzLwa1GntXahp5+i4Iu7OMe0oRp7S0Pb5ddkQlqpbTs=;
 b=P49vfxrOWQL4T5RdhOnYtgK8bwXfcfRf/bG6o/Bf/bOzmarMO3CwgQbhseVMo2glwG
 RlqY/iF8nsMxMJckhuLvBuuGWlo66tO0upMCQ6N1OZwrgo8phIm0ERofhDS2yy/KPhdo
 FZXK3qoJ9PZeUkhlKL7jmXe6c/mHNAvBIrsmXDc6X3ox7Lt65TRqPGoJGZSQCGV0yUhX
 GOocTvjZU4cxXf0I4XnCVhnpT5DO5/gc6Nd9g4ZwQMHDsUEiAXHMFVCjstHwjO20Gkvc
 ijgzUMaa8rhOVqXSsntuEPtVoPMFyNN9h859TcHSuT0nJOm7CEDWtjCZIpuQN4z0cxk/
 HiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400009; x=1699004809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzLwa1GntXahp5+i4Iu7OMe0oRp7S0Pb5ddkQlqpbTs=;
 b=iyZMbhWxPe2KQPPgezh5g2BhpnbMTk0gyv1ZCpTorZzwjQpOvi//2lLsA49wiHfKr7
 qJ1aSOCAMQho9T/ML3HGqCn0HPuO7QNMGJXb61dQ9VymCsVsIjzvWvJ02gziBx43yWq4
 9RU3arrAIcE6vV0c7jmG6GBQvL9GYb6U229qYQLmefjJdGYMGQ3d6cKimZxch9TA+Txx
 I/WZFpYms5Alzf3I00DTfW+BpWP04fvXbzBEJbVVbjds60A54nq76cwoQI1dMSghI+XX
 YceVT6R/irV29THyGoIhSegH419NwpkNa9dHYJzvSqducI8bgmMRIS9ScVOoAmE9WTjb
 Pn8Q==
X-Gm-Message-State: AOJu0YzQw0IAxmeKTH9hUbr9iCqjmFfRpvaV2I1wKur4S6Lmv/qgB78f
 +EWcemXnCR0vPtv6FKNsglA=
X-Google-Smtp-Source: AGHT+IF+xd8cuMtFJ/cywAMdwJALH04PvtMGn/mtI5e9KZNkVRA1ttigVPEIA2v+rqX3cz0pRpds5w==
X-Received: by 2002:a5d:68c1:0:b0:32d:a022:8559 with SMTP id
 p1-20020a5d68c1000000b0032da0228559mr1762750wrw.47.1698400009412; 
 Fri, 27 Oct 2023 02:46:49 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a5d5949000000b00326f5d0ce0asm1389222wri.21.2023.10.27.02.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:46:49 -0700 (PDT)
Message-ID: <b6cb24e3-d736-4951-b2dd-2a90562fd768@gmail.com>
Date: Fri, 27 Oct 2023 10:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/28] hw/pci: add pci_init_nic_devices(),
 pci_init_nic_in_slot()
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
 <20231025145042.627381-26-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-26-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x435.google.com
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
> The loop over nd_table[] to add PCI NICs is repeated in quite a few
> places. Add a helper function to do it.
> 
> Some platforms also try to instantiate a specific model in a specific
> slot, to match the real hardware. Add pci_init_nic_in_slot() for that
> purpose.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/pci/pci.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci.h |  4 +++-
>   2 files changed, 48 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


