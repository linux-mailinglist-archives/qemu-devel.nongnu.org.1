Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D957A248A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCV6-0002Md-21; Fri, 15 Sep 2023 13:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCV1-0002Ly-LZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:20:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCUy-0004Bg-C5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:20:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99de884ad25so315552966b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694798454; x=1695403254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmOqlqL8xj8Idxh/ZDTq3bRXeqtu/Viu1QRzu021qC0=;
 b=DU3pcbMvluE3wJgV5G+jbSWWU4LfFODM/2RY/z19mavgc2WXDTdv4idRzUEx0AuHrL
 PIjGXN9XJfkBlvrM8Ldjfi0bT4s7oQcIP63lpxMBJANIISSiroIvLHGE8UCrLgW9BDHM
 VCQAiFE+0a5d0LIwXVbHloNodlztqErMKqucWib3RvchbwXiWRqQwf3oySSu3hbOgekN
 4fwO1qE/q+kXJU2RzXNdQMHnjTT5Bi1ToUMY6pjRDIrtwc/hFc5Ml0NKNlTnMoUH2AbY
 jAaqdXFPsBSBSemF3BSDM5rSLQifiCIZ69F3eYe1VhKiT/xranR9SG2G6WMgkTXjQmJb
 wozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694798454; x=1695403254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmOqlqL8xj8Idxh/ZDTq3bRXeqtu/Viu1QRzu021qC0=;
 b=s2CUTcmSv0+HiF8ZLHhStms/dArs0Sd0RrFz2Ei3N2CYLI2moZmFVG4Z6+DdlWAl++
 mH1RPNKArfJijDkmPeXcY0kg55/zLoo/ZZ0+HAJ+wVocNYIsxwuDH92ZBzgWUkTIjE2Q
 OEVXFYB1/JPVjhxmDMG61mBORkTedf5ldOXLVjGVe7kRnSSkdpqU6TwmmQAsz6J5HC2X
 /doFg5CrCkGbdvyUtSirzdQPHHS9EU3C1TMgsiJutf6BRKju11y0dujuUN8jwXQSywNK
 HBjLgyusq0kWpsVzcRodMmzdoVTPaMvIXzFOEZIWEAyNN0DGS3z5WiJ7LUlYeYQNhIZR
 GOdg==
X-Gm-Message-State: AOJu0YxmfGmGni0l86CbvJq6176FOP17d8vPxVadfdr0Vi0BFJWS9ckE
 ZTp+xtNcCRgDwA7hpXfjk3+lEA==
X-Google-Smtp-Source: AGHT+IFFviMt20EsYAZA08NGV5I5tI2Z6/scXm903ChuDR+hlCj4o6yfeeFrZGO9+YA0FG9WtAmhiQ==
X-Received: by 2002:a17:906:4c2:b0:9a1:bee8:9252 with SMTP id
 g2-20020a17090604c200b009a1bee89252mr1826106eja.29.1694798453869; 
 Fri, 15 Sep 2023 10:20:53 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170906770d00b0097073f1ed84sm2694012ejm.4.2023.09.15.10.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:20:53 -0700 (PDT)
Message-ID: <f8607c9c-9c60-a1d2-b72f-e55ccc6422b8@linaro.org>
Date: Fri, 15 Sep 2023 19:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] vdpa net: fix error message setting virtio status
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Hawkins Jiawei <yin31149@gmail.com>, qemu-stable@nongnu.org,
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230915170836.3078172-1-eperezma@redhat.com>
 <20230915170836.3078172-2-eperezma@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915170836.3078172-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 19:08, Eugenio Pérez wrote:
> It incorrectly prints "error setting features", probably because a copy
> paste miss.
> 
> Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


