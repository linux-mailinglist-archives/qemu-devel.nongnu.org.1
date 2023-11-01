Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407947DE26B
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:34:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyCHp-0004H8-Ia; Wed, 01 Nov 2023 10:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyCHZ-0004DE-LY
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyCHX-00021q-9Y
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698849198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iqR6ykz9MKyRyCWzJ2eOyu5y636YXCu6GuY0nTUs3U=;
 b=L9dxnD8d7pRcM0RUtcX5Q6jhNqf6vkAPJSeVckffBM3NboaNDTwf7pHgyqju8dWQPkt5Ys
 gILuh6KPdWCWRu/986F3F8pDmwm9X8aq4k//vTAtgMFNxWE+1/zkXAorvYOy9nflO9ekJZ
 +saM5BwHFnyvbGlF7ZnD01ADSXer4pc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-AGJL_AhCPTeJ75T-Z6iWNg-1; Wed, 01 Nov 2023 10:33:17 -0400
X-MC-Unique: AGJL_AhCPTeJ75T-Z6iWNg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079c865541so7730407e87.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698849194; x=1699453994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3iqR6ykz9MKyRyCWzJ2eOyu5y636YXCu6GuY0nTUs3U=;
 b=g+rCqsTA+UG3hP6zNKjyhn27sgzCJ6smFs52aDIf2I3LE2uoCOmziez9Urhp+aMlkG
 Z7DYrI811Gw4eOD3+O/dry0WoM5HAbbC6yw6WVLMOmQu2P3rbfbIH2QP3Gl/iwbdaw0p
 lP3smSkEm7sCCZ5ER6H7xztFOlA3dG8c5Ek++OaQ/+acn3nlR2V4/mx6y8CKSAExKqSC
 hfhyIl4yd7CSUHOuFIgoQj+vh57MFTI2M33BjJZZwtSIDcH7LoeA+ezdl3GiWZgsCHxL
 MobLxFW/LcXIwmWA1x8qTlTtE4XsSSgJIkTE+1B1nZbYWpQOC9ANgSPpyeYHP5wBkLOp
 H/xw==
X-Gm-Message-State: AOJu0YxkfNcQolAkhxUtsv+gTYWT11DMMvdGy1EWAxAIRxasVXTbQkxi
 G3YDdmhQ42gZPVJDtARINbg5eNW3v7+yqdT0V8foJ5JfOvKvWSWQOaf7zyIxETPZSmzLU4g64zC
 6u3K9fi3P97348K0=
X-Received: by 2002:a19:5513:0:b0:507:a8d1:6e57 with SMTP id
 n19-20020a195513000000b00507a8d16e57mr11070031lfe.40.1698849194567; 
 Wed, 01 Nov 2023 07:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8uyvVjiVCp9NnUlpsIlZswfORYzkQHUhLSWCBKC8znFg1VHln15rH2lfDk+Jd98av353BA==
X-Received: by 2002:a19:5513:0:b0:507:a8d1:6e57 with SMTP id
 n19-20020a195513000000b00507a8d16e57mr11070016lfe.40.1698849194216; 
 Wed, 01 Nov 2023 07:33:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 i22-20020a508716000000b0053ff311f388sm1163329edb.23.2023.11.01.07.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 07:33:13 -0700 (PDT)
Message-ID: <fe67a968-7f72-438f-8b6f-244707f943b9@redhat.com>
Date: Wed, 1 Nov 2023 15:33:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Add support for RAPL MSRs in KVM/Qemu
Content-Language: en-US
To: Anthony Harivel <aharivel@redhat.com>, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, berrange@redhat.com
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-4-aharivel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231031144605.64822-4-aharivel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/31/23 15:46, Anthony Harivel wrote:
> +    /* Get QEMU PID*/
> +    pid = getpid();

This should be gettid(), or perhaps a VCPU thread's TID.

> 
> +    /* Those MSR values should not change as well */
> +    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> +                                    s->msr_energy.socket_path);

The "0" should be sched_getcpu().

I'll review later the way that the measuring thread is created and 
operates, as it's a holiday today here. :)

Paolo

> +    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> +                                    s->msr_energy.socket_path);
> +



