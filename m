Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028474393A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBDX-0006Me-Nu; Fri, 30 Jun 2023 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFBDV-0006Ly-Jn
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:19:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFBDU-0004JI-2N
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:19:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so2045651f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688120342; x=1690712342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwsOk1LcYtlW3s2elbYLJBfUQOXv54vSQvUcpQcfEEk=;
 b=pv0krMXQ85FJa1L200wZxhmWO8z8AuBhGEqsTFVTRV5LB06It7Immjv59ydIeS4Sks
 BuOGN3rR4Nba+BTbh6S3ihzEIqotACGDtt4KQ6rlkCqmQ9fPvPW28fzqfkMAkfwt0Qzh
 OPfrujhwtSIqY0HIcB1QVOubpCUTnkwja4dcLsyOBBW4D9nWWmESwhgNhajAjF4TrDvJ
 8+4D8cTQJYCjEMtkCfrASqJ3k6vPQ41LAtD7LoyGdL4jRIu202YL2DBIhJx5G9HZiQPT
 mAcOBR3jhUeQhYV/EIqPYTAIK1OfHRbwvyyBYHeoUosqNCZE9w2jq5VNqstljxwxMNxu
 /zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688120342; x=1690712342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwsOk1LcYtlW3s2elbYLJBfUQOXv54vSQvUcpQcfEEk=;
 b=SPBoQfv7a0BPyFW6W1bJbQOwSfilfvldeopWzoO1KriBvxMR2wPbSgHumaBkTrNKH4
 PjPJBJR47cWVoErX1TqU7jW2iPpVri045xw2Vf4TygTLcdvONj9TYan0dwAb+ORQpoci
 pagKzBO8plRXq7aKULlyfS9gNVW+42v4yFT/62BUGgjNvvXB7uRzn23/NM4t1CWvpLWS
 e1h11iTgLYMlb2rwcdunmrz/dGeWeB0ASB5IS+eN73yMosDB+jo2hHcYFYR0DXnxPkwH
 CAxpJ84OWx6z8fn6Ws/OW3iEENXuzLvPF21Uc6BQzh8ejhcAbJpDUVo4KObe0rPQLtmk
 P6pQ==
X-Gm-Message-State: ABy/qLa8HKVp7af5W8pphJwZiC+TMIMieAP/7RprQ2ZvDoddUgQZ2+eN
 wM5fP9Jsea6m9QPTFsEIR8wkEQ==
X-Google-Smtp-Source: APBJJlHT/NbfvTxXbfg8EMKmcr4se/17C5deMjc04V1y/Q8jnx+Jo0LRCq6JV/JN25zlBJ0q8y/4wg==
X-Received: by 2002:a5d:5304:0:b0:313:f157:7d58 with SMTP id
 e4-20020a5d5304000000b00313f1577d58mr2116814wrv.38.1688120342036; 
 Fri, 30 Jun 2023 03:19:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a5d6986000000b003047dc162f7sm17910562wru.67.2023.06.30.03.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:19:01 -0700 (PDT)
Message-ID: <390ba84c-fdb7-19db-c317-a38ebe2466cd@linaro.org>
Date: Fri, 30 Jun 2023 12:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] vdpa: delete duplicated VIRTIO_NET_F_RSS in
 vdpa_feature_bits
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <cover.1688112025.git.yin31149@gmail.com>
 <ee4b5afc22e3db57ba40781089cd84c4d00632b3.1688112025.git.yin31149@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ee4b5afc22e3db57ba40781089cd84c4d00632b3.1688112025.git.yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 30/6/23 10:54, Hawkins Jiawei wrote:
> This entry was duplicated on referenced commit. Removing it.
> 
> Fixes: 402378407dbd ("vhost-vdpa: multiqueue support")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   net/vhost-vdpa.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


