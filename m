Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D382374CECA
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlZ7-0002Pa-6N; Mon, 10 Jul 2023 03:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlZ5-0002PM-Bn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlZ4-0003XU-2c
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688975049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wy8WA3rf7veCd32aVuVpB3Lbiz77mp+CStvv6eJKBM0=;
 b=FKI/TwgjqLSRPzz+LbIBElN8uVSCExNIDV0XAcvL5MZAcz7bq/rZim9Psa0VWoXeqXFS9N
 ptSOavLVfIB8lOZGpa9edMLk5mUVg9T8nBlVuvJUl8g8t3GpY9N7WBcA0hXLnA/V+OWdiU
 4FxqXLjFqpxUNr3NWfvwuiCP9xe7DCA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-VX-PPp3KPP2BSrtXo1sBTA-1; Mon, 10 Jul 2023 03:44:07 -0400
X-MC-Unique: VX-PPp3KPP2BSrtXo1sBTA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76597a79a0aso618980185a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688975047; x=1691567047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wy8WA3rf7veCd32aVuVpB3Lbiz77mp+CStvv6eJKBM0=;
 b=ifCPzuy0hgANA+yOkmVhRuz917ZmuSopEfa9nwgbyfEMB8P/pBd3jRLerrg+c9U6Jo
 KgkrKHVqCfaP++UjsmGSpkt3FqyDhdWOx7YCQ1o/z0S/S1nYCTSsN+8Uz88fvA+2Ng6A
 VEyWMB8KyPiEmKyTY2pUDKGu4LKws2eN6G9+J8Ivg/oVonO8bT2MwzvNdONsevkRW0rs
 ZDYZ8tgCGyxQyhGCMRE2f5QLZA9wucfD9ufIlar7dNuDvARNC74ugbDOV+eKbL0txSnX
 MwJYK+/3DMUOrgiQbvaFyPa7crP/qU3L+UXJhNDd2/ry+Y2D9hFmOJuVRfnYJlNz7pQ/
 nbMw==
X-Gm-Message-State: ABy/qLb0ajajZOsT+rZJSn9EIPSUH6CqJCEz6TL7MKqNg1+0Su8W+boc
 VaEm15fyWtuiH55kpgXJB/8APELAPzBqHhMlckbrdNzE4fiH+pmYE3h4B6nAcXrTAy9+0V1ysQR
 kko4/GgDJOFEKrfw=
X-Received: by 2002:a05:620a:29c2:b0:767:14d0:14ff with SMTP id
 s2-20020a05620a29c200b0076714d014ffmr15767050qkp.43.1688975046982; 
 Mon, 10 Jul 2023 00:44:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBT7YGaxXUeZMFEC39lj6HOpUdbBbdNrHqKE2NqGNNbYEEjNzl7OwAyOO8cjccG2d3NF2iPA==
X-Received: by 2002:a05:620a:29c2:b0:767:14d0:14ff with SMTP id
 s2-20020a05620a29c200b0076714d014ffmr15767041qkp.43.1688975046808; 
 Mon, 10 Jul 2023 00:44:06 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 d15-20020a05620a158f00b0076211938e93sm4631134qkk.46.2023.07.10.00.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:44:06 -0700 (PDT)
Message-ID: <e64f03e9-d7ba-736c-a8d6-bae03c594f39@redhat.com>
Date: Mon, 10 Jul 2023 09:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] linux-headers: update to v6.5-rc1
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230709212308.370699-1-clg@redhat.com>
 <20230709212308.370699-2-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230709212308.370699-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 09/07/2023 23.23, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

Looks fine to me (I quickly double-checked that this is the correct update 
to v6.5-rc1).

Reviewed-by: Thomas Huth <thuth@redhat.com>


