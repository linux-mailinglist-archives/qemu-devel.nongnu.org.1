Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0947221B7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66A1-0006n8-HZ; Mon, 05 Jun 2023 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q669z-0006ma-3L
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q669x-0006ql-J8
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xj5pRMgomivuZ4JRliWWOHPOxy2+nGLXwuPnUJMUpsw=;
 b=Eja2pxBLXfE142LHMoznnSIRflMyrVeSXDb3eX2mtbuCPfyV+VkEMTkqNyFLPIDo16Sig6
 Fh/tEyFnE2qL4VTJjlRp6QNjciadnVMfkN4GX40LtXFoU+drSqXJtjZscIvYFa5BJ+jhEy
 YlxNJmz5op5DRUIC2NBYSKrwp6hs4ZM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-lnDT90HdO_ycmx8aun84BA-1; Mon, 05 Jun 2023 05:05:51 -0400
X-MC-Unique: lnDT90HdO_ycmx8aun84BA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9715654ab36so326012066b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685955950; x=1688547950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xj5pRMgomivuZ4JRliWWOHPOxy2+nGLXwuPnUJMUpsw=;
 b=VdcaH+pwqrONBdyg83qAbhPjNDEkOYevQuhpNwbwlQuCCxLlcdGezYUqRZISeMXJeO
 Fr0/SPYazcWAd80sVZg98yXfjpkZSt3E2P3JC6ZaAeXB/vO17vgSefm/lYwqzpHUahIo
 VGRzTaU7KKs+rY5JWNo8R/d+B6D4cvKyMDKeNbRen1D1zwtBPwJpqmH6CqXdTsDBAHkO
 BvEvlytD+zDd1kvT0azZy4eMVqXHpj40yLOl2DqUk0U9hG+G1+IUkwcD37spiklIW0rx
 90B5BFRLMLnbL4fpBQsnv8zQDklSXsE5vyHdDmQojfZBXwCOIrgKDat8/HuCl7PSwXK4
 lZpQ==
X-Gm-Message-State: AC+VfDxIc9aNcLWEfWmob13+CUvqgZW95Ne/qkF3MoCSBWePPJJnMO3/
 n3HNGsKX0kiFRjHvuzD4hyDiwTekZndRpKnHtfw1Bm/bDRqD7+6aXabgcvg/e8Y788vkA4YdopF
 HIQV8KMltVBmdlro=
X-Received: by 2002:a17:907:9496:b0:966:61b3:f630 with SMTP id
 dm22-20020a170907949600b0096661b3f630mr4593247ejc.9.1685955950400; 
 Mon, 05 Jun 2023 02:05:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zo7WD3m90SW/m0roDyflsjuaDrFHzzxMSbTLDFzflLLnRvec+giA//XRgeupamD/U/ulHKA==
X-Received: by 2002:a17:907:9496:b0:966:61b3:f630 with SMTP id
 dm22-20020a170907949600b0096661b3f630mr4593238ejc.9.1685955950137; 
 Mon, 05 Jun 2023 02:05:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 v13-20020a17090606cd00b00977da0f14ffsm1104254ejb.171.2023.06.05.02.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 02:05:49 -0700 (PDT)
Message-ID: <a6fc91db-a4e3-e9b7-ee51-d07cd4982f02@redhat.com>
Date: Mon, 5 Jun 2023 11:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-trivial@nongnu.org
References: <20230605082748.53989-1-pbonzini@redhat.com>
 <4352552f-67ba-b964-7a7e-b13c9b19a27c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <4352552f-67ba-b964-7a7e-b13c9b19a27c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 10:47, Thomas Huth wrote:
> On 05/06/2023 10.27, Paolo Bonzini wrote:
>> Queued, thanks.
> 
> Please unqueue it again, I'm still seeing some issues with the patch 
> (not sure why yet):
> 
> https://gitlab.com/thuth/qemu/-/jobs/4411089009

Yeah, noticed that myself now. :)

Paolo


