Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF59A9D88
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 10:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Afc-0006Wo-JP; Tue, 22 Oct 2024 04:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3AfV-0006TA-37
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3AfR-0003pm-OF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729587303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jxpdl0XLfiQh0SD6D+HlJdUC8wRTsJE1b42HmAu3ogQ=;
 b=htD+rweONAiWLQDd59CdEHPNNn7ptw12tZYvjXlhJrMCwAQnamcziOeGfTFy7/vjbpngBW
 momJPC8GZcEycXNDsxwMZneNPGoTIyhfIIwAkzHE4YY0dB0xWf0bFdkeZsyEsaIkxxq6tM
 UNAreyEjhuXjfB6mIOeBEUm4eqsBXuY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-0690jdAbMleifGVyW7J9rA-1; Tue, 22 Oct 2024 04:54:59 -0400
X-MC-Unique: 0690jdAbMleifGVyW7J9rA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460ba8f6a5aso73672581cf.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587298; x=1730192098;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jxpdl0XLfiQh0SD6D+HlJdUC8wRTsJE1b42HmAu3ogQ=;
 b=a+VmnwOxZCZFzfilttT3Mfm1FRSdEGf/bGZrN3toUUjnM4BWKRXdCTbWKzfMT+p94c
 SgFm2nMrrP48LmZElYsFZe97S+aMlrWx7RQlVpTEY9Jqox2uiCOOaGFZwFDa+ud3FV9+
 54PSf3mvgtbugh9AMiXlCnBdjKOCO4UF/rEX1btb5J3QJHCIZbSpfXb3aVFXyIwLepFk
 MSyggkrA+Vz0OLD8A1PgxX1i87HGnVCoJDtAQzhVdegUagU/b/khLKEDqztucoaEAutM
 IiUM2f9OYOBNJAmumSu4u2ZbnxkPi8enuFfSNknj/30t8idHPfDTOkZWO629knAVVnfY
 T4FA==
X-Gm-Message-State: AOJu0YyP3ANVpYh4Msr11B7MaDe0VxMH08UwibrsxXjTJf+Kjm1TRF9D
 lLQJxm9ACnKGF+PKmFRq8J1k5E4vN5kftVIcBctGPTof/ejfTL8pk+egW+aoV2vnm9743Z6BRN5
 qkI0RYttKDD9QVCz6hNPF+pd9PeC8RuKp0k1OdaLQefyzvwv6lS1k
X-Received: by 2002:a05:622a:449:b0:460:ab13:f53c with SMTP id
 d75a77b69052e-460aed4b5d8mr204106141cf.20.1729587298574; 
 Tue, 22 Oct 2024 01:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQKeDp/HNjIumSPwFojkAWk/AgoXJthpNata1RE2PlZu8keHndWidKa0tovNHRzLT8WwOdsA==
X-Received: by 2002:a05:622a:449:b0:460:ab13:f53c with SMTP id
 d75a77b69052e-460aed4b5d8mr204105991cf.20.1729587298146; 
 Tue, 22 Oct 2024 01:54:58 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de.
 [109.40.241.30]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c63971sm27283361cf.31.2024.10.22.01.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:54:57 -0700 (PDT)
Message-ID: <ffca6497-0003-4c50-a804-80cc85942003@redhat.com>
Date: Tue, 22 Oct 2024 10:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: enable afalg tests in fedora system test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Longpeng <longpeng2@huawei.com>
References: <20241021170236.1443887-1-berrange@redhat.com>
 <ea8e87e4-eade-4926-8c0c-b583a605f270@redhat.com>
 <Zxdcbl-kaTRggFeJ@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Zxdcbl-kaTRggFeJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/10/2024 10.03, Daniel P. Berrangé wrote:
> On Tue, Oct 22, 2024 at 07:31:49AM +0200, Thomas Huth wrote:
>> On 21/10/2024 19.02, Daniel P. Berrangé wrote:
>>> The AF_ALG crypto integration for Linux is not being tested in
>>> any CI scenario. It always requires an explicit configure time
>>> flag to be passed to turn it on. The Fedora system test is
>>> arbitrarily picked as the place to test it.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    .gitlab-ci.d/buildtest.yml | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> This is to detect the situation Markus found here:
>>>
>>>     https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03040.html
>>>
>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> index 01e8470a69..f0cbdf1992 100644
>>> --- a/.gitlab-ci.d/buildtest.yml
>>> +++ b/.gitlab-ci.d/buildtest.yml
>>> @@ -115,7 +115,7 @@ build-system-fedora:
>>>        job: amd64-fedora-container
>>>      variables:
>>>        IMAGE: fedora
>>> -    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs
>>> +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg
>>>        TARGETS: microblaze-softmmu mips-softmmu
>>>          xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
>>>        MAKE_CHECK_ARGS: check-build
>>
>> Is there a reason for this feature being disabled by default? Who is using
>> it if it is disabled by default? Should we maybe rather enable it by default
>> instead?
> 
> afalg isn't something you want to use in general. It performs worse than
> the userspace crypto in many cases, especially for small buffers where the
> context switch overhead kills.
> 
> It is potentially interesting if you have hardware crypto accelerator and
> your guest workload also wants virtio-crypto.
> 
> Having it as a compile time option is not ideal, but it was the least
> effort tradeoff.

Ok, makes sense, thanks for the explanation.

Reviewed-by: Thomas Huth <thuth@redhat.com>


