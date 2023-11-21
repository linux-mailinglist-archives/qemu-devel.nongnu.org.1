Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE27F2229
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 01:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ehi-0003eC-JH; Mon, 20 Nov 2023 19:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1r5Ehg-0003dX-68
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 19:33:24 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1r5Ehd-0003ET-UH
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 19:33:23 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2851b271e51so1332476a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1700526796; x=1701131596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YAWdck5bBOyxtOdRgfermpV3oPQUbX3pTqTi1uL2uwk=;
 b=Y/3UKS1jmBaZNChjROal+O/C2WDC1bsNDn3n0j+tjKxQZHR0fy3PUIhTi8hLSTKQih
 oEqdIkucJNq3SDowg0kUuZWt6MpezyCdrbnX8h9AcvL7TVMsO14MNGM/zhUsUx+jXECq
 oX+oqsoOpNS8m2CMVQHIHkFEes0f4gaWhO/lnLBEinT/mehvWuMJg9i2UAxU2R1tG98q
 w8ztCs9HMstm5QlTdYnzBsPtSlx9jDeiaoOHYe3h61YZwL/ATXVLLDxk+Nd2SivPW60V
 Z54xQymiv+rlX190jugYFl1reEgAlcrVs9io/BH4hL8/nSotGtxaby4D4fpoF3R68d9+
 zxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700526796; x=1701131596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAWdck5bBOyxtOdRgfermpV3oPQUbX3pTqTi1uL2uwk=;
 b=JOYUf3etrLaOFjZ9Fbm3swFIFiyzmadGnBGdQaS5u1YCuCMzyU988JR7vN6fBsjgkW
 IjWRMBxlqCf6fLOGWDwK7F+cFqAAwKv/DGIgoEy/4O7L4/z6X4bWo5UHu9n/HKjyhU3d
 T18LtAgYEiqY8nxoNdVOMiRZjb4vhO7uwy8YWTIuJMOiFc3rsGIE5USXul16lhOpP7gV
 lZPBEfycrIOwkHYSXWO2bHxpbCkLie6gnm9VIUYq2X5VZHM3ano2hn3qfjtTop/vp0GA
 agsxYqRtyIkxMfmUhvCK9l3E6ImEziyRMP2LUnJluH7/0kMz8hc5OtNFSz0n3s8WE6wZ
 Fyfg==
X-Gm-Message-State: AOJu0Yx0cC3cxF74CFWu4QKnuOxh8uwjO3PKHN24d5q21sYea/zWsukm
 fM2YrFAGi8UiwClYQklV1kPq3g==
X-Google-Smtp-Source: AGHT+IGrcdIl9KcC0Ha7UHJztKoBy3ub80ERmHKtvshRjS48uT8Ik+f1W3bMPW/OdxyepVrjeNJIUg==
X-Received: by 2002:a17:90a:fa03:b0:283:a384:5732 with SMTP id
 cm3-20020a17090afa0300b00283a3845732mr1659928pjb.9.1700526795962; 
 Mon, 20 Nov 2023 16:33:15 -0800 (PST)
Received: from [100.80.223.36] ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902c1c500b001c32fd9e412sm6695967plc.58.2023.11.20.16.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 16:33:15 -0800 (PST)
Message-ID: <c2d120f1-c629-4862-99a1-0577946e09fa@bytedance.com>
Date: Tue, 21 Nov 2023 08:28:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v2] backends/cryptodev: Do not ignore
 throttle/backends Errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
References: <20231120150418.93443-1-philmd@linaro.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20231120150418.93443-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Looks good to me. Thanks!

Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 11/20/23 23:04, Philippe Mathieu-Daudé wrote:
> Both cryptodev_backend_set_throttle() and CryptoDevBackendClass::init()
> can set their Error** argument. Do not ignore them, return early on
> failure. Use the ERRP_GUARD() macro as suggested in commit ae7c80a7bd
> ("error: New macro ERRP_GUARD()").
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e7a775fd9f ("cryptodev: Account statistics")
> Fixes: 2580b452ff ("cryptodev: support QoS")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/cryptodev.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index e5006bd215..fff89fd62a 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -398,6 +398,7 @@ static void cryptodev_backend_set_ops(Object *obj, Visitor *v,
>   static void
>   cryptodev_backend_complete(UserCreatable *uc, Error **errp)
>   {
> +    ERRP_GUARD();
>       CryptoDevBackend *backend = CRYPTODEV_BACKEND(uc);
>       CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
>       uint32_t services;
> @@ -406,11 +407,20 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
>       QTAILQ_INIT(&backend->opinfos);
>       value = backend->tc.buckets[THROTTLE_OPS_TOTAL].avg;
>       cryptodev_backend_set_throttle(backend, THROTTLE_OPS_TOTAL, value, errp);
> +    if (*errp) {
> +        return;
> +    }
>       value = backend->tc.buckets[THROTTLE_BPS_TOTAL].avg;
>       cryptodev_backend_set_throttle(backend, THROTTLE_BPS_TOTAL, value, errp);
> +    if (*errp) {
> +        return;
> +    }
>   
>       if (bc->init) {
>           bc->init(backend, errp);
> +        if (*errp) {
> +            return;
> +        }
>       }
>   
>       services = backend->conf.crypto_services;

-- 
zhenwei pi

