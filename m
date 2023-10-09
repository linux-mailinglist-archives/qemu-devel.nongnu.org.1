Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F47BD6F9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmYi-0001zX-IS; Mon, 09 Oct 2023 05:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmYg-0001yR-Sp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmYV-00029c-9F
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696843682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSIrbJsyYrG2eUg4UdZwqIVA2L/cqv8wSMaWIdIe8lQ=;
 b=bniiLRtyAye/gqqJ8uzXMI8Rb6SmNa6PQ+yc2h3JktQ+r1AJjqKlhZEEoKgqZAiY4y3m7k
 c++FONr38KKeMnRjqJ9QJ5JQ/gKv9dGkQzePstr4PpSG26nN3u1imAkfmaTVP36IQCBjmR
 pzTqR7KItHA7sUdLUD44hYGgfXdMr+c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-r0hDtBhRNdK_Bn2FYuHoQQ-1; Mon, 09 Oct 2023 05:28:00 -0400
X-MC-Unique: r0hDtBhRNdK_Bn2FYuHoQQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-324810f3bfcso2268922f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843679; x=1697448479;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSIrbJsyYrG2eUg4UdZwqIVA2L/cqv8wSMaWIdIe8lQ=;
 b=hi1IiBJ3wdqa1QmzGBo+rWVe5JdLP3+q4VxKHEd5GljRwY/Yl0VwNQrex22nYy+2IG
 HBtwIQg+wHGeVd7l1PEowjho0lSlNlnntaFA8W/R5ghhfJI4Q0zl66GwNw2+rqCbp7v0
 DKsfG2EUg4nNnklPBJAl4Yl3IAWyJSMFlCQA3AQRre9r0nD2ZF07Oo8kQaRpPYSpfA6p
 NlBEqtrJii+69i+HV8YfHyMTIr6Y1TkNih+ybtLAR8lRVu8BVOm4QsUBkn97a+1HBJH8
 Wrq/9nhXUF7b6GWzQ5vLNurZodPa/CboXs5av7KGj8GC1vJ1XecmLwjsPRvGrPz4AGAl
 deLg==
X-Gm-Message-State: AOJu0Yy21fUSMvqSR6I4ObtjGdVRmMcPAwAd5SYa3LUk3EB/xt4Rt3T9
 BkBVgqg2+bb8wGRdnSYlLboadfpaIjLISUBXcHb/qGHzPvcnDg9zY/P4GdxRJurZcdujHQcwevy
 aYVI8rAPB8icieJ4vVXN6MNE=
X-Received: by 2002:a5d:4ace:0:b0:329:6b96:f7cc with SMTP id
 y14-20020a5d4ace000000b003296b96f7ccmr6874025wrs.7.1696843679592; 
 Mon, 09 Oct 2023 02:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCV4E4NvIOhxh2dop80WVRHyjWnyGykdxTSxqlDc6BMP1ReDQq82+LP82t9FdSIHrL28ND+w==
X-Received: by 2002:a5d:4ace:0:b0:329:6b96:f7cc with SMTP id
 y14-20020a5d4ace000000b003296b96f7ccmr6874002wrs.7.1696843679161; 
 Mon, 09 Oct 2023 02:27:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 c6-20020adfed86000000b003279518f51dsm9118347wro.2.2023.10.09.02.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:27:58 -0700 (PDT)
Message-ID: <699c964a-e9e3-4d80-6a81-f2ba2251666f@redhat.com>
Date: Mon, 9 Oct 2023 11:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: follow Error API guidelines
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20231009075310.153617-1-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009075310.153617-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 09.10.23 09:53, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Return true/false on success/failure.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


