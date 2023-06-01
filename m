Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DC71F2AD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ngs-0005Fo-VT; Thu, 01 Jun 2023 15:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ngq-0005FH-UY
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ngp-0002Aj-Ei
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685646626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOnOg62A547itT/CujrO1E+kwaDN9UcU0zbP4Tega5Q=;
 b=aNOpp8Gge1LpnTqa1FoeuGWMm7Bc62bTmHjrYpV7bmtLwsJB0F+PMHDA+QBjsmciSkLpZJ
 jGdyyXTWSLN8uMJZL0IMNiLJSPZJqS2ASHRSe1BGIIokf6IerLUB+Tj1pr89K8pHqiRFEx
 7Btr6yNQbn48d1tYKOYN1rJafP1yIBI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-831-evHyNoGbe1T39rBWeg-1; Thu, 01 Jun 2023 15:10:23 -0400
X-MC-Unique: 831-evHyNoGbe1T39rBWeg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af28aae675so11883941fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 12:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685646621; x=1688238621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOnOg62A547itT/CujrO1E+kwaDN9UcU0zbP4Tega5Q=;
 b=i/V4zxzygJwj025sipAarSIqpHGdccFNk4Vgk/0Rrs2o3BXwEvaZzbOr6y+IIJekcR
 NSh0q51ILlUvdWqVqso1P8LEInBMvh6gtKCz2/Onz0Exo3SvtrTxvFz8cb0mjGeUger9
 qz/PSIbb4v02uCOJPDUGj9icN2RD72XFPTuexsBFbsMccB0SJSRTcflrJJGpLMBqx0pO
 CktaK1AkJZzjEXCeOya6PTHafsS3wBES2+dbCQYt6uJSFDcibP90OajBOcxFqLjRkJBF
 7m+Hjgj6/nLbRliRqRh37gzSf1K/MIormS4Uzh/pWAq5W+aFWCJ6y3WSW2CRRGOWZaeQ
 hLyw==
X-Gm-Message-State: AC+VfDwFK0gUeS4KEZ35sctVEEcrEZ2tQSK8bMCoU+b8qVVECa2aNQlA
 ppVXKVvkj93cZHmkwVqdJxkogJ3g4oyGkmUoEkG7Fs8AkUIPsRR123lGS/KEXY+pwPcjA8lL8jl
 Z3FzuGWzjfnHDM6c=
X-Received: by 2002:a05:651c:8f:b0:2ad:9a11:b131 with SMTP id
 15-20020a05651c008f00b002ad9a11b131mr229644ljq.32.1685646621731; 
 Thu, 01 Jun 2023 12:10:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UwcxoSE6Wr7l5UsdrEUxA2CSvrsSUDhVJ9WtrqQcfskYQjxWLGhiWehJ8xQQLVYVTe/w3rg==
X-Received: by 2002:a05:651c:8f:b0:2ad:9a11:b131 with SMTP id
 15-20020a05651c008f00b002ad9a11b131mr229630ljq.32.1685646621455; 
 Thu, 01 Jun 2023 12:10:21 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 s17-20020a1709064d9100b00969f25b96basm10838014eju.204.2023.06.01.12.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 12:10:20 -0700 (PDT)
Message-ID: <5599efac-c65d-b575-b14a-f257abcf227d@redhat.com>
Date: Thu, 1 Jun 2023 21:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/6] qtest: bump bios-table-test timeout to 6 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-6-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 18.31, Daniel P. Berrangé wrote:
> This is reliably hitting the current 2 minute timeout in GitLab CI
> for the TCI job, and even hits a 4 minute timeout.

That sentence is somewhat hard to parse... maybe rather:

This is reliably hitting the current 2 minute timeout in GitLab CI, and for 
the TCI job, it even hits a 4 minute timeout.

?

> At 6 minutes it
> looks sufficiently reliable.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index d9fa30edbc..4f45369421 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,6 +1,6 @@
>   slow_qtests = {
>     'aspeed_smc-test': 120,
> -  'bios-tables-test' : 120,
> +  'bios-tables-test' : 360,
>     'migration-test' : 300,
>     'npcm7xx_pwm-test': 150,
>     'qom-test' : 420,

With the commit description updated:
Reviewed-by: Thomas Huth <thuth@redhat.com>


