Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA67BF464
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7G7-00067y-Js; Tue, 10 Oct 2023 03:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7G5-00067X-4I
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:34:25 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7G3-0000W3-Ch
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:34:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b2cee40de8so1158341866b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696923261; x=1697528061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Wl37K9W4DlKyiHx8RILs8vhGgqipapECU+7QhKqoHc=;
 b=Bo7U78OAUQ0aEeLv1hlBqzOlXYGGthZoFK9CGkKAj55aOwlXyy0xdGqjhClGAoLilD
 9epir5Fu0/UcQstUM/aqbOkRaHxTIgBYCZ5e6yZShCfGgsH2Bu/hH4L3ss7KP16I7E58
 oD5cAWjDXz56nsQp7TfKGv6xO1Bk68JypJukgYPPvS9+dMH2rjd+TdQbHmgWbnSR+t1L
 2+2Nlhg3Z8aK3a2QOzsKWx4OKDYb4cr6xmEgt03ERf0CBx9w5O+ZznOZFvrVOJWQCQSL
 crPeKUGnWNZnghA8OMHUUsEdomtzHKaEcgrsRutJlPU9f80+USuC0nPMSOmEkZ6R2vQS
 rdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923261; x=1697528061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Wl37K9W4DlKyiHx8RILs8vhGgqipapECU+7QhKqoHc=;
 b=ORrvXV7SZMtJYMKqeaJwWOpliqVPT59qVEThUOQ6uJ/lARGFqmPBtPwhng0WaVs7wl
 D7dAckbG109ibuBXbqCGv7N9slslX5mmKwNd8HaomkqbfzTU8ZPivIsMhjn7AjuZQGBc
 rZxgZDn7zzz9WvDXjegjkq5bF2hdND3LoZUo5ovj3cuE80ub1NZizCIsHVjqC22wb708
 1RwXFD2zMxdbgZxZHNdTwLC3HUKiNpPSiNWEzUpSVgqCujRm4jjp32ud3aApj5EXqZkq
 B5PkWkvYVRIHy2uH0eXToY9Pjq2CIYYg9Jl5cwu2QqzUVBkfvX3sgqK+8y5N0y+XqlmJ
 PSFQ==
X-Gm-Message-State: AOJu0Yy6Sa0sg2phrvTajoQRrXcN/9O0sfM6t5AUqxpaz808mtHJLj2H
 TiMQLp7XUYCTudvRj1FkmGXnLw==
X-Google-Smtp-Source: AGHT+IFpiEKK8HNW0WrRuEshmmUMCWWLWhTGENUraE5doamZPTH7vdJ8dGIJzoMtvx0KIK7eTS4DoA==
X-Received: by 2002:a17:906:1005:b0:9ad:f60c:7287 with SMTP id
 5-20020a170906100500b009adf60c7287mr13293333ejm.28.1696923261642; 
 Tue, 10 Oct 2023 00:34:21 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 cb22-20020a170906a45600b0099ce025f8ccsm7992638ejb.186.2023.10.10.00.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:34:21 -0700 (PDT)
Message-ID: <eb92e802-de68-27ac-a22a-706039906939@linaro.org>
Date: Tue, 10 Oct 2023 09:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "anjo@rev.ng" <anjo@rev.ng>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
 <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
 <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
 <87jzrvvwqv.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87jzrvvwqv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/10/23 08:04, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> [...]
> 
>> If we have to clean that for -Wshadow=global, I'm tempted to rename
>> the typedef as 'vaddr_t' and keep the 'vaddr' variable names.
> 
> POSIX reserves suffix _t, see
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_02_02

Alternatives: tvaddr, VAddr, TargetVirtualAddress.

Naming is hard.

> Do we care?
> 
>> Richard, Anton, what do you think?
> 
> [...]
> 


