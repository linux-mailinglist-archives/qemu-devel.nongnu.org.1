Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0B777773
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3ZP-0005mg-Kk; Thu, 10 Aug 2023 07:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3ZM-0005lK-Ur
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:11:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3ZL-0006ZB-Dl
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:11:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9b9f0387dso11935651fa.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691665865; x=1692270665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixOEa7SHrFgx5QSQ3jqH8K1vBzbtQ2da9T/80Xz+MSw=;
 b=a9tzEDdZ4fKpDU8hUXPtX2I4svtDwoKG1bGrdA3uwwauw/+n4U3nodLqc52a2YuUjJ
 1smgS27orcUz/re91gUVovSsuNvtA9LnsDHr8PvDrlKMVmDVRCq08xmbZtY3YFkO15Oa
 fr00ekMv2e+Qv181/r24XLtCltm9rtqOP1T2mFSSV2R/0d28K7YkIx8A/9wgqJlWoNhm
 /VEv+V+rVJhYCnehitkUVFtfOwCeINhNOBuwjViOACeBVqVzM5CfVWbanYs/0gl0EiyZ
 003enz5yoyEnneTIueJlPZlt7EFFJZRV2/3e0al9dVA0sYy1jL8QS2c0NTsGc7AnXtbj
 mOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691665865; x=1692270665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixOEa7SHrFgx5QSQ3jqH8K1vBzbtQ2da9T/80Xz+MSw=;
 b=VG4kAy0Q3rYE+JYtV4h1TSiLQW4Q1qJccwPmZX4LVpBzqdpiKBAYkFVNCKLsfrlxy1
 eXSkbu4PVLpnd8e7oX5hdAvj5nPBn5IGyCR6PbN6DhRxECVAFcmJwb1zhpN4Q5L9D1LH
 DbdJTPUNpbCRGfyWDp1KdTTcXCdEsBjuXHGOnmuGEDm2I4cjgav5qR2SE5adujjOiN3S
 daxg68M/N/MuSN9s4gAcYEy4FExgQ27H5UbevieZClZMPdZyxRDSSUu4ehbxd83A9EVd
 JM+ViAFkhWiGVFP8oTd/rHwrglpSwXKcrZNLSDZ7RUeSBMjDUOIuAbOG02RPZ47jHIDZ
 6eMg==
X-Gm-Message-State: AOJu0YwFeAyYA/y8IkvrzcUBQj/IJBZvu5KY9WiEyFWL5ZA7wD87/WwZ
 FV3G9k+REUd8ptCU5utd97F6gQ==
X-Google-Smtp-Source: AGHT+IGl5qkw8ib3XdlC3Mx9Ek4HpNGn+z7AdpW+bqujwNYjeoP19ZvvstL2v9LPILwocr6QRuPZAw==
X-Received: by 2002:a2e:9397:0:b0:2b9:ecc5:d1de with SMTP id
 g23-20020a2e9397000000b002b9ecc5d1demr1548516ljh.37.1691665865317; 
 Thu, 10 Aug 2023 04:11:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c024800b003fd2d33ea53sm1784413wmj.14.2023.08.10.04.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:11:04 -0700 (PDT)
Message-ID: <f7774c34-64eb-893c-5533-d0746d10eedd@linaro.org>
Date: Thu, 10 Aug 2023 13:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/3] softmmu/physmem: file_ram_open() readonly
 improvements
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, David Hildenbrand
 <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <19a4115f.867a.189d62f6665.Coremail.logoerthiner1@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <19a4115f.867a.189d62f6665.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

Hi,

On 8/8/23 19:26, ThinerLogoer wrote:
> 
> At 2023-08-08 03:07:31, "David Hildenbrand" <david@redhat.com> wrote:

>> Instead of handling it inside file_ram_open(), handle it in the caller
>> and only fallback to readonly in a MAP_PRIVATE mapping.

> I have tested the patch on my compilation environment. These patches does not
> have problem on my setup. Great job on handling more cases about file
> opening here!

Does that mean we can add your tag on this series?

Tested-by: Thiner Logoer <logoerthiner1@163.com>


