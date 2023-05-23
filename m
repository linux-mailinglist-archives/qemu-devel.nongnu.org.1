Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559870E4AC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WkZ-0008Rw-BJ; Tue, 23 May 2023 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WkY-0008RY-7d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WkV-0004Ny-H1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684866522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH+ADVJ0HXS1iofeNk+DmtBk2pqSDzBL0jxbhBzwjVU=;
 b=aMpShUNOBlJ0y+Ks2Sd58KoF66iCqwsUDLzY1zhlK4IxqkELv662cjZ9ueKhtlK5tvzYTv
 Z9FgwNPOYgBTajoPFfqp/aA9sUwSZzHS/CdQY8yaCTKPi0T4IhhE1GbPH8CCF787YF7bd6
 3eZqRokxj+HIrWXKydvzSIvUQs65HJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-LI0iTAxsPRiudvqueeG2kw-1; Tue, 23 May 2023 14:28:41 -0400
X-MC-Unique: LI0iTAxsPRiudvqueeG2kw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3094e661decso2241634f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866520; x=1687458520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cH+ADVJ0HXS1iofeNk+DmtBk2pqSDzBL0jxbhBzwjVU=;
 b=Cv3+71itJ9qlYfMs5s88WrwejeKBGnYJ94EITBFHJoirKEj2h5XfrDaT5osmfYhXYr
 MAp92uy/0Ri9JnWIRGWmsh0TQ2ZgHhmRVCtK4IH9UrND/Eh19ecxzeEYWd+1vg5RuqHX
 4CpH2y5YXBVq9Bv2Q9nH4qf3r5wGmILKxkCXURiOW2WSFroxpxnMMFrXEHODlk3iT6FY
 8LUQey26injHdMt/iRJXfwONn1NvfM1sdkHvf5xlEg3oxVW8EC763/x5xdb1sI7CZuph
 buprYs6bACZUBkYV8iYcdWZtbq1NXH4Xbcq921Od/Pq10DQ0MM+v5yNl2qOTTsqxijNu
 dzcg==
X-Gm-Message-State: AC+VfDxyrF+0zUGk3qCqLgr2nKM1v35bt8FF/oMOvkZvlzMgVazKo8kz
 DfOtqyFXYgzb4wsvL+xjwjoiKjuUUCsUOxFrwoSA3uQDkmGlc/x3vYqQvQku6EUw/9/2SUT7eWb
 RNkYTj4tLOjsnDf4=
X-Received: by 2002:a5d:6144:0:b0:307:9d2a:fd35 with SMTP id
 y4-20020a5d6144000000b003079d2afd35mr11464758wrt.53.1684866520289; 
 Tue, 23 May 2023 11:28:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60wNW1GyonyzqCTQKoC5sUypRl7Kt+6abMiuxjF04oSjUKS+ubGhi1DCUVeCIDhv/imvi89g==
X-Received: by 2002:a5d:6144:0:b0:307:9d2a:fd35 with SMTP id
 y4-20020a5d6144000000b003079d2afd35mr11464752wrt.53.1684866519970; 
 Tue, 23 May 2023 11:28:39 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 c5-20020adfe705000000b002c71b4d476asm12009036wrm.106.2023.05.23.11.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:28:39 -0700 (PDT)
Message-ID: <30ec2bec-a7f1-f9a6-bb17-661de19b2aaf@redhat.com>
Date: Tue, 23 May 2023 20:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] arm/Kconfig: Make TCG dependence explicit
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230523180525.29994-1-farosas@suse.de>
 <20230523180525.29994-4-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523180525.29994-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 20.05, Fabiano Rosas wrote:
> Replace the 'default y if TCG' pattern with 'default y; depends on
> TCG'.
> 
> That makes explict that there is a dependence on TCG and enabling
> these CONFIGs via .mak files without TCG present will fail earlier.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/arm/Kconfig | 123 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 82 insertions(+), 41 deletions(-)


Reviewed-by: Thomas Huth <thuth@redhat.com>


