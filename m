Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3F79C773
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxOM-0006RP-8P; Tue, 12 Sep 2023 03:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxNj-0006Ap-45
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxNg-00089L-Vj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694502014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAhVA3cOOkGyxceuHMBNs63YeidbEdDXmF5olHlLYJI=;
 b=cJv26gn8og9/syHuRd+wQDrsVpz1dNfAAKP9hoN+KNM9Xwj3NoiUhMGuKqi+2yzm0UVd7y
 KJSaXkXFf8Bkej+ojSMbf7IeiFySQgNqJWAo1gkYZYZ75fyCExGBNseK8vNTRixgpzTHmb
 KVJ6quqQ6JXz+4mAoVidaj88vjWIpu8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-wAVq1JcUM-Kdwam_2s3bpw-1; Tue, 12 Sep 2023 03:00:13 -0400
X-MC-Unique: wAVq1JcUM-Kdwam_2s3bpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso25311875e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502012; x=1695106812;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lAhVA3cOOkGyxceuHMBNs63YeidbEdDXmF5olHlLYJI=;
 b=i1WrI5JZ4xptR3qA6O43uI6H4WVsSspRso2O+fITCN9QzapBXM4HDdjcvLvaJbFaFD
 yeltpPzONth4iVLZO6oVtfMF9Q/hYpOzLLytcbc/daJu5qWQBQ8/tIqMiCw6K2JwOKpr
 IE28oD5JiAB59CmuEJUCBHzOCD9tFYRzY5nQ4k38/frstFzRK0mloi5CHbYpsqa2j1mL
 ndwwQE+t61+W592+OWFDy2QKqFI//woL9XiCIovxvOQ/F45mk3/96H/7sdIgJm8y1OWF
 A6TLWyg/CZPlK8fMGGSbj7Q/dGHxS/uEHNRQUh7K0elTaQXMsn67z83/olJwTAdIAvRZ
 6TzA==
X-Gm-Message-State: AOJu0YxDL0kze94NNR0f9DkpF3C/9YvNKVhLG9iSNaMbZ2pZjyoaTa12
 ow/GUn5O6BoBXpXXtP4BJPkY+5k9No3jPXdAtM6L5Puygbhr9nPYhxw/eF/gIiLPlQUJfil+e+I
 Yk14L7RPUvdtenXM=
X-Received: by 2002:a05:600c:3b04:b0:3fe:d67d:5040 with SMTP id
 m4-20020a05600c3b0400b003fed67d5040mr1261672wms.5.1694502012087; 
 Tue, 12 Sep 2023 00:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTNGMm5mL8XzSQkJ09t26Yf3efOYuleJBox1VzFRnzKbwe7JYhRBBPMWC2+ZT7+pJJrgpVaw==
X-Received: by 2002:a05:600c:3b04:b0:3fe:d67d:5040 with SMTP id
 m4-20020a05600c3b0400b003fed67d5040mr1261653wms.5.1694502011674; 
 Tue, 12 Sep 2023 00:00:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9?
 (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de.
 [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003fed8e12d62sm12096111wmm.27.2023.09.12.00.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 00:00:11 -0700 (PDT)
Message-ID: <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
Date: Tue, 12 Sep 2023 09:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 12.09.23 04:11, xianglai li wrote:
> Introduce new function to destroy CPU address space resources
> for cpu hot-(un)plug.
> 
How do other archs handle that? Or how are they able to get away without 
destroying?

-- 
Cheers,

David / dhildenb


