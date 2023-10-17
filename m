Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 472787CC9C0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnku-0007At-4A; Tue, 17 Oct 2023 13:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnkn-00076P-GM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:21:14 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnkk-0004eg-MQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:21:13 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bfed7c4e6dso74948961fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697563269; x=1698168069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IYOQ6o4VfRBqL0+OOnxoc/gz7GiPGve2ZzadNPgd5m4=;
 b=YipsglzQwiPH/5j+yB6K/IW2tTvp/C7P+X8s+fn/LnV7nkh63RU6owi3aLEPQSMyq5
 PtqB7lZa97K3rxVUsJF/jl3J/ZhWU8iewbI8TjbGoiwG22qeMgyPyQh2J9orH8FeOmoE
 iwl6jTiK6VgAcnkIddv7pIzanTUKF7NoGPT8SevoQ192Sv0JldzqjhOTabT9sQp9EmEn
 78k36MVlqFlbPmWXFGsnyMoktudgfKLDhkVIjPQjjVj9iQjNXZXoFNYBcnZdD2ERh2u1
 S2O9Ez61wEqvJ3Z+rfEAu/492moO0OGjBczrVyCfcEqTIewwc0Ukednb9ARZKLDYTDO4
 0xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697563269; x=1698168069;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IYOQ6o4VfRBqL0+OOnxoc/gz7GiPGve2ZzadNPgd5m4=;
 b=OcJVrL3smNh86oaOEqb0wyjsDIqWdZ7aeDn5I7881EKEnjXzhNB+0uyTSB2mbQbN3T
 TXyg+J5qvyY9nq/7CkNCKUuEzl5AuKkFQWRPs0o1GFKuLF01NCFyVlGi5JvKLn6P3uta
 N48oyqZ381JPCEJEWIt5d+0bCe/ugKBJl7F8YMkuQd9QAfXjKAn4IroYFv4waRSfy6JH
 0aaMYLPtetfdTUH7p8xDXoUqvVi0i8wB3Fk9kvGHbfusJZOf2r+7w48F8BV6Gh/XR5N7
 79VdO0hqgCLEWynWcbUtIPBhcfQLg1cG3AVVi+4wBzinJHVWyE8CiTIFgPS1ASOGu3rF
 /AJg==
X-Gm-Message-State: AOJu0YyEPFf+QwCs4Ut+0I4FaLN2Is9HyyP5niR2P8E5zjwBVlRjJ7VD
 lZMDWJr0L17Dys0A3tbo33Ko78ByDcNaTHNn3Yg=
X-Google-Smtp-Source: AGHT+IG6utpYrlVoPmtBIunjL7tH6lwlDUvy8nhHvpj2vXWHHhNo/OooTJjbmB0ks0zTvoNIfeD3Hg==
X-Received: by 2002:a2e:aa22:0:b0:2c5:2fcd:2598 with SMTP id
 bf34-20020a2eaa22000000b002c52fcd2598mr1979242ljb.8.1697563268861; 
 Tue, 17 Oct 2023 10:21:08 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c430300b004076f522058sm10321068wme.0.2023.10.17.10.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:21:08 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:20:27 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 1/7] hw/virtio/virtio-pmem: Replace impossible check by
 assertion
User-Agent: meli 0.8.2
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-2-philmd@linaro.org>
In-Reply-To: <20231017140150.44995-2-philmd@linaro.org>
Message-ID: <2oo76.4h7yyj4brumn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 17 Oct 2023 17:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>The get_memory_region() handler is used when (un)plugging the
>device, which can only occur *after* it is realized.
>
>virtio_pmem_realize() ensure the instance can not be realized
>without 'memdev'. Remove the superfluous check, replacing it
>by an assertion.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/virtio/virtio-pmem.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
>index c3512c2dae..cc24812d2e 100644
>--- a/hw/virtio/virtio-pmem.c
>+++ b/hw/virtio/virtio-pmem.c
>@@ -147,10 +147,7 @@ static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
> static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
>                                                    Error **errp)
> {
>-    if (!pmem->memdev) {
>-        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
>-        return NULL;
>-    }
>+    assert(pmem->memdev);
> 
>     return &pmem->memdev->mr;
> }
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

