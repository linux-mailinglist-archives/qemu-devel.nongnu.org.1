Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC57D54A6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIwx-0008Ro-UQ; Tue, 24 Oct 2023 11:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIwv-0008NB-4f; Tue, 24 Oct 2023 11:04:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIwt-0008AK-Cj; Tue, 24 Oct 2023 11:04:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso26770145e9.1; 
 Tue, 24 Oct 2023 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698159841; x=1698764641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Qt2wllMLDF+l8+9ma3m0C77TgrERD8kIo4WEkyC+k=;
 b=gBPt/2SIYriDR7jAfOaw5j/O26POMqhuW06h2gLUeZUyDzM663C4cos7zNUu82qm4Y
 Km08bGz0MFDPt/OVuhNvbxrUqSc3gzj9aZk5UQFm19cRvOcgiYt2eSfSbGkBLTrrucqc
 FWTtoItr0TQW7/Y6ZBHf/yA10+5gpdKHFK6RwSeT3v/WNYfr93j6DDhLbLV0JdpSp00K
 Vqhpj2YxFcGezDQlaQg1OTOjDyQXU7K+H73GXnA0Pbh3YB6Z3SnFq3PKfFkNDSVMFJGY
 rrxvbaWC919Uodpxepjp8PhFvXOGIPiKMigD+uVdBvuS4bxleULPu13o2yB/IcWBMitb
 NPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698159841; x=1698764641;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1Qt2wllMLDF+l8+9ma3m0C77TgrERD8kIo4WEkyC+k=;
 b=fH7665slwMkqWoTvESJwE8/JhVjwCxBpqGT1Npa9FTdgwDLEB2DF5Q+HX9ieY5c2CE
 O+KWL9263sq6QLJQ0tK663dQuQjWThAkJzVvGwtYkKpAdApLLKcylC2vNPwlC2OGS5Py
 XuSx891p2mBsbHz6wo3IhxSdgxqHHJLdByiF2g1kcK1dOBldeGKQLpvul0JPiO1+PQ7f
 FCxO2aOkXJvqxvKIdAFxPEWWiX21dSxhYbouYM6o71dzqpElZPjio/zcJcW5jUjHF1Ki
 404j/O+Jj3L8ctKa4kpfMkgyuusSA6HBeRkXWpxhL07canjTGz9rQmbRLB/6q/uzYWJK
 7PMg==
X-Gm-Message-State: AOJu0YzeKERzaVGUYWnx6i/vmHTQfhKGwQiWa9e3CkLsQNPmFJ1ZQgoh
 7Wb7SgLCCBNqE8c64ZmDdOk=
X-Google-Smtp-Source: AGHT+IGm54ISKlvZ6ARRotUsrpXMLiaRdkUDxht2f3+ks747mTY2+cIYmiFMPEYmjUe2mjy+rnM4zA==
X-Received: by 2002:a05:600c:450d:b0:405:409e:1fcb with SMTP id
 t13-20020a05600c450d00b00405409e1fcbmr12972927wmo.5.1698159841241; 
 Tue, 24 Oct 2023 08:04:01 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056000128500b0031c6581d55esm10091262wrx.91.2023.10.24.08.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:04:00 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c13a1ff5-0853-41f7-883d-abae08f9ad09@xen.org>
Date: Tue, 24 Oct 2023 16:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] hw/xen: don't clear map_track[] in
 xen_gnttab_reset()
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
 <20231019154020.99080-5-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231019154020.99080-5-dwmw2@infradead.org>
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

On 19/10/2023 16:40, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The refcounts actually correspond to 'active_ref' structures stored in a
> GHashTable per "user" on the backend side (mostly, per XenDevice).
> 
> If we zero map_track[] on reset, then when the backend drivers get torn
> down and release their mapping we hit the assert(s->map_track[ref] != 0)
> in gnt_unref().
> 
> So leave them in place. Each backend driver will disconnect and reconnect
> as the guest comes back up again and reconnects, and it all works out OK
> in the end as the old refs get dropped.
> 
> Fixes: de26b2619789 ("hw/xen: Implement soft reset for emulated gnttab")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_gnttab.c | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


