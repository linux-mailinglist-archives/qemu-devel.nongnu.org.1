Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A8737F1B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuNQ-0003Oi-3J; Wed, 21 Jun 2023 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuNO-0003HY-67
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:43:46 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuNM-0001DN-H5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:43:45 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-988689a5f44so428241966b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687340622; x=1689932622;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQuLDyQUUmDNbiyiCoKnXnrXmcncUSvzDkpoqf+W6qw=;
 b=AgZsO1rjwyy7YRR+ZYGrZXLHpKpJKKA4I8JVzVRa6cc/7G9JIT+Hc2CrVrYIxSFdL5
 qLAyJVyEGKj4YpG4TpLVAbH7tXwavikVR7VSNjAKDXSINNSYYRHiPjYIUTsEKekLybe2
 X/PkkTdrmH1YB05m70HkRRLPicyvPP+ONs3kjIbDPXs0jQBgm4DaanAbwwK3EpZByhRM
 Lashuxb+2US1CfUd7mcbRy6OApN1WX15U0BgHN0NGvVJyVok2/EqzIBOoHk4oml7omUT
 LAAk/+rcyYuf6nTn76ohJBs9IN9Jjrwhj9NjvbUvT4fMWyvMX4O3FnbopEwNaCFuxtur
 kdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687340622; x=1689932622;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQuLDyQUUmDNbiyiCoKnXnrXmcncUSvzDkpoqf+W6qw=;
 b=l2ghqK2RkIHRbxPhzLQi+jAimdiJ7eItRrZwjqPY+CTULXHVtMr5BsanqBv3IyWh0Q
 oFLkhZqrPHVwTeL4P8Ar1BGXZQZifEs8qFiS0vAI5xCw5jxAvudCPIxtUZAfg3Sj4UVB
 TtYmaN92Hcy3XotraIeZabfgSOTZ3VJkHZ+Q6teEBd4QI1ikOJjMhmXmP3xckz3JK75e
 cJ4EVSNSim9gPTunSPpLilJLWDDvd6GAXdkVvliL9Xx6Muq+Y8pOBcCIX4QGnsiXybxJ
 WlcniQ9Qs3MyA24nAGNZyc+EOg7CD1bq+pmuLg4eqNSft3uwNzf/+ZE/YGOh7DbzljG4
 WdAw==
X-Gm-Message-State: AC+VfDwA+2NAwCgU+aTiV+9uybsH3Cbp1gx/4I6CXfhAB94SQcCyadx5
 2VVSpJ+x6UPGNy4GXUS05nh42A==
X-Google-Smtp-Source: ACHHUZ4L43pnChrZSHoWGkWx78xbW1VzPgUMPMic/DIofDfl0Uwt8WKwodyn/KnD87soJRkAt/LlJA==
X-Received: by 2002:a17:907:31c7:b0:989:34a0:45b0 with SMTP id
 xf7-20020a17090731c700b0098934a045b0mr4891402ejb.49.1687340622505; 
 Wed, 21 Jun 2023 02:43:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a1709064f9000b009890ab4efa9sm2811689eju.32.2023.06.21.02.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:43:42 -0700 (PDT)
Message-ID: <96026b89-90d4-a7a9-a802-7ff645b7090b@linaro.org>
Date: Wed, 21 Jun 2023 11:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 08/24] q800-glue.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621085353.113233-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 10:53, Mark Cave-Ayland wrote:
> The use of the DEFINE_TYPES() macro will soon be recommended over the use of
> calling type_init() directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800-glue.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


