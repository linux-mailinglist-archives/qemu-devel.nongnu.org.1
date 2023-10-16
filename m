Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F727CA47E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKDG-0000BA-JS; Mon, 16 Oct 2023 05:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKDA-0000B2-Rs
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKD9-00041Z-5W
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkQ6WqohpSwvs1ZydprzJVEcMxJ0rVDTyYDWHqDDkrE=;
 b=OS5IE5zVDa+TVM+iEpzsGvRKCfy1wYQZAJSK4KjBf8yXBihj4v2hKIxGCaZ8U7xc44PL9o
 Roc62YPAclOckHV2MSDiIUQN7DqLJYMkM10UYvoa86l8TVqx/IMAD1yGiaPceiIMqLZ3RX
 FkSOktUhItJLVlOGVGGG3pt3cpUVB/Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Cs4FLaktNZe18i8n2RlvpA-1; Mon, 16 Oct 2023 05:48:19 -0400
X-MC-Unique: Cs4FLaktNZe18i8n2RlvpA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9be8013f2d1so125283866b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449697; x=1698054497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkQ6WqohpSwvs1ZydprzJVEcMxJ0rVDTyYDWHqDDkrE=;
 b=jzMHoW9YW3mEaL7cuLdsT6ShMTLW+cXq/VpsraKvxV2ve8ntHh0J5kSbg6afWto/E1
 Ephmq93wWrNdyFotarSsHyrTnnz+maJ997uLs7yqfeK4FBEAufvOgCPRRUUOBe/JBJx7
 ImAi8aGZAyM2Y6XUUSoHp8X4TpbJCE+57dKLKvywiiE/00h+OuIrj8kdr5g7FieOCIqH
 2S0MhCwHtvkjXBkHwFZqzQHBk4EyUg4LRhhgw0wYRsGGNwZ0VQzqld2Yz4Q2lfoK29JP
 AT2Zv3Jw/mvB7mxYqBH2rD3i6UzI8bR5AEjWClggDeWT46jguUTlOVEjSmOkNVxnVwCV
 360A==
X-Gm-Message-State: AOJu0YxdFD+LqzTHIC6p3lqTS096n023LyArDIwlCAHz/zVdd1uBk1pJ
 GhpyZ3UVwYfQJCW+9txtjF3AdkhFG+1T3qq/4/gfL8oL5moRaog1hALujYYWirx1S53G+QelkHT
 lk+nnncwfS5Q2BvuWo0ONWh0=
X-Received: by 2002:a17:906:714a:b0:9b2:b9ad:ddd1 with SMTP id
 z10-20020a170906714a00b009b2b9adddd1mr29791622ejj.28.1697449697102; 
 Mon, 16 Oct 2023 02:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy5XpaRNjZgK7MYHI1741C5+rlEfIbpReaF0Qeyv1b7eI+T2qt2o+MDahXGzInMN6j5va08Q==
X-Received: by 2002:a17:906:714a:b0:9b2:b9ad:ddd1 with SMTP id
 z10-20020a170906714a00b009b2b9adddd1mr29791614ejj.28.1697449696789; 
 Mon, 16 Oct 2023 02:48:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 z10-20020a170906240a00b0099d798a6bb5sm3709781eja.67.2023.10.16.02.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:48:16 -0700 (PDT)
Message-ID: <129fe44e-62a2-4742-b109-b5048ab4d5d8@redhat.com>
Date: Mon, 16 Oct 2023 11:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] meson, cutils: allow non-relocatable installs
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-4-pbonzini@redhat.com> <2m6ug.d5dtxb4s48um@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2m6ug.d5dtxb4s48um@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/16/23 11:08, Manos Pitsidianakis wrote:
> On Mon, 16 Oct 2023 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> diff --git a/meson.build b/meson.build
>> index 010d2c649c2..251838f2609 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2111,6 +2111,7 @@ config_host_data.set('CONFIG_OPENGL', 
>> opengl.found())
>> config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
>> config_host_data.set('CONFIG_RBD', rbd.found())
>> config_host_data.set('CONFIG_RDMA', rdma.found())
>> +config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
>> config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>> config_host_data.set('CONFIG_SDL', sdl.found())
>> config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> 
> Is relocatable a good choice here? The term is used in linking and might 
> be confusing (when I read the subject that's what I thought it'd be 
> about). How about 'movable`?

I think it's a relatively common usage.  Google finds many uses for RPM 
but also in a lot of random forums (CMake, Julia, FreeBSD).  See also 
https://nehckl0.medium.com/creating-relocatable-linux-executables-by-setting-rpath-with-origin-45de573a2e98 
or 
https://www.gnu.org/software/gnulib/manual/html_node/Supporting-Relocation.html.

Paolo


