Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A462E78D536
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIoy-0004En-DI; Wed, 30 Aug 2023 06:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbIou-0004Dg-7Q
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbIor-0007f7-Jz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693392784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9Y+uH/DkCfKk8jypInqxZ49eiPaEMNppoei7qdkIBo=;
 b=YPWcPEfrDFKxK5WSnhB/yCP6CTahEcOwa1K8wEYnKrusGzXEW8Sl7lsROHe/4RI2OZUDu6
 iEhaXGdICHUWr0JU2CiREsWbbDY04A9ZlJDsb1mAfwz9wbVjhGya9FuvR2uH3GBLqnolPk
 9AzJbTQq1UA6ImLMh6FWr1jfvlXl0Rk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-pqn7N78PNEGSRRJ7kMaBlA-1; Wed, 30 Aug 2023 06:53:02 -0400
X-MC-Unique: pqn7N78PNEGSRRJ7kMaBlA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3feeb420c8aso36454905e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693392782; x=1693997582;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9Y+uH/DkCfKk8jypInqxZ49eiPaEMNppoei7qdkIBo=;
 b=e200CShYe7HwYnFMEmVZiCHXxajJnjdrz2EbqvuCilf2rPx9SIWuO4SjBZZHuhh267
 XrBpA4hT7rLtvcwnEINDkyr16rO34IonEX2icgPhPAsC7L0fshMMifkGzaKXFPQZ3Xhh
 xOMaJC54UOwaNCcmKOZEa2ySbFTnktHY5YcS+IQuBAL1TJCqTxZmxTg+9H+/rq1jxW5L
 pr8LWK+ReJMbNk3BJfBKVMevXgLkF2fCxLeKUO8UVCm87ylClC7W+PBpTL8LdG4v1VmX
 YuJVNqulrL+LHLMSrR0TFQ0SZiup+wD/X18jIuAFutg/USIfyOvQ4d0CLlr+qC7E9BiD
 AQXg==
X-Gm-Message-State: AOJu0Yx8usNcY1Dad6+wkzbgI0mACGb1hm7rrqryG69gEescw/HUnmin
 SIJuyPKVx1UbpeKGMzvPBmVo0o9lolGoGGA5kq9+VHjCnvOnjzkxaqv8FRLbNrhw0O62C4/UQLV
 1izUMxiRI+gagzTQ=
X-Received: by 2002:a05:600c:2113:b0:3fe:dc99:56ea with SMTP id
 u19-20020a05600c211300b003fedc9956eamr1521143wml.19.1693392781797; 
 Wed, 30 Aug 2023 03:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOf9GUUMyEUTwo5QPloDET4K9DmsMR0US5ksjwASpeJFM0Y8KFqLf2vC0vqKV2t7pGHCNmYw==
X-Received: by 2002:a05:600c:2113:b0:3fe:dc99:56ea with SMTP id
 u19-20020a05600c211300b003fedc9956eamr1521134wml.19.1693392781491; 
 Wed, 30 Aug 2023 03:53:01 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-145.web.vodafone.de.
 [109.43.179.145]) by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b003fc16ee2864sm1929834wms.48.2023.08.30.03.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 03:53:00 -0700 (PDT)
Message-ID: <740c7ad9-1c6f-ec7f-29d5-153bfc5f68ab@redhat.com>
Date: Wed, 30 Aug 2023 12:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 00/67] Make pixman an optional dependency
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 30/08/2023 11.37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> QEMU system emulators can be made to compile and work without pixman.
> 
> Given how pervasively pixman types and API is used in all the code base, it was
> a bit difficult to figure out how to cut the dependency.
> 
> I decided that it was important to keep VGA and graphics device working for
> compatibility reasons, although some devices, such as xlnx Display Port, have
> stronger dependency and have to be disabled. The ui/console code also has a lot
> of pixman usage and a bit of a mess to deal with. I made large refactoring to
> allow to compile out the VC code.
> 
> The series can be roughly divded as:
> - a few related preliminary cleanups
> - ui/console refactoring to allow ui/vc split
> - add a 'pixman' option, and a minimal pixman-compat.h
> - make some parts depend on 'pixman'
> 
> Graphic -display still work, although with some caveats. For ex, -display sdl or
> cocoa don't have VCs, so starting QEMU will print the following warnings when
> pixman is disabled:

I just had a quick look at the series, but for me it looks like this is 
adding a lot of additional complexity to the code (adds lots of #ifdefs, and 
adds a subset of the pixman library to the code base), which seems somewhat 
unfortunate for such a marginal feature request. What's really so bad about 
requiring pixman for building QEMU?

IMHO, if we really want to go down this path, I think we should rather 
disable all graphic related stuff in QEMU instead, i.e. disable VGA cards, 
Spice, SDL, etc. completely. I think this is also what has been requested in 
the original gitlab issue ticket where the reporter wanted to compile a 
text-mode only QEMU binary...?

... just my 0.02 € anyway.

  Thomas


