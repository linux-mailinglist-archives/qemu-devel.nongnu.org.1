Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C279194F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdA9t-00075e-5j; Mon, 04 Sep 2023 10:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdA9E-00075F-EB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdA9C-0008Ln-1J
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:01:48 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VhcnZxeXPY-ubuW2BXHdZA-1; Mon, 04 Sep 2023 10:01:44 -0400
X-MC-Unique: VhcnZxeXPY-ubuW2BXHdZA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401dba99384so9623455e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836102; x=1694440902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhHcz6/r90f8iYi2qJoBfNNa5kEzk+/IGA4VNlVgynE=;
 b=WguWIpXF2mSkJ+oXex2SCKRJuTEUYahlMVBg1LLNJeBGjVF5s6I/XZFyvlCZchi0lv
 ePWgji4bW00bpyJOKPlJdm1fS6OTtuq9HBnFM06BqK7TZ4mTe58SDCujuayXzDD44lGw
 THVbU8C/HpLiTHCrBxg6/02cJmX64mvrQRbfG/hITExDSHNMQhRDLLFYjpkpzjZBE07i
 Z0Nrr9B8f1HtK4qPOXgg26xSoPuYXSTmouohHV31QNBTlDKMXFS/RDI85sOkUQDDnsjD
 Nwd3bHjCoRmVSbukQXilsOLNT0bbZtD1++NpdS5p+u//UkBDbTwNmnNTjU4FqXhMB4S/
 6Z1A==
X-Gm-Message-State: AOJu0Yw64s+vXDotjJRKpyvSEDQ9hJ+lj5SvXOmRSbZI18PzIyen8VR/
 +OK/iqiQZKvCCKsGVjwsxi30gL6FHO8Iv3NEfqbqnaARMyAttSAjsnKaElz8Bv7YNKWP9VvadAB
 EtK04u5LxNbkM+XA=
X-Received: by 2002:a05:600c:2106:b0:3fe:d780:4f7a with SMTP id
 u6-20020a05600c210600b003fed7804f7amr6943689wml.3.1693836101978; 
 Mon, 04 Sep 2023 07:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEYNcTj5gcRRfC5IMesxxS3wW68kW9tOcuSZyOTK3sLf/gAeHiDsvxjNrHYNvm0RZXXcUCZQ==
X-Received: by 2002:a05:600c:2106:b0:3fe:d780:4f7a with SMTP id
 u6-20020a05600c210600b003fed7804f7amr6943672wml.3.1693836101664; 
 Mon, 04 Sep 2023 07:01:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feee8d8011sm17255112wmi.41.2023.09.04.07.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:01:41 -0700 (PDT)
Message-ID: <6ad67416-9a87-73a7-d41b-64f3ec66ea55@redhat.com>
Date: Mon, 4 Sep 2023 16:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 60/67] ui/vnc: VNC requires PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-61-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230830093843.3531473-61-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/30/23 11:38, marcandre.lureau@redhat.com wrote:
> -if get_option('vnc').allowed() and have_system
> +if get_option('vnc') \
> +  .disable_auto_if(not pixman.found()) \
> +  .require(pixman.found()) \
> +  .allowed() and have_system

".disable_auto_if()" is not needed, because ".require()" handles it.

However, please add an error message for ".require()" and make it a seprate variable:

have_vnc = get_option('vnc') \
   .disable_auto_if(not have_system) \
   .require(pixman.found(),
            error_message: 'cannot enable VNC if pixman is not available') \
   .allowed()

Thanks,

Paolo


