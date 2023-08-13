Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474B77A55D
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 09:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV57B-00052S-Rd; Sun, 13 Aug 2023 03:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qV577-00051n-Q1
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 03:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qV575-0005OT-7C
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 03:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691910129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6/Kpbro+CYe865IdCskX7pDWbZFR+GJitdolnxNzGk=;
 b=Eq11MveO81TNEE5trB7uZvQx8iZ8KNq5Qqq+DfSsCr3bE6TKPRc1gPwvn9jjZT7nXY0g9c
 QPjwpQQZE4YjBSfOHWzAk3cmdyXi/tW6Mwr9onoHp40JAZ4o6QlUT9LlNwLiz2IvmJDjHw
 ttzWy+S3eI2+UX3dkTx/yI3FbgTnpFI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-ju8HryR4NwmdIBh6nlSf1A-1; Sun, 13 Aug 2023 03:02:07 -0400
X-MC-Unique: ju8HryR4NwmdIBh6nlSf1A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so20683045e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 00:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691910126; x=1692514926;
 h=content-transfer-encoding:in-reply-to:subject:from:content-language
 :references:cc:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6/Kpbro+CYe865IdCskX7pDWbZFR+GJitdolnxNzGk=;
 b=IX/x/VX+Dk5ASjuDLsgCl2SV3kn3ezo9dMG9aGz6mFfvfN0fPdDd3lACU3QF8TEk+X
 JwRfscqfZrVDL+RowuV6NQJzrFxjkzmyxP2Du3veUF+uNBrDJpRgMKTJSPACb4X3IRx+
 M/mu23GsIG9gZV80uVhVfjADwOEsNaHj0/5z+vh4KP8f4x8JP8V1zzdKIdU4P3vnwyDr
 kVhtjj24ncR/Hpvn3t2LaKb2O31u10YKI+dtc9XIMhzLFlTMpUKogucg9cTrK5Fm6Tbi
 ntsqZg9ph21n8vaDWMfVq7U0oMWLtQIxcUVGYMCyTt614+Ae7Wrcvk2UR8YPk03Ue7cc
 oekw==
X-Gm-Message-State: AOJu0Yy8BjftnEOfY3kO/VSlx5TKVNhN7w5hq/iZtosWKgwtiW4xU+ml
 EWwLkc3ehjxTkwgV/vCFxN1JnxRkPn8ZA+x09JMYHbGbWn9oVG8WyZ8Ntx2ciqEAMq+YFtZAGMS
 WVTVlMeTZzz90qeM=
X-Received: by 2002:a05:600c:2258:b0:3fe:2f80:8394 with SMTP id
 a24-20020a05600c225800b003fe2f808394mr4859275wmm.15.1691910126228; 
 Sun, 13 Aug 2023 00:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpqxnRBBOMEs+N7X2KGH6hhyNEQhf7flZog7X4vfPhFumjBTCFC60XNJa3tc5Iq1jFO08l1g==
X-Received: by 2002:a05:600c:2258:b0:3fe:2f80:8394 with SMTP id
 a24-20020a05600c225800b003fe2f808394mr4859258wmm.15.1691910125543; 
 Sun, 13 Aug 2023 00:02:05 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-246.web.vodafone.de.
 [109.43.177.246]) by smtp.gmail.com with ESMTPSA id
 f17-20020adff451000000b00317efb41e44sm10640893wrp.18.2023.08.13.00.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Aug 2023 00:02:04 -0700 (PDT)
Message-ID: <d36baa73-f266-06ab-774c-42e5dc704f7b@redhat.com>
Date: Sun, 13 Aug 2023 09:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20230717182859.707658-1-berrange@redhat.com>
 <871qgdap1y.fsf@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 00/12] tests: enable meson test timeouts to improve
 debuggability
In-Reply-To: <871qgdap1y.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 08/08/2023 10.57, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> Perhaps the most painful of all the GitLab CI failures we see are
>> the enforced job timeouts:
>>
>>     "ERROR: Job failed: execution took longer than 1h15m0s seconds"
>>
>>     https://gitlab.com/qemu-project/qemu/-/jobs/4387047648
>>
>> when that hits the CI log shows what has *already* run, but figuring
>> out what was currently running (or rather stuck) is an horrendously
>> difficult.
> 
> I had this in my tree but I see there are a number of review comments to
> take into account. Will there be a v3 and do we want it this late in the
> cycle?

I think this could maybe cause some false positives in the CI until we 
fine-tuned all related timeouts, so no, we don't want to have this in the 
last release candidates of 8.1. We should commit it early in the 8.2 cycle 
(hoping that Daniel has some spare minutes to release a v3), so we can iron 
out the remaining issues there.

  Thomas


