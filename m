Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92073B836
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:51:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgGF-0005Bp-TJ; Fri, 23 Jun 2023 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgFz-0005AU-5S
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgFx-00021C-J2
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687524677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgAlc3sG2W+S9oUKWzHXDkQlvyR9ZL1B+1JLZ5SUzLY=;
 b=BVnYK+cfSlGZiqOsFwx4dHANEOshQGSzrvC/cIGpJ7guvCIRQydf9FLdzLy7sYz4HZcpxN
 U/YIsHiagjMelj8rSgc6dbyOajvBOunougnUfz5rQY2y/JR5nADZ/wEilrGTt8m+hFKawu
 OpEWrbHoMcROZTlUAFMcQFCrfwPDxhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-BiM_Uv5fOHeVDe4QU96mQw-1; Fri, 23 Jun 2023 08:51:15 -0400
X-MC-Unique: BiM_Uv5fOHeVDe4QU96mQw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f8f9b50f17so3876365e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687524673; x=1690116673;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgAlc3sG2W+S9oUKWzHXDkQlvyR9ZL1B+1JLZ5SUzLY=;
 b=loqqNNB8JoVI5YDybpNr0mDBNtlQnuwL1/FG/VgAiXQrUXx/V5iUuhtLpDJ9fmBMH/
 9az5WQoE6m+zRm0c9/+3WpaAifSMnb1sV4todjpgt9BVe3z40yTYqKaCnHgs0d9fhz0R
 4cZ2rAHzbjHmUnaoALStRLVQ4r6mtFMe9PlGre92zl46horZuwDQJ4eEmFb2n+MmA9X9
 ga8UQIUyRFf9vLUBxhtx9oDUm01sf4p5rpNrcwTs7mFRXDIADSyPEz6vHjIucPRxdInZ
 vQqTWaxrERw98hEz0MGf5esyyJKJkfwShMqxr20iP2Ygr8TzrmXa6D9RgXehihuU1Tmk
 PNUw==
X-Gm-Message-State: AC+VfDzFIphtxRSmh0+c+NUXeST8HR/WtPIRMgPPr69kh5CyVb6v8Ktv
 yYQIKdCAKcU9XGLhQJ3+6uNbatDpS9dQ9A1OP38XK/8tF0JtQb6hKA6rZLY05sssZvSNbPLph8A
 7Bza8LpsaxlT//MzremPGDvps7Ob38O3psXim3GIuUX1fVH7/dMIDAF8YYLCgR0aXH1RGdEk=
X-Received: by 2002:a05:600c:284:b0:3fa:7dfc:411f with SMTP id
 4-20020a05600c028400b003fa7dfc411fmr911184wmk.23.1687524673503; 
 Fri, 23 Jun 2023 05:51:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WGCDahjAg7K4BuaHwk6XJYsJxv7B8577mpKrWg5O5/PJ7hrDhpQTjcOodh6QV7QzSNQoksw==
X-Received: by 2002:a05:600c:284:b0:3fa:7dfc:411f with SMTP id
 4-20020a05600c028400b003fa7dfc411fmr911166wmk.23.1687524673129; 
 Fri, 23 Jun 2023 05:51:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:1700:9783:58ba:9db:1221?
 (p200300cbc7291700978358ba09db1221.dip0.t-ipconnect.de.
 [2003:cb:c729:1700:9783:58ba:9db:1221])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d5187000000b0031128382ed0sm9488345wrv.83.2023.06.23.05.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 05:51:12 -0700 (PDT)
Message-ID: <39b97e00-fb3c-29b2-aa1f-1de4c8094899@redhat.com>
Date: Fri, 23 Jun 2023 14:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] virtio-mem: Simplify bitmap handling and
 virtio_mem_set_block_state()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Shan <gshan@redhat.com>
References: <20230523183036.517957-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523183036.517957-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 23.05.23 20:30, David Hildenbrand wrote:
> Let's separate plug and unplug handling to prepare for future changes
> and make the code a bit easier to read -- working on block states
> (plugged/unplugged) instead of on a bitmap.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

I queued this to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


