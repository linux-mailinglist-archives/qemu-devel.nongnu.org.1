Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845847224C3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68X5-0007bJ-Az; Mon, 05 Jun 2023 07:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68Wz-0007ax-NW
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68Wy-0000vd-3t
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685965064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLSgkrNW5fSoY4/rWWdHyqZpskCNvxilzrmfrHEFpgY=;
 b=JFDuwByIDKCNUQulKjM1WTXRYoAoE2lZ4dKWxcDV3xEGytkMnCdYMJ/fECFza3rs1abtOE
 nn0OzgtnUWarR928DrYnkbOpogxRMmD7spu5iVEcldhnchGy7HLbkzEqxya1NiVudG3DH8
 L/u0O7hm1IHsFr9WhLmfI4cvlV8pDr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-N-rikQCMMcalBpzmn2eOtQ-1; Mon, 05 Jun 2023 07:37:43 -0400
X-MC-Unique: N-rikQCMMcalBpzmn2eOtQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f739a73ba4so4831745e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 04:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685965062; x=1688557062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLSgkrNW5fSoY4/rWWdHyqZpskCNvxilzrmfrHEFpgY=;
 b=kp8HUofNiFMizUatizy1QgSRG2nIzm7TX+VvfraIt2tEXUbkJ8zFnsml+EmnTpBBSI
 QLBgZUltnO3GO0oDIp3yvME5ORAR/GW49Uz59/Q1w3gHtMofLaAo3x3BwtLVxcJTj4AU
 Wps3Xl2eHLx5qQ32OJmrTpg355Cgx4mbOjJtoGmiWhDfSAszRzqD/GjAyQCfS+I62Ira
 Rl25YD5dKmMflFHDcViz+S+NfZ7s9ACuAMP96NI9fUxocycEb+7CLZkxttScqLb7f9+J
 FFuOAYXDlMKAK83zRzNGQoADGUQcUi9cI0FKEt4Fo1ChHeiUfUN3hO1vT9MYV1QhKZ9w
 Sj/w==
X-Gm-Message-State: AC+VfDxLcY6vMB5Sy4YLfmcUNWhRps+N/i/UyYqhAAXkF4iYHAiJ9CKA
 bLQjZTFNdZq49OoqT9HTCDxHzWHvXuAevTKqvWMBDo3qnXhab7RPP6k1dDjIkMRax1R0pml/MiW
 auNRA2M2UJ9+qk+w=
X-Received: by 2002:a05:600c:289:b0:3f6:3bb:5135 with SMTP id
 9-20020a05600c028900b003f603bb5135mr7057141wmk.14.1685965062491; 
 Mon, 05 Jun 2023 04:37:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63ZAMA5URZ9PJJu5EX7smrUbXX/hAy14E9PKAdxgALJNbo0U/rQWCsCAZCYY9WIhGSRKo5uw==
X-Received: by 2002:a05:600c:289:b0:3f6:3bb:5135 with SMTP id
 9-20020a05600c028900b003f603bb5135mr7057133wmk.14.1685965062256; 
 Mon, 05 Jun 2023 04:37:42 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b003f73a101f88sm4314745wml.16.2023.06.05.04.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:37:41 -0700 (PDT)
Message-ID: <2e7081ee-0ee7-0e39-59eb-32bcaf59dda8@redhat.com>
Date: Mon, 5 Jun 2023 13:37:39 +0200
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> for the TCI job, and even hits a 4 minute timeout. At 6 minutes it
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

Seems not to be enough for the CI (in the TCI job which is very slow in 
running the tests):

  https://gitlab.com/thuth/qemu/-/jobs/4412460439

An earlier run needed 403 seconds here already:

  https://gitlab.com/thuth/qemu/-/jobs/4411373383

  Thomas


