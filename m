Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A17399C2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFi5-0001e7-Ar; Thu, 22 Jun 2023 04:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCFi0-0001dy-3s
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCFhy-0002iR-F7
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687422625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3NKcMGzQM01Aey/IQ9VHOpDjI2KdV2iP+oD7E3HnY0=;
 b=VunkxD6ZOE8KV60cflne40r78Qdmd4KUzfwd7QW+uBXfxv3VafX+TkTYU9cKV6ehmBCUir
 aSPZtwTrKY9RIRkRXOV8IuhNRqi/aaq/YdiNn4ZacICi4JpYbfgABJGyg/GZ0xDv2QcktQ
 MCHQSndjXWIrJJxmjzBVE17f7gMrtNk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-lMjNqzaiOTGmeWlZ2_Gw4Q-1; Thu, 22 Jun 2023 04:30:22 -0400
X-MC-Unique: lMjNqzaiOTGmeWlZ2_Gw4Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso484483566b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 01:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687422621; x=1690014621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3NKcMGzQM01Aey/IQ9VHOpDjI2KdV2iP+oD7E3HnY0=;
 b=WLDk1Iv1QWKrr+sEO+TYkK7qAc6+sIWFkoI/1Tdo62+qEJDb6/NL0JsgHAnkkWp014
 nuEPgmDh0TdobifCmCdRQIuzlHBZHKjxI8QQAyOOBFoUSkz9a4gvMkQqM/jiym6/QHLX
 c+rvZUXjx16lVl91XwBb6BkEm/4rEgr0LWZfa5tUIEmktGSNxCRQuNYM0tDqn9XkVvTL
 3QK/BjApqE2nBG7dr4F9Sq3ieJUhLlsbHzLfU4/5trJ0EZekvOal2giBCDiGItCY0yu7
 aODAHkFoLO50Uk2pGDL8CDk/ZCxgnPe0mir84r+EDiCp0zXsXHLbBps6lK9+crRg1RKc
 6ZOQ==
X-Gm-Message-State: AC+VfDzX1yb8/Okad/5lZfkzGB0toAszNKP0S7Y044cA9z3pvcEDPAnY
 B7eWjmmWORAsQ7USdp70NoVhGacdeZdnRZZ6ah2kfF6KdbKWxUPGgbJncxy6zipqkZ6fpGfJor5
 UwMyRuyo4t3itkBI=
X-Received: by 2002:a17:907:5c8:b0:974:6de:8a5e with SMTP id
 wg8-20020a17090705c800b0097406de8a5emr16079305ejb.40.1687422621351; 
 Thu, 22 Jun 2023 01:30:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+YsOBXu8Z0PrTaIi0ZVBWa/5YjRZc3EL824T7LLPfUSpXgIN+CtasMiHJVt7eLk/XO0rSZA==
X-Received: by 2002:a17:907:5c8:b0:974:6de:8a5e with SMTP id
 wg8-20020a17090705c800b0097406de8a5emr16079275ejb.40.1687422620970; 
 Thu, 22 Jun 2023 01:30:20 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 z17-20020a1709063ad100b009821ce1ea33sm4305354ejd.7.2023.06.22.01.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 01:30:20 -0700 (PDT)
Message-ID: <ba2adea2-37a7-bb84-8df0-519eef4ac120@redhat.com>
Date: Thu, 22 Jun 2023 10:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
 <e715e41d-b50a-3747-8007-e188e911a724@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <e715e41d-b50a-3747-8007-e188e911a724@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/21/23 09:08, Thomas Huth wrote:
>>
>>           if (strcmp(incoming, "defer") != 0) {
>> +            warn_report("-incoming %s is deprecated, use -incoming 
>> defer and "
>> +                        " set the uri with migrate-incoming.", 
>> incoming);
>>               qmp_migrate_incoming(incoming, &local_err);
>>               if (local_err) {
>>                   error_reportf_err(local_err, "-incoming %s: ", 
>> incoming);
> 
> Could we maybe keep at least the smallest set of necessary parameters 
> around? I'm often doing a "-incoming tcp:0:1234" for doing quick sanity 
> checks with migration, not caring about other migration parameters, so 
> if that could continue to work, that would be very appreciated.

Yeah, this is throwing the baby out with the bathwater.

Paolo


