Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADC7596BE
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7Dy-0000s1-Hr; Wed, 19 Jul 2023 09:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7Dw-0000rU-JI
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7Dv-0006Oy-7O
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMkhcmK0BsbDgypzmnYzdKrbNatQALUnJFqddROFGEU=;
 b=TLj6OkxQi73DKdkwsUx054L3fq/74EzZXgI36oOk7YnLJsVqdwI8r1r5E/Fes1n/YJFSAQ
 kwEKPbEADgLQym6NiANEckMREiK5GpfgCkF6itKTEviay+Y9Kf5YDizIY/rfcDevO7dt/u
 FaLkAp9JAvx/oZXlZ1d1WKVXZrWoI38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-RLu2wWzkNKitqrSpIQm6nQ-1; Wed, 19 Jul 2023 09:28:08 -0400
X-MC-Unique: RLu2wWzkNKitqrSpIQm6nQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso3970116f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773283; x=1692365283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMkhcmK0BsbDgypzmnYzdKrbNatQALUnJFqddROFGEU=;
 b=EbQQ6+mRN7xLXzyK+rlNw0tQAF0h9nmENapNdYWEeRvIF2k0HsX9SiyhkiYzPgT3SM
 QMehemDBgVHMQMTAz2/T5uvK3Qb6n0bgBj8qSjQgEzZD6iXSacgut0/zvviBZ/zDClkT
 mSt1d1X6QA8DPdjq6ri5WMSjEcGjzMsQoqEyfCksO1zBFUXRzaSumu5EsOx1P/zMrC/P
 y/2w2hxEbd0PGEKOhjH5ci5MM9b/lbLHRn4xcxMNYQMbQCG38ah/O/uNe6xSBDBCcWO+
 A/Vmz1XIYXVSSW8NHZ/IfhmQh0aP7VFv4rADY13VWRNGrxznLw8TmfWjLAdXfRZZO712
 lKGw==
X-Gm-Message-State: ABy/qLYxNU4D177yw8vbGJadIN3l3qIvZOuUmhs7IyEtCiPHh78z7WVi
 G3f/Fj0mO3f3DuquSUlaRcJAwHi4eVzt3eKu6iINvw+faFEkIiuG6K0rTckw8Cct8gtDDnKOxFe
 IiVhdTK6XOwnrwpY=
X-Received: by 2002:adf:e8c8:0:b0:30f:cf93:4bb8 with SMTP id
 k8-20020adfe8c8000000b0030fcf934bb8mr4449210wrn.57.1689773283512; 
 Wed, 19 Jul 2023 06:28:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPzkWItdiFb+BzgxP99gIDqbd6l2pXZEYakXWbUfuJbixkwnovxIlfVEwcLCuFaWGdSpru5g==
X-Received: by 2002:adf:e8c8:0:b0:30f:cf93:4bb8 with SMTP id
 k8-20020adfe8c8000000b0030fcf934bb8mr4449192wrn.57.1689773283197; 
 Wed, 19 Jul 2023 06:28:03 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 f13-20020adfe90d000000b003143cdc5949sm5441879wrm.9.2023.07.19.06.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:28:02 -0700 (PDT)
Message-ID: <68c3cb5c-edaf-bfea-303f-b43ea932bd04@redhat.com>
Date: Wed, 19 Jul 2023 15:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/12] qtest: bump qos-test timeout to 2 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-10-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 17/07/2023 20.28, Daniel P. Berrangé wrote:
> The qos-test takes just under 1 minute in a --enable-debug
> build. Bumping to 2 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 9e4f5e0ecc..3df9a51b03 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -7,6 +7,7 @@ slow_qtests = {
>     'pxe-test': 180,
>     'prom-env-test': 180,
>     'boot-serial-test': 180,
> +  'qos-test': 120,
>   }
>   
>   qtests_generic = [

Reviewed-by: Thomas Huth <thuth@redhat.com>


