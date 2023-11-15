Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B37EC13D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 12:25:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3E0b-0008J6-Cj; Wed, 15 Nov 2023 06:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r3E0Y-0008GB-H3
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r3E0U-0008BN-P0
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700047469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zr9TyJtdwcQX++7CAxr/U8558TDeQJKSrA+9/xzIGY=;
 b=gmgjD+5mS6T+piesbb7ka9XZVk11xxFPef3x11j2w6HSRAanLbJoeJsdubZVR7IU2VT5Nt
 EiBbBiFJJ++z9uXT758Wfy+OkrSgpR0k3rGl5A8iE2ee7CEmNrNSNX7iIIqmdFyPAW6Id5
 WCSAUtGqJER3GyRrka9Ie0ODX/TyMAs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-L3rfgsUnP0OpcmHwhi-YLA-1; Wed, 15 Nov 2023 06:24:28 -0500
X-MC-Unique: L3rfgsUnP0OpcmHwhi-YLA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6bd00edc63fso9298079b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 03:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700047467; x=1700652267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0zr9TyJtdwcQX++7CAxr/U8558TDeQJKSrA+9/xzIGY=;
 b=nfYCJ6ZAfEHj+LFT9Xp06ufSDbgE3WKvNeqkDmMQxM2S/E6MUOpD85JkF3QhkMkWfr
 axOcjIa1dzIpwdD9RIrep3sOGEnramIMcK26cxRrJxSQOaw8pjQiLzktxlo3x9qGyNsK
 uXNQ3C7AQjwAmnVJY5/xm9ggO6E5usZgTZSpRxsJPYezjvBsaOEmCfUFKkgymhiRJjOW
 xqKn7tn2SkpgRmEYCW1ktJnm6DSDc30j67nLco21oMRS8HQ7YXWkAhPOoWV0anHAmCOO
 ocyTbb423NTWz/KIATcJmwfQD5MOeoa8Y0F5xLoY8lPULAVwBJLUsHsjgNsh7wI2eMXb
 pnUg==
X-Gm-Message-State: AOJu0YwLK54Bf785ImG2tY1pT/ky7962RRQdswd0T92Ueko7+k6xgO59
 nWByz+EOOaBAASEsDTMN1tGVpYA/Z1NEpll6h3GJgjgoD3q+BO7Pon3Fbhsd5sEhqvnUacR881q
 vdSrAi4aVYAcv2Ig=
X-Received: by 2002:a05:6a20:431d:b0:181:16dc:d1ae with SMTP id
 h29-20020a056a20431d00b0018116dcd1aemr16708392pzk.48.1700047466960; 
 Wed, 15 Nov 2023 03:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlQ7kkl0uG+hcqylmTeMlJtj0fVrKo/hW17Ch9fx+FopNWsy/ujAE1GWFZ/yK5141XA71ggg==
X-Received: by 2002:a05:6a20:431d:b0:181:16dc:d1ae with SMTP id
 h29-20020a056a20431d00b0018116dcd1aemr16708359pzk.48.1700047466660; 
 Wed, 15 Nov 2023 03:24:26 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 ha24-20020a17090af3d800b002776288537fsm6585213pjb.53.2023.11.15.03.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 03:24:26 -0800 (PST)
Message-ID: <dc3b8e48-1d33-480f-99bc-57e1242db13d@redhat.com>
Date: Wed, 15 Nov 2023 21:24:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/31] target/hppa: Remove object_class_is_abstract()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 imammedo@redhat.com, philmd@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-3-gshan@redhat.com>
 <35cae9bd-2240-2399-2212-e12f1683bf90@eik.bme.hu>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <35cae9bd-2240-2399-2212-e12f1683bf90@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/15/23 21:18, BALATON Zoltan wrote:
> On Wed, 15 Nov 2023, Gavin Shan wrote:
>> No need to check if @oc is abstract because it has been covered
>> by cpu_class_by_name().
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> target/hppa/cpu.c | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
>> index 04de1689d7..fc4d2abad7 100644
>> --- a/target/hppa/cpu.c
>> +++ b/target/hppa/cpu.c
>> @@ -163,7 +163,6 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
>>     ObjectClass *oc = object_class_by_name(typename);
>>
>>     if (oc &&
>> -        !object_class_is_abstract(oc) &&
>>         object_class_dynamic_cast(oc, TYPE_HPPA_CPU)) {
> 
> Might as well remove the line break as the remaining expression fits in 80 chars.
> 

Yes, but the whole chunk of code will be removed in PATCH[03]. So I think
we needn't the extra effort to adjust the format in PATCH[02]?

Thaks,
Gavin

>>         return oc;
>>     }
>>
> 


