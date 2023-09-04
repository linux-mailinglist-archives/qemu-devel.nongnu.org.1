Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E1791956
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAB2-0002YT-3j; Mon, 04 Sep 2023 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdAAz-0002RP-Kr
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdAAx-0000Fn-ES
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otXXTP7dzmSiH88NNy4bJKEplTYHCgxsMQ5yXtXB0/Y=;
 b=KGQtd65Y2Eq1fL0MVgC8fSZLyLe5zuR5I157BQiWyCt+tieDQhIWEWd9VE2776AF3oaPUA
 RixNe3+i1jUeMR9aejcyrdqISnQ8DaNbG/N+S+/72K40qiFCcXaZrlZJVBDON4x5qpGEeF
 X7AYDBRck7nhfbwyex/crm58U8JS0Ls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-G3BbdZGwNSGSpTs4LzR5Ww-1; Mon, 04 Sep 2023 10:03:33 -0400
X-MC-Unique: G3BbdZGwNSGSpTs4LzR5Ww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso10733575e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836212; x=1694441012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otXXTP7dzmSiH88NNy4bJKEplTYHCgxsMQ5yXtXB0/Y=;
 b=Wm4FubeyaHPM/d4g/i2Is1IUyCuNOLGGmX1+hNwNoOWu0ziAYRO4kYz1/uknFETcO3
 /8sufnBav8J4jkZmlRqhA6Y2Qwi7BZkkUSPS4smlYRnBgrHB1JYeS6bAHk4g2/VHWuUR
 oM0juZe5vxlQjNOnLHR8dEQAcjFtB1iiI+NideASJ61cRHGVK/VFi4FFFyMgG7RAtkAk
 T3TRp6hKIq2icLjz8Q13yct+hdtxgDzG/5dFdrZWVhCFLoxvOyDjhgh4XBYK43N/giUv
 QaOgIoh81tiQw+0Pvyvj5WrayO9A0lmRVfuzYoId5LBqUFIB+8U+FEY35tdmpfdY6Eu3
 9CGg==
X-Gm-Message-State: AOJu0YxxYmcfD7L4nEf9x2ZnDtF9+CNcwsy0jl0EmxQW99XMec15038J
 2M3zMkzsK7D2+I6eG9VBa5o7DzJIUIP/kIlevEZA+rxRRKeHHotr3NbNIJ/vRc6s9Ron1D7QTyL
 wd6rMl7OIzxjmVrc=
X-Received: by 2002:a7b:c4c7:0:b0:3fa:97ad:2ba5 with SMTP id
 g7-20020a7bc4c7000000b003fa97ad2ba5mr7283817wmk.31.1693836212214; 
 Mon, 04 Sep 2023 07:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELFx5L6jI32EBcfYatdYKuEkFo5exWC6fg48JO/1ci+7AzVj8BAJzoBE9afzmqjveLnu4h2Q==
X-Received: by 2002:a7b:c4c7:0:b0:3fa:97ad:2ba5 with SMTP id
 g7-20020a7bc4c7000000b003fa97ad2ba5mr7283804wmk.31.1693836211930; 
 Mon, 04 Sep 2023 07:03:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 d3-20020adfef83000000b0031c6ae19e27sm14527416wro.99.2023.09.04.07.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:03:31 -0700 (PDT)
Message-ID: <c1a109b1-74e8-6675-e341-0f4bf072a98f@redhat.com>
Date: Mon, 4 Sep 2023 16:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 61/67] ui/spice: SPICE/QXL requires PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-62-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230830093843.3531473-62-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/30/23 11:38, marcandre.lureau@redhat.com wrote:
> diff --git a/ui/meson.build b/ui/meson.build
> index b3525ef064..08d845d43a 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -133,7 +133,7 @@ if sdl.found()
>     ui_modules += {'sdl' : sdl_ss}
>   endif
>   
> -if spice.found()
> +if spice.found() and pixman.found()

Does the spice chardev make sense without pixman?  If not, please use 
the same .disable_auto_if and .require logic as VNC.

Paolo


