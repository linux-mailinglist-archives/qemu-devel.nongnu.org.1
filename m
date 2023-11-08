Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A57E5CCC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:59:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0mp6-0001oB-5N; Wed, 08 Nov 2023 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0mp4-0001k6-4D
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:58:38 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0mp2-0004wY-Fq
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:58:37 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9e4675c7a5fso2158566b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699466315; x=1700071115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cVZN983bRyBvnnwbMWxSeLYR+ktYWR3Us7DgdR215qs=;
 b=T72GU1lZyazDbckaMu+SFLLyhuc0P91Cd2Z9LGVR79U4jAqvJwLMLwVM0cIGdCp2sa
 kR5U3tqBa9oPozPQpnNnogyWyifESAtipp3of93Z6dqk2lXMDJNqcXPO6Dl0RGVR0B9M
 oc7GVC807+FwZGmFPTwx9q6ydcoMFKlmxk9nZBeng9TfyuBUlHmCRRNgsLrXVOanF2rf
 d7+JG97dFWXFsxZUPrgIRrWPrRHG4VcJeHBt1E/MMOe9HMGE3rbKagAs8SawR6EivJlH
 PKmDh+RYycQZnGztVFqAgokm2c8NDhpPziMX7QLfIe1qOrqjTjViBZ+d+WdspE6sIHai
 eknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699466315; x=1700071115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cVZN983bRyBvnnwbMWxSeLYR+ktYWR3Us7DgdR215qs=;
 b=khllueAAw5aHig8L6N/+q22pEWOHs13wsfWtQuZMfmdzs+AlPjCAeKVfKcDIaEeyAX
 TpGO5TJLB2pc4fmG7TMSbFCUs1Yyg97fDEgrv3eVlkUQGb0qMNUvoeG0/BTWrhu0eFA+
 L9YNcEfGhMHHm+h6VpMbEXsNyPdL8toFWC/qhuZS6wDLHKESaoL+wmgMJzdasnEZAvyQ
 SNi3EeP+oI+WW5naOSto0Kp9/QHR0vqVOl2LJt+pIAsv5ed1vdvG0ep/xMeXGU2pyhiJ
 Oj4Bd9OSegyA+hJ8ddVu++tYnfD/+CSSOa9k+/IhG88n+StB3iaqOKx205hbr0pTw2KS
 /00Q==
X-Gm-Message-State: AOJu0YxQZyBWoUWm+Oeph+eT1HfF2Y8SvxNhzZKILO6c1OwHEpuF5XAf
 C4y1PniVATS3wvLXI6oyFbobzA==
X-Google-Smtp-Source: AGHT+IEPItWzBUfeAMJARs2c08dI9kv87WJljJXp+RY0J4xGeoC55qiLFADtrAeBcmak9cMxPLIclA==
X-Received: by 2002:a17:906:dc92:b0:9be:6bf0:2f95 with SMTP id
 cs18-20020a170906dc9200b009be6bf02f95mr2316071ejc.20.1699466314962; 
 Wed, 08 Nov 2023 09:58:34 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 lv19-20020a170906bc9300b009a9fbeb15f5sm1372376ejb.46.2023.11.08.09.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:58:12 -0800 (PST)
Message-ID: <00cac732-a896-44d1-ae58-34f13d0f9a5f@linaro.org>
Date: Wed, 8 Nov 2023 18:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] qom: add default value
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, jsnow@redhat.com,
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, thuth@redhat.com, darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com, lvivier@redhat.com
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-2-davydov-max@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108153827.39692-2-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 8/11/23 16:38, Maksim Davydov wrote:
> qmp_qom_list_properties can print default values if they are available
> as qmp_device_list_properties does, because both of them use the
> ObjectPropertyInfo structure with default_value field. This can be useful
> when working with "not device" types (e.g. memory-backend).
> 
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   qom/qom-qmp-cmds.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


