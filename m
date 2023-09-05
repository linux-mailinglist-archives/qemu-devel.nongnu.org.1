Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA3792200
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTjB-0003Ip-V6; Tue, 05 Sep 2023 06:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTj6-0003IH-It
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTj2-0007ZM-CU
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693911363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JfNd+iTX3VoLrEVRVi0H1UohDpK1DEnxbGYtgu0rB8=;
 b=SpS0liLQakT9SF2yv3YaIzbx6LopSVQ/KGZZUcYS/ojNCrql9J3+sUju2APqEIyulnT5Ae
 3EzPKV1xOen1mIiZYr0F8edVa/Z24+7bus9n4wYK6BTHqcuBGebbldzRh7ehIoAn9FsMYX
 Vx0oKXQggBvFQilkKDhrMq6IinIgVPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-bn_pkGMsPw6eH3KbUInVOg-1; Tue, 05 Sep 2023 06:56:01 -0400
X-MC-Unique: bn_pkGMsPw6eH3KbUInVOg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f49c34d1fso893571f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693911360; x=1694516160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3JfNd+iTX3VoLrEVRVi0H1UohDpK1DEnxbGYtgu0rB8=;
 b=mI4boX3BCFMnhPZvsjVoBbp798a/6LcnGEY/V0RO51DJq/inttEtzNMS51popZRxS8
 cOm5WO7nxwbL57KjrFsx31NATHok8zNmyDbaXhLb8Lp+EZ+QkUAMDARNy6VHyeBkJEs2
 JiRw91nMAVKUsSEIW4J14dqQamFtj2alyoxX43VJdjTC+GhdyCVkkcttwMw4WqDugl85
 doo5cpct2BvMWmCOwB4RjtQcgYHvDLtaLZnfkP8+OgdHNTR14kA4dq644mHxj9EdsV6N
 Pis1f7eQp6EeIBxElQP7z3k3H4GPHBRFJYz0V+hV3NFqHUfTNkjdL4nvPZSs+mNdHNFS
 wBtw==
X-Gm-Message-State: AOJu0YxrGGH7jthhnIFGEbDuzWFjm840BqpU7RJf40mVyW5syGsGa5yU
 rw7NVTWmxpjGKosPPdjIiLtimH/mEtBLBgwpLefg4oe36T+LwbkVc7E1D35A0kc0oK/Zdhg+NIt
 QcGt5oB16gR6YVZ8=
X-Received: by 2002:a5d:6a47:0:b0:317:6263:1ae2 with SMTP id
 t7-20020a5d6a47000000b0031762631ae2mr8753988wrw.63.1693911360065; 
 Tue, 05 Sep 2023 03:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzQ25BjKqPT6EXm/XvvYrYCMbM1/ykbTLr2lZsuZKBBoBXaElNf9Uhm2xl5wYbd2d1Q0I6A==
X-Received: by 2002:a5d:6a47:0:b0:317:6263:1ae2 with SMTP id
 t7-20020a5d6a47000000b0031762631ae2mr8753977wrw.63.1693911359753; 
 Tue, 05 Sep 2023 03:55:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 x2-20020adff0c2000000b0031971ab70c9sm17157635wro.73.2023.09.05.03.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 03:55:59 -0700 (PDT)
Message-ID: <4c044b4c-87cd-c81b-6d4e-e7c8b8622098@redhat.com>
Date: Tue, 5 Sep 2023 12:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] audio: remove QEMU_AUDIO_* and -audio-help support
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230905101944.307701-1-pbonzini@redhat.com>
 <12deb1fe-5a9d-ba44-8867-62f674ecfdf4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <12deb1fe-5a9d-ba44-8867-62f674ecfdf4@redhat.com>
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

On 9/5/23 12:39, Thomas Huth wrote:
>>
>> +        dolog("Device %s: audiodev default parameter is deprecated, 
>> please "
>> +              "specify audiodev=%s\n", name,
>> +              QTAILQ_FIRST(&audio_states)->dev->id);
> 
> You said that you removed the default handling ... so this log message 
> looks suspicious ... is this code block still required?

I was referring to the ".can_be_default" argument, maybe I should change 
"default audio backend" to "default audio driver" in the commit message? 
  Unfortunately this code (which is a separate entry in deprecated.rst) 
cannot be removed because of non-qdevified soundcards.

Paolo


