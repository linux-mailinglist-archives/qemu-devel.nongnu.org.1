Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608747ADD53
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoeI-00075Y-TT; Mon, 25 Sep 2023 12:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkoe9-00074p-H5
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkoe7-0005P6-U9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695660078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIWgrMFpAdp5+hUdjD5HjV9ba6wuYdR0ydWBNHxwUUU=;
 b=CQLF0JGbQ+EDA5aGSqAZZfTlKQHmrsrggZVy0VrK8SXmLYbuoZWM7UIdOlhqw51FV4qsNc
 OM4jggCzRmBhKIME7RMdCBvOnV5wK+Esn2SjEIyNzNZPF28MHNxbrMGJpif5CnzHqeXi+6
 VgRmF4ukTT+hJzthiJAFzVgq9Kp3t8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-SbvE86sANb-LEKLBtRvUmg-1; Mon, 25 Sep 2023 12:41:15 -0400
X-MC-Unique: SbvE86sANb-LEKLBtRvUmg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31ff9e40977so5486032f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695660074; x=1696264874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PIWgrMFpAdp5+hUdjD5HjV9ba6wuYdR0ydWBNHxwUUU=;
 b=Ly1w2QfU4lxD33mgJHSDDZ3CwLhaX4XuT21QuTLMaPSXrrrmr5mUCPIHlSn7ijgVnb
 XqgBoTVI+QxJxMEVaonhfd7Tp8r2QEiE8lvdeEnPTN7xF09hINw/MfTHh72XfAsrkBYs
 2s3zDBkB2mI5YdtYHCOl1pjspD/5x9s/jckg1p4j9p1XFVcXJUS8oejJHEAiFr8COxJr
 a1Ch5CFhp0gOKBnprK+2LKQEAcfuj7lbEr6GV3ubWAoWsimittT/qBaFGvT2pffoiuOz
 +Yu+NNo2nIdZTXXNeCh1j9W0f6o7NElidS81HtSLlVzNue3OnHUkaPf1VXLKzGo8QQ4h
 dlEA==
X-Gm-Message-State: AOJu0YxYe0gozU+M8Llyf8YxhRY9QExtwz6GZOQsGMKzZnDOTf1pfM0q
 DtS+S3C6vzkGQWIu56mVWseM7sTX9DF9mh3X/t3KqJ7dzqFGh/TMTk1lGDJNDzqumNINqQF9YzE
 BrKQd8bRY75RlGJ4=
X-Received: by 2002:a05:6000:1c18:b0:323:20a7:94d with SMTP id
 ba24-20020a0560001c1800b0032320a7094dmr4259424wrb.50.1695660074368; 
 Mon, 25 Sep 2023 09:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm2s3LYHBl6Xj9WcRxxEyQxYDafZMVwRyjbemjRhTqBAWH/ioJxeuWKQlDQnKT9dG18JFSAw==
X-Received: by 2002:a05:6000:1c18:b0:323:20a7:94d with SMTP id
 ba24-20020a0560001c1800b0032320a7094dmr4259400wrb.50.1695660073987; 
 Mon, 25 Sep 2023 09:41:13 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 n22-20020a1c7216000000b003fee849df23sm12636110wmc.22.2023.09.25.09.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 09:41:13 -0700 (PDT)
Message-ID: <0e258375-e3a0-8b5d-189e-cb2cea913ecb@redhat.com>
Date: Mon, 25 Sep 2023 18:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 13/15] hw/qdev: Remove DEFINE_PROP_DMAADDR() and
 'hw/qdev-dma.h'
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230203145536.17585-1-philmd@linaro.org>
 <20230203145536.17585-14-philmd@linaro.org> <87zg1a8r5v.fsf@pond.sub.org>
 <87bkdq8qh1.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87bkdq8qh1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/25/23 13:03, Markus Armbruster wrote:
> +David
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> DEFINE_PROP_DMAADDR() is only used once. Since it doesn't
>>> add much value, simply remove it, along with the header
>>> defining it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> DEFINE_PROP_DMAADDR() lets you wrap a property around a dma_addr_t
>> member without assuming anything about dma_addr_t.
>>
>> Whether that's worth avoiding I can't say.  Depends on how much the
>> abstraction leaks in other ways.  Thoughts?

I think it's okay to simplify things.  If anybody ever has a reason to 
make dma_addr_t variable sized (probably a bad idea because many of its 
users are compiled once only) they have one extra place to fix.  Tough 
luck. :)

Paolo


