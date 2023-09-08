Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B1798A42
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedpr-0003YR-UF; Fri, 08 Sep 2023 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qedpp-0003YH-A3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:55:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qedpm-0007sg-PH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:55:53 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a5dff9d2d9so276268066b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694188549; x=1694793349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zsm+iymHe3JNaUmWP5axplIN1WMwyS22wkdHWEAfFDk=;
 b=xJgnr7KivB2sce5hqyfDulPSf+hk9ObghPdt+ZInQFhCDnQi7vRrNEWuOOQvG0m0zR
 Bvpcx7OfBI4k1FC5FrMZQR7aYH8VnqZxt/GkrZsEcakSsY8YzPM/kp6i+c5BvtorBNAC
 EuNEW3JewTOpRRxvenDz3V21iNyzvjR+lMViO0YGtJhTQboKjZSTmaSdW9jditKkw46N
 PDtCEN/Ir26hO4u4Ge54wb6fc8UQfq8j+TYU9+IBQtfrjKjzEQpNNXleU62AjkoFB7bO
 Tpi+v4omlNb1WzItmP/9QwNlbt+g3yOowM5CcxzqbUS3WmcwkbLzxN8Hyd/SzQEGG+F9
 jEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694188549; x=1694793349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zsm+iymHe3JNaUmWP5axplIN1WMwyS22wkdHWEAfFDk=;
 b=ewzcwiY8CX+9NcP9Aw8Ys3B/B10MovjFThcZgOpM211tgveEr1pzSRVcRHWMnymkS8
 D6gshZf6DFJLDzWLIo/vmCgWU/Os/48sDEHEHIlyAEoOkIgW96PyBaXOEYcHYjSd9Tx9
 2SioDXA6rrwNq4xx1mZ5u2wNi37ivkXRfbNJvjj1AbU6Rgl7h9E0mAmZx98w/gfhaeU6
 imvgbC/w83lcS6dYF+HXrQIKNoBr76GuGgM2FArMdZq4SSTZQQZiZ25qPlKeuIObeAsb
 Nb6VMd8SWmiSRHz8uPnE7P7Hi5JWBjUfcsBe2UHxQTFY/7XksO8arwKXtwj0vN8YJdTY
 JsUA==
X-Gm-Message-State: AOJu0Ywq1duMRf3pNK+W7JRqXuKzfugapKJl6oj1IannQWL8j38J1aE3
 e/IkjUvEl6HyGxzsrjUzB00ieA==
X-Google-Smtp-Source: AGHT+IFWeVP+BXFVUutoj5SIyAwuvN7omHfqeZrcPbbmQ6Vvf9l49f9BvZ9iwvaikQxFwY28sPf6fA==
X-Received: by 2002:a17:906:3d21:b0:9a1:f96c:4baf with SMTP id
 l1-20020a1709063d2100b009a1f96c4bafmr2239122ejf.5.1694188549111; 
 Fri, 08 Sep 2023 08:55:49 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a170906074a00b0099293cdbc98sm1220037ejb.145.2023.09.08.08.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 08:55:48 -0700 (PDT)
Message-ID: <5b82b6ae-cc19-2fc7-abef-8eefe40e4247@linaro.org>
Date: Fri, 8 Sep 2023 17:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 0/4] Virtio shared dma-buf
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, marcandre.lureau@gmail.com,
 cohuck@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
References: <20230908154743.809569-1-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230908154743.809569-1-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 8/9/23 17:47, Albert Esteve wrote:
> v1 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
> v2 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
> v3 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06126.html
> v4 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05174.html
> v5 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00255.html
> v6 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00987.html
> v7 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01190.html
> v7 -> v8:
> - Move "qemu/osdep.h" include to the virtio-dmabuf source file.
> - Remove duplicated glib include.
> - Change the title of commits to better reflect the path to the change

Thank Albert you for the various respin with review comment addressed.

Michael, no other comment on my side.

Regards,

Phil.

> This patch covers the required steps to add support for virtio cross-device resource sharing[1],
> which support is already available in the kernel.

> Albert Esteve (4):
>    util/uuid: add a hash function
>    hw/display: introduce virtio-dmabuf
>    vhost-user: add shared_object msg
>    libvhost-user: handle shared_object msg


