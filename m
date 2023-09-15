Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A47A248B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCV9-0002NX-RV; Fri, 15 Sep 2023 13:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCV7-0002NE-Cw
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:21:05 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCV5-0004E8-3R
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:21:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so2728563a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694798461; x=1695403261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSiqYiFkr+KqUYv5Mks/eTo6f22l5u5ZvmM+eP12odE=;
 b=H87G5cR0fuZNPgMsLgZVt1v5fo0nUfDIFzpbv0pKAlxKl/2KAJequJX79fjaGdDc1b
 QGpBeVzXWaqi/yuxY+HD/HXIfvvXT58jWuSrVbzBcNUQDx7CS/TlW2Xl4iCx8S5hzAU9
 l1aCDqEQeChXVaIw6MbpXshpA7gCz1smGMdM0mW2cEHfivaOJ0XOs0qd3T05X+tUZ7pz
 j3yPOqz3CYLbaU/9NiGXNCa4tPI491BM/E2i/VoABTaCbU7RTtURfj6WYJpS4OMLcscr
 JKR5qN/noch4YHJ/lpGSMKzkyZUxkYJRHvSI4HMcmk2M+aLD4xxy6svmQsgHELJaXwpA
 QWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694798461; x=1695403261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSiqYiFkr+KqUYv5Mks/eTo6f22l5u5ZvmM+eP12odE=;
 b=XcUricg8QiVrTsdh+V+SmUtSAq+SG7C3vGXj+eov7krPzGBmQqYZMj5ehKCj8F/GIq
 +aSP/KBw1/v+6kmn9NMFd/AOJZqxQyPg+qw5oesMSFU/DnR+jH8lrqGV/r4d5D+LYtqk
 d/2Nn7W+4CfdMg+mZbSmuiehZdnwdmdvtqTcr5K6Z6SdjxG94EbprCAIKR11NclCDJCV
 kw660nAf8ifIwkz0Wx76Ferq+Hcp05cJ0hqu9QWOxltzU8KtKZ6BpsgsD4hhQCuRcAbu
 gvc85C0vwzbua2xCa1p+mDUKGLGvxYP3tjconguC0fV1EeFhtz/7501/2Z7c40DWam/M
 mCAw==
X-Gm-Message-State: AOJu0Yw+bvt5YgLxp+vINBU5TlnrtQPqF24xmMFTiEpYMfG1eWsiTSsT
 90UTdsv24xdNCBU5alFfaV79UQ==
X-Google-Smtp-Source: AGHT+IFoUZo4SVx5Ah6lodQGTUoJi602QEYzWxelA0ekOcGlYZHPZBnkC48x/EalJtRCfCRsv0/LHA==
X-Received: by 2002:a05:6402:b88:b0:530:97b5:49ce with SMTP id
 cf8-20020a0564020b8800b0053097b549cemr1761173edb.10.1694798461347; 
 Fri, 15 Sep 2023 10:21:01 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 p21-20020aa7d315000000b00522828d438csm2528382edq.7.2023.09.15.10.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:21:00 -0700 (PDT)
Message-ID: <c348aadd-13e8-28a4-3a47-3bf17b63b240@linaro.org>
Date: Fri, 15 Sep 2023 19:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] vdpa net: stop probing if cannot set features
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Hawkins Jiawei <yin31149@gmail.com>, qemu-stable@nongnu.org,
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230915170836.3078172-1-eperezma@redhat.com>
 <20230915170836.3078172-3-eperezma@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915170836.3078172-3-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 15/9/23 19:08, Eugenio Pérez wrote:
> Otherwise it continues the CVQ isolation probing.
> 
> Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


