Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C607D4FE3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGdU-0004ZV-4X; Tue, 24 Oct 2023 08:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGdL-0004Y2-HI; Tue, 24 Oct 2023 08:35:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGdJ-0008Ul-4A; Tue, 24 Oct 2023 08:35:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso36448955e9.3; 
 Tue, 24 Oct 2023 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698150939; x=1698755739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jt2cxa6ddwVCH4+7Ko2rashlvH36j0rjOEJrfGyoF5I=;
 b=MG7p0qOC32pPOhJFhUGyOUNl+98d7ZfaNaY+K3j9EoJ0FfpRsI6TDt87tChurLUssi
 wJxEXdgsk7mm56cJ7A6FK5VSiCihCzXuccA6HQ1dvXf0vtYDuBQfAqBq11vBi8M+4vFG
 YtmgiGKC9sr9ELVRWJMFYr+01c4RBWsBfBdrwrK8iZgx5Np3C80ECR5zGGFGkzpO8S7W
 qEPFs8eMy4DFaY/rqHGQoVFQvjeSzigTtF2njtYvon4XY3fAV2Arfu5Q13VTEzI7NEgT
 m4yc/U4mfTAyKnVsWW9zTTgAllX505r7OrMQHrxerT0YHD/UqyqSio3rk5Fzf8LD3FSW
 V9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698150939; x=1698755739;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jt2cxa6ddwVCH4+7Ko2rashlvH36j0rjOEJrfGyoF5I=;
 b=q4S6rsuu5r2vpRLaSKG7v4ncEsVEbvW7ZkMzaTweJjo3Cf9VlCzHcShiMnCKD5E1Yp
 96B7hvAf/Zuoh8v72a943doxrTYalUs6sGUhjk2mH1QYxgHMAlF4UJJ5aaivDPQrFk47
 Ho/Ymhbf4drse43XIQQ+kdpZg4kFwXaKDCC5LHCof3jmF96HZ7acFG1Qfe7KB9WsvM0b
 xlFNYg1NB/AYIi2N2tPo0MXlwifVpvmJthXr4ghiWEuQbMzBjZfk7Cd07lymq1kEAIDz
 r11X4TAUvqok++xSYO8zJCX4tu72d8c8PCiIvgHesoy+v6ZFe7mFPRgHCYlubr29YuVU
 WbYg==
X-Gm-Message-State: AOJu0YyMSM/fVgTUA2eCIUR8Of8pKHuZnY8WiKso+4C8MHZ5OHlfC9Te
 G2n8gk0AHcXdWQQx5Ri+suY=
X-Google-Smtp-Source: AGHT+IHcviZwp5sEUV8HujATdN4eCJmLKJnxtVpxw/CtGmvUMvR85yAd1lcelMOmu9e8/DWbEGFBkQ==
X-Received: by 2002:a05:600c:154e:b0:405:4a78:a890 with SMTP id
 f14-20020a05600c154e00b004054a78a890mr9583548wmg.8.1698150939091; 
 Tue, 24 Oct 2023 05:35:39 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm16729462wms.29.2023.10.24.05.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:35:38 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <84ac7780-e17a-4957-b49b-46a8307eb9da@xen.org>
Date: Tue, 24 Oct 2023 13:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] hw/xen: populate store frontend nodes with XenStore
 PFN/port
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-6-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32e.google.com
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

On 16/10/2023 16:19, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This is kind of redundant since without being able to get these through
> ome other method (HVMOP_get_param) the guest wouldn't be able to access

^ typo

> XenStore in order to find them. But Xen populates them, and it does
> allow guests to *rebind* to the event channel port after a reset.
> 

... although this can also be done by querying the remote end of the 
port before reset.

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


