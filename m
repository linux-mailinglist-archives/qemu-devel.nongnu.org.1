Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A727E48E2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:58:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RGq-0004rd-DH; Tue, 07 Nov 2023 13:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RGk-0004pf-Ct
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:57:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RGi-0003ky-Qx
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:57:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3697132f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383461; x=1699988261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxeMoeY9zvz5MBwcODtQ1lKXNlwP3wEjii0rHdfpido=;
 b=ASKA7hChIF2rHYeSguecyDY7OQZv5oSHXVVe0vzS9LMPsQCeBgZZobp7xIs3Sj4n7U
 FTJH6vpOFk1qKddzIiVzyrRt/fOCV/i89s0qo6dms0rIKE5T4ECMwzcjphJ7fJ3w8XqZ
 O4ajMz6b9s4ZMVnJvWdnrGQtvW2AbZl+e3ZHM2KSzi7TXNAi6ZcSgWE/P+kZ84/Gu5U9
 BAY9BwQvtDcoZyhmnh8s1wSZnzo/pe6NS0cxuFgdy6dImnhXJtqx3FgS98RTNzOPvMHX
 Ybuz1+F7oPH29x3SP57YXfTTUHmQRRmeCo77RqjCIRBxn17o/BZfLK3urM8K8jdDlfSm
 8EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383461; x=1699988261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxeMoeY9zvz5MBwcODtQ1lKXNlwP3wEjii0rHdfpido=;
 b=FP1AfCrLMV/veS+Ywi26CHMeFZ7QxSh9MpVWEG+GP5Mcub0ZdvQEg/W2YMIYPd2SoO
 53bZnWtOpGZzZZ3Umxeihid0SrNE2HGOgH93w3L2NpogqrMyfcV03wq4i58Facy7AuBY
 J+vagjx7gbOwDBZI06BKMFfBhgkgO8kEFcssxOjZU30YQybp6CJMq9ljHGgLDhReTPhS
 ZyVIrLbiuz/YO5fvGo2jeDeWrt537lwh2JpVx0UCviiwFQdrON/Fk9jiDt+vu1+XBEIT
 gPN6RfEV6NVSISKN7RUxo1iXhlU+ONw7G/78dQNzzhPfOg9cyX18cmd4oPvliZuPzY94
 5esg==
X-Gm-Message-State: AOJu0Yxqd4SIN2IUiiSMJeCCohVgiun1XBgQgcMwgbbsir6ucFZilRPb
 obfdYoR9vLIpMMAwGK94v44Kpg==
X-Google-Smtp-Source: AGHT+IE7petM7bGHMYkovkipGhemur0E0ePpH9y2sb0jRkOJI+gtKEc3Bs5fVvfpjwrAxwaf/i0SRQ==
X-Received: by 2002:a5d:5381:0:b0:32d:939d:c7cf with SMTP id
 d1-20020a5d5381000000b0032d939dc7cfmr21182543wrv.52.1699383461608; 
 Tue, 07 Nov 2023 10:57:41 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm3079754wrt.18.2023.11.07.10.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:57:41 -0800 (PST)
Message-ID: <374517d4-b42e-41dc-a307-2c8dca8c3560@linaro.org>
Date: Tue, 7 Nov 2023 19:57:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-snd-pci: fix the PCI class code
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20231107185034.6434-1-vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107185034.6434-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/11/23 19:50, Volker Rümelin wrote:
> The virtio sound device is currently an unclassified PCI device.
> 
> ~> sudo lspci -s '00:02.0' -v -nn | head -n 2
> 00:02.0 Unclassified device [00ff]:
>   Red Hat, Inc. Device [1af4:1059] (rev 01)
>          Subsystem: Red Hat, Inc. Device [1af4:1100]
> 
> Set the correct PCI class code to change the device to a
> multimedia audio controller.
> 
> ~> sudo lspci -s '00:02.0' -v -nn | head -n 2
> 00:02.0 Multimedia audio controller [0401]:
>   Red Hat, Inc. Device [1af4:1059] (rev 01)
>          Subsystem: Red Hat, Inc. Device [1af4:1100]
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
> The two additional lines have been lost between v6 and v7 of
> the "Add VIRTIO sound card" patch series.
> 
>   hw/audio/virtio-snd-pci.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


