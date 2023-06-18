Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D77348AB
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB07p-0007Qp-IE; Sun, 18 Jun 2023 17:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB07k-0007LR-TZ
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB07h-00047E-B4
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687124388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DPo8RImprXjsrua5byGSHCKYJkXN7XK2Zm4JbAl6ck=;
 b=Fi8HjO6TwaQM7KbdliPxeoCTEc49H0VyGmUkccpITNmTmsKOVRe7x9yaf48/HUFhuk4BTC
 xmafFum8BXbjnMxY74SMiZDYNzQbhqh8TR/guftXqvzHJAvB+fron7zZeG39X2J7i2TPzN
 9EFhROhnww0c2mQd9z5+s12+gp3ngUM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-ZzR5yDXhPQOwGVkRUZHkrQ-1; Sun, 18 Jun 2023 17:39:46 -0400
X-MC-Unique: ZzR5yDXhPQOwGVkRUZHkrQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b46d5db8daso4347021fa.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687124384; x=1689716384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DPo8RImprXjsrua5byGSHCKYJkXN7XK2Zm4JbAl6ck=;
 b=VcSfRVF2TEzznW/orF/FgOmekFAd1D/4AB7cHJlwy1dxk1S0T78jQ6dc+9Ev2tIAnq
 cPepuG4CEf9E8nknEIx0cVHH8689VEposFrgv9pyQxpNg6Ub/2lJeTawU8YS4kE6zHD1
 QChmAlPNkFuvgHn3NZYPEctKfHYHXZaxSkGc94iBplzQPjPC4YjtesDT1APdOxFmlB+b
 McSNDYFeKsIAspzIMy2IuHJWCnl6sSnqZkWIT8mWZzziOJjg3V2edEm2rIc1arsuI8+9
 OO2r/1//5SB6fVXPTQ12KHBYHBiq/I6wDPyZrE4zmzBP/rdU+WHNfr5Ur769Q+pyTMhQ
 w26w==
X-Gm-Message-State: AC+VfDwZDaX3t4es3U9hFRVjMY19rWgK3zdy9jmour73OHIIemZGq27c
 c3/Jlb4TBoN7tJX57IcF2a6tYjLq5v4HGV9tSXeWVbGi2FIjbhfPHp466qf218r5Ux5fwkPfrmv
 9A196X3CxALG0IhE=
X-Received: by 2002:a2e:b616:0:b0:2b3:781b:e00d with SMTP id
 r22-20020a2eb616000000b002b3781be00dmr4594243ljn.33.1687124384686; 
 Sun, 18 Jun 2023 14:39:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ijNdFUIpVQaCOdPaVD3ZIpBeRIsn89RaW6WkrE4tdbl9DLmdKSD31E8s4qmAB1kh5exdF8Q==
X-Received: by 2002:a2e:b616:0:b0:2b3:781b:e00d with SMTP id
 r22-20020a2eb616000000b002b3781be00dmr4594234ljn.33.1687124384263; 
 Sun, 18 Jun 2023 14:39:44 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.googlemail.com with ESMTPSA id
 sb24-20020a170906edd800b009887478cc88sm1357438ejb.177.2023.06.18.14.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 14:39:43 -0700 (PDT)
Message-ID: <2013bbae-3bdd-df61-9e4c-b0c9dcf8b5a9@redhat.com>
Date: Sun, 18 Jun 2023 23:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] kvm: reuse per-vcpu stats fd to avoid vcpu interruption
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mark Kanda <mark.kanda@oracle.com>
References: <ZIiz8R3F76VqTmKO@tpad> <87h6rab8gv.fsf@pond.sub.org>
 <ZIyffW2qasdS4PVN@tpad> <e3705cba-d57d-27f7-aa1e-ad4a3c0bfe52@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <e3705cba-d57d-27f7-aa1e-ad4a3c0bfe52@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/18/23 01:00, Philippe Mathieu-Daudé wrote:
>>       case STATS_TARGET_VCPU:
>>           add_stats_entry(result, STATS_PROVIDER_KVM,
>> -                        current_cpu->parent_obj.canonical_path,
>> +                        cpu->parent_obj.canonical_path,
> 
> Can we get a NULL deref here ...
> 
>>                           stats_list);
>>           break;
>>       default:
> 
> 
>>   static void query_stats_cb(StatsResultList **result, StatsTarget 
>> target,
>> @@ -4180,7 +4180,7 @@ static void query_stats_cb(StatsResultList 
>> **result, StatsTarget target,
>>               error_setg_errno(errp, errno, "KVM stats: ioctl failed");
>>               return;
>>           }
>> -        query_stats(result, target, names, stats_fd, errp);
>> +        query_stats(result, target, names, stats_fd, NULL, errp);
> 
> ... from here?

No, target is STATS_TARGET_VM here.

In the kernel, KVM_GET_STATS_FD could also be improved because it does 
not need to take vcpu->mutex.  However that would not be enough; it 
would require QEMU changes anyway to remove run_on_cpu.  So I'm queuing 
the patch, thanks!

Paolo


