Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FF7F4DBB
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 18:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qdM-0001AC-4N; Wed, 22 Nov 2023 12:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qdK-00019E-9w; Wed, 22 Nov 2023 12:03:26 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qdI-0003jJ-Jl; Wed, 22 Nov 2023 12:03:26 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c87903d314so53008041fa.1; 
 Wed, 22 Nov 2023 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700672601; x=1701277401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:reply-to
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEtUeZ8IRcomJX3U5boVELiXEWRp5E8uCIfp4rw0dVo=;
 b=meSTmB32plqp5ccHFsFxeJeSmQzYI13m9BnGo23ZROanTIjy/yI5UUnRk+Y3LUw6WL
 E7JP/AjHjFWX7ZulYKGZCBDG6AXvnT7KW3wldyPOWaXK6qjyb9gEXb2rPlDomx1pKN67
 c9TkNGQv8jNWeFjhp+Z6XYjeugDGWb+aKQ4WFWiHHfKDmGgrGYyrIu7a/SdC+ahmfnI1
 31wpsbRjJ2O1LPP33xkEKBmk5ehMhf5fC+HudoxUW/s+v2w9YCsY8PTCCYC9pLrDsQAt
 Ggm9IgklxwOMWywLVlVjpuSpIYT2tUM60W0KBG1d9v2a3pOYnmKkDcowaGgZf1uQI4BT
 tUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700672601; x=1701277401;
 h=content-transfer-encoding:in-reply-to:organization:reply-to
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEtUeZ8IRcomJX3U5boVELiXEWRp5E8uCIfp4rw0dVo=;
 b=IflBH2bng8zOG91IXdDNWT4w0pGHuTeocG2kcNEz7rZLDzG2Xg+HYwE6o6BIRvuoty
 qJDW9JViW4ndFwmGyIHtXfdvi+Je4hRxzXN1kAwHeAOfnAFZdhWAH38RaMIcRPHtXn3G
 cXEo4htYzDFNnU8BB9eIYr9wFzcYEzkgc1rM/wLwvoSQHBR0tQGmapkGt7YvimukpIvG
 854D2/vxmruDqaoZMnqnzW8jZ9wL8Kk7YfsDXWftVvbWDuGG71TTDMwYzMLXdg9g80Wl
 vNbT9FEG678AEQ10y8MACGMUFYBOlIhajdeDWzyodoh9KdD1AMiEYzBCpQ23zhX9K6Lt
 H8ow==
X-Gm-Message-State: AOJu0YzKH5gKbw/5xlC0kGyMVMeNStGImPGmRZHnEGEnGnuWESkYQgyM
 iqmvaMSIIdUG6Wndl7pAHVo=
X-Google-Smtp-Source: AGHT+IGVFrYCPl+0WYrNSHYpgKmNNL26tpHJL5ZgVWSHvOaQgH6SJCnZv7LvHlPBLONBP4Vyt6XHeQ==
X-Received: by 2002:a2e:3a11:0:b0:2c5:3139:2d04 with SMTP id
 h17-20020a2e3a11000000b002c531392d04mr2181461lja.47.1700672601055; 
 Wed, 22 Nov 2023 09:03:21 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c4fc700b003fefaf299b6sm24729wmq.38.2023.11.22.09.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 09:03:20 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <02fcd3c2-afe2-43f4-8a15-7caa85a147f5@xen.org>
Date: Wed, 22 Nov 2023 17:03:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] xen: backends: touch some XenStore nodes only if
 device...
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-3-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231121221023.419901-3-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x234.google.com
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

On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> was created by QEMU
> 
> Xen PV devices in QEMU can be created in two ways: either by QEMU
> itself, if they were passed via command line, or by Xen toolstack. In
> the latter case, QEMU scans XenStore entries and configures devices
> accordingly.
> 
> In the second case we don't want QEMU to write/delete front-end
> entries for two reasons: it might have no access to those entries if
> it is running in un-privileged domain and it is just incorrect to
> overwrite entries already provided by Xen toolstack, because toolstack
> manages those nodes. For example, it might read backend- or frontend-
> state to be sure that they are both disconnected and it is safe to
> destroy a domain.
> 
> This patch checks presence of xendev->backend to check if Xen PV
> device is acting as a backend (i.e. it was configured by Xen

Technally *all* XenDevice objects are backends.

> toolstack) to decide if it should touch frontend entries in XenStore.
> Also, when we need to remove XenStore entries during device teardown
> only if they weren't created by Xen toolstack. If they were created by
> toolstack, then it is toolstack's job to do proper clean-up.
> 


