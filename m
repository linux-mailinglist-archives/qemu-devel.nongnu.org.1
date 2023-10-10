Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053297BF6E6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq8l0-0003fR-9Q; Tue, 10 Oct 2023 05:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq8kx-0003du-U3
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq8kw-0004GN-4p
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696929019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuLSmFZTaUbXwGk4W3kHdJdBFlCnmv+pqBbyrBWNMM4=;
 b=PeSL7xj/x/HJcUXNmuQ/G6mRV3gBiJFNpjwbqQuPI/m8BhP0zQWJ+ZjSUBP9fE/+muKCIk
 08X+0RuYJIDqt68xjllpIHpslO3tjJXqqNv+YawqOCS7pX2wcOizanzTnWRjicgsnwpKze
 UzoA1jjuCHWY+m8MW0ie1l27Fm4CcoI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-YpSIUk1HOTKtiArA-UDRQQ-1; Tue, 10 Oct 2023 05:10:18 -0400
X-MC-Unique: YpSIUk1HOTKtiArA-UDRQQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65d3df97d7fso56387436d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696929018; x=1697533818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cuLSmFZTaUbXwGk4W3kHdJdBFlCnmv+pqBbyrBWNMM4=;
 b=daPeZd/BivN6QoT26ECNpy3hNMS4ZBaZwQpTSwjJtPXkwC2PXcmCelWDba1HMVzilb
 iMouif2fmstCwCevzqtKAgEkvprnSJ1boU/UhyA6iqLQA86hVRtV/v0xdGOIp1GCX4X3
 lOTFsVgpbT68gDXbnrrLCnLIXghfwfHz1pU4YQktLVQETK2MD73VNukWvKv8qyB/WndO
 rZRTOcSaa9OCRX5U3H/IL1fSe4iKi0KwxHa8XYx3flIOz1Wnf6lvIAFXb0RDqI5Af6Ae
 tw1A0SxbJBltehBnSPd6acjekOnEczZnNnyiCNAbEqEmsqFzOrp18fDVM91uuwpkPeHa
 bcsA==
X-Gm-Message-State: AOJu0Yy/Rgu5g0IA1yZW22WqsYuVxAjn8Ub1ir2h4+YcEa2/DFOQfQoA
 v8L2FDMQR1xaMiuf8EA+3bzD3DOGj3zYMA9m/h1h6M1IBgcjaDlE4qmQjkSoDtZ1JQlaV0bkkQM
 +Tz79krkT7B1SuQ8=
X-Received: by 2002:a05:6214:5b0c:b0:65b:15bf:4f13 with SMTP id
 ma12-20020a0562145b0c00b0065b15bf4f13mr15687818qvb.65.1696929017984; 
 Tue, 10 Oct 2023 02:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeDIrw9tPRJaJHPc5tjgOBOq1u/2xAH/82A9C3RUxCt9kctrUxAlmXc+6tWVrKIw5BvlICoQ==
X-Received: by 2002:a05:6214:5b0c:b0:65b:15bf:4f13 with SMTP id
 ma12-20020a0562145b0c00b0065b15bf4f13mr15687804qvb.65.1696929017694; 
 Tue, 10 Oct 2023 02:10:17 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 oj13-20020a056214440d00b0065b1e6c33dfsm159932qvb.18.2023.10.10.02.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:10:17 -0700 (PDT)
Message-ID: <5705bd47-fcaf-09ba-a749-5773ecd71cae@redhat.com>
Date: Tue, 10 Oct 2023 11:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "anjo@rev.ng" <anjo@rev.ng>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
 <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
 <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
 <87jzrvvwqv.fsf@pond.sub.org>
 <eb92e802-de68-27ac-a22a-706039906939@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <eb92e802-de68-27ac-a22a-706039906939@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/10/2023 09.34, Philippe Mathieu-Daudé wrote:
> On 10/10/23 08:04, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>> [...]
>>
>>> If we have to clean that for -Wshadow=global, I'm tempted to rename
>>> the typedef as 'vaddr_t' and keep the 'vaddr' variable names.
>>
>> POSIX reserves suffix _t, see
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_02_02
> 
> Alternatives: tvaddr, VAddr, TargetVirtualAddress.
> 
> Naming is hard.
> 
>> Do we care?

According to our docs/devel/style.rst :

"Scalar type
names are lower_case_with_underscores_ending_with_a_t, like the POSIX
uint64_t and family.  Note that this last convention contradicts POSIX
and is therefore likely to be changed."

Maybe this would be a good point in time now to revisit our coding style, 
update it and then to change the "vaddr" type accordingly?

My 0.02 €: If enum types should already be in CamelCase, why not also use 
that for scalar types? So I'd vote for VirtAddr or VAddr here.

  Thomas


