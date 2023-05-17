Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6881D706F26
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKjq-0006mv-GD; Wed, 17 May 2023 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKjo-0006jB-02
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKjm-000642-JA
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684343693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsCler1ymSUdlCyB+s8I6e/eCiI2pZeq5O1Qx4xNk5c=;
 b=DZGlP8vRVQxbeKjvZo9Zc5wiJmo2lSIOZwi6ya4ZIDZ7z/t2mYjmaC7RD2CE8oJwlK1zjy
 rh5oWNsu9kDRaS4fAKygewMAvEhVGHe6Phq1oimTrscbS+ZnW6bJxQPfEc5cfPSjwksQWd
 A2PhJ0V/dJn3YgP6EL3ZX8XbbDTvqLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-uocDmgsPOJKC4SbWCN-LRA-1; Wed, 17 May 2023 13:14:52 -0400
X-MC-Unique: uocDmgsPOJKC4SbWCN-LRA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f33f8ffa37so4193035e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343690; x=1686935690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OsCler1ymSUdlCyB+s8I6e/eCiI2pZeq5O1Qx4xNk5c=;
 b=gwlIi38zo2gbhPvmfkIMfrq8cgWvD79vV+BiHkXa42A6hAzAP9fq0uAOEC0zpEAGTi
 2FIf/zB1daWiX52H1xSeKl+n456lVwE3gLgGmc/GRjsPZ4dUrL2RybbfwHwJQ1YfpLJm
 xaEisA/04hYIyiTtNVZUb6KQ8bkZSDSQKKoCKU6m18bKTS+eNgKw82y3DbTcTsP+oob7
 7AqNFjhchIzDEU7vk4bXNfktFGpPBETte3DatjgkFikKHlyvGGtbOKib4XZNLQ3URSCu
 w7jghf0i/H4JMz0Kim9qrQ6DZBUJJrj0enG4c2KoI6pbQ6DbbP4em903Eo8hiejj0VH8
 2Bog==
X-Gm-Message-State: AC+VfDyQdo0cJ3DqBqq4T96OMxMV2992Sb8nTYzBUkonCNsqGFiWuKi2
 ozJQhqXIy9QO86RPGQS8AEMsaUBR/pSTkLC+kgLuWDtJAz+oqBVATZGToI5knlvyqyhV5vYoNPl
 i4vBRGhaILVVnM04=
X-Received: by 2002:a7b:cb91:0:b0:3f4:e70c:219f with SMTP id
 m17-20020a7bcb91000000b003f4e70c219fmr15073865wmi.6.1684343690324; 
 Wed, 17 May 2023 10:14:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bwdjjRwstQcESLF5nQ5josOxJZa/nhdJbVrFULSXe3J4HPGkWvuRob/VhUAy7LuWRtXlNzA==
X-Received: by 2002:a7b:cb91:0:b0:3f4:e70c:219f with SMTP id
 m17-20020a7bcb91000000b003f4e70c219fmr15073850wmi.6.1684343689971; 
 Wed, 17 May 2023 10:14:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 t1-20020a1c7701000000b003f4e4f51f64sm2835557wmi.7.2023.05.17.10.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 10:14:49 -0700 (PDT)
Message-ID: <053b071d-9a57-f4c5-b2bd-c2b26ff67c52@redhat.com>
Date: Wed, 17 May 2023 19:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qapi/parser: Fix type hints
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com
References: <20230511111709.971477-1-armbru@redhat.com>
 <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
 <87sfbwx339.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87sfbwx339.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/16/23 07:22, Markus Armbruster wrote:
>>    File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
>>      def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>> TypeError: 'type' object is not subscriptable
> Life's too short for wrestling with such pigs.  Unless John has better
> ideas, I'll*remove*  these return type annotations.  Maybe these pigs
> will behave after John's Python venv work lands.

re.Match[str] is new in 3.9.  However, typing.Match[str] should work.

Paolo


