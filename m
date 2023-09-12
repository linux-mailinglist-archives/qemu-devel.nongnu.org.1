Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEA79C6D5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfwjk-0003Jg-Pr; Tue, 12 Sep 2023 02:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfwjd-0003Hq-W7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:18:54 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfwjZ-00036O-Uv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:18:52 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so86999091fa.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499528; x=1695104328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJGOOeXFzyrerTR66woHzjHXj+yy+nJR/mF/XS+IRFs=;
 b=eZ8yiAjnHkatHbuH18z5T+dUZcFSii+n965rKZUHgNjjAYXKJ9YuYw3iybk/vohRIV
 MOe96d/+IEziXrNkg5Bo/v5pXx2ZxmCfyNX4XMuz7+sgWKhXPPvOtMVhT1w7RT6rdIwM
 Q0tt09wfXHhr7X5N+gEqAzrZvbcqCPJb68N21diTo9k9TGRh/z/OFdGNKee9ztWfyfOw
 RuMfRb/xkBls363YhD0qN4KgyQrClsm6n6KGGfY+2q0PZ4P91Ez6agDpO8K65n/0R/Hi
 xThHMoRAKh/AqfSrdajSSjki2Xzpf+G/HY8faUmjucE3vuVx7PKwljjBwoVXhu2LeLGs
 wNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499528; x=1695104328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJGOOeXFzyrerTR66woHzjHXj+yy+nJR/mF/XS+IRFs=;
 b=IjKcVQiKkZzoXXuzrj1KRtbo2MY3UM2IPrINWfAwfD9qjaOCjiMxFhqK5GqpEdDInb
 15BnmJxCcnDkvesc+3UHJjV+5VETqHpqx+phaJEYN5TjKRTHYYY9lwHYSqujkAx40f1o
 hAjtjK6ls2RxXS39EQi6iuRMWqKLJqSsNbt6w8Fbe2qlYISrev45es0rlc7k32Ftmn91
 AkzyOYbXpD3OgRVsNI2QMU8sPotVhJkSUMzvcz5HRnuRrHLyGWQXT24k3UWYtClM/Lt3
 mFpweXV1zvxPq9jDCkh5T8IzsxxwyCTuqpfKOXuxhGUefK+6qtxvsk6bGhJLW1PLNC+S
 cz0A==
X-Gm-Message-State: AOJu0YzzA9tUss0J7QH7kFqiDiHINkgOMnhrlvpJ2LffgynGjij7OiJh
 +tiZTCyHy1EgupcuW24hkoChjQ==
X-Google-Smtp-Source: AGHT+IFivHBIa4rX3gemNkEY2AIr8hcFrEcTe/VGv86zq5I/+MasPIYJUnOShIEpVOXODDwuQ9QNAQ==
X-Received: by 2002:a2e:88c5:0:b0:2bb:b01a:9226 with SMTP id
 a5-20020a2e88c5000000b002bbb01a9226mr9561613ljk.7.1694499527102; 
 Mon, 11 Sep 2023 23:18:47 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 op5-20020a170906bce500b00992ea405a79sm6365265ejb.166.2023.09.11.23.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 23:18:46 -0700 (PDT)
Message-ID: <430ea775-678f-e5ac-d548-6556dcf54e06@linaro.org>
Date: Tue, 12 Sep 2023 08:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230911215435.4156314-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911215435.4156314-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/9/23 23:54, Stefan Hajnoczi wrote:
> gcc 13.2.1 emits the following warning:
> 
>    net/vhost-vdpa.c: In function ‘net_vhost_vdpa_init.constprop’:
>    net/vhost-vdpa.c:1394:25: error: ‘cvq_isolated’ may be used uninitialized [-Werror=maybe-uninitialized]
>     1394 |         s->cvq_isolated = cvq_isolated;
>          |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
>    net/vhost-vdpa.c:1355:9: note: ‘cvq_isolated’ was declared here
>     1355 |     int cvq_isolated;
>          |         ^~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> Cc: Eugenio Pérez <eperezma@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   net/vhost-vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..7eaee841aa 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1352,7 +1352,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>       VhostVDPAState *s;
>       int ret = 0;
>       assert(name);
> -    int cvq_isolated;
> +    int cvq_isolated = 0;
>   
>       if (is_datapath) {
>           nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,

Alternatively:

-- >8 --
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 34202ca009..218fe0c305 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1352,13 +1352,12 @@ static NetClientState 
*net_vhost_vdpa_init(NetClientState *peer,
      VhostVDPAState *s;
      int ret = 0;
      assert(name);
-    int cvq_isolated;

      if (is_datapath) {
          nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
                                   name);
      } else {
-        cvq_isolated = vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, 
features,
+        int cvq_isolated = 
vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, features,
                                                        queue_pair_index 
* 2,
                                                        errp);
          if (unlikely(cvq_isolated < 0)) {
@@ -1391,7 +1390,7 @@ static NetClientState 
*net_vhost_vdpa_init(NetClientState *peer,

          s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
          s->vhost_vdpa.shadow_vq_ops_opaque = s;
-        s->cvq_isolated = cvq_isolated;
+        s->cvq_isolated = true;

---

Whichever you prefer:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


