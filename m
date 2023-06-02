Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D371FDCB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q512k-00076V-Ev; Fri, 02 Jun 2023 05:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q512i-00075P-Qn
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:25:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q512h-0002iS-3Z
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:25:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30af0aa4812so1837768f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685697953; x=1688289953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOYjbwqiAiOuSzvgisznhUVFElP9U7QI/fHNL5rSm/I=;
 b=Yz7St6GtaP7l0L2EKjNg79Ouy8ZNlnNoHdVTKsmQ27Qfg/7ZjaX/UmnuTOKuSbzbrs
 5MekbP76KXd6Mmj0klJ93+WvaZbJ4RbFseyQ6wKYLuAmfCxyQJF4KTfLGjAdPHJEtg5J
 OUr4iIDXYJk3KN6JsjAIbjHQVisL6XG+5v70oua4ljqvKEkcmxhRroRIIF1N6yEldl0Z
 dmu3/FomHmwGHcCeCqCYX8nrjA14u1DPcPFDsGI/JwSbtNNE4tyGN8n1jav6bPapUPit
 rWjHkn0du06EvqNQT7Pz3QxCSsffLsqOg7MYtD07qWF+w9E4StuuAT6S77XqNZKuqa2g
 wiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685697953; x=1688289953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOYjbwqiAiOuSzvgisznhUVFElP9U7QI/fHNL5rSm/I=;
 b=ZsSt7SB4VSSEwerFVLVIq0hst3dejOAZK9Jw9sL1BCG/vI1Jfrcj3/S8kWGo3HWERz
 +/heKscDwqMKSMe25jXZ2wmuip8fBeFqTRTj1um+Pa6Ft+1BheV7dAcGQl1ROKbQE2m9
 uJABxyxlQfQCeaLV84tfg5QcmAtySFQEgz95AhhrXZ/BVzESzCG4O9PS0Uux7B56o5xp
 G/t6LhyqvQzd4rf4Q75mmDaZT0Hk+Vax4dl7GGKQRXUS4FipuI0qih2k4+se7df7NfcZ
 iDu1aYYwgAfYqhjieC8/ikeywRAPRNIF7bHF0a5tjupphisEK6Nh4GCiZmSPQj8t7LvE
 dbWQ==
X-Gm-Message-State: AC+VfDwxSagT+q1cTFkywpy8x/WQnphDUYQhs6sREtuxDHCVpt4ZOlZG
 +dXkfxV4UMgzwHNhg6xXCdEAng==
X-Google-Smtp-Source: ACHHUZ67Z0cL1RypTH19REmZ2Z5tc6GtR9DgrSPaTezuv8L+5Q8jt5qX/q6x0Zj080QrkBf1AHMO5g==
X-Received: by 2002:a5d:4c84:0:b0:307:9a49:da89 with SMTP id
 z4-20020a5d4c84000000b003079a49da89mr3938704wrs.38.1685697953571; 
 Fri, 02 Jun 2023 02:25:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a5d504e000000b00300aee6c9cesm1134014wrt.20.2023.06.02.02.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:25:53 -0700 (PDT)
Message-ID: <42b27eb4-19f2-4b2b-f4b6-769435416919@linaro.org>
Date: Fri, 2 Jun 2023 11:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230602085321.1814165-1-eperezma@redhat.com>
 <20230602085321.1814165-2-eperezma@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602085321.1814165-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 2/6/23 10:53, Eugenio Pérez wrote:
> We need to call it from resource cleanup context, as munmap needs the
> size of the mappings.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


