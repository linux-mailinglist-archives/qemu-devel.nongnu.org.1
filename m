Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1E76037E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 02:03:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO5UL-0000n2-OQ; Mon, 24 Jul 2023 20:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qO5UK-0000ml-Jv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 20:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qO5UJ-0001GX-5T
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 20:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690243273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGMLgvPQ9oVQ5a58eOnstHWba90xgOfCvkrBdng9LSo=;
 b=Lb+8gCY96SQNpmSqMByCLLeyO34+uJbrzQB5Fb/Iw94FYLjIyGPorX1fEl8eNsCn5NmWkA
 2WIHlCXw0DLqfovkLs3J+Ta5yJEWGEgYFjVBzUh0Y9gcYMxJlrqsSvPpcY2XGaJoBLdixm
 2AB26YHeU8hY5uAYC/SQb+IzIHU9IFc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-vT_ZMitBOlqQ-UIEvR4-4A-1; Mon, 24 Jul 2023 20:01:11 -0400
X-MC-Unique: vT_ZMitBOlqQ-UIEvR4-4A-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3a44fae8668so10469192b6e.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 17:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690243270; x=1690848070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGMLgvPQ9oVQ5a58eOnstHWba90xgOfCvkrBdng9LSo=;
 b=auzdeNK4kWUc/BLHpmupskBQJTBrlgtCNQ+emlsaBsoV77+w7Hsq+mTpgulkWwdCEs
 4wqqXAlWm/m3NMGdnqA84SayhTamyXim1Ndo3eujvomMEVspgH/cIhwYo8mYSS2O2MLe
 lq7Aq211s5PJbDDdb1K9q45a7QjVwCqOEtCMvjk3Pktyp5/RZlwVVPJING4j3PmzNoA8
 92dlPgDbENb46Ho9eaQENBW7RWyv+ZGOwebkDvPGf5MhsvaaT5QUVhwlt8ilERnXHtYx
 oGS0OePH4zqcu99M6oHCM2lXxB/VBbC9t8PBNMQwKhAt2Y8p5Hs4lz1uf5fM/4pVsrR9
 M4XA==
X-Gm-Message-State: ABy/qLYVkqTZUZOCTHS8DtktVeFEXFgdvuCcasimtgGad68BhHMGRQPw
 ycO2t+/hmgT4h7hCGap09psoLEfRLqulLLr5ZIicW9PmU82IFFWg/+8cgrgV1G7Kvt8dYT+VLhp
 GqIsq98EDaCDsaQ0=
X-Received: by 2002:a05:6808:1818:b0:3a5:afdf:8ebb with SMTP id
 bh24-20020a056808181800b003a5afdf8ebbmr6830760oib.17.1690243270257; 
 Mon, 24 Jul 2023 17:01:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFu3NnsE3XLXcJopkwLRAi4e/BTrUxK7AmsrBhX79A1EvKKi/DteHzm3DR+T9FjEBnI40I8kw==
X-Received: by 2002:a05:6808:1818:b0:3a5:afdf:8ebb with SMTP id
 bh24-20020a056808181800b003a5afdf8ebbmr6830750oib.17.1690243270053; 
 Mon, 24 Jul 2023 17:01:10 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a1709029b8700b001b89045ff03sm9565456plp.233.2023.07.24.17.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 17:01:09 -0700 (PDT)
Message-ID: <4a990b57-800c-6799-8c23-4488069ffb76@redhat.com>
Date: Tue, 25 Jul 2023 10:01:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.2 2/2] arm/kvm: convert to kvm_get_one_reg
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230718111404.23479-1-cohuck@redhat.com>
 <20230718111404.23479-3-cohuck@redhat.com>
 <db578c20-22d9-3b76-63e7-d99b891f6d36@redhat.com> <878rb5g0f0.fsf@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <878rb5g0f0.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 7/24/23 18:48, Cornelia Huck wrote:
> On Mon, Jul 24 2023, Gavin Shan <gshan@redhat.com> wrote:
>>
>> On 7/18/23 21:14, Cornelia Huck wrote:
>>> We can neaten the code by switching the callers that work on a
>>> CPUstate to the kvm_get_one_reg function.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    target/arm/kvm.c   | 15 +++---------
>>>    target/arm/kvm64.c | 57 ++++++++++++----------------------------------
>>>    2 files changed, 18 insertions(+), 54 deletions(-)
>>>
>>
>> The replacements look good to me. However, I guess it's worty to apply
>> the same replacements for target/arm/kvm64.c since we're here?
>>
>> [gshan@gshan arm]$ pwd
>> /home/gshan/sandbox/q/target/arm
>> [gshan@gshan arm]$ git grep KVM_GET_ONE_REG
>> kvm64.c:    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
>> kvm64.c:    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
>> kvm64.c:        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
> 
> These are the callers that don't work on a CPUState (all in initial
> feature discovery IIRC), so they need to stay that way.
> 

Right, All these ioctl commands are issued when CPUState isn't around. However, there
are two wrappers read_sys_{reg32, reg64}(). The ioctl call in kvm_arm_sve_get_vls()
can be replaced by read_sys_reg64(). I guess it'd better to do this in a separate
patch if you agree.

Thanks,
Gavin


