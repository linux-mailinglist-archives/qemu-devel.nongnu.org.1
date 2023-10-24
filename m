Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E667D56A5
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJSx-0004dX-Bf; Tue, 24 Oct 2023 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJSu-0004Tf-Sy; Tue, 24 Oct 2023 11:37:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJSo-0006nj-Qs; Tue, 24 Oct 2023 11:37:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso22268205e9.1; 
 Tue, 24 Oct 2023 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698161819; x=1698766619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A8ZSzBnis7KNXr8T2w9cXrHfqOor5r4c/mfSgp7VlQs=;
 b=jqekbZrPWwrT83xBwLo5KBG34AA/XRVCAUtle+5TnheHzeGN526FGesONq5xumr0EH
 nq2/L4IWRGCiJn6k9Nlnt+rt0IinbC93GwnaFruJuwzEUlir6aPu5NUaSpAgomA7+toV
 w+hQGkynmh96vGEnmEIN/ZnIlw4JF3cewSK/agP14KZGSn29140x0/leOuVdn/DRjakD
 xiKw5ntTklbfSBY0rhR5QQ68ZxVxpQr5CaL5MAHWHKjCC8Osvjhg6YMrCXItM3bYjYZT
 xtNBUfh66/z82LQgDiXczdIFengVtZ+/lWFt46BUqpFreM58JtRfyI4YyQOHn4hTPmrG
 mOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161819; x=1698766619;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8ZSzBnis7KNXr8T2w9cXrHfqOor5r4c/mfSgp7VlQs=;
 b=TKeamtWVb3+9yr+sVR/qSLnlWVrGsOSniGu7PWhiLm0DlrFHH8osbiVwy11pE6Sgzt
 ll5BRnzhCRfHlwjdqM7GsZV3Pj7CQw+BEUYZFgtwxIYxhpmYAGKkM/HKzY+luECbBm1v
 kA5xArmgC0jtUY/lqEWOPyOOMGeZoAgDl9xTKiIFZaEGw5RbfjJpeBLc0dVroEsMKNTK
 rnvsOwASeRcSVgSJvE1xHmlfojKzI7puDerJxnDBabyVBUkc7iiN77gDRhcTjM+k2OfE
 YoOG2aqZSuWr0yr8uxKPC75d6UXeGEltKZtzkH63/aCOoVkNrS32A9ddbiP1d9GjmyHF
 /Ylw==
X-Gm-Message-State: AOJu0YwwYfCwqCZpGrLTHl/fwKviM366L4TbBYzj8xRgCYVyBHULFn90
 plaeux4iSZuV4zgP2xCuEmc=
X-Google-Smtp-Source: AGHT+IF1dcmYSOIBAYhyDN+rJjDUtbiR7bpGX9yxUQ7nJ0qnc13saq8mF6pQ7QGMUfeqrZmcr7qgJw==
X-Received: by 2002:a05:600c:1d19:b0:401:b2c7:349b with SMTP id
 l25-20020a05600c1d1900b00401b2c7349bmr9736055wms.7.1698161819005; 
 Tue, 24 Oct 2023 08:36:59 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 x24-20020a05600c179800b0040523bef620sm785126wmo.0.2023.10.24.08.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:36:58 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <979ce4f2-195c-4488-869e-72c9abed1339@xen.org>
Date: Tue, 24 Oct 2023 16:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/24] hw/xen: populate store frontend nodes with
 XenStore PFN/port
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
 <20231019154020.99080-11-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231019154020.99080-11-dwmw2@infradead.org>
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

On 19/10/2023 16:40, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This is kind of redundant since without being able to get these through
> some other method (HVMOP_get_param) the guest wouldn't be able to access
> XenStore in order to find them. But Xen populates them, and it does
> allow guests to *rebind* to the event channel port after a reset.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


