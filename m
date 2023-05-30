Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8911716BB0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43ZH-0005yI-By; Tue, 30 May 2023 13:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q43Z3-0005y3-3U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q43Z1-0001DI-LS
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685469318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYiQKhEdcivdLvy6/30/wVvux22cBYvh8vNCbr/B1hM=;
 b=YyKeC7VXhCo80pPYLNpeWvGmb2h39uz2x1HbiRwPFCB14eBd0fPuDtbXKpH1D32TMa4+oq
 rSHJS3zoOKClHdqvs98UOLtAXUn66rVtNQw/l07jGQRZuaATii4NKbdMZRJzui1FMu19ZF
 SpGrooeKBwfJXOmYSHqPh86b1G5t118=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-X03ALg37OIyLszbUhiAMMQ-1; Tue, 30 May 2023 13:55:17 -0400
X-MC-Unique: X03ALg37OIyLszbUhiAMMQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30aa0cc2152so2573073f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685469316; x=1688061316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYiQKhEdcivdLvy6/30/wVvux22cBYvh8vNCbr/B1hM=;
 b=gqeS5IkJr3Jwfif6QfnH/47zhon4QJyu3om1RhDheOtCu78RlDzEJXhMunFMB4MgXL
 NOsy8wL/h166PZyyex+fhz5ThZDRDiRgY/r14yt0vbgG2+qA/pEts8Pj58PXx81OLu3T
 auKZH+IySaxxLzI5Jgy7igUTTFc1QLKosoQ4LAxzKYD1afKPWgw31t2UjkFKcK/R+STI
 IxA3GWRrunfO5uycUI3iCpgkDBBUjqqO/DBwwhcxur6lu6JMGilFLC1LtN286Jmr/DaU
 bfdR9RSHCvAKoxpWRRqZHKUskEAcqtdx1H0oL4WoKXzXJto9ievqDcIMV+JnhrTqT+2d
 1ebQ==
X-Gm-Message-State: AC+VfDwJHlE3mwoRWjO8vfvHguuJmpoRPHyUha7XPbjrlw69lrQ0O/lB
 3xjQ8s+X0kPxTJD5lTvbmYklFZyg+YXXgmgLq9fuLmCe6huGUi6ebmU6QxKUc4Jh0LsKzlIgzvh
 zC+APREsfiShqBo8=
X-Received: by 2002:adf:f04c:0:b0:306:3319:e432 with SMTP id
 t12-20020adff04c000000b003063319e432mr2342295wro.18.1685469316046; 
 Tue, 30 May 2023 10:55:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W4zoCQWl9OtR3yBGdciWSV2qOBWHcWHdfkjZ0SANFaqBt1Myy7YHKjitxOyPtaHajvIuvNA==
X-Received: by 2002:adf:f04c:0:b0:306:3319:e432 with SMTP id
 t12-20020adff04c000000b003063319e432mr2342283wro.18.1685469315758; 
 Tue, 30 May 2023 10:55:15 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 b18-20020a5d6352000000b0030adc30e9f1sm4038175wrw.68.2023.05.30.10.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 10:55:15 -0700 (PDT)
Message-ID: <6235dc46-86a7-77b3-b758-d001794a6434@redhat.com>
Date: Tue, 30 May 2023 19:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re:
 tests/avocado/virtio-gpu.py:VirtioGPUx86.test_vhost_user_vga_virgl: ERROR
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <7b9511f8-eca4-8a27-9d4e-31a6f16a6bb0@linaro.org>
 <8696ef96-7287-b059-261b-d06d1d3b0c25@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8696ef96-7287-b059-261b-d06d1d3b0c25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On 30/05/2023 17.00, Richard Henderson wrote:
> Ping.
> 
> On 5/25/23 10:00, Richard Henderson wrote:
>> Hi guys,
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4352476431
>> https://gitlab.com/qemu-project/qemu/-/jobs/4352476434
>>
>> This test ERRORs on the azure k8s runners with
>>
>> qemu-system-x86_64: egl: no drm render node available
>> qemu-system-x86_64: egl: render node init failed
>>
>> Can we please SKIP the test if the required resource is not available?

Maybe easy to fix... test_virtio_vga_virgl uses:

         try:
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
             self.cancel("VirGL not enabled?")

But the failing test test_vhost_user_vga_virgl just does:

         self.vm.launch()

without checking for an exception. I think we need to add the same "try: ...
except:" handling as above. I'll send a patch.

  Thomas


