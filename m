Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B061978BB26
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qal19-0006au-BW; Mon, 28 Aug 2023 18:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal14-0006OD-NZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:47:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal10-00024d-Li
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:47:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso23371925e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693262840; x=1693867640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0kK2IUSaOA3DvE4RUtCE+29JaWS66Ls07PEuyaX/Gk=;
 b=FBdHob693bDrCEWAWTHHOLw0Z9kUXxN7BG4Kf91jYXVy1gyo6Xqu/L1VZPij7t10sB
 VBgqSYasQPWT9xlQKbBf7sww+3rWxJcvCx+KsyJx+VIe2Rh+xVtL8OgQUc1FYDqH7oI1
 AZ2kWAun19GnAk9ZaG+YAdUiEZpSB2+et4PFyhLn9LN55UyyM+DMucxF+YRVUW67/TK3
 QjRvteiTnRvWsF7igv7MvsrqMEcewif7r7IiomrzEj+wFZFdd21ba4ErJ9pkYPA8FBLA
 SmMLaL74TkZ6iAxrmoyJYkTVxRVtnfqUl+aVbD7u8fX1kLCsjolcO9ay52qz01uJ0vAP
 eC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262840; x=1693867640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0kK2IUSaOA3DvE4RUtCE+29JaWS66Ls07PEuyaX/Gk=;
 b=ChkWK1PyBZVOF+D9lUBejNoLsBFj9jgz0oKZE9/Q6++TIccHkL8kfl/4b6sq7HqEV5
 9GEL0fGPQLJxiIDv/dw8jRJ89AqW2/p1B3Gaq1Y1bHzcpubEVBd/KlaUQeg1Q3Bu6iPI
 JTMwdw9P90gj2Y112uJkGNDFXkGw61svgp+LCMLVbBOQrR4GBU5/EtcKWQMwtAxq1jYs
 7lgeybAIQ5pvinbtfLrxXKWck5/xxzoGHe/Onja4cdr0fCN6oqNuJfzC1cpfE3fq34Io
 /AB8Ck/k7F1HxjxVPvvKMTFQzTsGp2nLuTVqAdPIbDsj6yOv4WXVeXQ29WCJz+dC334B
 0Dxg==
X-Gm-Message-State: AOJu0Yy3l4swAODYAhGt4kStfD0KCAEFGtZDTiSNODepN147IVvAraS/
 1hwGQ7tAdnRve079ow6xbzNleA==
X-Google-Smtp-Source: AGHT+IGYApIsL0PaIRqb9NvOgw8rA7SS5XrGTa8dhsJ5aSGt3X9mbKIjs6oa+rA4D0oqTJqUEV1jAg==
X-Received: by 2002:a7b:c4c7:0:b0:3ff:516b:5c4c with SMTP id
 g7-20020a7bc4c7000000b003ff516b5c4cmr604808wmk.18.1693262840031; 
 Mon, 28 Aug 2023 15:47:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c248200b003fee567235bsm14934730wms.1.2023.08.28.15.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 15:47:19 -0700 (PDT)
Message-ID: <2d117930-72d4-78a0-a139-a3f635b7ad7f@linaro.org>
Date: Tue, 29 Aug 2023 00:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/7] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_msg"
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-5-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-5-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 27/8/23 20:29, Laszlo Ersek wrote:
> At this point, only "vhost_user_write_msg" calls "enforce_reply"; embed
> the latter into the former.
> 
> This is purely refactoring -- no observable change.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 32 ++++++++------------
>   1 file changed, 13 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


