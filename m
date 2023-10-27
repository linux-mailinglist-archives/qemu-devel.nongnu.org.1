Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA277D8F98
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwH8w-0004du-FU; Fri, 27 Oct 2023 03:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwH8u-0004dC-1D; Fri, 27 Oct 2023 03:20:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwH8p-00026V-Ix; Fri, 27 Oct 2023 03:20:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so1290557f8f.0; 
 Fri, 27 Oct 2023 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698391221; x=1698996021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GiaZXgzc6McjQsGUPYikXLbeJ+i8MopBoPjQmhJQfo4=;
 b=LXWuBtTZoLs3XsyRkcyiO36d8E7pH013ndIOB89RlNoujvRgcXZw2jkYE55yVgfT2/
 9ZOWQezpuJruzsdWsdrwPfLF68zPGxJXVT/gK7F0ppehyaj4XFeMfwgFUOdNNiWcFMQ9
 0WHZgZQZXwC/98FInGqoZ/gGXXXB3LuyVmS6gLRyudgSxqlK2xyL3KmKWBJIHqnVKm78
 uCtOrBB9eCmv616SyPY999a/XgJTaBTobY8B9I31Pe5ZbrRrdxVW/ASLCiSwlov6MMkV
 0y+7G7ctdNjVDPTjTLtv1jsAU/SUsaKjekoEsTEaCUIKtpIVrzsdGreoliHlbDgHmdyO
 XZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698391221; x=1698996021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GiaZXgzc6McjQsGUPYikXLbeJ+i8MopBoPjQmhJQfo4=;
 b=onKtzM8MuKA5HdyWcabRmRPV4VGVkFqM3mu0tmql6uaw3uDkALDcm92nheXvQHvx2w
 ADWQBdTYZlJF6LasNQzKUNoif1N0GeSu9zZdW81rZHABeZ9z/XPdswUrmo4urx5YIlrJ
 IAs3JBO2hFZcatAgpLXQfnu/8gxYorUMSZspD3OymXlWt5OToUO8lNehl2nRFLuNua6S
 lZplgl1PgbbGwjkkX/ldDhlreCb4+CdMYsAsbitKu54KgkGnhEfryTwCRO9TOSXKd/7B
 pcBHdutA6SC1MciaBlgjkL29F480rasOg1n9IhUc1W+sun5QltQXbrCerGAogqp7XYcw
 9yrQ==
X-Gm-Message-State: AOJu0YwPEDdF7gpf2PQRYJy6aOy32OnuTNJmR+Nzb2P4rUfSAb4IxZWf
 NJdUiNIKImMHNg71xzAqoqo=
X-Google-Smtp-Source: AGHT+IF4ESb9Dtm5knfUhlBl2xjFSwSZ+UZKmlwz+qng/KTBk8Cd66OauspRUmQDrVkZd9/qUpk6wg==
X-Received: by 2002:a5d:4c42:0:b0:31f:a62d:264 with SMTP id
 n2-20020a5d4c42000000b0031fa62d0264mr1433744wrt.37.1698391221555; 
 Fri, 27 Oct 2023 00:20:21 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a5d534d000000b0032d9548240fsm1114969wrv.82.2023.10.27.00.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:20:21 -0700 (PDT)
Message-ID: <94b54185-7ae6-48f9-976c-f4213a3643d0@gmail.com>
Date: Fri, 27 Oct 2023 08:20:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/28] hw/xen: take iothread mutex in
 xen_evtchn_reset_op()
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
 <20231025145042.627381-7-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x432.google.com
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
> The xen_evtchn_soft_reset() function requires the iothread mutex, but is
> also called for the EVTCHNOP_reset hypercall. Ensure the mutex is taken
> in that case.
> 
> Fixes: a15b10978fe6 ("hw/xen: Implement EVTCHNOP_reset")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


