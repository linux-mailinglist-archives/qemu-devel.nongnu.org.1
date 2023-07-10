Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297474E084
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 23:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIyti-0007gv-KM; Mon, 10 Jul 2023 17:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIyth-0007gh-Mb
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:58:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIytg-0001Mm-8D
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:58:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso51479565e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689026299; x=1691618299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JywJx1X809DQXGPFBk5XjtiL5MoqVVxEQC0YC0L3FdQ=;
 b=US4lrRlEgva5RCkuXL93gNr45wRKX9Mla+3sYapxxI39ag4ZQc3S2ZadFLhhDo2aJF
 GOL7WWY8za+JJvcSs1OC/6yKZ5pNIEXHXoHEOWqZDCg4u42mw9mG5jOn9Z2S/m6thTgv
 8Q+soprEu0j7SqnD5zDt7nmWGUjx56FsxtpT64hdzkNkpCDRaXIfUg4Abhof7+KwGnt1
 +INyrnlsY58PVgt1z5JPGwk1Pznquf2UN9WtPdgbImKMdMZTx4ux13zMRE40dI5zmQEB
 JkKcpoSgpnug2ACb6N801KzBli5kiH+IwkWRVZIhKLTyArPBnPmV2XMAJgEErgLixizM
 LpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689026299; x=1691618299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JywJx1X809DQXGPFBk5XjtiL5MoqVVxEQC0YC0L3FdQ=;
 b=j4M2nK6YOO7f612sfWcR9hdId6/g2SyQouTmNVQShHkZc/B2U0Vs7s/NvAkmz79YK+
 fbSp0rr4940dXUTYven/7LNOI2p4gd07jWcq6pbXoUNpG6/Y+D0LP6ffCryV/LptwgOX
 jC0VmKgrfOodSRN/mbGenVRNjXn86S/YN1SgiOTlYuAtdB5b4m+WnoyhxWsjNKVotbDU
 fNJ4ZhFOtO7MTa7m6jEGppACinWRUFzQ5c5BOFPFrP5z84ovfKi1laFvs8DRp78/BrIt
 zEmvljTYhPC8J1amD8dFah0+tdSq+E+eMJKKA6zLQM7eGnNrZq43cP5G3dDyu+HVcr7l
 LlDA==
X-Gm-Message-State: ABy/qLYoXk0uS5wFMKfQOCERj+60PjZxnfF9cRX0YEzNMLZCcFRDrldJ
 ItGFqsdo0Irz4d4FtDBKNCMRiQ==
X-Google-Smtp-Source: APBJJlFOHDoY1u69m1uAamRfYo9gzGt2CnENOs0ID7ZHhTHCxOcMsVT9R+sXnNZ1LGt5CwFJAmGvwg==
X-Received: by 2002:adf:e483:0:b0:314:1bb7:8a19 with SMTP id
 i3-20020adfe483000000b003141bb78a19mr11661766wrm.35.1689026298834; 
 Mon, 10 Jul 2023 14:58:18 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 o18-20020adfe812000000b00314417f5272sm472718wrm.64.2023.07.10.14.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 14:58:18 -0700 (PDT)
Message-ID: <d8555049-c6b9-fb81-0473-71ee87f632d8@linaro.org>
Date: Mon, 10 Jul 2023 23:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/20] include/hw/virtio: add kerneldoc for virtio_init
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Eric Blake
 <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Hanna Reitz
 <hreitz@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230710153522.3469097-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 10/7/23 17:35, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/hw/virtio/virtio.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


