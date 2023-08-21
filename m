Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3A782487
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTt-00018D-SB; Mon, 21 Aug 2023 03:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTJ-0000JB-2V
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzTB-0006GE-TC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzYUfGOuphqn9e4ZFKIyYNQTV3zqWjd+dyPXUk/YQfE=;
 b=YDsjKK97sDHQ7SV2gWR8trF6fudeVonqaRfcyHIuvZKDqf0N1sN7F7dBttRaWA0GtXv0m2
 Pb4XETufFEeVHAMiHoi362rgS4BJ0TlQQHBLRzAlki6cy1Y+xoU7mYQv7fgMMKrf1nnfQc
 kr9YM7jiUgpoxDal8/JxoFh9/KBwsGo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-13O4UWnwMfyZHRuJ3twmsQ-1; Mon, 21 Aug 2023 03:35:02 -0400
X-MC-Unique: 13O4UWnwMfyZHRuJ3twmsQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3180237cef3so1807071f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603301; x=1693208101;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzYUfGOuphqn9e4ZFKIyYNQTV3zqWjd+dyPXUk/YQfE=;
 b=Uuf9BArhTDkkVTrqTkdNRrVTg6f01zB96lvMAcfYc91O5LeQSubPpO8zoYSkaGmXsm
 mRHmbbbk/WXTXMmWkxx7GKXBv6n+tjGpGcLfh8d3TijogY+VVfUZLq/6tG9WkNnFKK47
 MgRdP+qdM2wBvUiqfUbPGaUmkzR1mpeeERGPpXwrRjzO9rxagnfIdAeGF1nttQ1URz3U
 JVoNgolYmQfy29MAtFuQ2nfmXyBAn4UpqPhvjeisn0wVDZU3VHkvhn24ERhZRDRXuhFC
 7YBcmAV/DNF+qf3JwSlXKC3fqd02Ah0ybfeHWZzmQLwb+r5aqNmhwgKQuli6uNm24T/q
 yvlA==
X-Gm-Message-State: AOJu0Yxdv5ir7T9gHs0T19NmR0PgD94tQc/vk2d8529tzb3dOGA5SQG2
 FVh32uCfnIzkF81VOPPVaBgaqTC0VGKh34z+4cN6IX/J3TFhKE1+4CFGBRW9J2muX1l5PbyinsB
 MwvH6cLxDU2QSkfA=
X-Received: by 2002:a5d:4f0f:0:b0:319:89ce:da0b with SMTP id
 c15-20020a5d4f0f000000b0031989ceda0bmr4077084wru.68.1692603301451; 
 Mon, 21 Aug 2023 00:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgYNGjCPSQ95IPgoXUzYgu1Mj+NXewlBVcMuxP42mcRpRKd3l209sdwav9lL9fkI1mBfsQ6Q==
X-Received: by 2002:a5d:4f0f:0:b0:319:89ce:da0b with SMTP id
 c15-20020a5d4f0f000000b0031989ceda0bmr4077074wru.68.1692603301242; 
 Mon, 21 Aug 2023 00:35:01 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a5d62c1000000b0031ad2663ed0sm11333097wrv.66.2023.08.21.00.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:00 -0700 (PDT)
Message-ID: <94253d77-c914-525f-fa7c-3c6c9330f432@redhat.com>
Date: Mon, 21 Aug 2023 09:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/21] block-coroutine-wrapper: Allow arbitrary parameter
 names
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-8-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-8-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



Am 17/08/2023 um 14:50 schrieb Kevin Wolf:
> Don't assume specific parameter names like 'bs' or 'blk' in the
> generated code, but use the actual name.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


