Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94178C347
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawqt-0001kD-1q; Tue, 29 Aug 2023 07:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawqq-0001jS-M9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:25:40 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawqo-0003I6-Hi
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:25:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso550912066b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693308337; x=1693913137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qnZUdeLJou2LIqV7Ui8wQ2Dj5nX5PIdbafzFPKxW7E=;
 b=kAlCn4tmFNKaqGgOrKjjqY/TClMSl2rcanFQbb5sAHT7AE6JKr1edUnUUYUMceL4G7
 uD1LqwND1aEtzjDZVNM46xT3u9pKIdT8FDiA3BBp83+3AhxavPSjgpPh9vKBt78eIduQ
 zj2rqud6Kn1uD6S8QD2LDtdG9M1DM7BEPydODljCL1g9c5RLH2uImUXQx/Vk3NCQcX3B
 Vns/bHCtOA3tyLPHAh8MH+Z7owijlYzjjBzgCQmjyqRiHfQIiyl6wbAhOJfJCNj2OIWN
 rgcbC+vFvDOFSg35pBuos/EHGauoU11aDXDW1BT0uutWb6Rc51GKORb6ztiu1Y7G2qMb
 Fy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693308337; x=1693913137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qnZUdeLJou2LIqV7Ui8wQ2Dj5nX5PIdbafzFPKxW7E=;
 b=ZQEcEunv0WC7fHaepWfZ0acPCFjExiHiIygKw3d5AdW6NoWPKPLlV2HmREoTbYd2Yd
 E2fpum7xan/qAXcZiDBUQ/o3qOB2qIHJE004u8b6UmVYbmzLRfa/awAbPmzq6DxRbioJ
 We672E/sr+1v76Rcj7xU8VKWnw/T8Yv/0pDLvMmjwWdLUZVUVMI5ng9RTOeUFk+NszFo
 DEXY2LQoSywipWACJismOxph6WmFnU+GmIh8SZbOo+R9/2c3kf1YZFmj4o0/OPKCzEA+
 hyly0NvW6dBMHSsEc6nCIuEvwUmLHx3pIsfHgAphIhnUEihEoAsc6Ii/22VeFHo2wOtN
 ks9Q==
X-Gm-Message-State: AOJu0YyqyLlOWFL8TmVfNrgaPtyDLvhzvaJeoCw6PsCY/1bDcCX8EOiL
 Z7zd2Gjun4Cc41ZHnh9mepu9/Q==
X-Google-Smtp-Source: AGHT+IHDuCCB0VsALDZNTUQemV/Seu9lKRwGhBBKG/24M70N67uk4r5Chz1gYDNLTR8JI+9PkYmxBg==
X-Received: by 2002:a17:906:20e:b0:9a5:d095:a8e4 with SMTP id
 14-20020a170906020e00b009a5d095a8e4mr847486ejd.1.1693308336881; 
 Tue, 29 Aug 2023 04:25:36 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 uz4-20020a170907118400b0098dfec235ccsm5837956ejb.47.2023.08.29.04.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 04:25:36 -0700 (PDT)
Message-ID: <f0505e8b-cb42-9cb4-e157-ad9f214e4677@linaro.org>
Date: Tue, 29 Aug 2023 13:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/11] docs: Start documenting VM templating
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-10-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823153412.832081-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 23/8/23 17:34, David Hildenbrand wrote:
> Let's add some details about VM templating, focusing on the VM memory
> configuration only.
> 
> There is much more to VM templating (VM state? block devices?), but I leave
> that as future work.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   MAINTAINERS                   |   1 +
>   docs/system/index.rst         |   1 +
>   docs/system/vm-templating.rst | 125 ++++++++++++++++++++++++++++++++++
>   3 files changed, 127 insertions(+)
>   create mode 100644 docs/system/vm-templating.rst

While not my specialty, the doc LGTM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


